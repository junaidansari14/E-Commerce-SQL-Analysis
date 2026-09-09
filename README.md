# E-Commerce Sales & Customer Analysis Using SQL

## PROJECT OVERVIEW

An e-commerce company wants to understand its sales performance, customer behavior, product performance, and revenue trends. This project uses SQL to analyse transactional data and generate business insights that can support customer retention, product strategy, and revenue growth.

The project demonstrates SQL analysis from basic to advanced level using customer, order, order-item, and product data.

## BUSINESS PROBLEMS

The analysis focuses on identifying:

1. Highest revenue-generating customers
2. Top-performing product categories
3. Most profitable categories
4. Customer segment performance
5. Top customers within each segment
6. Monthly revenue trends
7. Month-over-month revenue changes
8. High-value customers

## TOOLS AND TECHNOLOGIES

* SQL
* MySQL Workbench
* Excel (Data Preparation)

## DATASET INFORMATION

The dataset contains e-commerce transaction information including:

* Customer ID
* Order ID
* Order Date
* Product ID
* Product Category
* Product Subcategory
* Brand
* Quantity
* Unit Price
* Discount
* Order Amount
* Payment Method
* Customer Segment
* Membership Status
* Profit Amount
* Profit Margin

The data was organized into related tables:

* Customers
* Orders
* Order Items
* Products

## DATA CLEANING AND PREPARATION

Before analysis, the following steps were performed:

* Checked data types and column structure
* Checked NULL and duplicate records
* Validated Customer and Order IDs
* Verified table relationships
* Corrected join conditions
* Prepared the data for SQL analysis

## REAL-TIME BUSINESS PROBLEMS SOLVED

### Customer Revenue Analysis

**What does it identify?**
Identifies the highest revenue-generating customers.

**Business Action:**
Use customer revenue data to create targeted loyalty and retention strategies.

### Product Performance Analysis

**What does it identify?**
Identifies categories generating the highest revenue and profit.

**Business Action:**
Focus inventory, marketing, and promotional activities on profitable categories.

### Customer Segment Analysis

**What does it identify?**
Identifies the top-performing customers within each customer segment.

**Business Action:**
Create segment-specific offers and retention strategies.

### Monthly Revenue Analysis

**What does it identify?**
Tracks monthly revenue and identifies periods of growth or decline.

**Business Action:**
Investigate revenue declines and improve sales and promotional strategies.

### Top Customers Per Segment

**What does it identify?**
Uses `RANK()` and `ROW_NUMBER()` to identify the top customers within each segment.

**Business Action:**
Prioritize high-value customers for personalized marketing and loyalty programs.

## ADVANCED SQL ANALYSIS

The project includes advanced SQL techniques such as:

* CTEs
* Subqueries
* `RANK()`
* `ROW_NUMBER()`
* `DENSE_RANK()`
* `PARTITION BY`
* `LAG()`
* `LEAD()`
* `CASE WHEN`

These techniques were used for customer ranking, segment-wise analysis, and month-over-month revenue comparison.

## KEY INSIGHTS

* Identified the highest revenue-generating customers.
* Identified top customers within individual customer segments.
* Analysed revenue and profitability across product categories.
* Compared monthly revenue to identify growth and decline patterns.
* Used window functions to perform advanced customer and time-based analysis.

## CONCLUSION

This project demonstrates how SQL can transform raw e-commerce transaction data into meaningful business insights. The analysis helps businesses understand customer value, product performance, revenue trends, and segment-level performance to support better data-driven decisions.

