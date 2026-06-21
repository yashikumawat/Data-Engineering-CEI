## Assignment 5 –  Understand Spark fundamentals and perform data cleaning, transformation, and aggregation using DataFrames.

### Step 1: Initialize the Spark Session

* Created a PySpark `SparkSession` to initialize the Spark environment.
* **Observation:** The Spark session was successfully initialized, enabling all subsequent PySpark operations.

---

### Step 2: Load the Dataset

* Loaded the **Sample Superstore.csv** file into a PySpark DataFrame.
* Enabled the header option to correctly read the column names.
* **Observation:** The dataset was imported successfully and was ready for exploration and analysis.

#### Explore the Dataset

* Displayed the first few rows of the dataset.
* Examined the column names.
* Inspected the schema and data types of all columns.
* **Observation:** The dataset contained both categorical and numerical attributes, providing a clear understanding of its structure.

---

### Step 3: Data Cleaning

* Counted the total number of records.
* Identified duplicate rows in the dataset.
* Removed duplicate records.
* **Observation:** The dataset became more consistent and reliable after duplicate records were removed.

#### Analyze Missing Values

* Calculated the number of null values in each column.
* Reviewed the dataset for missing or invalid entries.
* **Observation:** Missing values were identified, helping assess the overall quality of the dataset.

---

### Step 4: Filter the Dataset

* Filtered records based on **Category**.
* Filtered records based on **Region**.
* Applied conditions on numerical columns such as **Sales**.
* **Observation:** Filtering enabled focused analysis of specific subsets of the dataset.

---

### Step 5: Transformation of Data

* Renamed **Ship Mode** to **Shipment Mode**.
* Renamed **Ship Date** to **Shipment Date**.
* **Observation:** The updated column names improved readability and made the dataset easier to understand.

#### Change Data Types

* Converted the **Sales** column from string to a numeric data type.
* Verified the updated schema after conversion.
* Handled invalid values encountered during the conversion process.
* **Observation:** Data type conversion enabled numerical computations and improved the consistency of the dataset.

---

### Step 6: Perform Aggregation

* Calculated the total number of records.
* Computed the average values of numerical columns.
* Determined the minimum and maximum values for numerical columns.
* **Observation:** Aggregation provided summary statistics that helped understand the distribution and range of the data.

---

### Step 7: Perform Group-wise Analysis

* Grouped the dataset using `groupBy()`.
* Applied the `count()` function to determine the number of records in each group.
* Applied the `sum()` function to calculate total values.
* Applied the `avg()` function to compute average values for each group.
* **Observation:** Group-wise analysis revealed meaningful trends and comparisons across different categories and regions.

---

### Export the Transformed Dataset

* Saved the cleaned and transformed DataFrame as a CSV file.
* Verified that the transformed dataset was ready for future use.
* **Observation:** The final dataset was successfully prepared for reporting and further analysis.

