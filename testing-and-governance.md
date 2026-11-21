# Testing, Governance and Performance

## Functional testing

- Validate KPI calculations against approved source or finance/sales totals.
- Confirm date slicers and period comparisons use the intended date field.
- Validate drill-through, cross-filtering and interactions.
- Test blank, zero, negative and unusually large values.
- Confirm totals reconcile at each reporting level.

## Access testing

- Test all approved access types and combinations.
- Verify unauthorized users cannot retrieve restricted rows through visuals, exports or alternate report paths.
- Validate each semantic model and downstream report.
- Re-test after changes to mapping data, relationships or role definitions.

## Performance testing

- Identify expensive visuals and high-cardinality filters.
- Review SQL query plans and stored procedure performance where applicable.
- For DirectQuery, assess source query latency, concurrency and visual interaction patterns.
- Use Performance Analyzer and supported model diagnostics.
- Avoid asserting performance improvements without measured before/after evidence.

## Governance

- Maintain KPI definitions and data lineage.
- Use development, test and production deployment practices as applicable.
- Keep source control for documentation, SQL templates and supported model artifacts.
- Restrict workspace permissions using least privilege.
- Record report owner, business owner, refresh/query mode and support contact.
- Keep credentials and sensitive data out of source control.
