/*
    Illustrative metadata table for per-entity incremental load state.
    Review and adapt to your platform's standards before use.
    This is a generic template, not a copy of a production implementation.
*/
CREATE TABLE dbo.IncrementalLoadControl
(
    EntityName              sysname         NOT NULL,
    LastSuccessfulWatermark datetime2(7)    NULL,
    LastRunId               uniqueidentifier NULL,
    LastRunStatus           varchar(20)     NULL,
    LastRunStartUtc         datetime2(7)    NULL,
    LastRunEndUtc           datetime2(7)    NULL,
    CONSTRAINT PK_IncrementalLoadControl
        PRIMARY KEY (EntityName)
);
GO

/*
    Watermark update should be executed only after the corresponding
    entity extraction, staging, target processing and required validation
    have completed successfully.
*/
