
# Hotel Revenue Management & Dynamic Pricing Dashboard
## Technical Project Report

## 1. Executive Summary

This project develops an interactive hotel booking analytics dashboard using SQL Server and Microsoft Power BI. Its objective is to analyze booking patterns, cancellation behavior, Average Daily Rate (ADR), and hypothetical pricing scenarios to support hotel revenue management analysis.

The project uses the Hotel Booking Demand dataset from Kaggle, originally containing 119,390 records and 32 columns. The workflow begins with dataset preparation and column selection, followed by SQL Server schema design, data preparation and analytical measure development in Power BI, dynamic pricing scenario analysis, and dashboard development.

The final dashboard contains six KPI cards, six charts, and five slicers. A What-If parameter enables users to explore hypothetical price changes and their effect on modeled revenue under a constant-demand assumption.

## 2. Project Overview

**Project title:** Hotel Revenue Management & Dynamic Pricing Dashboard

**Domain:** Hospitality analytics and revenue management

**Technologies:**
- SQL Server
- SQL
- Microsoft Power BI
- DAX
- Power BI What-If parameter

The project combines relational database design, data preparation, analytical measures, interactive visualization, and scenario analysis in one reporting solution.

## 3. Business Problem

Hotels need to understand booking patterns, cancellation behavior, and room pricing to make informed revenue management decisions.

This project addresses the following business questions:

- What is the overall booking volume?
- How does cancellation behavior differ between City Hotel and Resort Hotel?
- How does ADR vary by hotel type?
- Which deposit types and market segments have high cancellation rates?
- How do booking and revenue indicators vary across categories and time?
- How does a hypothetical price adjustment affect the revenue displayed by the dashboard?

## 4. Project Objectives

The project objectives are to:

1. Prepare the source dataset by selecting columns relevant to the analysis.
2. Design a SQL Server schema that organizes booking records and descriptive attributes.
3. Establish relationships between fact and dimension tables.
4. Prepare and clean data in Power BI.
5. Develop analytical measures and KPIs using DAX.
6. Implement a What-If parameter for dynamic pricing scenario analysis.
7. Build an interactive dashboard with KPI cards, charts, and slicers.
8. Present findings that help users explore hotel booking and cancellation behavior.

## 5. Dataset Description

The project uses the **Hotel Booking Demand** dataset.

**Source:** [Hotel Booking Demand — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)

| Attribute | Description |
|---|---|
| Original records | 119,390 |
| Original columns | 32 |
| Domain | Hotel reservations |
| Hotel categories | City Hotel and Resort Hotel |
| Main analytical areas | Bookings, cancellations, ADR, customer types, deposit types, market segments, and stay duration |

The dataset contains reservation-related attributes such as hotel type, arrival information, lead time, stay duration, guest counts, booking channels, market segments, deposit types, ADR, and reservation status.

The initial preparation stage involved removing columns considered unnecessary for the project's analytical objectives. The original CSV is not included in the repository and can be obtained from the Kaggle source.

## 6. Project Workflow

The project follows a sequence of database, data preparation, analytical, and visualization tasks.

### 6.1 Dataset Preparation

The original CSV was downloaded from Kaggle. Columns considered unnecessary for the project's objectives were removed to prepare the dataset for the subsequent workflow.

### 6.2 SQL Server Database Design

The database schema was designed to separate booking records from descriptive attributes. A fact table and related dimension tables provide the database structure used in the analytical workflow.

### 6.3 Power BI Data Preparation

The data was brought into Power BI for cleaning and preparation. Analytical measures were developed to support booking, cancellation, ADR, and revenue analysis.

### 6.4 Dynamic Pricing Scenario

A What-If parameter was created to let users change a hypothetical price adjustment. Related measures calculate and display the scenario results, and a slicer provides interactive control over the selected percentage.

### 6.5 Dashboard Development

The resulting measures and scenario outputs were used to create KPI cards, charts, and slicers in an interactive Power BI dashboard.

**Overall workflow:**

Kaggle Dataset → Column Selection → SQL Server Schema → Power BI Data Cleaning and Measures → What-If Scenario → Interactive Dashboard

## 7. Data Quality and Initial Profiling

Initial profiling of the original CSV identified the following characteristics.

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

These figures describe the original source data and provide context for the data preparation process.

Duplicate-looking records and unusual numerical values should be interpreted in the context of hotel bookings. For example, a zero ADR may reflect a particular booking condition rather than automatically indicating an invalid record.

## 8. Data Cleaning and Preparation in Power BI

Power BI was used for data preparation and cleaning following the database design stage.

The data preparation workflow focused on making the dataset suitable for analytical reporting, including the review of:

- Column data types and field structure.
- Missing and placeholder values.
- Duplicate-looking records.
- Zero, negative, and unusually high ADR values.
- Guest counts and stay-duration fields.
- Fields required for booking, cancellation, pricing, and revenue analysis.

The prepared data was then used to support the development of analytical measures and dashboard visuals.

## 9. SQL Server Schema Design

