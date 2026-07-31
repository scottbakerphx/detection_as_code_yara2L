# Where do these rules actually run? (and how to practice without burning $)

YARA-L 2.0 rules **only execute inside Google SecOps (Chronicle)**. You need a SecOps instance with logs. Here's
how to run + validate them cheaply — and what NOT to do.

## 1. Run / execute rules → Google SecOps labs on Skills Boost (FREE)
- The **Security Operations learning path** labs on **skills.google (Cloud Skills Boost)** give you a real
  SecOps instance **pre-loaded with a mock enterprise's logs** (Windows, GCP/AWS, EDR, DNS, proxy…).
- Write a rule → run it against that data → watch it fire. Labs run on **training credits**, NOT GCP billing.
- **This is the primary venue.** You do not build the SIEM — Google provides it.

## 2. Generate REAL logs cheaply → a tiny GCP project (near-free)
For portfolio realism and to prove your UDM field mappings are correct:
- Small GCP project + **Cloud Audit Logs** + **Security Command Center — Standard (FREE)**.
- Perform actions yourself: create a service-account key, make a bucket public, trigger failed logins, etc.
- Real security telemetry appears — **that you own**. Export it to **BigQuery** and write detection **logic** in
  SQL to validate the idea (plays to a Spark/BigQuery background). Copy the real event JSON into the rule's
  writeup so the field mappings are grounded, not guessed.
- **voidptr's own GCP project is exactly this kind of mini-enterprise** — detect against your own audit logs.

## 3. Model against free, realistic content
- **`chronicle/detection-rules`** (Google's GitHub) — real community YARA-L rules **+ sample UDM events**.
- **Atomic Red Team** — safely runs real ATT&CK techniques to *generate* attack telemetry.
- **Security-Datasets / Mordor**, **Splunk BOTS** — public labeled datasets to model detections on.

## ❌ What NOT to do
- **Do NOT stand up a live Chronicle/Google SecOps SIEM on personal or $1800 startup credits.** It's
  enterprise-priced (ingestion-based, thousands/month) and isn't self-serve for individuals. It would vaporize
  the credits. Use the labs for execution instead.
- **Do NOT** confuse **SCC Standard** (free, fine to enable) with **Google SecOps/Chronicle** (paid SIEM).

## The workflow in one line
Write rule here (git) → **generate/borrow real logs** (GCP project + BigQuery / public datasets) → **run + tune
in a Skills Boost lab** → mark `status: tuned` → commit. That loop, over and over, *is* the craft.
