# GCP SecOps — complete study & usage guide (detection-as-code → job)

A step-by-step plan to go from "learning" to **hireable GCP SecOps / detection engineer**, tying together the
three portfolio assets + Google Cloud Skills Boost + the Professional Cloud Security Engineer cert. Built to be
**free** to practice (never a paid SIEM). Author: **Scott Baker**.

> **Your unfair advantage (lead with it):** HIPAA & HITRUST remediator + infosec/IT analyst + **AWS Solutions
> Architect** + **Databricks Spark/Scala** + GCP SecOps. That's compliance + detection + multi-cloud + big-data —
> a *senior-flavored, under-supplied* profile. You are **not** an entry-level candidate.

---

## 0. The three assets (your proof-of-work)
| Asset | Repo | What it proves |
|---|---|---|
| **Detection rules** | `detection_as_code_yara2L` (rules/ + CI linter) | you write & maintain YARA-L detections like software |
| **BigQuery detections** | same repo, `bigquery/` | security **data engineering** — detection-at-scale in SQL (your Spark strength) |
| **VS Code extension** | `vscode-yara-l` | initiative + tooling; you gave the community a YARA-L highlighter |

Two credentials pillars sit on top: **Skills Boost Security Operations path** (hands-on) + **PCSE cert** (signal).

---

## 1. The mental model — the detection engineering loop
```
   pick a threat (MITRE technique)
        │
   write the detection  ── YARA-L rule (repo, edited in VS Code + the extension)
        │                └ + the equivalent BigQuery SQL
        │
   get real/sample logs ── Skills Boost lab data  OR  your own GCP project → BigQuery
        │
   run & tune          ── YARA-L in a SecOps lab · SQL in BigQuery (watch it fire, cut false positives)
        │
   document + commit   ── writeup ("what it catches, expected FPs, how tuned"), status: learning→tuned
        │
   repeat  ← this loop, over and over, IS the craft (and the résumé)
```

---

## 2. Environment setup (one time)

1. **Editor:** VS Code. Install your **`vscode-yara-l`** extension (from source: copy into
   `~/.vscode/extensions/`, or `vsce package` → `code --install-extension yara-l-0.1.0.vsix`). `.yaral` files now
   highlight. *(Keep IntelliJ for the voidptr Kotlin app; VS Code for detections.)*
2. **Clone the repos** and work in them: `detection_as_code_yara2L` (rules + bigquery) and `vscode-yara-l`.
3. **Skills Boost account:** sign in at **skills.google** (Cloud Skills Boost) with your unlocked credits. This
   is where you *run* YARA-L against pre-loaded enterprise logs — **free, sandboxed, no GCP billing**.
4. **A small free GCP project** (your log lab):
   - Enable **Cloud Audit Logs**; create a **BigQuery log sink** (see `bigquery/README.md`).
   - Enable **Security Command Center — Standard (FREE)** for posture practice. **Never** enable SCC
     Premium/Enterprise or a Chronicle SIEM on your billing/$1800 (enterprise-priced).
   - Set a **budget alert** ($5–$10) so you're pinged before anything costs real money.

---

## 3. The plan, phased (adjust pace to your schedule)

### Phase 1 — YARA-L + SecOps fundamentals  (~2–3 weeks)
- On **Skills Boost**, do the **Security Operations / Google SecOps (Chronicle)** courses + labs (search
  "Security Operations", "Google SecOps", "Chronicle"). Focus: UDM data model, how ingestion works, the rule
  editor, running a rule.
- **Master YARA-L 2.0 structure:** `meta / events / match / condition / outcome`; variables `$e #count %ph @out`;
  windows (`over 10m`); aggregations. Re-read `STYLE.md`.
- **Do:** in a lab, take each of the 3 starter rules in `rules/`, run them against the lab data, tune, and mark
  `status: tuned`. Add 3–5 more of your own (start from MITRE techniques you find interesting).

