# YARA-L 2.0 — VS Code syntax highlighting

Syntax highlighting for **YARA-L 2.0** detection rules — the rule language for **Google Security Operations
(Chronicle SIEM)**. Lightweight (a TextMate grammar, no runtime code): open any `.yaral` / `.yl` file and it
lights up.

## Highlights
- **Sections:** `meta` · `events` · `match` · `condition` · `outcome` · `options`
- **`rule <name>`** declarations
- **Variables:** `$event`, `#count`, `%placeholder`, `@outcome`
- **Operators & keywords:** `and` `or` `not` `nocase` `over` `any` `all`, comparisons
- **Functions:** `re.regex`, `strings.*`, `timestamp.*`, `net.*`, `math.*`, aggregations (`count`, `max`, …)
- **Strings, regex literals (`/…/`), durations (`10m`, `1h`), numbers**
- **`meta` keys** highlighted distinctly
- Line (`//`) and block (`/* */`) comments

## Install
**From source (dev):**
1. Copy/clone this folder into `~/.vscode/extensions/yara-l-0.1.0/` (or open it and press **F5** to launch an
   Extension Development Host).
2. Open a `.yaral` file — highlighting applies automatically.

**Package a `.vsix` (to share / sideload):**
```bash
npm i -g @vscode/vsce
vsce package                 # -> yara-l-0.1.0.vsix
code --install-extension yara-l-0.1.0.vsix
```

**Publish to the Marketplace (optional, for the résumé line):**
```bash
vsce login scottbakerphx     # needs an Azure DevOps publisher + PAT
vsce publish
```

## Why
Built as part of a **detection-as-code** workflow (see `detection_as_code_yara2L`) — there wasn't a good
YARA-L 2.0 highlighter, so here's one. Author: **Scott Baker**.

## Notes
- YARA-L (Google SecOps) is a *different language* from YARA (malware signatures) — this grammar targets YARA-L 2.0.
- Grammar is pragmatic, not a full parser; authoritative validation happens in the SecOps platform. PRs welcome.

## License
MIT.
