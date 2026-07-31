-- Detection: repeated PERMISSION_DENIED then a success, same actor + IP  (BigQuery / Cloud Audit Logs)
-- GCP analog of rules/credential_access/multiple_failed_logins_then_success.yaral — access probing /
-- privilege brute-forcing that eventually succeeds. MITRE: T1110 Brute Force / TA0006. Severity: HIGH.
--
-- gRPC status codes: 7 = PERMISSION_DENIED, 0 = OK. Tune the >= 10 threshold against your own data.

WITH ev AS (
  SELECT
    timestamp,
    protopayload_auditlog.authenticationInfo.principalEmail AS actor,
    protopayload_auditlog.requestMetadata.callerIp          AS ip,
    protopayload_auditlog.status.code                       AS status_code
  FROM `PROJECT.DATASET.cloudaudit_googleapis_com_activity_*`
  WHERE _TABLE_SUFFIX BETWEEN FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
                          AND FORMAT_DATE('%Y%m%d', CURRENT_DATE())
    AND protopayload_auditlog.authenticationInfo.principalEmail IS NOT NULL
)
SELECT
  actor,
  ip,
  COUNTIF(status_code = 7) AS denied,
  COUNTIF(status_code = 0) AS allowed,
  MIN(timestamp)           AS first_seen,
  MAX(timestamp)           AS last_seen
FROM ev
GROUP BY actor, ip
HAVING denied >= 10 AND allowed >= 1     -- many denials AND at least one success in the window
ORDER BY denied DESC;
