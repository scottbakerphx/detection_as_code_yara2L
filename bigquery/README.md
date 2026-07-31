# BigQuery detections — security data engineering track

The **same detections** as the YARA-L rules, expressed as **scalable SQL over Cloud Audit Logs in BigQuery**.
This is the *security-data-engineering* side of the job — analytics over large log volumes (plays to a Spark
background). It also lets you **validate detection logic cheaply**, on real logs you own, without a paid SIEM.

## Why do both (YARA-L *and* SQL)?
- **YARA-L** = streaming detections in Google SecOps (real-time SIEM). Runs in Skills Boost labs.
- **BigQuery SQL** = the same behavior as a batch/analytics query on exported logs — great for tuning, hunting,
  and detection-at-scale, and it costs ~nothing on the free tier. Showing both proves range.

## Setup (free tier)
1. **Enable Cloud Audit Logs** on a small GCP project (Admin Activity logs are on by default; enable Data
   Access logs if you want reads too).
2. **Create a log sink → BigQuery:**
   ```bash
   # create a dataset, then a logging sink that routes audit logs into it
   bq --location=US mk --dataset PROJECT:security_audit
   gcloud logging sinks create audit-to-bq \
     bigquery.googleapis.com/projects/PROJECT/datasets/security_audit \
     --log-filter='logName:"cloudaudit.googleapis.com"'
   # grant the sink's writer identity BigQuery Data Editor on the dataset (the create command prints the SA)
   ```
   Logs land in sharded tables like `security_audit.cloudaudit_googleapis_com_activity_YYYYMMDD`.
3. **Generate telemetry** (so there's something to detect): create a service-account key, make a test bucket
   public, poke resources you lack permission on — then re-run the queries.

## Run a detection
Edit `PROJECT.DATASET` in each `.sql`, then run in the BigQuery console or:
```bash
bq query --use_legacy_sql=false < detections/gcp_service_account_key_created.sql
```

## Cost
Audit logs for a small project are tiny. BigQuery free tier = **10 GB storage + 1 TB queried / month free** —
this track stays comfortably free. **Never** stand up a paid Chronicle/SecOps SIEM for this.

## Scale notes (the "big data" mindset)
- Always filter `_TABLE_SUFFIX` (date shards) first — it's the cheapest predicate and bounds bytes scanned.
- Avoid `SELECT *`; project only needed columns (BigQuery bills on bytes read).
- High-cardinality joins/aggregations over long windows get expensive — say so in the rule's comment, same as
  you would when tuning a YARA-L `match` window.
