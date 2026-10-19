# Hotel Revenue Management & Dynamic Pricing Dashboard - Technical Report

## 1. Executive Summary
This report audits a team project built on the Kaggle *Hotel Booking Demand* data using SQL Server and Power BI. The original CSV (119,390 rows, 32 columns) was independently profiled. Dashboard KPIs for bookings (119K), cancellation rate (37.04%) and Average ADR (101.83) match the CSV exactly. The dashboard's Total Revenue (31.26M) could not be reproduced and needs confirmation from the DAX. The dynamic-pricing view is a constant-demand scenario (+30% price gives +30% revenue by construction), not a forecast. The supplied SQL file is schema-only, and the database backup could not be opened, so the cleaning steps are not verified.

## 2. Project Overview
SQL Server holds a star-style model (raw, dimensions and facts schemas). Power BI presents one dashboard page with KPI cards, charts, slicers and a Price Change % slicer.

## 3. Business Problem
Hotels need to understand booking volume, cancellations and price levels, and to test how price changes could affect revenue.

## 4. Project Objectives
Explore bookings and cancellations by hotel, segment, deposit type and customer type; report ADR; simulate price scenarios.

## 5. Dataset Source and Description
Kaggle *Hotel Booking Demand* (City Hotel 79,330 rows; Resort Hotel 40,060), arrivals July 2015 - August 2017. 32 columns including hotel, is_canceled, lead_time, arrival date parts, ADR, market_segment, distribution_channel, adults/children/babies, deposit_type, customer_type, reservation_status.

## 6. Initial Data Audit (original CSV, unmodified)
See `results/data_quality_summary.csv`.

| Check | Count | Business implication |
|---|---|---|
| Exact duplicate rows | 31,994 | Possible double counting, or legitimate repeats (no booking ID) |
| Zero total guests | 180 | Invalid bookings |
| Zero total nights | 715 | No stay value |
| ADR = 0 | 1,959 | Lowers average ADR; complimentary or missing price |
| Negative ADR | 1 (-6.38) | Invalid |
| ADR maximum | 5,400 | Outlier |
| agent 'NULL' text | 16,340 | Missing agent |
| company 'NULL' text | 112,593 | 94% empty |
| country 'NULL' text | 488 | Missing country |
| children 'NA' text | 4 | Breaks numeric typing |
| Undefined market/channel/meal | 2 / 5 / 1,169 | Unclassified |

Cancellation is fully consistent with status: all `Check-Out` rows are not canceled; `Canceled` and `No-Show` rows are canceled.

## 7. Data Cleaning and Quality Checks
| Item | Original state (verified) | Implemented transformation | Resulting state |
|---|---|---|---|
| Rows | 119,390 | Not documented in supplied scripts | Dashboard shows 119K bookings and ADR 101.83, both consistent with **no rows removed** (inference, not proof) |
| Missing text (NULL/NA) | see section 6 | Schema shows agent as INT and children as DECIMAL NOT NULL, so conversion occurred; method not documented | Unverified |
| Date fields | Separate year/month/day | Schema has `arrival_date` and `booking_date` (date) | Combination logic not in supplied script |
| Columns | 32 | Schema omits distribution_channel, babies, is_repeated_guest, booking_changes, company, parking, special requests | 25 raw columns |
| Zero-guest / ADR anomalies | present | Not documented | Not verified |

Recommended but **not implemented by the team (as far as evidence shows):** remove or flag zero-guest rows, investigate ADR outliers and negative ADR, review duplicates, standardise `Undefined`.

## 8. SQL Implementation
`sql/hotel.sql` (UTF-16, SSMS "script database") creates database `HotelBookingDB`, schemas `raw`, `dimensions`, `facts`, ten dimension tables (agent, country, customer_type, date, deposit_type, hotel, market_segment, meal, reservation_status, room_type), the fact table `facts.booking` and 10 foreign keys. It contains no data-loading, cleaning or analytical queries. Nothing was executed on SQL Server.

## 9. Data Transformation and Data Modeling
`facts.booking` references each dimension by surrogate key (room_type is role-playing: reserved and assigned). Measures available in the fact table: is_canceled, lead_time, nights, adults, children, previous cancellations, waiting list, adr.

## 10. Power BI Model and Relationships
Evidence: visuals combine fields from `dimensions hotel`, `market_segment`, `deposit_type`, `customer_type`, `country` with measures in `_Measures`, which implies working relationships. The relationship definitions themselves were not read (compressed DataModel).

## 11. DAX Measures and KPI Definitions
Measure names found: Avg_ADR, Cancellation_rate, Total_Booking, Confirmed_Booking, Canceled_Booking, Total Revenue (`_Measures`); Scenario Revenue, Revenue Difference (`Price Change %`). DAX text not read. Behaviour observed against the CSV:

