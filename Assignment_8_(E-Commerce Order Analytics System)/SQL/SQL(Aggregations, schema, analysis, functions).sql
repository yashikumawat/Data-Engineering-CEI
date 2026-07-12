-- Databricks notebook source
-- MAGIC %python
-- MAGIC
-- MAGIC files = ["customers_cleaned", "products_cleaned", "orders_cleaned", "order_items_cleaned"]
-- MAGIC
-- MAGIC for f in files:
-- MAGIC     df = spark.read.csv(f"/Workspace/Users/yashikumawat53@gmail.com/Drafts/ecommerce_project/cleaned_data/{f}.csv",header=True, inferSchema=True)
-- MAGIC     df.write.mode("overwrite").saveAsTable(f)

-- COMMAND ----------


-- Q1: Total revenue per category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)), 2) AS total_revenue
FROM order_items_cleaned oi
JOIN products_cleaned p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- COMMAND ----------


-- Q2: Top 10 customers by total order value
SELECT
    o.customer_id,
    c.customer_name,
    ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)), 2) AS total_order_value
FROM orders_cleaned o
JOIN order_items_cleaned oi ON o.order_id = oi.order_id
JOIN customers_cleaned c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.customer_name
ORDER BY total_order_value DESC
LIMIT 10;

-- COMMAND ----------


-- Q3: Month-wise order count for the last 12 months
SELECT
    date_format(to_timestamp(o.order_date), 'yyyy-MM') AS year_month,
    COUNT(*) AS order_count
FROM orders_cleaned o
WHERE to_timestamp(o.order_date) >= add_months(
    (SELECT MAX(to_timestamp(order_date)) FROM orders_cleaned), -12
)
GROUP BY year_month
ORDER BY year_month;

-- COMMAND ----------

-- Q4: Customers who placed orders but never had any item delivered
SELECT DISTINCT
    o.customer_id,
    c.customer_name
FROM orders_cleaned o
JOIN customers_cleaned c ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND o.customer_id NOT IN (
      SELECT customer_id FROM orders
      WHERE status = 'DELIVERED' AND customer_id IS NOT NULL
  );

-- COMMAND ----------


-- Q5: Products that were ordered but had more returns than purchases
SELECT
    p.product_id,
    p.product_name,
    SUM(CASE WHEN oi.quantity > 0 THEN oi.quantity ELSE 0 END) AS total_purchased,
    SUM(CASE WHEN oi.quantity < 0 THEN -oi.quantity ELSE 0 END) AS total_returned
FROM order_items_cleaned oi
JOIN products_cleaned p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING total_returned > total_purchased;

-- COMMAND ----------


-- Q6: Return rate (returned items / total items) per category
SELECT
    p.category,
    ROUND(
        1.0 * SUM(CASE WHEN oi.quantity < 0 THEN -oi.quantity ELSE 0 END)
        / SUM(ABS(oi.quantity)),
    4) AS return_rate
FROM order_items_cleaned oi
JOIN products_cleaned p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY return_rate DESC;


-- COMMAND ----------


-- Q7: Running Totals with Window Functions
WITH daily AS (
    SELECT
        o.region_code,
        to_date(o.order_date) AS order_date,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)) AS daily_revenue
    FROM orders_cleaned o
    JOIN order_items_cleaned oi ON o.order_id = oi.order_id
    GROUP BY o.region_code, to_date(o.order_date)
)
SELECT
    region_code,
    order_date,
    ROUND(daily_revenue, 2) AS daily_revenue,
    ROUND(SUM(daily_revenue) OVER (
        PARTITION BY region_code ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS running_total
FROM daily
ORDER BY region_code, order_date;

-- COMMAND ----------


-- Q8: Ranking with DENSE_RANK
WITH product_revenue AS (
    SELECT
        p.category,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)) AS total_revenue
    FROM order_items_cleaned oi
    JOIN products_cleaned p ON oi.product_id = p.product_id
    GROUP BY p.category, p.product_id, p.product_name
)
SELECT
    category,
    product_name,
    ROUND(total_revenue, 2) AS total_revenue,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS rank_in_category
