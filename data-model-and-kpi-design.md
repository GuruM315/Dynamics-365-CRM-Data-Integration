# Data Model and KPI Design

## 1. Modeling principles

- Define the grain of every fact table before creating relationships.
- Use conformed dimensions for Date, Account, Employee/Salesperson, Region and Business Unit where appropriate.
- Use stable keys and document source-to-target mappings.
- Avoid ambiguous many-to-many relationships unless deliberately designed and tested.
- Keep measures in a consistent semantic layer and document their business definitions.

## 2. Example subject areas

| Subject area | Possible grain | Example dimensions |
|---|---|---|
| Opportunity | One row per CRM opportunity or opportunity line, as defined | Date, Account, Owner, Stage, Region |
| Invoice | One row per invoice or invoice line, as defined | Invoice Date, Account, Salesperson, Region |
| Sales Order | One row per order or order line, as defined | Order Date, Account, Owner |
| Campaign / Lead | One row per campaign activity or lead, as defined | Campaign, Lead Source, Date, Region |

## 3. KPI definition template

For each KPI, record:
- Display name
- Business definition
- Numerator and denominator, if applicable
- Grain and aggregation rule
- Date basis (created, modified, close, invoice, etc.)
- Currency and conversion rules
- Exclusions and filters
- Source table/view and semantic model measure
- Business owner and validation status

## 4. Example definitions (illustrative)

**Invoice Amount:** Sum of the approved invoice amount field for invoices in the selected reporting period.

**Open Pipeline:** Sum of the approved opportunity amount for opportunities classified as open under the agreed business rule.

**Target Achievement %:** Actual performance divided by target, multiplied by 100. Define zero-target behavior and ensure numerator and denominator use the same period and scope.

**Lead-to-Opportunity Conversion %:** Count of eligible leads converted to opportunities divided by the eligible lead population, using an agreed cohort and attribution rule.

These are examples only. Use the organization's approved KPI definitions in a real implementation.
