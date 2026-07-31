-- Detection: GCP service-account KEY created  (BigQuery / Cloud Audit Logs)
-- Same threat as rules/cloud_gcp/gcp_service_account_key_created.yaral, expressed as scalable SQL.
-- MITRE: T1098.001 Additional Cloud Credentials (Persistence). Severity: MEDIUM.
--
-- Replace `PROJECT.DATASET` with your audit-log sink dataset (see bigquery/README.md).
-- Runs over the last 7 days of the sharded Admin Activity table.

SELECT
  timestamp,
  protopayload_auditlog.authenticationInfo.principalEmail          AS actor,
  protopayload_auditlog.resourceName                               AS service_account,
  protopayload_auditlog.requestMetadata.callerIp                   AS caller_ip,
  protopayload_auditlog.requestMetadata.callerSuppliedUserAgent    AS user_agent
FROM `PROJECT.DATASET.cloudaudit_googleapis_com_activity_*`
WHERE _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
                        AND FORMAT_DATE('%Y%m%d', CURRENT_DATE())
  AND protopayload_auditlog.methodName = 'google.iam.admin.v1.CreateServiceAccountKey'
ORDER BY timestamp DESC;