FROM product_revenue
ORDER BY category, rank_in_category;

-- COMMAND ----------


-- Q9: LAG/LEAD Analysis
WITH customer_orders AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date
    FROM orders_cleaned
    WHERE customer_id IS NOT NULL
),
gaps AS (
    SELECT
        customer_id,
        order_date,
        previous_order_date,
        CASE WHEN previous_order_date IS NOT NULL
             THEN datediff(to_date(order_date), to_date(previous_order_date))
             ELSE NULL END AS days_gap
    FROM customer_orders
),
avg_gaps AS (
    SELECT customer_id, AVG(days_gap) AS avg_gap
    FROM gaps
    WHERE days_gap IS NOT NULL
    GROUP BY customer_id
)
SELECT
    g.customer_id,
    g.order_date,
    g.previous_order_date,
    g.days_gap,
    CASE WHEN a.avg_gap > 30 THEN 'At Risk' ELSE 'Active' END AS risk_status
FROM gaps g
LEFT JOIN avg_gaps a ON g.customer_id = a.customer_id
ORDER BY g.customer_id, g.order_date;

-- COMMAND ----------


-- Q10: CTE with Multiple Levels
WITH monthly_revenue AS (
    SELECT
        o.customer_id,
        date_format(to_timestamp(o.order_date), 'yyyy-MM') AS year_month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)) AS revenue
    FROM orders_cleaned o
    JOIN order_items_cleaned oi ON o.order_id = oi.order_id
    WHERE o.customer_id IS NOT NULL
    GROUP BY o.customer_id, year_month
),
categorized AS (
    SELECT
        customer_id,
        year_month,
        revenue,
        CASE
            WHEN revenue > 10000 THEN 'High'
            WHEN revenue >= 5000 THEN 'Medium'
            ELSE 'Low'
        END AS revenue_category
    FROM monthly_revenue
)
SELECT
    year_month,
    revenue_category,
    COUNT(DISTINCT customer_id) AS customer_count
FROM categorized
GROUP BY year_month, revenue_category
ORDER BY year_month, revenue_category;

-- COMMAND ----------


-- Q11: NTILE for Segmentation
WITH customer_ltv AS (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)) AS total_value
    FROM orders_cleaned o
    JOIN order_items_cleaned oi ON o.order_id = oi.order_id
    WHERE o.customer_id IS NOT NULL
    GROUP BY o.customer_id
)
SELECT
    customer_id,
    ROUND(total_value, 2) AS total_value,
    NTILE(4) OVER (ORDER BY total_value DESC) AS quartile,
    CASE NTILE(4) OVER (ORDER BY total_value DESC)
        WHEN 1 THEN 'Platinum'
        WHEN 2 THEN 'Gold'
        WHEN 3 THEN 'Silver'
        WHEN 4 THEN 'Bronze'
    END AS quartile_label
FROM customer_ltv
ORDER BY quartile, total_value DESC;

-- COMMAND ----------


-- Q12: Year-over-Year Comparison
WITH monthly_revenue AS (
    SELECT
        year(to_timestamp(o.order_date)) AS year,
        month(to_timestamp(o.order_date)) AS month,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)) AS revenue
    FROM orders_cleaned o
    JOIN order_items_cleaned oi ON o.order_id = oi.order_id
    GROUP BY year, month
)
SELECT
    cur.year,
    cur.month,
    ROUND(cur.revenue, 2) AS revenue,
    ROUND(prev.revenue, 2) AS prev_year_revenue,
    CASE
        WHEN prev.revenue IS NOT NULL AND prev.revenue != 0
        THEN ROUND((cur.revenue - prev.revenue) * 100.0 / prev.revenue, 2)
        ELSE NULL
    END AS yoy_growth_percent
