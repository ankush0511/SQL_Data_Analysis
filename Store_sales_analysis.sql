-- DATA PREPROCESSING
SELECT 
    *
FROM
    store.retail_sales;

SELECT 
    COUNT(*)
FROM
    store.retail_sales;


SELECT DISTINCT
    (category)
FROM
    store.retail_sales;

-- CHECK & DELETE  NULL

SELECT 
    *
FROM
    store.retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL;

DELETE FROM store.retail_sales 
WHERE
    sale_date IS NULL OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL;
    
-- EDA
-- How Many Sales We Have
SELECT 
    COUNT(*) AS 'Total_Sales'
FROM
    store.retail_sales;

-- How Many Customer We have
SELECT 
    COUNT(DISTINCT customer_id)
FROM
    store.retail_sales;

-- Business Probles
-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT 
    *
FROM
    store.retail_sales
WHERE
    sale_date = '2022-11-05';
    
-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND YEAR(sale_date) = 2022
        AND MONTH(sale_date) = 11
        AND quantity >= 4;

-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT 
    category,
    SUM(total_sale) AS 'net_sale',
    COUNT(*) AS 'total_orders'
FROM
    store.retail_sales
GROUP BY category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
    category, AVG(age) AS 'avg_age'
FROM
    store.retail_sales
WHERE
    category = 'Beauty'
GROUP BY category;

-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT 
    *
FROM
    store.retail_sales
WHERE
    total_sale > 1000;
-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    gender, category, COUNT(*)
FROM
    store.retail_sales
GROUP BY gender , category;
-- Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
    YEAR(sale_date) AS 'year_sale',
    MONTH(sale_date) AS 'mon',
    AVG(total_sale) AS 'avg_total'
FROM
    store.retail_sales
GROUP BY 1 , 2
ORDER BY 1 , 2 , 3 DESC;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id, SUM(total_sale) AS 'toal_sales'
FROM
    retail_sales
GROUP BY customer_id
ORDER BY toal_sales DESC
LIMIT 5;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
    category, COUNT(DISTINCT (customer_id))
FROM
    retail_sales
GROUP BY category;
   
-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):  
   
  WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