| KPI | Dashboard | Recomputed from CSV | Status |
|---|---|---|---|
| Total_Booking | 119K | 119,390 | Consistent |
| Cancellation_rate | 37.04% | 44,224 / 119,390 = 37.04% | Match |
| Avg_ADR | 101.83 | mean ADR of all rows = 101.83 | Match (includes canceled and zero-ADR rows) |
| Avg ADR City / Resort | ~105 / ~95 | 105.30 / 94.95 | Consistent |
| Cancellation by deposit | ~99% / ~28% / ~22% | 99.36 / 28.38 / 22.22 | Consistent |
| Segment share Online TA | 47.3% | 47.30% | Match |
| Total Revenue | 31.26M | ADR x nights: 42.72M all, 26.00M non-canceled | **Not reproduced** |
| Scenario Revenue | 40.64M | 31.26M x 1.30 | Arithmetic consistent |
| Revenue Difference | 9.38M | 0.30 x 31.26M | Arithmetic consistent |

## 12. What-If Dynamic Pricing Scenario Analysis
A `Price Change %` parameter (slicer set to 30% in the screenshot) feeds Scenario Revenue and Revenue Difference. The reported numbers equal Total Revenue multiplied by 1.30, so **demand is held constant** and the result is a scenario simulation. It does not model price elasticity, cancellations or occupancy, and is not a validated demand forecast or a guaranteed profit increase. Whether the scenario applies to canceled bookings depends on the unread DAX.

## 13. Dashboard Design and Interactivity
One page, 16 visuals: 6 KPI cards; cancellation rate by deposit type (bar); Avg ADR by hotel (line); bookings by market segment (donut); confirmed vs canceled by customer type (column); revenue and scenario revenue by month (line); revenue by country (bar); slicers for hotel, customer type, market segment, deposit type and Price Change %. The monthly chart peaks in January, which differs from the arrival-month pattern in the CSV (arrivals peak in August), so its month field is probably not arrival month (probably booking date; unverified).

## 14. Key Findings and Verified Results
| Finding | Value | Formula / unit |
|---|---|---|
| Rows x columns | 119,390 x 32 | |
| Canceled bookings | 44,224 (37.04%) | SUM(is_canceled)/rows |
| City vs Resort cancellation | 41.73% vs 27.76% | per hotel |
| Avg ADR City vs Resort | 105.30 vs 94.95 | mean adr |
| Non Refund deposit cancellation | 99.36% | 14,587 bookings |
| Groups segment cancellation | 61.06% | 19,811 bookings |
| Direct / Corporate cancellation | 15.34% / 18.73% | |
| Online TA ADR vs Groups ADR | 117.20 vs 79.48 | |
| Top non-canceled stay-value countries | PRT 5.54M, GBR 4.11M, FRA 3.10M | adr x nights, non-canceled |
| Arrivals by month | Aug 13,877 highest; Jan 5,929 lowest | row counts |

## 15. Business Insights and Recommendations
These are observations from the data; none has been tested as an intervention.
- Non-refundable bookings cancel at 99.36%, which is unusual and worth checking for data coding or no-show handling.
- Groups cancel most (61.06%); consider stricter deposit or release rules.
- City Hotel cancels more but has the higher ADR.
- Seasonality: bookings peak in summer (Jul-Aug).
- Before using the pricing scenario operationally, add a demand-response assumption.

## 16. Data Validation and Quality Assurance
Independent pandas recomputation on the original CSV; comparison with screenshot values; visual-binding inspection of the `.pbix`. Not done: SQL Server execution, DAX inspection, backup restore.

## 17. Limitations and Assumptions
See `docs/limitations.md`.

## 18. Team Contributions
No names were provided. Roles with the evidence found:

| Role | Evidence in files |
|---|---|
| Person 1 - SQL ingestion and cleaning | `raw.hotel_bookings_raw` table exists; cleaning statements not in supplied script |
| Person 2 - Data preparation and modeling | dimension/fact tables, `arrival_date`/`booking_date` columns in schema |
| Person 3 - Relationships, DAX, KPIs | `_Measures` table with six KPI measures bound to visuals; DAX text unread |
| Person 4 - What-If pricing | `Price Change %` parameter with Scenario Revenue and Revenue Difference measures |
| Person 5 - Dashboard integration | one 16-visual page with cards, slicers, custom background |

## 19. Reproducibility Instructions
1. Download the CSV (see `data/README.md`). 2. Restore `HotelBookingDB.bak` on SQL Server 2022 (compatibility level 160) or run `sql/hotel.sql` for the empty schema. 3. Open `powerbi/Final___Hotel.pbix` in Power BI Desktop and refresh. 4. Recompute metrics from the CSV with any tool using the formulas in section 11.

## 20. Conclusion
Core KPIs reconcile with the raw data. The revenue definition and the cleaning logic remain to be documented by the team, and the pricing view should be presented as a fixed-demand simulation.

## 21. References
- Antonio, N., de Almeida, A., & Nunes, L. (2019). Hotel booking demand datasets. Data in Brief, 22, 41-49.
- Kaggle: https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand
