# Hotel Revenue Management & Dynamic Pricing Dashboard
## Technical Project Report

## 1. Executive Summary

This project analyzes hotel booking data to explore booking patterns, cancellation behavior, pricing indicators, and revenue scenarios. The project uses SQL Server to organize the data and Microsoft Power BI to develop an interactive dashboard with DAX measures and a What-If parameter for dynamic pricing analysis.

The original Hotel Booking Demand dataset contains 119,390 records and 32 columns. The analysis includes cancellation rates, Average Daily Rate (ADR), deposit types, market segments, customer types, and country-level revenue views.

The dashboard presents six KPI cards, six charts, and five slicers. Its dynamic pricing feature allows users to examine how hypothetical price changes affect modeled revenue under a constant-demand assumption.

## 2. Project Overview

**Project title:** Hotel Revenue Management & Dynamic Pricing Dashboard

**Domain:** Hospitality analytics and revenue management

**Primary tools:**
- SQL Server and SQL
- Microsoft Power BI
- DAX
- What-If parameter

The project combines database organization, analytical measures, interactive visualizations, and scenario analysis in one reporting workflow.

## 3. Business Problem

Hotels need to understand booking patterns, cancellation behavior, and room pricing to make informed revenue management decisions.

Questions addressed by this project include:

- How many bookings are represented in the dataset?
- How does cancellation behavior differ between City Hotel and Resort Hotel?
- How does ADR vary by hotel type?
- Which deposit types and market segments have high cancellation rates?
- How do booking and revenue indicators vary across categories and time?
- How does a hypothetical price adjustment affect the revenue value displayed by the dashboard?

## 4. Project Objectives

The main objectives are to:

1. Profile the original dataset and identify data quality issues.
2. Organize booking data using SQL Server schemas and tables.
3. Develop a Power BI data model for analytical reporting.
4. Create DAX measures for booking, cancellation, stay-duration, ADR, and revenue indicators.
5. Build an interactive dashboard with KPI cards, charts, and slicers.
6. Implement a What-If parameter for hypothetical pricing analysis.
7. Communicate findings through visualizations and business-oriented recommendations.

## 5. Dataset Description

The project uses the **Hotel Booking Demand** dataset.

**Source:** [Hotel Booking Demand — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)

| Dataset attribute | Description |
|---|---|
| Original records | 119,390 |
| Original columns | 32 |
| Domain | Hotel reservations |
| Main hotel categories | City Hotel and Resort Hotel |
| Main analytical areas | Bookings, cancellations, ADR, customer segments, deposit types, and stay duration |

The dataset contains reservation-related fields such as hotel type, arrival information, lead time, stay duration, guest counts, booking channels, market segments, deposit types, ADR, and reservation status.

The original CSV is not included in the repository and should be obtained from the Kaggle source.

## 6. Initial Data Audit

Initial profiling of the original, unmodified CSV identified the following data quality characteristics.

| Observation | Count or value |
|---|---:|
| Original records | 119,390 |
| Original columns | 32 |
| Duplicate-looking rows | 31,994 |
| Rows with zero guests | 180 |
| Rows with zero nights | 715 |
| Rows with ADR equal to zero | 1,959 |
| Rows with negative ADR | 1 |
| Maximum ADR | 5,400 |
| Missing country values | 488 |
| Missing agent values | 16,340 |
| Missing company values | 112,593 |
| Missing children values | 4 |
| Undefined market segment values | 2 |
| Undefined distribution channel values | 5 |
| Undefined meal values | 1,169 |

These observations describe the original CSV before considering any transformations applied during the project workflow.

Duplicate-looking rows and unusual numerical values require interpretation in the context of hotel bookings. For example, a zero ADR may represent a special booking condition rather than an invalid record. Data preparation decisions should consider both data quality and business meaning.

## 7. Data Cleaning and Preparation

Data profiling provides the basis for preparing the dataset for analysis. The project workflow organizes the data for SQL Server and Power BI reporting.

The principal preparation areas include:

- Reviewing column types and data structure.
- Identifying missing and placeholder values.
- Inspecting duplicate-looking records.
- Examining zero, negative, and unusually high ADR values.
- Reviewing guest counts and stay-duration fields.
- Organizing booking data for analytical queries and dashboard measures.

The original CSV provides the baseline for data profiling. The SQL database and Power BI model are used in the subsequent analytical workflow.

## 8. SQL Server Implementation

SQL Server is used as the database layer for organizing hotel booking data.

The database structure follows three main schema categories:

| Schema | Purpose |
|---|---|
| `raw` | Stores source-level booking data |
| `dimensions` | Organizes descriptive attributes used for analysis |
| `facts` | Holds booking-related analytical records |

