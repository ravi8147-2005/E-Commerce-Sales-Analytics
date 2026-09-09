--Extract Year from Order Date
SELECT order_id,
       order_date,
	   EXTRACT(year from order_date) as order_year
FROM superstore;

--Extract Month
SELECT order_id,
       order_date,
	   EXTRACT(month from order_date) as order_month
FROM superstore;

--Extract Quarter
SELECT order_id,
       order_date,
	   EXTRACT(QUARTER FROM order_date) as order_quarter
FROM superstore;

--Sales by Year
SELECT 
       EXTRACT(YEAR FROM order_date) AS order_year,
       sum(sales) as total_sales
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year;

--Profit by Year
SELECT EXTRACT(YEAR FROM order_date) AS order_year,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year;

--Sales by Month (Across All Years)
SELECT EXTRACT(MONTH FROM order_date) AS month,
SUM(sales) AS total_sales
FROM superstore
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month ;

--Monthly Sales Trend (Year + Month)
SELECT DATE_TRUNC('MONTH',order_date) as month,
sum(sales) as total_sales
FROM superstore
GROUP BY DATE_TRUNC('MONTH',order_date)
ORDER BY month ;

--Profit by Quarter
SELECT EXTRACT(QUARTER FROM order_date) as quarter,
SUM(profit) AS total_profit
FROM superstore
GROUP BY EXTRACT(QUARTER FROM order_date) 
ORDER BY quarter ;

--Average Shipping Time
SELECT
    ROUND(AVG(ship_date - order_date), 2) AS avg_shipping_days
FROM superstore;

--Shipping Days for Every Order
SELECT order_id,
       ship_date,
	   order_date,
	   ship_date - order_date AS shipping_days
FROM superstore;

--Orders Placed in December
SELECT *
FROM superstore
WHERE EXTRACT(MONTH FROM order_date) = 12;

--Orders in Quarter 4
SELECT * FROM superstore
WHERE EXTRACT(QUARTER FROM order_date) = 4;

--Number of Orders per Year
SELECT EXTRACT(YEAR FROM order_date) AS year,
       COUNT(order_id) AS total_order
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY YEAR;

--Number of Orders per Month
SELECT EXTRACT(MONTH FROM order_date) as Month,
COUNT(order_id) AS total_order
FROM superstore
GROUP BY EXTRACT(MONTH FROM order_date) 
ORDER BY Month;

--Month Name with Sales
SELECT TO_CHAR(order_date,'FMMonth') as Month_name,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY TO_CHAR(order_date,'FMMonth') 
ORDER BY MIN(EXTRACT(MONTH FROM order_date));

