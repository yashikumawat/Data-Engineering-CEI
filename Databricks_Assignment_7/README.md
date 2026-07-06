# Delta Lake MERGE Implementation

This assignment demonstrates how to use **Databricks**, **PySpark**, and **Delta Lake** to perform incremental data loading using the **MERGE** operation (upsert). The project reads an initial dataset and an incremental dataset, converts them into Delta tables, and merges the new records with the existing data while updating matching records.

## Objectives

* Read CSV files into Apache Spark DataFrames.
* Clean and standardize column names.
* Convert CSV data into Delta tables.
* Perform basic data quality checks.
* Remove duplicate records.
* Apply the Delta Lake **MERGE** operation to update existing records and insert new records.
* Validate the final merged dataset.

## Technologies Used

* Databricks
* PySpark
* Delta Lake
* CSV Files

## Why Databricks?

Databricks provides a unified cloud platform for big data processing and analytics. In this project, Databricks is used because it offers:

* An interactive notebook environment for developing and executing PySpark code.
* Native support for Delta Lake, enabling ACID transactions and reliable data management.
* Optimized Spark clusters for fast data processing.
* Simple creation and management of Delta tables.
* Efficient handling of large-scale ETL and data engineering workflows.
* Built-in support for SQL, Python, Scala, and R within the same workspace.

Using Databricks simplifies the implementation of incremental data loading and ensures data consistency through Delta Lake's transactional capabilities.

## Steps Performed

### 1. Spark Session Creation

* Configured a Spark session with Delta Lake extensions.
* Enabled Delta Lake support within Databricks.

### 2. Load Initial Dataset

* Read the Superstore CSV dataset into a Spark DataFrame.
* Enabled schema inference for automatic data type detection.

### 3. Data Cleaning

* Standardized column names by removing spaces and special characters.
* Improved compatibility with Spark SQL and Delta tables.

### 4. Create Delta Table

* Stored the cleaned dataset as a Delta table.
* Verified the successful creation of the table.

### 5. Data Validation

* Counted the total number of records.
* Removed duplicate customer records.
* Checked for null values across all columns.

### 6. Load Incremental Dataset

* Read the incremental CSV file.
* Applied the same column name standardization process.
* Created a second Delta table for incremental data.

### 7. Perform MERGE Operation

* Used Delta Lake's MERGE command.
* Updated records where the Row_ID already existed.
* Inserted new records that were not present in the original dataset.

### 8. Verify Results

* Displayed the merged dataset.
* Counted the total number of records after the merge operation.

## Key Learning Outcomes

* Creating and managing Delta tables in Databricks.
* Working with Apache Spark DataFrames.
* Performing data cleaning before loading data.
* Handling duplicate and null records.
* Implementing incremental data loading using Delta Lake.
* Understanding ACID transactions provided by Delta Lake.
* Using the MERGE operation for efficient update and insert workflows.
* Building scalable ETL pipelines using Databricks and PySpark.
workflows.

