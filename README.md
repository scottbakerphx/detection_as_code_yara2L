# detection_as_code_yara2L

**Detection-as-code portfolio — YARA-L 2.0 rules for Google Security Operations (Chronicle SIEM).**

A version-controlled library of detection rules, organized by MITRE ATT&CK tactic + cloud platform, each with
metadata, a plain-English writeup of *what it catches and why*, and (where possible) sample events to test
against. This is **detection engineering done like software**: rules live in git, are reviewed, and are meant
to be validated/tuned in a real Google SecOps instance or a Skills Boost lab.

> Author: **Scott Baker** — AWS Solutions Architect · Databricks (Spark/Scala) · HIPAA & HITRUST remediation ·
> pursuing Google Cloud Professional Cloud Security Engineer + Google SecOps.

## Why this repo exists
Certs prove you studied; **detections in git prove you can do the work.** Hiring managers for detection-engineer
/ SecOps roles want to see real rules, sound metadata, and clear reasoning — that's what lives here.

## 👉 Start here: [`STUDY_GUIDE.md`](STUDY_GUIDE.md)
The complete step-by-step plan — how to use all of this **together with the Google Cloud Skills Boost SecOps
path + the PCSE cert**, all on **free** tooling.

## Layout
```
rules/
  credential_access/   persistence/   execution/   exfiltration/     # by MITRE ATT&CK tactic
  cloud_gcp/   cloud_aws/                                            # by cloud platform
bigquery/     the SAME detections as scalable SQL over Cloud Audit Logs (security data engineering track)
docs/         writeups + a YARA-L primer + where/how to run rules
data/         sample UDM events to validate rules against
.github/workflows/   CI that lints rule metadata + structure (detection-as-code = tested in git)
```
Companion repo: **[`vscode-yara-l`](https://github.com/scottbakerphx/vscode-yara-l)** — YARA-L 2.0 syntax
highlighting for VS Code.

## YARA-L 2.0 in 30 seconds
A YARA-L rule matches over Google SecOps **UDM** (Unified Data Model) events:
```
rule descriptive_name {
  meta:        // author, description, severity, MITRE mapping, references
  events:      // UDM event patterns + variables ($e, $ip, $user, ...)
  match:       // grouping variables over a time window (e.g. $ip over 10m)
  condition:   // when to fire (e.g. #fail >= 10 and $ok)
}
```

## How to practice (without burning GCP credits)
- Write/edit rules here → **validate + tune in a Google SecOps lab on Skills Boost** (skills.google). Labs run
  in a sandbox on **training credits**, NOT your GCP billing — so you never pay for a live Chronicle instance.
- Enable **Security Command Center — Standard (free)** on a GCP project for real posture-management practice.
- Bridge exercise (later): point detections at your *own* project's Cloud Audit Logs / SCC findings.

## Honest note
UDM field names and event types in these rules are written from the schema as authored; **verify each against
the current UDM schema in your SecOps instance and tune thresholds against real data** before trusting them.
They're learning-grade detections meant to be validated, not dropped into production blind.

## License
MIT (see LICENSE) — learn from them, adapt them.
