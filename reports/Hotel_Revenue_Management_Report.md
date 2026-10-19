# Hotel Revenue Management & Dynamic Pricing Dashboard — Technical Report

## 1. Executive Summary

This report documents and audits a team project built on the Kaggle Hotel Booking Demand dataset using SQL Server and Power BI. The original CSV contains 119,390 rows and 32 columns. The SQL raw table contains 25 columns, while the Power BI fact table contains 24 columns.

The dashboard displays 119K bookings (rounded), a cancellation rate of 37.04%, and an average ADR of 101.83. These values agree with independent calculations from the original CSV. However, the underlying DAX formulas were not independently inspected, so their correctness remains unverified.

The dashboard displays Total Revenue of approximately 31.26M, Scenario Revenue of 40.64M, and Revenue Difference of 9.38M at the 30% price-change setting. The Total Revenue figure could not be reproduced from the tested ADR-based calculations using the original CSV. Therefore, the revenue figures and pricing scenario remain provisional.

The pricing scenario appears consistent with increasing the displayed base revenue by 30% while holding demand constant. It should be interpreted as a scenario simulation, not a validated demand forecast or a guaranteed increase in revenue or profit.

The supplied SQL script defines the database schema but does not include data-loading or cleaning scripts. The final database contents, data transformations, DAX calculations, and some model relationships could not be independently verified.

## 2. Project Overview

The project uses SQL Server for a database model containing raw, dimension, and fact schemas, and Power BI for interactive reporting.

The dashboard presents booking and cancellation metrics, average daily rate (ADR), customer and market-segment comparisons, country-level analysis, and a price-change scenario.

## 3. Business Problem

Hotels need to understand booking volume, cancellation patterns, customer segments, and room-price levels. They may also want to explore how hypothetical price adjustments could affect revenue.

This project provides a dashboard for exploring booking data and illustrating a potential pricing scenario. The scenario's business validity depends on the assumptions and calculations used in the model.

## 4. Project Objectives

- Analyze bookings and cancellations by hotel, market segment, deposit type, and customer type.
- Examine average daily rates across hotels and customer segments.
- Explore booking patterns by country and month.
- Present key booking and cancellation indicators in an interactive dashboard.
- Simulate hypothetical price changes using a What-If parameter.
- Document data-quality issues and limitations affecting interpretation.

## 5. Dataset Source and Description

The project uses the Kaggle *Hotel Booking Demand* dataset.

Source: https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand

The original CSV contains 119,390 rows and 32 columns:

- City Hotel: 79,330 records.
- Resort Hotel: 40,060 records.
- Arrival dates: July 2015 through August 2017.

The dataset includes booking status, lead time, arrival-date components, ADR, market segment, distribution channel, guest counts, deposit type, customer type, and reservation status.

The original CSV contains 32 columns, whereas the SQL raw table contains 25 columns and the Power BI fact table contains 24 columns. The reason for every schema difference has not been fully established.

## 6. Initial Data Audit

The following observations were reported from profiling the original, unmodified CSV. 

| Check | Count | Business implication |
|---|---:|---|
| Exact duplicate rows | 31,994 | Potential duplicate records or legitimate repeated observations; no unique booking identifier was used to establish whether they are erroneous |
| Zero total guests | 180 | Records with no adults, children, or babies require investigation |
| Zero total nights | 715 | Records with no overnight stay require review |
| ADR = 0 | 1,959 | May represent complimentary stays, missing pricing, or other special cases |
| Negative ADR | 1 (-6.38) | Requires investigation before pricing analysis |
| Maximum ADR | 5,400 | Potential outlier requiring validation |
| `agent` contains the text `NULL` | 16,340 | Missing agent information |
| `company` contains the text `NULL` | 112,593 | Extensive missing company information |
| `country` contains the text `NULL` | 488 | Missing country information |
| `children` contains the text `NA` | 4 | May require conversion or missing-value handling |
| Undefined market segment / distribution channel / meal | 2 / 5 / 1,169 | Unclassified or undefined category values |

The original CSV's cancellation status is consistent with the following classification: `Check-Out` records are not canceled, while `Canceled` and `No-Show` records are marked as canceled.

These observations describe the original CSV. They do not establish which records were retained, removed, or transformed in the SQL database or Power BI model.