The project SQL files include `sql/hotel.sql` and `sql/hotel_utf8.sql`.

This structure separates source data, descriptive entities, and analytical records, providing an organized foundation for Power BI reporting.

## 9. Data Transformation and Analytical Preparation

The project workflow moves data from the source CSV into SQL Server and then into Power BI.

The analytical preparation process focuses on:

1. Making booking attributes available for analysis.
2. Organizing descriptive categories for filtering and grouping.
3. Preparing date-related and booking-related fields for reporting.
4. Supporting measures that summarize bookings, cancellations, stay duration, ADR, and revenue.
5. Enabling comparisons across hotel types, customer types, deposit types, market segments, and countries.

The final report is designed to support interactive analysis rather than isolated spreadsheet calculations.

## 10. Power BI Data Model

The Power BI model uses a set of dimension tables to organize booking attributes and support analytical reporting.

The reported dimension tables are:

1. `agent`
2. `country`
3. `customer_type`
4. `date`
5. `deposit_type`
6. `hotel`
7. `market_segment`
8. `meal`
9. `reservation_status`
10. `room_type`

The model also includes booking-related data and a `_Measures` table for organizing DAX measures.

The model supports analysis by hotel type, country, customer type, deposit type, market segment, meal, room type, agent, reservation status, and date.

## 11. DAX Measures and KPI Definitions

The project includes the following measures in the `_Measures` table.

| Measure | Analytical purpose |
|---|---|
| `Total_Booking` | Summarizes the number of bookings represented by the model |
| `Confirmed_Booking` | Reports bookings classified as confirmed by the measure logic |
| `Canceled_Booking` | Reports bookings classified as canceled by the measure logic |
| `Cancellation_rate` | Measures cancellations relative to the applicable booking population |
| `Avg_ADR` | Reports Average Daily Rate |
| `Average Lead Time` | Summarizes the time between booking and arrival |
| `Average Length of Stay` | Summarizes the duration of hotel stays |
| `Total Nights Stayed` | Reports the total nights represented by the measure |
| `Total Revenue` | Provides the revenue value displayed by the dashboard |

The pricing scenario also uses the following measures:

| Measure | Analytical purpose |
|---|---|
| `Price Change % Value` | Returns the selected price-change parameter value |
| `Revenue Change %` | Represents the relative revenue change calculated by the scenario |
| `Revenue Difference` | Displays the difference between modeled scenario revenue and the base revenue |
| `Scenario Revenue` | Displays revenue under the selected price-change scenario |

The exact results of each measure depend on its DAX definition, the model relationships, and the current report filter context.

## 12. Dynamic Pricing Scenario Analysis

The dashboard includes a What-If parameter named `Price Change %`.

The parameter allows the user to change the hypothetical price adjustment and observe the resulting revenue values displayed by the dashboard.

The scenario uses the following concepts:

- **Base revenue:** the revenue value displayed before applying the selected price change.
- **Price change:** the percentage selected by the user.
- **Scenario revenue:** the revenue value displayed under the selected scenario.
- **Revenue difference:** the difference between scenario revenue and base revenue.
- **Revenue change percentage:** the relative change represented by the scenario measures.

### Example scenario

At a selected price increase of 30%, the dashboard displays approximately:

| Indicator | Displayed value |
|---|---:|
| Base revenue | 31.26M |
| Scenario revenue | 40.64M |
| Revenue difference | 9.38M |

The scenario holds demand constant. It therefore demonstrates the mathematical effect of a price adjustment under the selected assumptions, rather than modeling changes in demand, occupancy, booking volume, or operating costs.

## 13. Dashboard Design and Interactivity

The Power BI dashboard contains 17 visuals.

### KPI cards

The six KPI cards display:

1. `Cancellation_rate`
2. `Total_Booking`
3. `Revenue Difference`
4. `Avg_ADR`
5. `Total Revenue`
6. `Scenario Revenue`

### Charts

The six charts cover:

1. Cancellation rate by deposit type.
2. ADR by hotel type.
3. Bookings by market segment.
4. Confirmed versus canceled bookings by customer type.
5. Monthly base revenue and scenario revenue.
6. Revenue by country.

### Slicers

The dashboard includes five slicers to allow users to filter the displayed results and explore different subsets of the booking data.

Together, the cards, charts, and slicers provide an interactive view of booking performance, cancellation patterns, pricing indicators, and revenue scenarios.

## 14. Key Findings and Results

The following findings were calculated from the original CSV dataset.

### Booking and cancellation patterns

- The original dataset contains 119,390 bookings.
- The overall cancellation rate is approximately 37.04%.
- City Hotel has a cancellation rate of approximately 41.73%.
- Resort Hotel has a cancellation rate of approximately 27.76%.

The difference between the two hotel categories indicates that cancellation behavior varies by hotel type.

### Average Daily Rate

- Overall average ADR is approximately 101.83.
- City Hotel average ADR is approximately 105.30.
- Resort Hotel average ADR is approximately 94.95.

City Hotel has a higher average ADR than Resort Hotel in the original dataset.

### Deposit types and market segments

- The Non-Refund deposit category has a cancellation rate of approximately 99.36%.
- The Groups market segment has a cancellation rate of approximately 61.06%.

These results identify categories that merit closer investigation when evaluating cancellation policies and booking behavior.

### Revenue scenario

The dashboard displays a base revenue of approximately 31.26M and a scenario revenue of approximately 40.64M at a 30% price increase, with a displayed difference of approximately 9.38M.

This result illustrates the pricing scenario implemented in the dashboard under its constant-demand assumption.

## 15. Business Insights and Recommendations

### Cancellation management

The difference in cancellation rates between City Hotel and Resort Hotel suggests that cancellation policies and booking behavior should be analyzed separately for each hotel type.

### Deposit policy evaluation

The high cancellation rate associated with the Non-Refund deposit category should be reviewed alongside booking conditions, segment composition, and the definition of the cancellation-rate measure.

### Market segment analysis

The Groups segment's cancellation rate suggests an opportunity to investigate group booking terms, booking lead times, and cancellation patterns.

### Pricing analysis

The What-If parameter provides a simple way to explore hypothetical price changes. For operational use, pricing decisions should also consider demand, occupancy, booking pace, seasonality, and costs.

### Dashboard use

The dashboard can serve as an exploratory reporting tool for reviewing booking and cancellation indicators and comparing results across the available categories.

## 16. Data Validation and Quality Checks

The initial audit identifies important characteristics of the source data, including duplicate-looking rows, missing values, zero-guest records, zero-night records, and unusual ADR values.

The original CSV provides the reference dataset for profiling and calculating the findings presented in this report.

The project workflow then organizes the data through SQL Server and Power BI, where measures and visuals present the booking and pricing analysis.

For consistent interpretation, the selected date range, filter context, cancellation definition, and revenue definition should be considered when comparing KPI values.

## 17. Limitations and Assumptions

### Dataset characteristics

The source data includes missing values, placeholder values, duplicate-looking records, and unusual numerical observations. Their interpretation depends on the meaning of the relevant fields and the intended analysis.

### Revenue interpretation

Revenue figures depend on the definition implemented in the model. The dashboard's revenue indicators should be interpreted according to the measure logic and model filter context.

### Dynamic pricing assumptions

The pricing scenario assumes that demand remains constant when the price changes. It does not model customer price sensitivity, changes in occupancy, competitor pricing, operating costs, or profit margins.

### Analytical scope

The dashboard is designed for descriptive analysis and hypothetical scenario exploration. It does not constitute a demand-forecasting model or an optimization system for automatically setting hotel prices.

## 18. Team Contributions

The project was divided into five roles:

1. **SQL ingestion:** database setup and source-data handling.
2. **Data modeling:** organization of tables and analytical relationships.
3. **DAX and KPIs:** development of measures and performance indicators.
4. **Dynamic pricing:** implementation of the What-If parameter and scenario measures.
5. **Dashboard design:** creation of KPI cards, charts, slicers, and report layout.

This division separates the main technical tasks involved in building the analytics solution.

## 19. Reproducibility Instructions

To reproduce the project workflow:

1. Download the original CSV from the Kaggle source listed in Section 21.
2. Prepare the SQL Server database using the SQL files included in the repository.
3. Load the dataset into the database according to the database setup process.
4. Open `powerbi/Final___Hotel.pbix` in Power BI Desktop.
5. Configure the data source and database connection.
6. Refresh the model.
7. Review the KPI cards, charts, slicers, and dynamic pricing scenario.

The original CSV must be obtained separately because it is not included in the repository.

## 20. Conclusion

The Hotel Revenue Management & Dynamic Pricing Dashboard combines SQL Server data organization with Power BI reporting to explore hotel bookings, cancellation behavior, ADR, and revenue scenarios.

The analysis highlights differences in cancellation rates between hotel types, variation in ADR, and cancellation patterns across deposit types and market segments.

The interactive dashboard brings these indicators together and includes a What-If parameter for exploring hypothetical price adjustments. This provides a foundation for further work in hotel revenue analytics, with additional opportunities to incorporate demand behavior, occupancy, seasonality, and cost information.

## 21. References

1. Antonio, N., de Almeida, A., & Nunes, L. (2019). *Hotel booking demand datasets*. Data in Brief, 22.
2. [Hotel Booking Demand dataset — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)
