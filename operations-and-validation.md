# Operations, Monitoring and Data Validation

## Run-level audit fields

A practical audit design may capture:

| Field | Purpose |
|---|---|
| Run ID | Unique identifier for a package/entity execution |
| Entity name | CRM entity being processed |
| Start / end time | Execution duration and traceability |
| Window start / end | Incremental extraction boundaries |
| Extracted count | Number of source rows retrieved |
| Staged count | Number of rows landed in staging |
| Inserted / updated count | Target changes applied |
| Rejected count | Rows failing validation |
| Status | Started, succeeded or failed |
| Error summary | Safe diagnostic information |

These are recommended audit fields; include only those that exist in the actual implementation when describing a completed production solution.

## Validation checklist

- Confirm the CRM entity and destination mapping.
- Validate source identifiers are populated.
- Check duplicates in the incoming batch.
- Verify required fields and data type conversions.
- Compare extracted and staged row counts.
- Reconcile inserted, updated and rejected records.
- Confirm the watermark advances only after success.
- Verify a rerun does not create duplicate target rows.
- Confirm downstream reports read the expected target tables/views.

## Troubleshooting guide

| Symptom | Investigation |
|---|---|
| Zero rows extracted | Check watermark, filter boundaries, source permissions and whether changes occurred |
| Duplicate target rows | Check key mapping, uniqueness constraints and idempotent upsert logic |
| Missing updates | Verify incremental field/mechanism, timestamp precision, overlap and watermark commit timing |
| Package failure | Review SSIS execution messages and connector diagnostics |
| Source/target count mismatch | Review rejects, transformations, filtering and delete handling |
| Slow extraction | Review entity filters, selected columns, paging and CRM service limits |

## Safe publication checklist

- Replace internal server, database, tenant and environment names.
- Remove credentials, tokens, connection strings and personal data.
- Use synthetic sample data only.
- Confirm that diagrams and screenshots contain no confidential information.
- Obtain authorization before publishing any employer-owned design or implementation detail.