FROM monthly_revenue cur
LEFT JOIN monthly_revenue prev
    ON cur.month = prev.month AND cur.year = prev.year + 1
ORDER BY cur.year, cur.month;


-- COMMAND ----------


-- Q13: First/Last Value Analysis
WITH customer_category_orders AS (
    SELECT
        o.customer_id,
        o.order_date,
        p.category,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY to_timestamp(o.order_date) ASC)  AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY to_timestamp(o.order_date) DESC) AS rn_last
    FROM orders_cleaned o
    JOIN order_items_cleaned oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.customer_id IS NOT NULL
),
first_cat AS (
    SELECT customer_id, category AS first_category
    FROM customer_category_orders WHERE rn_first = 1
),
last_cat AS (
    SELECT customer_id, category AS last_category
    FROM customer_category_orders WHERE rn_last = 1
)
SELECT
    f.customer_id,
    f.first_category,
    l.last_category,
    CASE WHEN f.first_category != l.last_category THEN 'Yes' ELSE 'No' END AS category_shift
FROM first_cat f
JOIN last_cat l ON f.customer_id = l.customer_id
ORDER BY f.customer_id;

-- COMMAND ----------


-- Q14: Cumulative Distribution
WITH customer_revenue AS (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent / 100.0)) AS revenue
    FROM orders_cleaned o
    JOIN order_items_cleaned oi ON o.order_id = oi.order_id
    WHERE o.customer_id IS NOT NULL
    GROUP BY o.customer_id
),
ranked AS (
    SELECT
        customer_id,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM customer_revenue
)
SELECT
    customer_id,
    ROUND(revenue, 2) AS revenue,
    ROUND(cumulative_revenue, 2) AS cumulative_revenue,
    ROUND(cumulative_revenue * 100.0 / total_revenue, 2) AS cumulative_percent
FROM ranked
ORDER BY revenue DESC;


-- COMMAND ----------


-- Q15: Complex CTE - Cohort Analysis
WITH cohorts AS (
    SELECT customer_id, date_format(to_timestamp(registration_date), 'yyyy-MM') AS cohort_month
    FROM customers_cleaned
),
customer_orders AS (
    SELECT
        o.customer_id,
        c.cohort_month,
        (year(to_timestamp(o.order_date)) - year(to_timestamp(cust.registration_date))) * 12
        + (month(to_timestamp(o.order_date)) - month(to_timestamp(cust.registration_date))) AS month_offset
    FROM orders_cleaned o
    JOIN customers cust ON o.customer_id = cust.customer_id
    JOIN cohorts c ON o.customer_id = c.customer_id
    WHERE o.customer_id IS NOT NULL
),
cohort_sizes AS (
    SELECT cohort_month, COUNT(DISTINCT customer_id) AS cohort_size
    FROM cohorts
    GROUP BY cohort_month
),
cohort_activity AS (
    SELECT cohort_month, month_offset, COUNT(DISTINCT customer_id) AS active_customers
    FROM customer_orders
    WHERE month_offset BETWEEN 0 AND 3
    GROUP BY cohort_month, month_offset
)
SELECT
    cs.cohort_month,
    cs.cohort_size,
    ca.month_offset,
    ca.active_customers,
    ROUND(ca.active_customers * 100.0 / cs.cohort_size, 2) AS retention_rate_percent
FROM cohort_sizes cs
JOIN cohort_activity ca ON cs.cohort_month = ca.cohort_month
ORDER BY cs.cohort_month, ca.month_offset;

-- COMMAND ----------


-- Q16: Self-Join with Window Function

SELECT
    p1.product_name AS product_a,
    p2.product_name AS product_b,
    COUNT(*) AS times_bought_together
FROM order_items_cleaned oi1
JOIN order_items_cleaned oi2
    ON oi1.order_id = oi2.order_id
   AND oi1.product_id < oi2.product_id
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
GROUP BY oi1.product_id, oi2.product_id, p1.product_name, p2.product_name
ORDER BY times_bought_together DESC
LIMIT 20;