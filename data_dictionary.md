# Data Dictionary

## Original CSV (`hotel_bookings.csv`, 32 columns, verified)
hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, babies, meal, country, market_segment, distribution_channel, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, booking_changes, deposit_type, agent, company, days_in_waiting_list, customer_type, adr, required_car_parking_spaces, total_of_special_requests, reservation_status, reservation_status_date.

Notes verified from the file: `children` contains 4 text values `NA`; `agent`, `company`, `country` use the literal text `NULL` for missing values; `adr` ranges from -6.38 to 5400.

## SQL Server schema (from `sql/hotel.sql`, schema-only script)
**Schemas:** `raw`, `dimensions`, `facts`.

| Table | Columns |
|---|---|
| raw.hotel_bookings_raw | 25 columns: hotel, is_canceled, lead_time, arrival_date_year/month/week_number/day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, meal, country, market_segment, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, deposit_type, agent (int), days_in_waiting_list, customer_type, adr, reservation_status, reservation_status_date |
| dimensions.hotel / meal / country / market_segment / deposit_type / customer_type / reservation_status / agent | surrogate `*_key` (identity) + one unique natural-value column |
| dimensions.room_type | room_type_key, room_type_code (used twice by the fact table: reserved and assigned) |
| dimensions.date | date_key, full_date, year, month_number, month_name, week_number, day_of_month, day_name, quarter_number |
| facts.booking | booking_key + 9 dimension keys, is_canceled, lead_time, weekend/week nights, adults, children, previous_cancellations, previous_bookings_not_canceled, days_in_waiting_list, adr (nullable), arrival_date, booking_date, reservation_status_date |

**Columns in the CSV with no counterpart in the SQL schema:** distribution_channel, babies, is_repeated_guest, booking_changes, company, required_car_parking_spaces, total_of_special_requests, and the separate arrival year/month/week/day columns (replaced by `arrival_date`; `booking_date` is a new column - how it is calculated is not in the supplied script).

## Power BI (from report metadata)
Tables referenced by visuals: `_Measures` (measures: Avg_ADR, Cancellation_rate, Total_Booking, Confirmed_Booking, Canceled_Booking, Total Revenue), `Price Change %` (column `Price Change %`; measures Scenario Revenue, Revenue Difference), and dimension tables `dimensions hotel`, `market_segment`, `deposit_type`, `customer_type`, `country`.
