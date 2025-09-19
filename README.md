# Customer Purchase Analysis using SQL

## 📌 Overview
This project contains SQL queries designed to analyze customer purchase behavior, promotional usage, and engagement patterns from an **e-commerce orders dataset** (`book.orders`).  

It demonstrates how SQL can be used for **business insights**, **customer retention strategies**, and **trigger-based marketing**.

---



### 1. Top 3 Outlets by Cuisine Type  
**Goal:** Find the top 3 performing outlets for each cuisine type without using `TOP` or `LIMIT`.  
**Concepts Used:** CTE, Window Functions (`ROW_NUMBER()`).

### 2. Daily Customer Acquisition Count  
**Goal:** Count how many customers were acquired each day since launch.  
**Concepts Used:** Aggregation, `MIN()`, Date formatting.

### 3. Customers Acquired in Jan 2025 Who Only Ordered in Jan  
**Goal:** List customers who joined in Jan 2025 and never placed an order in any other month.  
**Concepts Used:** Filtering, Subqueries.

### 4. Customers With First Order (Promo) But No Order in Last 7 Days  
**Goal:** Identify customers acquired one month ago, whose first order used a promo code, and who have been inactive for the last 7 days.  
**Concepts Used:** CTE, Joins, Date Filtering.

### 5. Trigger Customers After Every Third Order  
**Goal:** Simulate a trigger to target customers after every 3rd order (3rd, 6th, 9th, …) on the current day.  
**Concepts Used:** Window Functions, Modulo `%`.

### 6. Customers With All Orders on Promo Codes  
**Goal:** List customers who placed more than one order and all their orders used a promo code.  
**Concepts Used:** Aggregations with `HAVING`.

---

   git clone https://github.com/<your-username>/customer-purchase-analysis-sql.git
