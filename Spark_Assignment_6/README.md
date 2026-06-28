# Spark Assignment 6

This repository contains fundamental Spark concepts, DataFrame operations, data cleaning techniques, aggregation functions, performance optimization, and best practices using **PySpark**. It serves as a quick revision guide for understanding commonly asked Spark interview and practical questions. The document includes explanations along with sample PySpark code snippets to demonstrate each concept. 

---

## Topics Covered

* Apache Spark fundamentals and architecture
* Spark vs. MapReduce
* In-memory processing and caching
* DataFrame transformations and actions
* Removing duplicate records
* Filtering and aggregation operations
* Handling missing (null) values
* GroupBy and aggregation techniques
* DataFrame immutability
* Conditional filtering
* Timestamp conversion
* Shuffle operations
* Data cleaning best practices
* Multiple aggregations using `.agg()`
* Schema inference and explicit schema definition 

---

## Basic Steps Performed

1. Studied the differences between MapReduce and Apache Spark to understand why Spark provides better performance for large-scale data processing.
2. Learned how Spark uses in-memory computation with caching and persistence to speed up iterative workloads.
3. Practiced removing duplicate records using `dropDuplicates()` based on selected columns.
4. Applied filtering before aggregation to improve query performance.
5. Explored methods to handle missing values using `.na.drop()` and `.na.fill()`.
6. Calculated grouped statistics such as counts, averages, minimum, maximum, and mean using aggregation functions.
7. Understood DataFrame immutability and how transformations create new DataFrames instead of modifying existing ones.
8. Implemented conditional filtering using multiple logical conditions.
9. Converted timestamp columns into the appropriate Spark data types.
10. Learned how shuffle operations occur during wide transformations and how to minimize their impact.
11. Cleaned datasets by removing invalid records and trimming unwanted spaces.
12. Used `.agg()` to calculate multiple statistics efficiently in a single pass.
13. Explored the risks of using `inferSchema=True` and understood the benefits of defining an explicit schema. 

---

## Learning Gained

* Developed a strong understanding of Apache Spark architecture and its advantages over traditional MapReduce.
* Learned how Spark optimizes execution through lazy evaluation and DAG-based processing.
* Understood the importance of caching and persistence for improving performance in iterative processing.
* Gained practical knowledge of common DataFrame operations used for data cleaning and preprocessing.
* Learned effective techniques for handling duplicate and missing data.
* Improved understanding of filtering, grouping, and aggregation operations in PySpark.
* Understood how immutable DataFrames support reliable and consistent data processing pipelines.
* Learned when wide transformations trigger shuffle operations and how to reduce their performance cost.
* Gained experience in converting data types and working with timestamp columns.
* Learned efficient aggregation techniques using a single `.agg()` operation.
* Understood why explicitly defining schemas improves performance, consistency, and data quality compared to automatic schema inference.
* Strengthened practical PySpark skills that are commonly used in data engineering projects and technical interviews. 

