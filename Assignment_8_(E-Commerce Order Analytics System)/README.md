# E-Commerce Order Analytics System

## Overview

The **E-Commerce Order Analytics System** is a data engineering project that demonstrates an end-to-end ETL (Extract, Transform, Load) pipeline using Python, Pandas, PySpark, SQL, and Databricks. The project simulates a real-world e-commerce platform by generating synthetic datasets, introducing intentional data quality issues, cleaning and validating the data, and performing analytical SQL queries to generate business insights.

The project emphasizes data quality, data validation, ETL processes, and SQL-based analytics, making it an excellent demonstration of core data engineering concepts.

---

## Objectives

* Generate realistic e-commerce datasets using Python.
* Introduce intentional data quality issues for data cleaning practice.
* Perform comprehensive data cleaning and validation.
* Generate a data quality report.
* Load cleaned datasets into Spark tables.
* Perform business analysis using SQL.
* Build an end-to-end ETL workflow suitable for analytics.

---

## Technology Stack

* Python
* Pandas
* PySpark
* Apache Spark
* Databricks
* SQL
* CSV Files

---

## Project Structure

```text
Assignment_8_(E-Commerce_Order_Analytics_System)
│
├── generate_data.py
├── clean_data.py
├── sql_queries.sql
├── README.md
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── order_items.csv
│
└── cleaned_data/
    ├── customers.csv
    ├── products.csv
    ├── orders.csv
    ├── order_items.csv
    └── data_quality_report.txt
```

---

# Dataset Description

The project consists of four datasets that represent different entities of an e-commerce system.

## Customers Dataset

Contains customer information including:

* Customer ID
* Customer Name
* Email Address
* Registration Date
* Customer Type

---

## Products Dataset

Contains product-related information including:

* Product ID
* Product Name
* Category
* Subcategory
* Cost Price

---

## Orders Dataset

Contains order details including:

* Order ID
* Customer ID
* Order Date
* Order Status
* Region Code

---

## Order Items Dataset

Contains item-level details for each order including:

* Item ID
* Order ID
* Product ID
* Quantity
* Unit Price
* Discount Percentage

---

# Intentional Data Quality Issues

To simulate real-world datasets, several data quality issues were intentionally introduced.

### Customers

* Invalid email addresses
* Missing email domain
* Incorrect email formatting

### Products

* Leading and trailing spaces
* Uppercase product names
* Lowercase product names
* Inconsistent text formatting

### Orders

* Missing customer IDs
* Multiple date formats
* Invalid date values

### Order Items

* Negative quantities
* Orphan order IDs
* Invalid foreign key references

---

# Data Cleaning Process

The cleaning pipeline performs the following operations:

* Standardizes product names.
* Removes unnecessary spaces.
* Converts product names to title case.
* Converts multiple date formats into a standard format.
* Identifies missing customer IDs.
* Validates email addresses.
* Checks referential integrity between Orders and Order Items.
* Removes orphan records.
* Detects invalid quantities.
* Generates a detailed data quality report.

---

# Data Quality Checks

The following validations are performed during the cleaning process:

* Missing values
* Invalid email addresses
* Incorrect date formats
* Duplicate records
* Negative quantities
* Discount percentage validation
* Referential integrity checks
* Data consistency validation

---

# ETL Workflow

```text
Generate Raw Data
        │
        ▼
Raw CSV Files
        │
        ▼
Data Cleaning & Validation
        │
        ▼
Cleaned CSV Files
        │
        ▼
Load into Spark Tables
        │
        ▼
SQL Analysis
        │
        ▼
Business Insights
```

---

# SQL Analysis

The cleaned datasets are queried using SQL to generate meaningful business insights.

The SQL analysis includes:

* Total customers
* Total orders
* Total revenue
* Month-wise order trends
* Customer purchase analysis
* Product performance
* Category-wise sales
* Region-wise sales
* Order status distribution
* Top-selling products
* Customer segmentation
* Revenue analysis
* Average order value
* Discount analysis

---

# SQL Queries and Results

The repository contains a SQL file that includes all analytical queries used in the project.

**Note:** The result of every SQL query is included immediately below its corresponding query in the same SQL file. This allows anyone reviewing the project to easily understand both the query logic and its output without executing the queries separately.

---

# Data Quality Report

After the cleaning process, a **data_quality_report.txt** file is automatically generated.

The report contains:

* Total rows processed
* Invalid email addresses
* Missing customer IDs
* Incorrect date formats
* Invalid records
* Orphan order items
* Negative quantity records
* Discount validation summary
* Overall data quality statistics

---

# Key Features

* Synthetic e-commerce dataset generation
* Intentional data quality issues
* Automated data cleaning
* Email validation
* Product name normalization
* Date format standardization
* Referential integrity validation
* Data quality reporting
* Spark DataFrame processing
* SQL-based business analytics
* End-to-end ETL pipeline

---

# Learning Outcomes

This project helped in understanding and implementing:

* Data Generation
* Data Cleaning
* Data Validation
* Data Quality Assessment
* ETL Pipeline Development
* Pandas Data Processing
* PySpark Transformations
* Spark SQL
* SQL Analytics
* Referential Integrity
* Data Engineering Best Practices

---

# Conclusion

The **E-Commerce Order Analytics System** demonstrates a complete data engineering workflow from synthetic data generation to analytics-ready datasets. The project showcases practical implementation of ETL pipelines, data cleaning, validation, and SQL-based reporting using Python, Pandas, PySpark, and Databricks.

By introducing realistic data quality issues and resolving them through a structured cleaning pipeline, the project provides hands-on experience with common challenges encountered in real-world data engineering. The final cleaned datasets and SQL analysis enable meaningful business insights, making this project a strong demonstration of data engineering and analytics skills.

