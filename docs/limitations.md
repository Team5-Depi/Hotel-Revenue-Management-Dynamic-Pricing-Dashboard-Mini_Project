# Limitations

## Inspection limits
- No SQL Server was available: nothing was executed against SQL Server. `HotelBookingDB.bak` (86 MB, SQL Server tape-format backup) could not be restored or read, so row counts and any data-cleaning logic inside the database are **unverified**.
- `hotel.sql` contains no cleaning/ETL statements, so the team's cleaning steps cannot be documented from it. Only the resulting schema is known.
- DAX measures, relationships, calculated columns and the What-If parameter definition are inside the compressed DataModel and were not read. Visual-to-field bindings and the dashboard screenshot are the evidence used.
- **Dashboard Total Revenue (31.26M) could not be reproduced** from the CSV with the formulas tested (ADR x nights all bookings 42.72M; non-canceled 26.00M; ADR x week-nights 31.15M; others). Its definition must be confirmed from the DAX in Power BI Desktop.

## Data limits
- The dataset has no booking ID; 31,994 fully identical rows may be legitimate separate bookings.
- ADR = 0 (1,959 rows), 1 negative ADR, a maximum of 5,400, 180 zero-guest rows and 715 zero-night rows affect averages and revenue estimates.
- ADR is a price per night, so ADR-based revenue is an *estimated booking value*, not recognized revenue; canceled bookings are not guaranteed income.

## What-If scenario
The scenario value displayed equals Total Revenue x (1 + price change %) (31.26M x 1.30 = 40.64M). Demand is therefore held constant: a simulation, not a demand forecast and not an expected profit gain. Real price changes affect cancellations and occupancy; the evidence here (e.g. segments with higher ADR also cancel more) does not establish price elasticity.