## 7. Data Cleaning and Quality Checks

| Item | Original state | Transformation evidence | Result and limitation |
|---|---|---|---|
| Rows | 119,390 | Row-filtering logic is not documented in the supplied SQL script | Dashboard booking count and average ADR agree with the original CSV, suggesting that the full dataset may have been retained. The actual row count of `facts.booking` was not verified |
| Missing text values | Text values such as `NULL` and `NA` occur in the CSV | The SQL schema specifies data types for fields such as `agent` and `children`, but the conversion and missing-value handling process is undocumented | The actual conversion and cleaning logic remain unverified |
| Date fields | Arrival year, month, and day are separate CSV columns | `sql/hotel.sql` defines `arrival_date`, `booking_date`, and `reservation_status_date` | The date-construction and booking-date derivation logic are not documented in the supplied script |
| Columns | 32 in the original CSV | The SQL raw schema contains 25 columns, and the Power BI fact table contains 24 columns | Seven original CSV columns are absent from the SQL raw schema: `distribution_channel`, `babies`, `is_repeated_guest`, `booking_changes`, `company`, `required_car_parking_spaces`, and `total_of_special_requests`. The stage at which these columns became unavailable is unverified |
| Zero-guest and ADR anomalies | Zero-guest rows, zero-night records, zero ADR, negative ADR, and extreme ADR values are present | No documented transformation was identified in the supplied SQL script | Whether these records were retained, excluded, or adjusted in the final model is unverified |
| Duplicate-looking rows | 31,994 exact duplicate rows were reported in the original CSV | No documented deduplication logic was identified in the supplied SQL script | The project materials do not establish whether any duplicate records were removed |

Recommended checks, not confirmed as implemented by the team, include investigating zero-guest records, reviewing ADR anomalies, assessing potential duplicates, and standardizing undefined category values.

The agreement between selected dashboard values and CSV calculations is useful evidence, but it does not prove that no rows were removed or that all transformations were performed correctly.

## 8. SQL Implementation

The supplied file, `sql/hotel.sql`, defines the `HotelBookingDB` database, the `raw`, `dimensions`, and `facts` schemas, ten dimension tables, the fact table `facts.booking`, and foreign-key constraints.

The ten dimension tables are:

- `agent`
- `country`
- `customer_type`
- `date`
- `deposit_type`
- `hotel`
- `market_segment`
- `meal`
- `reservation_status`
- `room_type`

The supplied SQL script defines the schema and database structure but does not include data-loading scripts, documented cleaning transformations, or analytical queries. The script was not executed as part of this review.

The final database state and the contents and row count of `facts.booking` could therefore not be independently verified.

The project materials also contain a discrepancy between `sql/hotel.sql` and the SSMS diagram regarding date columns and date-dimension relationships. The final implemented date model remains unconfirmed.

## 9. Data Transformation and Data Modeling

The project uses a fact-and-dimension modeling approach. The fact table schema includes booking attributes such as `is_canceled`, `lead_time`, `nights`, `adults`, `children`, previous cancellations, waiting-list information, and `adr`.

These are fact-table columns, not DAX measures.

The schema includes room-type dimensions for reserved and assigned room types. The supplied SQL script documents the database structure, but it does not establish the actual data-loading, cleaning, or transformation process.

The final data model should be validated against the source CSV and the Power BI model before the project is described as fully reproducible.

## 10. Power BI Model and Relationships

The Power BI model contains a fact table displayed as `facts booking` and ten dimension tables: `agent`, `country`, `customer_type`, `date`, `deposit_type`, `hotel`, `market_segment`, `meal`, `reservation_status`, and `room_type`.

The dashboard uses fields associated with several dimensions and measures from `_Measures`. However, the relationship definitions, cardinalities, and filter directions could not be independently verified from the available model evidence.

The SSMS diagram also differs from `sql/hotel.sql` in its date-column and date-relationship definitions. The diagram shows `arrival_date_key` and `reservation_status_date_key` linked to the date dimension, while the SQL script defines `arrival_date`, `booking_date`, and `reservation_status_date` without those date foreign keys.

The final relationship configuration and date model therefore remain unconfirmed.

