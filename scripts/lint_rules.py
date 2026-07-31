#!/usr/bin/env python3
"""Lightweight detection-as-code linter for YARA-L 2.0 rules.

Not a YARA-L *compiler* (only Google SecOps can truly validate syntax) — it's a CI gate that keeps the library
professional: every `.yaral` rule must have the required meta keys and the core blocks. Run in CI so a rule
can't merge half-documented.

    python scripts/lint_rules.py            # lint rules/
    python scripts/lint_rules.py path.yaral # lint one file
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

REQUIRED_META = ["author", "description", "severity", "mitre_tactic", "yara_l_version", "status"]
SEVERITIES = {"LOW", "MEDIUM", "HIGH", "CRITICAL"}
BLOCKS = ["meta:", "condition:"]  # events:/match: aren't required by every rule; meta + condition are


def lint(path: Path) -> list[str]:
    text = path.read_text(encoding="utf-8")
    errs: list[str] = []
    if not re.search(r"\brule\s+[a-z0-9_]+\s*\{", text):
        errs.append("no `rule <snake_name> {` declaration")
    for b in BLOCKS:
        if b not in text:
            errs.append(f"missing `{b}` block")
    meta = {m.group(1): m.group(2).strip().strip('"') for m in re.finditer(r'(\w+)\s*=\s*"([^"]*)"', text)}
    for k in REQUIRED_META:
        if k not in meta:
            errs.append(f"missing meta key: {k}")
    if meta.get("severity") and meta["severity"] not in SEVERITIES:
        errs.append(f"severity must be one of {sorted(SEVERITIES)}, got {meta['severity']!r}")
    if text.count("{") != text.count("}"):
        errs.append("unbalanced braces { }")
    return errs


def main(args: list[str]) -> int:
    root = Path(args[0]) if args else Path("rules")
    files = [root] if root.suffix == ".yaral" else sorted(root.rglob("*.yaral"))
    if not files:
        print(f"no .yaral files under {root}")
        return 1
    bad = 0
    for f in files:
        errs = lint(f)
        if errs:
            bad += 1
            print(f"✗ {f}")
            for e in errs:
                print(f"    - {e}")
        else:
            print(f"✓ {f}")
    print(f"\n{len(files) - bad}/{len(files)} rules passed")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
