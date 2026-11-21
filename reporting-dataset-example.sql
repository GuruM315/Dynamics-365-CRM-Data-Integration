/*
    Generic illustrative SQL reporting view.
    Replace names and data types with synthetic portfolio examples.
    Do not paste production SQL or confidential business rules here.
*/
CREATE VIEW dbo.vw_CrmOpportunityPortfolio
AS
SELECT
    OpportunityId,
    AccountId,
    OwnerId,
    RegionCode,
    BusinessUnitCode,
    OpportunityStage,
    EstimatedAmount,
    CreatedOn,
    ExpectedCloseDate
FROM dbo.SampleOpportunity;
GO

/*
    The sample table above is illustrative. The view does not represent
    an actual employer schema or a production CRM extraction implementation.
*/
