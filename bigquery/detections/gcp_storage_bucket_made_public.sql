-- Detection: GCS bucket made public  (BigQuery / Cloud Audit Logs)
-- Same threat as rules/cloud_gcp/gcp_storage_bucket_made_public.yaral.
-- MITRE: T1567 Exfiltration Over Web Service. Severity: HIGH.
--
-- We catch a storage IAM change whose audit payload references allUsers / allAuthenticatedUsers.
-- (Pragmatic: search the audit record JSON — the exact binding-delta path varies; TO_JSON_STRING is robust.)

SELECT
  timestamp,
  protopayload_auditlog.authenticationInfo.principalEmail  AS actor,
  protopayload_auditlog.resourceName                       AS bucket,
  protopayload_auditlog.requestMetadata.callerIp           AS caller_ip
FROM `PROJECT.DATASET.cloudaudit_googleapis_com_activity_*`
WHERE _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
                        AND FORMAT_DATE('%Y%m%d', CURRENT_DATE())
  AND protopayload_auditlog.methodName = 'storage.setIamPermissions'
  AND REGEXP_CONTAINS(TO_JSON_STRING(protopayload_auditlog), r'allUsers|allAuthenticatedUsers')
ORDER BY timestamp DESC;
