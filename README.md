# ✈️ Highcloud Airlines – End-to-End Data Analytics Project

Tools Used: Excel | Power BI | Tableau | MySQL
Skills Applied: Data Cleaning | Modeling | SQL Analysis | Dashboarding | Insights & Recommendations

## 📌 Project Overview

Highcloud Airlines provided a large operational dataset containing flight details, aircraft information, passenger movement, carrier information, and route-level metrics.

This end-to-end project demonstrates how to:

Clean raw aviation data

Model it properly for analytics

Perform SQL-based business analysis

Build dashboards in Excel, Power BI, and Tableau

Deliver actionable insights for stakeholders

## 🎯 Objectives

Clean and preprocess airline operational data

Create time-based metrics like Year, Quarter, Month, Weekday

Calculate Load Factor% and other operational KPIs

Analyse trends by carrier, route, aircraft type and region

Build dashboards in multiple BI tools

Provide insights & recommendations for airline optimisation

## 🧹 Data Preparation & Cleaning

Performed in Excel + SQL

Removed special characters in column names (%, #, -)

Converted Year, Month(#), Day → Date field

Handled missing values (e.g., Airline_ID, Seats, Passengers)

Standardized text fields (state codes, country, carrier names)

Created derived metrics

## 🛢️ SQL Modeling & Analysis

Using MySQL, the following transformation logic and analytics were performed:

🔧 Data Engineering (SQL)

CTEs for date transformation

Views to simplify recurring calculations

Stored Procedures for dynamic queries

Joins across Airport, Carrier, Route attributes

Load Factor%, Passenger Trends, Route Ranking

## 📊 Key SQL KPIs

Load Factor% (Passengers / Available Seats)

Yearly / Monthly / Quarterly performance

Carrier performance and rankings

Top aircraft types by passenger volume

Top routes (origin → destination)

Weekend vs Weekday performance

Distance group analysis

## 📊 Dashboards Created
### 🟦 Power BI Dashboard

Load Factor by Year, Quarter, Carrier

Passenger Trend Analysis

Aircraft Type Comparison

Route Performance

Interactive Filters (Year, Carrier, Aircraft Type, Distance Group)

### 🟩 Tableau Dashboard

Transported Passengers by Region

Aircraft Type Utilisation

Carrier Market Share

Route Demand Heatmap

### 🟧 Excel Dashboard

Quick KPIs summary

Pivot chart visualisations

Snapshot-level insights for reporting

### 🔑 Key Insights

Load Factor increased consistently from 2008–2013 → indicates improved seat utilization.

Domestic carriers handled ~90% of all passengers.

Boeing 737-700 was the most used aircraft (~23M passengers).

Passenger volume peaked in 2011–2012, slight drop after 2013.

Weekend & Weekday load factors were almost equal (~76%), showing stable demand.

Major carriers had the highest Airline ID registrations (~52K).

### 💡 Business Recommendations

Expand fleet capacity on high-demand Boeing 737 routes.

Push international expansion to reduce over-reliance on domestic traffic.

Launch weekend promotional campaigns to increase occupancy.

Allocate operational staff based on monthly/quarterly peaks.

Focus on profitable city-pairs and optimize underperforming routes.

## 🗂️ Project Structure
├── Data
│   ├── Highcloud_Airlines.csv
│   └── Cleaned_Data.csv
├── SQL
│   ├── Data Cleaning.sql
│   ├── CTE Models.sql
│   └── Business Analysis.sql
├── Dashboards
│   ├── PowerBI.pbix
│   ├── Tableau.twbx
│   └── Excel_Dashboard.xlsx
├── Images
│   ├── Dashboard1.png
│   ├── Dashboard2.png
│   └── Dashboard3.png
└── README.md

## 🚀 Outcome

This end-to-end project demonstrates your ability to:
✔ Handle real-world messy aviation data
✔ Apply SQL for deep business analytics
✔ Build professional dashboards across Excel, Power BI & Tableau
✔ Deliver actionable insights for airline optimization

Perfect for showcasing in your portfolio, resume, and interviews.

Author: Shreerajsingh Chouhan
Linkedin: https://www.linkedin.com/in/shreerajsingh-c-chouhan-098820215/
