# 🏨 OYO Hotels Sales Analysis — SQL Case Study

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Domain](https://img.shields.io/badge/Domain-Hospitality%20%7C%20Sales%20Analytics-orange)

## 📌 Project Overview

This project is an end-to-end SQL-based data analysis case study on **OYO Hotels**, one of India's largest budget hotel chains. The analysis covers data cleaning, schema design, and business KPI extraction to derive actionable insights around bookings, cancellations, revenue, and customer behavior.

---

## 🗂️ Database Schema

The project uses two tables:

### `oyo_sales` (Fact Table)
| Column | Description |
|---|---|
| `booking_id` | Unique booking identifier (Primary Key) |
| `customer_id` | Customer identifier |
| `hotel_id` | Foreign key referencing `oyo_city` |
| `check_in` | Check-in date |
| `check_out` | Check-out date |
| `date_of_booking` | Date when the booking was made |
| `no_of_rooms` | Number of rooms booked |
| `amount` | Total booking amount |
| `discount` | Discount applied |
| `status` | Booking status (`Stayed` / `Cancelled`) |

### `oyo_city` (Dimension Table)
| Column | Description |
|---|---|
| `hotel_id` | Unique hotel identifier (Primary Key) |
| `city` | City where the hotel is located |

---

## 🛠️ Data Cleaning Steps

Before analysis, the following cleaning steps were performed:

- ✅ Renamed BOM-corrupted column headers (`ï»¿booking_id` → `booking_id`, `ï»¿hotel_id` → `hotel_id`)
- ✅ Converted `check_in`, `check_out`, and `date_of_booking` from string (`DD-MM-YYYY`) to proper `DATE` data type using `STR_TO_DATE()`
- ✅ Checked for **NULL values** — none found
- ✅ Checked for **duplicate records** — none found
- ✅ Established **Primary Keys** on both tables and a **Foreign Key** relationship from `oyo_sales` to `oyo_city`

---

## 📊 KPIs & Analysis

### 🔢 Sales KPIs (`Sales_view`)
- Total number of customers
- Maximum & Minimum sales amount
- Maximum & Minimum discount
- Total number of rooms booked
- Average sales & average discount

### 📅 Date KPIs (`date_view`)
- Earliest & latest check-in dates
- Earliest & latest check-out dates
- Earliest & latest booking dates

---

## 🔍 Business Questions Answered

| # | Analysis | Description |
|---|---|---|
| 1 | **Month-wise Actual Sales** | Net revenue (amount − discount) by month for stayed bookings |
| 2 | **Maximum Discount Month** | Which month had the highest total discounts given |
| 3 | **Cancellation Rate** | `(Cancelled / Total) * 100` grouped by month |
| 4 | **Booking Rate by City** | Percentage of stayed bookings per city |
| 5 | **Hotel Count by City** | Number of OYO hotels in each city |
| 6 | **City-wise Revenue & Stays** | Total revenue and stay count grouped by city |
| 7 | **Most Frequent Room Bookings** | Most common number of rooms booked per transaction |
| 8 | **Average Cost Per Room by City** | `SUM(amount) / COUNT(*)` grouped by city |

---

## 💡 Key SQL Concepts Used

- `ALTER TABLE`, `MODIFY COLUMN`, `RENAME COLUMN`
- `STR_TO_DATE()` for date format conversion
- `CREATE VIEW` for reusable KPI summaries
- `JOIN` (INNER JOIN) across fact and dimension tables
- Aggregate functions: `SUM()`, `AVG()`, `MAX()`, `MIN()`, `COUNT()`
- `GROUP BY`, `ORDER BY`, `HAVING`
- Primary Key & Foreign Key constraints

---

## 🚀 How to Run

1. Open **MySQL Workbench** or any MySQL-compatible client.
2. Run the script to create and select the database:
   ```sql
   CREATE DATABASE oyo_sales;
   USE oyo_sales;
   ```
3. Import the data files using **Table Data Import Wizard**:
   - Right-click on **Tables** in the schema panel
   - Select **Table Data Import Wizard**
   - Browse and select your CSV files, then click through to Finish
4. Execute the SQL script `oyo_case_study.sql` sequentially.

---

## 📁 Repository Structure

```
oyo-hotels-sql-case-study/
│
├── oyo_case_study.sql      # Full SQL script (cleaning + analysis)
├── data/
│   ├── oyo_sales.csv       # Raw sales data
│   └── oyo_city.csv        # City/hotel dimension data
└── README.md               # Project documentation
```

---

## 🧰 Tools & Technologies

- **Database:** MySQL
- **Client:** MySQL Workbench
- **Language:** SQL

---

## 👤 Author

> Feel free to connect or raise an issue if you have suggestions or questions!

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