## 11. DAX Measures and KPI Definitions

The following measure names were identified in the project materials. Their DAX formulas were not independently inspected. Descriptions of their purposes are therefore based on their names and observed dashboard usage, not verified formula logic.

**Measures associated with `_Measures`:**

- `Average Lead Time`
- `Average Length of Stay`
- `Avg_ADR`
- `Canceled_Booking`
- `Cancellation_rate`
- `Confirmed_Booking`
- `Total Nights Stayed`
- `Total Revenue`
- `Total_Booking`

**Measures associated with `Price Change %`:**

- `Price Change % Value`
- `Revenue Change %`
- `Revenue Difference`
- `Scenario Revenue`

The model also contains a field named `Value`, whose purpose was not confirmed.

### KPI and result comparison

| KPI or finding | Dashboard value | Independent CSV calculation | Status |
|---|---:|---:|---|
| `Total_Booking` | 119K | 119,390 rows | Consistent after rounding; DAX formula unverified |
| `Cancellation_rate` | 37.04% | 44,224 / 119,390 = 37.04% | Values agree; DAX formula unverified |
| `Avg_ADR` | 101.83 | Mean ADR across all original CSV rows = 101.83 | Values agree; includes canceled and zero-ADR rows; DAX formula unverified |
| Average ADR by hotel | Approximately 105 / 95 | City Hotel: 105.30; Resort Hotel: 94.95 | Consistent with the original CSV; DAX formula unverified |
| Cancellation by deposit type | Approximately 99% / 28% / 22% | Non Refund: 99.36%; No Deposit: 28.38%; Refundable: 22.22% | Consistent with the original CSV; DAX formula unverified |
| Online TA segment share | 47.3% | 47.30% | Consistent with the original CSV |
| Total Revenue | 31.26M | ADR × nights: 42.72M across all rows and 26.00M across non-canceled rows | Not reproduced; revenue definition and DAX formula remain unverified |
| Scenario Revenue | 40.64M | 31.26M × 1.30 = 40.638M | Arithmetically consistent with a 30% increase to the displayed base value; DAX formula unverified |
| Revenue Difference | 9.38M | 31.26M × 0.30 = 9.378M | Arithmetically consistent with a 30% increase to the displayed base value; DAX formula unverified |

The ADR-times-nights calculations are test definitions used for comparison. They are not established as the project's official revenue definition and do not necessarily represent recognized hotel revenue.

Agreement between a displayed value and an independently calculated CSV statistic does not independently validate the DAX formula, relationships, or data transformations.

## 12. What-If Dynamic Pricing Scenario Analysis

The dashboard includes a `Price Change %` slicer and the measures `Scenario Revenue` and `Revenue Difference`.

In the reviewed screenshot, the parameter is set to 30%. The dashboard displays approximately:

- Total Revenue: 31.26M
- Scenario Revenue: 40.64M
- Revenue Difference: 9.38M

These displayed values are arithmetically consistent with applying a 30% increase to the displayed base revenue. This suggests a fixed-demand scenario in which revenue changes proportionally with the selected price adjustment.

However, the DAX formulas were not inspected, and the definition of Total Revenue has not been reconciled with an independent calculation from the original CSV.

The scenario should therefore be described as a provisional pricing simulation, not a validated revenue forecast or a guaranteed increase in revenue or profit.

The available evidence does not establish how the calculation treats canceled bookings, changes in demand, occupancy, price elasticity, or other operational constraints. These assumptions should be documented before the scenario is used for decision-making.

## 13. Dashboard Design and Interactivity

The dashboard contains 17 visuals: six KPI cards, six charts, and five slicers.

The six KPI cards display:

- `Cancellation_rate`
- `Total_Booking`
- `Revenue Difference`
- `Avg_ADR`
- `Total Revenue`
- `Scenario Revenue`

The six charts cover:

1. Cancellation rate by deposit type.
2. Average ADR by hotel.
3. Bookings by market segment.
4. Confirmed versus canceled bookings by customer type.
5. Revenue and scenario revenue by month.
6. Revenue by country.

The five slicers are hotel, customer type, market segment, deposit type, and `Price Change %`.

