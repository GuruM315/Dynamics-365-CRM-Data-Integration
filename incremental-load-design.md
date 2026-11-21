# Incremental Load — Technical Process

## 1. Purpose

Incremental loading transfers records that are newly created or modified in Dynamics 365 CRM without repeatedly extracting the entire entity dataset. The solution described in this portfolio covers nearly 20 CRM entities.

## 2. Core concepts

**Watermark:** A saved high-water mark representing the last successfully processed extraction boundary for an entity.

**Incremental attribute/mechanism:** The source-side field or platform-supported mechanism used to identify changes. Examples in general integration designs include a modified timestamp or native change tracking. Confirm the actual field/mechanism used by each package.

**Overlap window:** An optional look-back interval that re-reads a small portion of the prior extraction period to reduce the risk of missing late-visible changes. It requires duplicate-safe target processing.

**Idempotency:** Re-running the same batch should not create duplicate target records or corrupt existing values.

## 3. Processing sequence

1. **Initialize the run**
   - Generate a unique run identifier.
   - Record entity name, start time and execution context.
   - Read the last successful watermark for that entity.

2. **Define the extraction boundary**
   - Determine the extraction end boundary for the current run.
   - Apply the configured lower boundary and any approved overlap.
   - Ensure the filter uses the correct CRM field and timezone/precision behavior.

3. **Extract from Dynamics 365**
   - Use the configured SSIS/KingswaySoft CRM source component.
   - Retrieve only records in the incremental window.
   - Handle paging, throttling and transient connectivity errors according to the connector configuration.

4. **Stage the data**
   - Land the extracted rows in the corresponding SQL Server staging table.
   - Associate rows with the run identifier where the design supports batch tracking.
   - Preserve source identifiers and relevant audit timestamps.

5. **Validate and transform**
   - Check required keys, data types and mandatory attributes.
   - Apply approved mappings and business transformations.
   - Identify duplicate source keys within the batch.
   - Route invalid records to an exception process rather than silently discarding them.

6. **Apply changes to target**
   - Match source records using a stable CRM identifier.
   - Insert records not already present.
   - Update existing records when source values have changed.
   - Apply delete/inactivation logic only where explicitly designed and validated.

7. **Reconcile and audit**
   - Record extracted, staged, inserted, updated, rejected and failed row counts when available.
   - Investigate count differences and rejected records.
   - Record completion status and execution duration.

8. **Commit the watermark**
   - Advance the entity watermark only after all required processing and validation steps succeed.
   - On failure, preserve the prior successful watermark so the window can be retried safely.

## 4. Illustrative SQL watermark filter

The following is a generic example only. Replace the field and parameter names with the actual source field and connector syntax used in the implementation.

```sql
-- Illustrative filter logic; not a production-ready CRM query.
WHERE ModifiedOn >= @WindowStart
  AND ModifiedOn <  @WindowEnd;
```

Use a consistent boundary convention (for example, inclusive start and exclusive end) to avoid gaps or overlaps between adjacent windows.

## 5. Illustrative target upsert logic

A target load commonly matches records by the immutable CRM record identifier. The example in `../sql/templates/target-upsert-pattern.sql` demonstrates the concept. Production implementations should use the organization's approved transaction, indexing, concurrency and error-handling strategy.

## 6. Delete handling

An update timestamp filter does not automatically guarantee that deleted source records will be detected. Document the actual delete strategy separately. Possible designs include native change tracking, soft-delete/status flags, periodic reconciliation, or a dedicated deletion feed. Do not assume hard deletes are covered by a modified timestamp.

## 7. Operational edge cases to test

- First-time initialization when no watermark exists.
- No-change window / zero-row extraction.
- Multiple updates to the same record between runs.
- Records updated near the extraction boundary.
- Failed package after staging but before target application.
- Retry of a previously failed window.
- Duplicate records in staging.
- CRM throttling, timeout or temporary connectivity loss.
- Source deletion or deactivation.
- Timezone and timestamp precision differences.

## 8. Implementation-specific details to complete

Before publishing a production-specific description, confirm and document:
- Actual incremental field or change-tracking mechanism per entity.
- Whether the process uses an overlap window.
- Actual watermark persistence location.
- Whether target processing uses stored procedures, staging tables, MERGE, or another pattern.
- Delete-handling strategy.
- Schedule, retry policy and monitoring mechanism.
