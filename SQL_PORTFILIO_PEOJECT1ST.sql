CREATE DATABASE PROJECT;
USE PROJECT;

CREATE TABLE SALE(
transactions_id INT NOT NULL,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR (20),
age INT,
category VARCHAR (50),
quantiy INT ,
price_per_unit INT,
cogs INT,
total_sale INT
);


-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * 
FROM SALE
WHERE SALE_DATE = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--    and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM SALE
WHERE category = 'Clothing' AND quantiy >= 4 AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT CATEGORY, COUNT(TOTAL_SALE),SUM(TOTAL_SALE)
FROM SALE 
GROUP BY CATEGORY;

-- Q.4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(AGE))
FROM SALE 
GROUP BY CATEGORY 
HAVING CATEGORY ='BEAUTY';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * 
FROM SALE
WHERE TOTAL_SALE >= 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT CATEGORY,GENDER,COUNT(TRANSACTIONS_ID) 
FROM SALE
GROUP BY CATEGORY,GENDER
ORDER BY CATEGORY;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT
   EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
        -- EXTRACT(DAY FROM sale_date) as DAY,
    ROUND(AVG(total_sale)) AS average_sale
FROM sale
GROUP BY year, month
ORDER BY year, month;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
    SUM(total_sale) as total_sales
FROM sale
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) 
FROM sale
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sale
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;