Other identified measures include `Average Lead Time`, `Average Length of Stay`, `Total Nights Stayed`, `Price Change % Value`, and `Revenue Change %`. These measures were not identified among the displayed KPI cards in the reviewed dashboard.

The monthly chart appears to peak in January, while arrival counts in the original CSV peak in August. The month field used in the dashboard has not been verified, so it should not be described as booking month or arrival month without further inspection.

## 14. Key Findings and Verified Results

The following findings were recomputed from the original CSV. They describe that source file and should not automatically be interpreted as independently verified outputs of the final Power BI model.

| Finding | Value | Formula / unit |
|---|---:|---|
| Original dataset size | 119,390 rows × 32 columns | CSV dimensions |
| Canceled bookings | 44,224 (37.04%) | Count of canceled rows / all rows |
| City vs Resort cancellation rate | 41.73% vs 27.76% | Cancellation rate within each hotel type |
| Average ADR: City vs Resort | 105.30 vs 94.95 | Mean ADR by hotel type |
| Non Refund deposit cancellation | 99.36% | Cancellation rate for this deposit type |
| Groups segment cancellation | 61.06% | Cancellation rate within the Groups segment |
| Direct / Corporate cancellation | 15.34% / 18.73% | Cancellation rate by market segment |
| Online TA ADR vs Groups ADR | 117.20 vs 79.48 | Mean ADR by market segment |
| Top non-canceled stay-value countries | PRT: 5.54M; GBR: 4.11M; FRA: 3.10M | ADR × nights for non-canceled rows; analytical proxy, not verified revenue |
| Arrivals by month | August: 13,877; January: 5,929 | Arrival-month row counts |

The country-level stay-value figures are derived from ADR multiplied by nights. They should not be presented as confirmed accounting revenue.

The cancellation rates and segment comparisons are descriptive findings. They do not establish that a particular deposit policy or pricing intervention would cause cancellations to increase or decrease.

## 15. Business Insights and Recommendations

The following recommendations are based on descriptive observations in the original CSV. None has been validated through an intervention or causal analysis.

- **Review non-refundable cancellations.** The observed cancellation rate for the Non Refund category is 99.36%. This unusual result should be checked against the dataset's coding, booking status, and no-show definitions before drawing operational conclusions.
- **Investigate group cancellations.** The Groups segment has an observed cancellation rate of 61.06%. Before changing deposit or release policies, validate the segment definition and examine booking conditions.
- **Compare hotel performance.** City Hotel has a higher observed cancellation rate than Resort Hotel, but it also has a higher average ADR. These differences may reflect distinct customer mixes, locations, or booking patterns.
- **Investigate seasonality.** Arrival counts peak in July and August in the original dataset. Additional analysis could examine seasonality by hotel type, market segment, and booking lead time.
- **Validate pricing assumptions.** Before using the What-If scenario for operational decisions, incorporate or explicitly document assumptions about demand response, cancellations, occupancy, and price elasticity.
- **Reconcile revenue calculations.** Establish a documented revenue definition and validate it against the source data before using revenue-based KPIs to make business decisions.

## 16. Data Validation and Quality Assurance

The original CSV was independently profiled, and key statistics were recomputed using pandas. Selected values were compared with the dashboard screenshot, and the visible Power BI fields and visuals were reviewed.

The following activities were not completed as part of this review:

- Executing the SQL script on SQL Server.
- Restoring and inspecting the database backup.
- Independently verifying the final row count and contents of `facts.booking`.
- Inspecting the DAX formulas.
- Independently verifying all Power BI relationships, calculated columns, Power Query steps, and What-If parameter definitions.
- Reconciling the dashboard's Total Revenue measure with an independently established revenue definition.

Agreement between selected dashboard values and CSV calculations does not, by itself, prove that the underlying DAX formulas, relationships, or data transformations are correct.

## 17. Limitations and Assumptions

The main limitations are:

