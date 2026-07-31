# Rule authoring style (YARA-L 2.0)

Consistency is what makes a detection library look *professional*. Every rule follows this.

## Naming
- File + rule name: `snake_case`, descriptive of the behavior, not the tool. One rule per file.
- Path: `rules/<tactic_or_platform>/<rule_name>.yaral`.

## Required `meta`
| key | notes |
|-----|-------|
| `author` | you |
| `description` | one clear sentence: *what it catches and why it matters* |
| `severity` | `LOW` / `MEDIUM` / `HIGH` / `CRITICAL` |
| `mitre_tactic` | e.g. `TA0006 Credential Access` |
| `mitre_technique` | e.g. `T1110 Brute Force` |
| `reference` | a URL (MITRE, vendor doc) |
| `yara_l_version` | `2.0` |
| `status` | `learning` → `tuned` → `production` |
| `platform` | for cloud rules: `GCP` / `AWS` / `Azure` |

## Structure discipline
- `events:` — pattern the UDM fields; bind variables (`$ip`, `$user`, `$actor`) you'll group on.
- `match:` — group variables over an explicit window (`$ip, $user over 10m`). Windows are *tuning knobs*.
- `condition:` — keep it readable; use counts (`#fail >= 10`) and joins deliberately.

## Every rule needs
1. A **writeup** in `docs/` (or a top comment): what it detects, expected FPs, how to tune, test data used.
2. **Test events** in `data/` where practical, so a reviewer can see it fire.
3. A **status** — be honest. `learning` until you've validated it against real data in a SecOps lab.

## Tuning mindset (this is the craft)
- Start broad, measure false positives, tighten. Note *why* a threshold/window is what it is.
- Prefer **behavior** over **indicators** (IOCs age out; behavior lasts).
- At scale (your Spark background helps): think about event volume — a rule that joins high-cardinality fields
  over a long window is expensive. Call it out.
