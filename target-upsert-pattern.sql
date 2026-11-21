/*
    Illustrative target upsert pattern.
    Replace schema, table, key and column names with synthetic examples.
    Validate transaction handling, concurrency, indexes and SQL Server
    version compatibility before using in any environment.
*/

-- Example only: insert new CRM records based on a stable source identifier.
INSERT INTO dbo.TargetEntity
(
    CrmRecordId,
    AttributeA,
    AttributeB,
    SourceModifiedOn,
    WarehouseLoadedOn
)
SELECT
    s.CrmRecordId,
    s.AttributeA,
    s.AttributeB,
    s.SourceModifiedOn,
    SYSUTCDATETIME()
FROM dbo.StagingEntity AS s
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.TargetEntity AS t
    WHERE t.CrmRecordId = s.CrmRecordId
);

-- Existing-record updates should be implemented using the approved
-- update/join pattern for the target environment. Avoid blindly copying
-- this template without handling duplicate source keys and concurrency.
