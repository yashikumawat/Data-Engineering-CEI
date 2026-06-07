use superstore;
-- Step 1: Setup Data 

CREATE TABLE customers AS 
SELECT row_id,Customer_ID,Customer_Name,Segment,Country,City,State,Postal_Code,Region,Order_ID
FROM superstore_raw;

CREATE TABLE orders  AS 
SELECT row_id,Order_ID,Order_Date,Ship_Date,Ship_Mode,Product_ID,Customer_ID
FROM superstore_raw;

CREATE TABLE products  AS 
SELECT row_id,Product_ID,Product_Name,Sales,Quantity,Discount,Profit,Category,Sub_Category,Order_ID
FROM superstore_raw;

-- Step 2: Perform Required Queries 
-- 1.
select * from orders where order_id in (select order_id from products where sales>(select avg(sales) from products));

-- 2.
SELECT c.Customer_ID,
       c.Customer_Name,
       MAX(p.Sales) AS Highest_Sales
FROM customers c
JOIN orders o ON c.Customer_ID = o.Customer_ID
JOIN products p ON o.Order_ID = p.Order_ID
GROUP BY c.Customer_ID, c.Customer_Name;

-- 3.
WITH CustomerSales AS (
    SELECT o.Customer_ID,
           SUM(p.Sales) AS Total_Sales
    FROM orders o
    JOIN products p
      ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT distinct c.Customer_ID,
       c.Customer_Name,
       cs.Total_Sales
FROM CustomerSales cs
JOIN customers c
  ON cs.Customer_ID = c.Customer_ID;
-- 4.
WITH CustomerSales AS (
    SELECT o.Customer_ID,
           SUM(p.Sales) AS Total_Sales
    FROM orders o
    JOIN products p
        ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT distinct c.Customer_ID,
       c.Customer_Name,
       cs.Total_Sales
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID
WHERE cs.Total_Sales > (
    SELECT AVG(Total_Sales)
    FROM CustomerSales
);

-- 5.
WITH CustomerSales AS (
    SELECT o.Customer_ID,
           SUM(p.Sales) AS Total_Sales
    FROM orders o
    JOIN products p
        ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT distinct c.Customer_ID,
       c.Customer_Name,
       cs.Total_Sales,
       dense_RANK() OVER (ORDER BY cs.Total_Sales DESC) AS Sales_Rank
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID;

-- 6.
SELECT Customer_ID,
       Order_ID,
       Order_Date,
       ROW_NUMBER() OVER (
           PARTITION BY Customer_ID
           ORDER BY Order_Date
       ) AS RowNumber
FROM orders;

-- 7.
WITH CustomerSales AS (
    SELECT o.Customer_ID,
           SUM(p.Sales) AS Total_Sales
    FROM orders o
    JOIN products p
        ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT Customer_ID,
       Total_Sales,rn
FROM (
    SELECT Customer_ID,
           Total_Sales,
           ROW_NUMBER() OVER (ORDER BY Total_Sales DESC) AS rn
    FROM CustomerSales
) t
WHERE rn <= 3;

-- Step 3: Final Combined Query
WITH CustomerSales AS (
    SELECT o.Customer_ID,
           SUM(p.Sales) AS Total_Sales
    FROM orders o
    JOIN products p
        ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT distinct c.Customer_Name,
       cs.Total_Sales,
       dense_RANK() OVER (ORDER BY cs.Total_Sales DESC) AS Sales_Rank
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID
ORDER BY Sales_Rank;

-- Mini Project: Customer Sales Insights 
-- 1.
select * from customers limit 5;

-- 2. 
select * from customers ORDER BY row_id DESC limit 5;

-- 3.
SELECT *
FROM customers c
JOIN (
    SELECT Order_ID
    FROM customers
    GROUP BY Order_ID
    HAVING COUNT(*) = 1
) t
ON c.Order_ID = t.Order_ID;

-- 4.
WITH CustomerSales AS (
    SELECT o.Customer_ID,
           SUM(p.Sales) AS Total_Sales
    FROM orders o
    JOIN products p
        ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT distinct c.Customer_ID,
       c.Customer_Name,
       cs.Total_Sales
FROM CustomerSales cs
JOIN customers c
    ON cs.Customer_ID = c.Customer_ID
WHERE cs.Total_Sales > (
    SELECT AVG(Total_Sales)
    FROM CustomerSales
);

-- 5.
WITH Highest_Order_Value AS (
    SELECT o.Customer_ID,
           MAX(p.Sales) AS Highest_Sales
    FROM orders o
    JOIN products p
        ON o.Order_ID = p.Order_ID
    GROUP BY o.Customer_ID
)
SELECT DISTINCT
       c.Customer_ID,
       c.Customer_Name,
       h.Highest_Sales
FROM customers c
JOIN Highest_Order_Value h
    ON c.Customer_ID = h.Customer_ID;