### Phase 2 — Detection-at-scale in BigQuery  (~1–2 weeks)
- Follow `bigquery/README.md`: export your GCP project's audit logs → BigQuery.
- Generate telemetry (create an SA key, make a bucket public, trigger permission-denials), then run the 3 SQL
  detections and confirm they fire on *your own* logs.
- Write 3–5 more SQL detections. Practice **cost-aware SQL** (filter `_TABLE_SUFFIX`, project columns) — narrate
  the scale tradeoffs (this is where your Spark brain shines and interviewers notice).

### Phase 3 — Professional Cloud Security Engineer (PCSE)  (~4–8 weeks, parallel-able)
- See §4. Study the exam guide, do the PCSE learning path on Skills Boost, take practice exams, sit the cert.

### Phase 4 — Portfolio polish + job hunt  (ongoing)
- Every rule has a writeup + (where possible) sample events. CI stays green. READMEs sharp.
- Add a short **"detection engineering journal"** (docs/): 5–10 entries of "threat → detection → how I tuned it".
- Résumé/LinkedIn: the two lines below. Apply to **detection engineer / SOC L2–L3 / cloud security engineer /
  security data engineer** roles (many are multi-cloud — your AWS SA helps).

---

## 4. Should you grab the GCP Security cert? — YES.
**Google Cloud Professional Cloud Security Engineer (PCSE)** is the right cert for this lane.

- **Why:** it's *the* flagship GCP security credential — the résumé signal that gets you past screening. It pairs
  perfectly with the hands-on portfolio (cert = "studied", portfolio = "can do"; you want both).
- **What it covers:** configuring access (IAM/orgs), network security, data protection, **logging/monitoring/
  SecOps**, and compliance — much of which overlaps your HITRUST/compliance background *and* the SCC/audit-log
  work you're already doing.
- **Format (verify current details on the exam page):** ~2-hour, multiple-choice/multiple-select proctored exam,
  ~$200 USD. No hard prerequisites, but it assumes real hands-on GCP security experience — which the portfolio
  gives you.
- **How to prep:** the **PCSE learning path on Skills Boost** (use your credits) → the official **exam guide**
  (map every objective) → **practice exams** until you're consistently ~85%+ → schedule it.
- **Order:** do Phase 1–2 first (hands-on makes the cert concepts click), then knock out PCSE. Don't cert-first;
  hands-first.

*(Later stretch: a Google SecOps-specific credential if offered, and/or Security+ if a role wants a vendor-neutral
baseline. PCSE is the priority.)*

---

## 5. The weekly rhythm (make it a habit)
- **2–3×/week:** one detection end-to-end (write → run in lab / BigQuery → tune → document → commit).
- **1×/week:** a PCSE study block (a learning-path module + a few practice questions).
- **Monthly:** tidy the portfolio, write one journal entry, apply to 5–10 roles.

Consistency > intensity. Twelve tuned detections + PCSE + the extension = a portfolio most candidates can't match.

---

## 6. Résumé / interview framing
- *"Detection-as-code portfolio: authored & CI-validated YARA-L 2.0 detections for Google SecOps; equivalent
  detection-at-scale in BigQuery SQL over Cloud Audit Logs."*
- *"Authored a YARA-L 2.0 VS Code language extension."*
- In interviews, walk the **loop** (§1) on one detection: the threat, the rule, how you got logs, how you tuned
  out false positives, the scale tradeoff. That story is what separates you.

---

## 7. Cost guardrails (so the $1800 stays safe)
- ✅ Free: Skills Boost labs (training credits), a tiny GCP project, **SCC Standard**, BigQuery free tier.
- ❌ Never on personal/startup credits: **Google SecOps/Chronicle SIEM**, **SCC Premium/Enterprise**.
- Keep a **budget alert** on the GCP project. voidptr's backend (scale-to-zero + free tiers) is also safe.
