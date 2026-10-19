# Hotel Revenue Management & Dynamic Pricing Dashboard

A hotel booking analytics project built with SQL Server and Power BI to analyze booking patterns, cancellations, Average Daily Rate (ADR), and hypothetical dynamic pricing scenarios.

![Hotel Revenue Management Dashboard](powerbi/Dashboard/dashboard.jpg)

## Business Problem and Objectives

Hotel revenue teams need to understand booking behavior, cancellation patterns, and room pricing to support revenue management decisions.

This project aims to:
- Analyze booking volume and cancellation patterns.
- Compare Average Daily Rate (ADR) across hotel types.
- Explore cancellation behavior by deposit type, market segment, and customer type.
- Monitor revenue-related KPIs.
- Evaluate hypothetical price changes using a What-If parameter in Power BI.

## Dataset

**Hotel Booking Demand** dataset from Kaggle.

- **Records:** 119,390
- **Columns:** 32
- **Source:** [Hotel Booking Demand — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)

The original dataset is not included in this repository. Download it from Kaggle before reproducing the analysis.

## Tools and Technologies

- SQL Server
- SQL
- Microsoft Power BI
- DAX
- Power BI What-If parameter

## Project Workflow

1. Download the original CSV dataset from Kaggle.
2. Load and organize the booking data in SQL Server.
3. Structure the database using `raw`, `dimensions`, and `facts` schemas.
4. Connect the data model to Power BI.
5. Build DAX measures, KPI cards, charts, and slicers.
6. Use the price-change parameter to explore hypothetical revenue scenarios.

**Workflow:** CSV → SQL Server → Power BI data model → DAX measures → Interactive dashboard.

## Key Findings

The following figures were calculated from the original CSV dataset.

| Metric | Result |
|---|---:|
| Total bookings | 119,390 |
| Overall cancellation rate | 37.04% |
| City Hotel cancellation rate | 41.73% |
| Resort Hotel cancellation rate | 27.76% |
| Average ADR | 101.83 |
| City Hotel average ADR | 105.30 |
| Resort Hotel average ADR | 94.95 |
| Non-Refund deposit cancellation rate | 99.36% |
| Groups segment cancellation rate | 61.06% |

These results highlight differences in cancellation behavior between hotel types, deposit categories, and market segments.

## Dynamic Pricing Scenario

The dashboard includes a **Price Change %** parameter that allows users to explore hypothetical price adjustments and their effect on modeled revenue.

At a 30% price increase, the displayed scenario changes revenue from approximately **31.26M to 40.64M**, representing a modeled difference of approximately **9.38M**.

The scenario assumes demand remains constant. It is intended for sensitivity analysis and does not account for customer response, changes in booking volume, operating costs, or profit margins.

## Dashboard Features

The Power BI dashboard contains 17 visuals:

- **6 KPI cards:** cancellation rate, total bookings, revenue difference, average ADR, total revenue, and scenario revenue.
- **6 charts:** cancellation by deposit type, ADR by hotel, bookings by market segment, booking status by customer type, monthly revenue scenario comparison, and revenue by country.
- **5 slicers:** interactive filters for exploring the dashboard data.

## Repository Structure

```text
Hotel-Revenue-Management-Dynamic-Pricing/
├── Data/
│   └── README.md
├── sql/
│   ├── hotel.sql
│   └── hotel_utf8.sql
├── powerbi/
│   ├── Final___Hotel.pbix
│   └── Dashboard/
│       └── dashboard.jpg
├── reports/
│   └── Hotel_Revenue_Management_Report.md
└── README.md
```

## Reproduction

1. Download the original dataset from the Kaggle link above.
2. Follow the available database setup instructions and prepare the SQL Server database.
3. Open `powerbi/Final___Hotel.pbix` in Power BI Desktop.
4. Configure the data source and database connection as needed.
5. Refresh the data model and explore the dashboard.

## Data Quality and Preparation

Initial profiling of the original CSV identified:
- 31,994 duplicate-looking rows.
- 180 rows with zero guests.
- 715 rows with zero nights.
- 1,959 rows with an ADR of zero.
- One row with a negative ADR value.
- Missing or placeholder values in several columns.

These checks help identify records that require attention during data preparation and analysis.

## Team Contributions

The project was divided into five roles covering SQL ingestion, data modeling, DAX and KPI development, dynamic pricing scenario analysis, and dashboard design.

See Section 18 of the project report for the team contribution breakdown.

## References

- Antonio, N., de Almeida, A., & Nunes, L. (2019). *Hotel booking demand datasets*. Data in Brief, 22.
- [Hotel Booking Demand dataset — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)
