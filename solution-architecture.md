# CRM Power BI — Solution Architecture

## 1. Logical architecture

```mermaid
flowchart TD
    A["Dynamics 365 CRM"] --> B["CRM subject areas"]
    B --> B1["Accounts and Contacts"]
    B --> B2["Opportunities and Sales"]
    B --> B3["Orders and Invoices"]
    B --> B4["Campaigns and Leads (if available)"]
    B1 --> C["SQL Server reporting layer"]
    B2 --> C
    B3 --> C
    B4 --> C
    C --> D["Stored procedures / views / reporting datasets"]
    D --> E["Power BI semantic models"]
    E --> F["Management reports"]
    E --> G["Sales reports"]
    E --> H["Marketing reports"]
    I["Identity and access mapping"] --> E
    E --> J["Power Automate PDF export and email"]
```

## 2. Architecture layers

| Layer | Purpose | Typical artifacts |
|---|---|---|
| CRM source | Operational business data | Accounts, Contacts, Opportunities, Orders, Invoices, Campaigns and Leads |
| SQL reporting | Prepare consistent reporting datasets | Tables, views, stored procedures |
| Semantic model | Relationships, measures and metadata | Power BI semantic models, DAX |
| Report experience | Role-focused analytics | Management, Sales and Marketing reports |
| Security | Restrict data to authorized users | User mapping, role/scope rules, RLS where configured |
| Distribution | Deliver recurring reports | Power Automate flows, PDF exports, recipient configuration |

## 3. Semantic model design

A typical commercial CRM model may include dimensions such as Date, Account, Employee/Salesperson, Region, Business Unit, Campaign and Opportunity Stage, with facts such as Opportunity, Invoice, Sales Order and Campaign Activity. The actual model should follow available source data and grain.

Document for each model:
- Business purpose and report consumers.
- Fact table grain and key dimensions.
- Relationship cardinality and filter direction.
- Measures and KPI definitions.
- Storage mode (Import, DirectQuery, Direct Lake or composite, as actually configured).
- Refresh or query behavior and performance considerations.

## 4. Report distribution flow

```mermaid
flowchart TD
    A["Scheduled trigger"] --> B["Identify report and authorized recipients"]
    B --> C["Export Power BI report to PDF"]
    C --> D{"Export successful?"}
    D -- No --> E["Log failure and notify support"]
    D -- Yes --> F["Prepare email and attach/embed PDF"]
    F --> G["Send to approved recipients"]
    G --> H["Log delivery outcome"]
```

The export API, workspace capacity, licensing and connector capabilities must be validated for the tenant. Do not distribute a report to recipients whose access scope has not been verified.
