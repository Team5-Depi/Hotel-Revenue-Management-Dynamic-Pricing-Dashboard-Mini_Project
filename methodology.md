# Methodology

1. **Inspection** - every supplied file was opened with the tools available (see limitations).
2. **Independent CSV audit** - pandas, reading all columns as text first so `NULL`/`NA` literals are visible; nothing removed or modified.
3. **SQL audit** - `hotel.sql` was converted from UTF-16 to UTF-8 (copy in `sql/hotel_utf8.sql`) and read. It is an SSMS-generated *schema* script (CREATE DATABASE/SCHEMA/TABLE/FOREIGN KEY). It contains no INSERT, UPDATE, view, procedure or analytical query.
4. **Power BI audit** - the `.pbix` zip was unpacked. The report layer (`Report/definition/...`) is readable JSON: one page, 16 visuals, their fields. The `DataModel` is compressed (XPress9) and could not be read without Power BI tooling, so DAX expressions, relationships and the What-If parameter definition were not read.
5. **Validation** - dashboard values from the screenshot were compared with metrics recomputed from the original CSV.

## Metric definitions used for validation
- Total bookings = row count; Cancellation rate = SUM(is_canceled)/rows; Average ADR = mean of `adr` over all rows.
- Estimated stay value (tested only) = adr x (stays_in_weekend_nights + stays_in_week_nights).
