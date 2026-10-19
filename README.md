# Hotel Revenue Management & Dynamic Pricing Dashboard

Power BI dashboard and SQL Server model for hotel booking analysis, cancellations, ADR and a price-change scenario.

![Dashboard](powerbi/Dashboard/dashboard.jpg)

## Business problem and objectives
Understand bookings, cancellations and ADR, and test how a price change could affect revenue.

## Dataset
Kaggle *Hotel Booking Demand* (119,390 rows x 32 columns). Not included; see [data/README.md](Data/README.md).

## Tools
SQL Server, SQL, Power BI, DAX, What-If parameter.

## Workflow
CSV -> SQL Server (`raw`, `dimensions`, `facts` schemas) -> Power BI model and DAX KPIs -> dashboard with pricing scenario.

## Verified findings (recomputed from the original CSV)
| KPI | Value |
|---|---|
| Bookings | 119,390 |
| Cancellation rate | 37.04% (City 41.73%, Resort 27.76%) |
| Average ADR | 101.83 (City 105.30, Resort 94.95) |
| Non Refund deposit cancellation | 99.36% |
| Groups segment cancellation | 61.06% |

Dashboard Total Revenue (31.26M) could **not** be reproduced from the CSV; its DAX must be confirmed. Details: [report](reports/Hotel_Revenue_Management_Report.md), [results](results/key_findings.csv).

## Dynamic pricing simulation
The Price Change % slicer scales revenue (30%: 31.26M -> 40.64M, +9.38M). Demand is held constant, so this is a scenario simulation, not a forecast or guaranteed profit.

## Repository structure
```
README.md  LICENSE  .gitignore
Data/README.md
sql/hotel.sql (UTF-16 original), hotel_utf8.sql
powerbi/Final___Hotel.pbix, Dashboard/dashboard.jpg
reports/Hotel_Revenue_Management_Report.md
docs/data_dictionary.md  methodology.md  limitations.md
results/data_quality_summary.csv  key_findings.csv
```

## Reproduction
Download the CSV into `data/`, restore or create the database from `sql/`, open the `.pbix` in Power BI Desktop and refresh.

## Data limitations
31,994 duplicate rows, 180 zero-guest rows, 1,959 zero-ADR rows, text `NULL`/`NA` values. SQL cleaning steps and DAX were not verifiable. See [docs/limitations.md](docs/limitations.md).

## Team contributions
Five roles (SQL ingestion, modeling, DAX/KPIs, What-If pricing, dashboard design); see report section 18.

## References
Antonio, de Almeida & Nunes (2019), Data in Brief 22; Kaggle dataset page.
