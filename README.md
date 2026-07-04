# 🚕 Bengaluru Ride-Booking Analytics

A full end-to-end data analytics project simulating one month of ride-hailing operations in Bengaluru — from synthetic data generation and PostgreSQL modeling to Power BI dashboarding and written business analysis.

![Status](https://img.shields.io/badge/status-complete-brightgreen)
![Python](https://img.shields.io/badge/Python-3.12-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-ready-336791)
![Power BI](https://img.shields.io/badge/Power%20BI-dashboard-F2C811)

---

## 📌 Project Overview

This project analyzes **100,000 ride-booking records** for Bengaluru city across **June 2026**, covering the full booking lifecycle — successful trips, customer cancellations, driver cancellations, and incomplete rides — along with fare value, trip distance, turnaround times (VTAT/CTAT), and customer/driver ratings.

The goal is to demonstrate the analytics workflow used in real ride-hailing operations teams: generating clean, relational data → loading it into a proper database → building an interactive BI dashboard → producing a written business report with findings and recommendations.

**Overall booking success rate is fixed at ~62%**, matching realistic ride-hailing completion benchmarks, with fare, distance, VTAT/CTAT, and rating fields populated only for successful bookings.

---

## 🗂️ Repository Structure

```
├── data/
│   └── bengaluru_ride_bookings.csv        # 100,000-row raw dataset
├── sql/
│   └── create_table.sql                   # PostgreSQL schema + COPY import script
├── reports/
│   └── Bengaluru_Ride_Booking_Analytics_Report.pdf   # 10-page written analysis
├── dashboard/
│   └── Ola-Dashboard.pbix                 # Power BI dashboard (Overall, Vehicle Type, Revenue, Cancellation, Ratings)
├── assets/
│   └── (dashboard screenshots used below)
└── README.md
```

> Adjust the paths above to match how you've organized files in your own repo.

---

## 🧾 Dataset Description

| Field | Description |
|---|---|
| `date`, `time` | Booking date & time (June 1–30, 2026) |
| `booking_id` | Unique booking reference |
| `booking_status` | Success / Cancelled by Driver / Cancelled by Customer / Incomplete |
| `customer_id` | Anonymized customer identifier (~42,000 unique customers) |
| `vehicle_type` | Auto, Bike, eBike, Mini, Prime Plus, Prime Sedan, Prime SUV |
| `pickup_location`, `drop_location` | One of 50 Bengaluru zones (always distinct) |
| `avg_vtat`, `avg_ctat` | Vehicle/customer arrival time — successful rides only |
| `cancelled_rides_by_customer` / `...by_driver` | Cancellation flags + reason |
| `incomplete_rides` | Incomplete ride flag + reason |
| `booking_value` | Fare — successful rides only |
| `ride_distance` | Trip distance (km) — successful rides only |
| `driver_ratings`, `customer_rating` | Ratings (1–5) — successful rides only |

**Business rules applied:**
- "AC is not working" is only used as a cancellation reason for 4-wheeler categories (Prime Sedan, Prime Plus, Prime SUV).
- All fare, distance, VTAT/CTAT, and rating fields are `NULL` for cancelled/incomplete rides — only successful bookings carry these values.
- Pickup and drop locations are never the same.

---

## 🛠️ Tech Stack

- **Python** (pandas, NumPy) — synthetic data generation
- **PostgreSQL** — relational storage and querying
- **Power BI** — interactive dashboarding
- **ReportLab / matplotlib** — automated PDF report generation

---

## 🗄️ Database Setup

```sql
CREATE TABLE bengaluru_ride_bookings (
    id                                  SERIAL PRIMARY KEY,
    date                                DATE NOT NULL,
    time                                TIME NOT NULL,
    booking_id                         TEXT NOT NULL UNIQUE,
    booking_status                     TEXT NOT NULL,
    customer_id                        TEXT NOT NULL,
    vehicle_type                       TEXT NOT NULL,
    pickup_location                    TEXT NOT NULL,
    drop_location                      TEXT NOT NULL,
    avg_vtat                           NUMERIC(5,2),
    avg_ctat                           NUMERIC(5,2),
    cancelled_rides_by_customer        INTEGER NOT NULL DEFAULT 0,
    reason_for_cancelling_by_customer  TEXT,
    cancelled_rides_by_driver          INTEGER NOT NULL DEFAULT 0,
    reason_for_cancelling_by_driver    TEXT,
    incomplete_rides                   INTEGER NOT NULL DEFAULT 0,
    incomplete_rides_reason            TEXT,
    booking_value                      NUMERIC(10,2),
    ride_distance                      NUMERIC(6,2),
    driver_ratings                     NUMERIC(2,1),
    customer_rating                    NUMERIC(2,1)
);

\copy bengaluru_ride_bookings (date, time, booking_id, booking_status, customer_id,
    vehicle_type, pickup_location, drop_location, avg_vtat, avg_ctat,
    cancelled_rides_by_customer, reason_for_cancelling_by_customer,
    cancelled_rides_by_driver, reason_for_cancelling_by_driver,
    incomplete_rides, incomplete_rides_reason, booking_value, ride_distance,
    driver_ratings, customer_rating)
FROM 'data/bengaluru_ride_bookings.csv'
WITH (FORMAT csv, HEADER true, NULL '');
```

Full schema with indexes is in [`sql/create_table.sql`](sql/create_table.sql).

---

## 📊 Dashboard

Built in Power BI across five pages: **Overall**, **Vehicle Type**, **Revenue**, **Cancellation**, and **Ratings**.

<!-- Add your own dashboard screenshots here, e.g.: -->
<!-- ![Overall Dashboard](assets/overview.png) -->
<!-- ![Cancellation Dashboard](assets/cancellation.png) -->

---

## 🔍 Key Insights

- **62.3% of bookings completed successfully**; the remaining 37.7% split across driver cancellations (17.8%), customer cancellations (9.9%), and incomplete rides (10.0%).
- **Driver-initiated cancellations outnumber customer-initiated ones nearly 2:1**, pointing to supply-side friction (vehicle issues, availability) as the bigger lever for improving completion rate.
- **Mini, Auto, and Bike** are the platform's volume and revenue drivers, consistent with demand for affordable city mobility.
- **Ratings are remarkably consistent (~4.0/5)** across every vehicle type for both drivers and customers — service quality is not a differentiator between categories.
- **Average VTAT ~8 minutes, average CTAT ~15 minutes** for successful rides — within typical urban mobility benchmarks.
- Cancellation reasons on both the customer and driver side are fairly evenly distributed, suggesting **process/operational issues rather than one dominant root cause**.

Full analysis, charts, and recommendations are in the [10-page PDF report](reports/Bengaluru_Ride_Booking_Analytics_Report.pdf).

---

## 🚀 How to Reproduce

1. Clone this repo
2. Load `data/bengaluru_ride_bookings.csv` into PostgreSQL using `sql/create_table.sql`
3. Open `dashboard/Ola-Dashboard.pbix` in Power BI Desktop and point it to your database (or the CSV directly)
4. Explore the report in `reports/` for the written narrative behind the numbers

---

## 📄 License

This project uses synthetically generated data for educational and portfolio purposes. No real customer or driver data is included.

---

## 🙋 About

Built as part of a data analytics portfolio to demonstrate SQL modeling, BI dashboarding, and business communication skills for analytics roles.