SQL Server provides the relational database structure used in the project.

The database follows three main schema categories.

| Schema | Purpose |
|---|---|
| `raw` | Organizes source-level booking data |
| `dimensions` | Stores descriptive attributes used for grouping and filtering |
| `facts` | Stores booking-related records for analysis |

The database design separates descriptive entities from booking records, allowing analytical queries to use fact and dimension tables.

The project SQL files are:

- `sql/hotel.sql`
- `sql/hotel_utf8.sql`

## 10. Power BI Data Model

The Power BI model supports analysis across booking attributes and descriptive categories.

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

The model also includes booking-related records and a `_Measures` table for organizing DAX calculations.

This structure supports filtering and analysis by hotel, country, customer type, deposit type, market segment, meal, room type, agent, reservation status, and date.

## 11. DAX Measures and KPIs

DAX measures were used to summarize booking performance and support the dashboard.

### 11.1 Main Measures

| Measure | Purpose |
|---|---|
| `Total_Booking` | Reports the booking count according to the measure definition |
| `Confirmed_Booking` | Reports confirmed bookings according to the measure definition |
| `Canceled_Booking` | Reports canceled bookings according to the measure definition |
| `Cancellation_rate` | Calculates the cancellation rate |
| `Avg_ADR` | Reports Average Daily Rate |
| `Average Lead Time` | Summarizes the interval between booking and arrival |
| `Average Length of Stay` | Summarizes the duration of hotel stays |
| `Total Nights Stayed` | Reports total nights according to the measure definition |
| `Total Revenue` | Provides the revenue value displayed by the dashboard |

### 11.2 Dynamic Pricing Measures

| Measure | Purpose |
|---|---|
| `Price Change % Value` | Returns the selected price-change parameter value |
| `Revenue Change %` | Represents the relative revenue change calculated by the scenario |
| `Revenue Difference` | Displays the difference between scenario revenue and base revenue |
| `Scenario Revenue` | Displays revenue under the selected price-change scenario |

The displayed results depend on the DAX definitions, data model, relationships, and current report filter context.

## 12. What-If Dynamic Pricing Scenario

The dashboard includes a What-If parameter named `Price Change %`.

The parameter allows users to select a hypothetical price adjustment using a slicer. The selected value is used by the scenario measures to calculate and display the corresponding revenue indicators.

### 12.1 Scenario Components

- **Base revenue:** the revenue value displayed before applying the selected price change.
- **Price change:** the percentage selected by the user.
- **Scenario revenue:** the modeled revenue value under the selected scenario.
- **Revenue difference:** the difference between scenario revenue and base revenue.
- **Revenue change percentage:** the relative change represented by the scenario measures.

### 12.2 Example Scenario

At a selected price increase of 30%, the dashboard displays the following values.

| Indicator | Displayed value |
|---|---:|
| Base revenue | 31.26M |
| Scenario revenue | 40.64M |
| Revenue difference | 9.38M |

This scenario assumes demand remains constant. It illustrates the effect of the selected price adjustment under the implemented scenario assumptions. It does not model customer price sensitivity, changes in booking volume, occupancy changes, or operating costs.

## 13. Dashboard Design and Interactivity

The final Power BI dashboard contains 17 visuals, organized into KPI cards, charts, and slicers.

### 13.1 KPI Cards

The six KPI cards display:

1. `Cancellation_rate`
2. `Total_Booking`
3. `Revenue Difference`
4. `Avg_ADR`
5. `Total Revenue`
6. `Scenario Revenue`

These cards provide a high-level overview of booking activity, cancellations, ADR, and the pricing scenario.

### 13.2 Charts

The six charts cover:

1. Cancellation by deposit type.
2. ADR by hotel type.
3. Bookings by market segment.
4. Confirmed versus canceled bookings by customer type.
5. Monthly base revenue versus scenario revenue.
6. Revenue by country.

### 13.3 Slicers

The dashboard includes five slicers for interactive filtering. These allow users to explore subsets of the data according to the fields configured in the report.

### 13.4 Dashboard Development

Emad was responsible for building the Power BI dashboard, arranging the KPI cards and charts, and developing the visual layout using the available analytical measures and dynamic pricing outputs.

## 14. Key Findings

The following findings were calculated from the original CSV dataset.

### 14.1 Booking and Cancellation Patterns

- The original dataset contains 119,390 bookings.
- The overall cancellation rate is approximately 37.04%.
- City Hotel has a cancellation rate of approximately 41.73%.
- Resort Hotel has a cancellation rate of approximately 27.76%.

The difference between hotel types indicates that cancellation behavior varies across the two categories.

### 14.2 Average Daily Rate

- Overall average ADR is approximately 101.83.
- City Hotel average ADR is approximately 105.30.
- Resort Hotel average ADR is approximately 94.95.

City Hotel has a higher average ADR than Resort Hotel in the original dataset.

### 14.3 Deposit Types and Market Segments

- The Non-Refund deposit category has a cancellation rate of approximately 99.36%.
- The Groups market segment has a cancellation rate of approximately 61.06%.

These findings identify categories that can be examined more closely when evaluating booking conditions and cancellation behavior.

### 14.4 Pricing Scenario

At a selected 30% price increase, the dashboard displays a scenario revenue of approximately 40.64M compared with a base revenue of approximately 31.26M.

The resulting displayed difference is approximately 9.38M under the scenario assumptions.

## 15. Business Insights and Recommendations

### 15.1 Cancellation Management

The higher cancellation rate observed for City Hotel suggests that hotel-specific cancellation patterns should be examined when evaluating reservation policies and booking behavior.

### 15.2 Deposit Policy Analysis

The high cancellation rate associated with the Non-Refund deposit category warrants further analysis of booking conditions, reservation timing, and the composition of this category.

### 15.3 Market Segment Analysis

The cancellation rate for the Groups segment provides an opportunity to investigate group booking terms, lead times, and cancellation behavior.

### 15.4 Pricing Analysis

The What-If parameter enables users to explore hypothetical price adjustments. Operational pricing decisions should also consider demand, occupancy, seasonality, competitor pricing, and operating costs.

### 15.5 Dashboard-Based Decision Support

The dashboard brings multiple indicators into one interface, allowing users to explore patterns across hotel types, customer categories, deposit types, countries, and time periods.

## 16. Data Validation and KPI Interpretation

The original CSV was used as the basis for initial profiling and the findings reported in this document.

The SQL Server and Power BI stages organize the data and present analytical results through measures, charts, and interactive filters.

When comparing KPI values, the following factors are relevant:

- The data population included in the calculation.
- The definition of a booking and a cancellation.
- The date and category filters applied.
- The definition of ADR and revenue.
- The measure logic and relationships in the Power BI model.

These factors determine how individual measures should be interpreted within the dashboard.

## 17. Assumptions and Analytical Scope

### 17.1 Dataset Characteristics

The original data contains missing values, placeholder values, duplicate-looking records, and unusual numerical observations. Their interpretation depends on the meaning of the relevant fields and the analytical objective.

### 17.2 Revenue Indicators

Revenue indicators represent the calculations implemented in the Power BI model. Their interpretation depends on the measure definitions and report filter context.

### 17.3 Dynamic Pricing

The pricing scenario assumes demand remains constant when the price changes. It does not model customer price sensitivity, occupancy changes, booking volume changes, operating costs, or profit margins.

### 17.4 Project Scope

The dashboard focuses on descriptive analytics and hypothetical pricing scenario analysis. It is designed to support exploration of booking and revenue indicators rather than automatically optimize hotel prices.

## 18. Team Contributions

The project was completed collaboratively, with responsibilities divided across database design, data preparation, analytical measures, dynamic pricing, and dashboard development.

### Mohamed Salah — SQL Database Design

- Designed the SQL schema.
- Organized data using fact and dimension tables.
- Established relationships between the tables.

### Donia Ragab and Dalia Hamdy — Data Preparation and Measures

- Worked on data cleaning and preparation in Power BI.
- Developed analytical measures for the booking analysis.

### Omar El-Zayat — Dynamic Pricing Scenario

- Implemented the What-If dynamic pricing scenario.
- Developed the related scenario measures.
- Added the slicer used to control the selected price-change percentage.

### Menna Emad — Power BI Dashboard Development

- Built the Power BI dashboard.
- Arranged the KPI cards and charts.
- Developed the visual layout and dashboard presentation using the analytical measures and pricing scenario outputs.

## 19. Reproducibility Instructions

To reproduce the project workflow:

1. Download the original Hotel Booking Demand CSV from the Kaggle source listed in Section 21.
2. Prepare the source data by selecting the columns required for the analysis.
3. Set up SQL Server using the SQL files included in the repository.
4. Load the data and organize the fact and dimension tables.
5. Open `powerbi/Final___Hotel.pbix` in Power BI Desktop.
6. Configure the database connection and refresh the model.
7. Review the analytical measures and dashboard visuals.
8. Use the `Price Change %` slicer to explore the dynamic pricing scenario.

The original CSV must be downloaded separately because it is not included in the repository.

## 20. Conclusion

The Hotel Revenue Management & Dynamic Pricing Dashboard combines SQL Server database design with Power BI data preparation, DAX measures, and interactive visualization.

The project explores booking volume, cancellation patterns, ADR, and revenue indicators using the Hotel Booking Demand dataset. Its dashboard brings these indicators together and includes a What-If parameter that enables users to examine hypothetical price changes.

The analysis highlights differences in cancellation behavior across hotel types and booking categories. The dynamic pricing scenario provides an additional way to explore revenue sensitivity under a constant-demand assumption.

The resulting solution provides a foundation for further hotel analytics work, including more detailed demand analysis, occupancy-based pricing, seasonality analysis, and cost-aware revenue optimization.

## 21. References

1. Antonio, N., de Almeida, A., & Nunes, L. (2019). *Hotel booking demand datasets*. Data in Brief, 22.
2. [Hotel Booking Demand Dataset — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)
