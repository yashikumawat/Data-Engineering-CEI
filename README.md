# Data-Exploration-Assignment-1-
This project demonstrates data preprocessing and analysis on an e-commerce dataset using Python and Pandas. It includes handling missing values, removing duplicates, filtering data, creating derived columns like total_amount and discounted_price, and exporting a cleaned dataset for further analytics and machine learning tasks.


### Step 1: Import Libraries and Load Dataset

The assignment starts by importing essential Python libraries such as Pandas and loading the e-commerce dataset from a CSV file into a DataFrame for analysis and preprocessing.

### Step 2: Explore and Understand the Dataset

Basic exploratory operations such as viewing the first few rows, checking dataset dimensions, column names, and data types are performed to understand the structure and contents of the dataset.

### Step 3: Identify and Handle Missing Values

Missing values are identified using `isnull().sum()`. Numerical columns are filled using median values, text columns are filled with placeholders like “Unknown”, and unnecessary columns with excessive missing data are removed.

### Step 4: Perform Basic Data Operations

The code performs various data manipulation tasks such as selecting important columns, filtering rows using conditions, and displaying relevant subsets of data for better analysis.

### Step 5: Remove Duplicate Records

Duplicate rows in the dataset are identified using `duplicated()` and removed using `drop_duplicates()` to improve data consistency and quality.

### Step 6: Create Derived Columns

New columns are created from existing data to generate meaningful insights. Examples include `total_amount`, `discounted_price`, `savings_amount`, and `price_category`.
Example Formula:
\text{total_amount} = \text{price} \times \text{quantity}
These derived columns help in analyzing pricing, discounts, and customer purchasing behavior.

### Step 7: Save the Cleaned Dataset

After preprocessing and transformation, the cleaned dataset is saved as a new CSV file using the `to_csv()` function. The final dataset is now ready for visualization, reporting, or machine learning tasks.
