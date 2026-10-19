# Hotel Revenue Management & Dynamic Pricing Dashboard

An interactive hotel booking analytics project built with SQL Server and Microsoft Power BI to analyze booking patterns, cancellations, Average Daily Rate (ADR), and hypothetical dynamic pricing scenarios.

[![Hotel Dashboard](<Power BI & Dashboard/Dashboard/dashboard.jpg>)](<Power BI & Dashboard/Dashboard/dashboard.jpg>)

## Business Problem

Hotels need to understand booking behavior, cancellation patterns, and room pricing to support revenue management decisions. This project uses hotel booking data to explore these patterns and provides an interactive dashboard for analyzing performance indicators and hypothetical price changes.

## Project Objectives

- Analyze booking volume and cancellation patterns.
- Compare Average Daily Rate (ADR) across hotel types.
- Explore cancellations by deposit type, market segment, and customer type.
- Organize booking data using a relational SQL Server schema.
- Prepare and analyze data in Power BI.
- Develop DAX measures and key performance indicators.
- Implement a What-If parameter to explore hypothetical pricing scenarios.
- Present results through interactive KPI cards, charts, and slicers.

## Dataset

**Hotel Booking Demand** - Kaggle.

- **Original dataset:**

`hotel_bookings.csv- 119,390 rows x 32 columns.

**Prepared dataset:**

`Final_Data_File.csv- 119,390 rows

x 25 columns, containing the columns selected for project analysis.

**Source:** [Hotel Booking Demand Dataset](https://www.kaggle.com

/datasets/jessemostipak/hotel-booking

-demand)

Both the original dataset and the prepared dataset are stored in the `Data/` directory. The original file, `hotel_bookings.csv, contains all 32 columns, while `Final_Data_File.csv contains the 25 columns selected for the project workflow.

## Tools and Technologies

- SQL Server
- SQL
- Microsoft Power BI
- DAX
- Power BI What-If parameter

## Project Workflow

1. **Dataset preparation:** Start with the original Kaggle CSV, remove the 7 columns not required for the analysis, and save the resulting 25-column dataset as `Final_Data_File.csv` in the `Data/` directory.
2. **SQL database design:** Create the database schema, organize booking records into fact and dimension tables, and define table relationships.
3. **Power BI data preparation:** Import the prepared data or database tables, perform the required data-cleaning operations, and prepare the analytical model.
4. **Measures and KPIs:** Develop measures to analyze bookings, cancellations, ADR, stay duration, and revenue.
5. **Dynamic pricing scenario:** Create a What-If parameter, scenario-related measures, and a slicer that allows users to change the hypothetical price adjustment.
6. **Dashboard development:** Use the analytical measures and scenario outputs to create KPI cards, charts, and interactive filters.

**Workflow:** Original Kaggle CSV (32 columns) → Initial Column Selection (25 columns) → `Final_Data_File.csv` → SQL Server Schema → Power BI Data Preparation and Measures → What-If Pricing Scenario → Interactive Dashboard.

## Key Findings

The following figures were calculated from the original CSV dataset. Results calculated using the prepared dataset or the final dashboard model may differ.

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

These findings highlight differences in cancellation behavior and ADR across hotel types, deposit categories, and market segments.

## Dynamic Pricing Scenario

The dashboard includes a **Price Change %** What-If parameter that allows users to explore hypothetical price adjustments.

At a selected price increase of 30%, the dashboard displays the following scenario:

| Indicator | Displayed value |
|---|---:|
| Base revenue | 31.26M |
| Scenario revenue | 40.64M |
| Revenue difference | 9.38M |

The scenario assumes demand remains constant. It illustrates the effect of a hypothetical price adjustment on modeled revenue and does not account for changes in demand, booking volume, operating costs, or profit margins.

## Dashboard Features

The Power BI dashboard contains 17 visuals.

### KPI Cards

- Cancellation Rate
- Total Bookings
- Revenue Difference
- Average ADR
- Total Revenue
- Scenario Revenue

### Charts

- Cancellation by deposit type
- ADR by hotel type
- Bookings by market segment
- Confirmed versus canceled bookings by customer type
- Monthly base revenue versus scenario revenue
- Revenue by country

### Interactivity

Five slicers allow users to filter and explore the dashboard according to the available data and report configuration.

## Repository Structure

    Hotel-Revenue-Management-Dynamic-Pricing/
    ├── Data/
    │   ├── hotel_bookings.csv
    │   ├── Final_Data_File.csv
    │   └── README.md
    ├── sql/
    │   ├── HotelBookingDB.zip
    │   └── hotel.sql
    ├── Power BI & Dashboard/
    │   ├── Final___Hotel.pbix
    │   └── Dashboard/
    │       └── dashboard.jpg
    ├── Report/
    │   └── Hotel_Revenue_Management_Report.md
    └── README.md
    
## Reproduction

1. Download the original dataset from the [Kaggle source](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand) if needed.
2. Use `Final_Data_File.csv` from the `Data/` directory. If preparing the data from scratch, remove the 7 columns not required for the analysis and save the resulting 25-column dataset under this filename.
3. Set up the SQL Server database using the SQL files available in the repository.
4. Load the prepared data into the database and establish the fact and dimension table relationships.
5. Open `Power BI & Dashboard/Final___Hotel.pbix` in Power BI Desktop.
6. Configure the data source paths and refresh the model as needed.
7. Explore the KPI cards, charts, filters, and dynamic pricing scenario.

## Data Quality and Preparation

Initial profiling of the original 32-column CSV identified the following characteristics:

- 31,994 duplicate-looking rows.
- 180 rows with zero guests.
- 715 rows with zero nights.
- 1,959 rows with an ADR of zero.
- One row with a negative ADR value.
- Missing or placeholder values in several columns.

These figures describe the original dataset and may differ from the prepared dataset used in the project. The initial preparation stage involved removing 7 columns that were not required for the analysis, while additional data-cleaning operations were performed during the Power BI workflow.

## Team Contributions

The project was completed collaboratively, with responsibilities divided across database design, data preparation, analytical measures, scenario analysis, and dashboard development.

- **Mohamed Salah:** SQL schema design, fact and dimension tables, and database relationships.
- **Donia Ragab and Dalia Hamdy:** Data cleaning and development of analytical measures in Power BI.
- **Omar El-Zayat:** What-If dynamic pricing scenario, scenario-related measures, and the price-change slicer.
- **Menna Emad:** Power BI dashboard design, including KPI cards, charts, and visual layout.

## References

- Antonio, N., de Almeida, A., & Nunes, L. (2019). *Hotel booking demand datasets*. Data in Brief, 22, 41–49.
- [Hotel Booking Demand Dataset — Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)