- **Unverified data pipeline:** The supplied SQL script defines database objects but does not document the data-loading or cleaning process.
- **Schema differences:** The original CSV has 32 columns, the SQL raw table has 25, and the Power BI fact table has 24. The stage at which the seven missing raw-schema columns became unavailable is unknown.
- **Unverified row filtering:** The final row count of `facts.booking` was not confirmed.
- **Unverified DAX formulas:** The names and displayed values of measures are known, but their formula logic has not been independently inspected.
- **Unresolved revenue definition:** Total Revenue could not be reproduced from the tested ADR-times-nights calculations.
- **Date-model discrepancy:** The SQL script and SSMS diagram show different date-column and relationship definitions.
- **Unverified Power Query transformations:** Missing-value handling, duplicate handling, and anomaly treatment are not documented in the supplied SQL script.
- **Pricing scenario assumptions:** The displayed scenario appears consistent with a proportional price adjustment, but demand response and operational effects are not established.
- **Potential source-data anomalies:** Zero-guest records, zero-night records, zero and negative ADR values, extreme ADR values, and duplicate-looking rows require interpretation before operational use.

### Recommended revenue validation

To investigate the revenue discrepancy, the project team should:

1. Inspect the DAX definition of `Total Revenue`.
2. Compare `Total Revenue` with `Total Nights Stayed` and `Total_Booking` under the same filter context.
3. Compare revenue-related measures for canceled and non-canceled bookings.
4. Reconcile the Power BI calculations with the corresponding SQL aggregation and original CSV.
5. Verify the effect of the `Price Change %` parameter on each relevant measure.
6. Document the final formula and its business interpretation.

Until these checks are completed, revenue and pricing-scenario figures should be treated as provisional.

## 18. Team Contributions

The following roles are listed as the team's reported responsibilities. The available technical files provide evidence of project components, but do not independently verify which individual implemented each component.

| Role | Evidence in project materials |
|---|---|
| Mohamed Salah — SQL ingestion and cleaning | The `raw.hotel_bookings_raw` table is referenced in the project materials. The supplied SQL script does not document cleaning statements or data-loading logic |
| Donya Ragab — Data preparation and modeling | Dimension and fact tables are defined in the schema; the date model contains unresolved differences between project artifacts |
| Dalia Hamdy — Relationships, DAX, and KPIs | The `_Measures` table and measures bound to dashboard visuals are identified; the underlying DAX formulas were not independently inspected |
| Omar El-Zayat — What-If pricing | The `Price Change %` parameter and the `Scenario Revenue` and `Revenue Difference` measures are identified in the project materials |
| Menna Emad — Dashboard integration | The reviewed dashboard contains one page with 17 visuals, including KPI cards, charts, and slicers |

These role descriptions should be confirmed by the team before being presented as a verified record of individual contributions.

## 19. Reproducibility Instructions

1. Download the original CSV using the source listed in `data/README.md`.
2. Use `sql/hotel.sql` to create the database schema and tables in SQL Server. The script defines the schema but does not load or clean the dataset.
3. The `HotelBookingDB.bak` backup was not verified as part of this review and is not included in the reviewed repository materials. A successful restore cannot be guaranteed from the supplied files alone.
4. Open `powerbi/Final___Hotel.pbix` in Power BI Desktop. Refreshing the report requires access to the correct database or data source and a compatible model configuration.
5. Recompute the CSV statistics independently using the definitions documented in this report.
6. Inspect and document the DAX formulas, Power Query transformations, data relationships, and What-If parameter configuration before claiming full end-to-end reproducibility.
7. Reconcile the date model and revenue definition before treating the dashboard's revenue calculations as validated results.

The exact refresh steps depend on the data-source configuration embedded in the Power BI file, which was not independently verified in this review.

## 20. Conclusion

The project demonstrates a hotel-booking analysis dashboard with booking and cancellation KPIs, comparisons across hotels and customer segments, country-level analysis, and an interactive price-change scenario.

Several displayed booking and ADR statistics agree with independent calculations from the original CSV. However, the revenue definition and DAX calculations remain unverified, the data-loading and cleaning process is not documented in the supplied SQL script, and discrepancies remain between the SQL schema and the Power BI date model.

The dynamic pricing results should therefore be presented as a provisional fixed-demand simulation rather than a validated forecast. Further validation of the data pipeline, model relationships, and revenue calculations is required before the dashboard is used for operational decisions.

## 21. References

- Antonio, N., de Almeida, A., & Nunes, L. (2019). Hotel booking demand datasets. *Data in Brief, 22*, 41–49.
- Kaggle. *Hotel Booking Demand*. https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand
