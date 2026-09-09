--Top Selling Product in Each Category
WITH product_sales AS (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY category, product_name
)
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(
               PARTITION BY category
               ORDER BY total_sales DESC
           ) AS rnk
    FROM product_sales
) t
WHERE rnk = 1;

--Most Profitable Customer
SELECT
    customer_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 1;

--Bottom 10 Products by Profit
SELECT
    product_name,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit
LIMIT 10;

--Average Discount by Category
SELECT
    category,
    ROUND(AVG(discount),2) AS avg_discount
FROM superstore
GROUP BY category;

--Customers Spending Above Average
WITH customer_sales AS (
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY customer_name
)
SELECT *
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
);

--Region Contributing the Highest Sales
SELECT
    region,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC
LIMIT 1;

--Highest Profit State in Each Region
WITH state_profit AS (
    SELECT
        region,
        state,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY region,state
)
SELECT *
FROM(
SELECT *,
       DENSE_RANK() OVER(
       PARTITION BY region
       ORDER BY total_profit DESC) rnk
FROM state_profit
)t
WHERE rnk=1;

--Monthly Running Sales
SELECT
    DATE_TRUNC('month',order_date) AS month,
    SUM(sales) AS monthly_sales,
    SUM(SUM(sales))
    OVER(ORDER BY DATE_TRUNC('month',order_date))
     AS Running_sales
FROM superstore
GROUP BY DATE_TRUNC('month',order_date);

--Profit Margin by Category
SELECT
category,
ROUND(
SUM(profit)/SUM(sales)*100,2
) profit_margin
FROM superstore
GROUP BY category;

--Top Customer in Every Segment
WITH customer_sales AS(
SELECT
segment,
customer_name,
SUM(sales) total_sales
FROM superstore
GROUP BY segment,customer_name
)

SELECT *
FROM(
SELECT *,
DENSE_RANK() OVER(
PARTITION BY segment
ORDER BY total_sales DESC
) rnk
FROM customer_sales
)t
WHERE rnk=1;

--Find the top 5 states by sales.
SELECT state,
       SUM(sales) AS total_sales
FROM superstore
GROUP by state
ORDER BY total_sales DESC
LIMIT 5;

--Find the bottom 5 states by profit.
SELECT state,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_profit 
LIMIT 5;

--Find the highest discounted orders.
SELECT product_name,
       order_id,
	   customer_name,
       discount,
	   sales
FROM superstore
ORDER BY discount DESC,sales DESC;

--Find customers with more than 20 orders.
SELECT customer_name,
       COUNT(order_id) AS total_orders
FROM superstore
GROUP BY customer_name
HAVING COUNT(order_id) >20
ORDER BY total_orders DESC;

--Find the average shipping days by ship mode.
SELECT ship_mode,
	   ROUND(AVG(ship_date - order_date),2) AS shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY shipping_days ;

--Find the top 3 products in every category.
WITH product_sales AS
(
SELECT
    category,
    product_name,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY category,product_name
)

SELECT *
FROM
(
SELECT *,
DENSE_RANK() OVER
(
PARTITION BY category
ORDER BY total_sales DESC
) AS rnk
FROM product_sales
)t
WHERE rnk<=3;

--Find year-over-year sales.
WITH yearly_sales AS
(
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY EXTRACT(YEAR FROM order_date)
)

SELECT
    year,
    total_sales,
    LAG(total_sales) OVER(ORDER BY year) AS previous_year_sales,
    ROUND(
    ((total_sales-LAG(total_sales) OVER(ORDER BY year))
    /LAG(total_sales) OVER(ORDER BY year))*100
    ,2) AS yoy_growth_percent
FROM yearly_sales;

--Find month-over-month sales growth using LAG()
WITH monthly_sales AS
(
SELECT
DATE_TRUNC('month',order_date) AS month,
SUM(sales) AS total_sales
FROM superstore
GROUP BY DATE_TRUNC('month',order_date)
)

SELECT
month,
total_sales,
LAG(total_sales) OVER(ORDER BY month) previous_month_sales,
ROUND(
((total_sales-LAG(total_sales) OVER(ORDER BY month))
/LAG(total_sales) OVER(ORDER BY month))*100
,2) AS monthly_growth
FROM monthly_sales;

--Most Profitable Sub-Category
SELECT  sub_category,
        SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 1;

--Least Profitable Category
SELECT  category,
        SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit
LIMIT 1;

--Customers Who Purchased from All Three Categories
SELECT customer_name,
       COUNT(DISTINCT category) AS category_count
FROM superstore
GROUP BY customer_name
HAVING COUNT(DISTINCT category) = 3;

--Products with Sales Greater Than 10000 but Negative Profit
SELECT
product_name,
SUM(sales) total_sales,
SUM(profit) total_profit
FROM superstore
GROUP BY product_name
HAVING SUM(sales)>10000
AND SUM(profit)<0
ORDER BY total_sales DESC;

--Top Customer in Each State
WITH customer_sales AS
(
SELECT
state,
customer_name,
SUM(sales) total_sales
FROM superstore
GROUP BY state,customer_name
)

SELECT *
FROM
(
SELECT *,
DENSE_RANK() OVER
(
PARTITION BY state
ORDER BY total_sales DESC
) rnk
FROM customer_sales
)t
WHERE rnk=1;

--Highest Selling City in Every State
WITH city_sales AS
(
SELECT
state,
city,
SUM(sales) total_sales
FROM superstore
GROUP BY state,city
)

SELECT *
FROM
(
SELECT *,
DENSE_RANK() OVER
(
PARTITION BY state
ORDER BY total_sales DESC
) rnk
FROM city_sales
)t
WHERE rnk=1;

--Percentage Contribution of Sales by Category
SELECT
category,
SUM(sales) total_sales,
ROUND(
SUM(sales)*100/
(SUM(SUM(sales)) OVER())
,2) AS contribution_percent
FROM superstore
GROUP BY category;

--Fastest Shipping Mode
SELECT
ship_mode,
ROUND(AVG(ship_date-order_date),2) avg_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days
LIMIT 1;

--Slowest Shipping Mode
SELECT
ship_mode,
ROUND(AVG(ship_date-order_date),2) avg_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days DESC
LIMIT 1;

--Customer Retention (Customers with Multiple Orders)
SELECT
customer_name,
COUNT(DISTINCT order_id) total_orders
FROM superstore
GROUP BY customer_name
HAVING COUNT(DISTINCT order_id)>1
ORDER BY total_orders DESC;

--Loss-Making Orders with Discount Above 30%
SELECT
order_id,
customer_name,
product_name,
sales,
profit,
discount
FROM superstore
WHERE profit<0
AND discount>0.30
ORDER BY discount DESC;

--Executive Sales Report
WITH report AS
(
SELECT
SUM(sales) total_sales,
SUM(profit) total_profit,
ROUND((SUM(profit)/SUM(sales))*100,2) profit_margin,
COUNT(DISTINCT order_id) total_orders,
COUNT(DISTINCT customer_id) total_customers
FROM superstore
),

best_category AS
(
SELECT category
FROM superstore
GROUP BY category
ORDER BY SUM(sales) DESC
LIMIT 1
),

worst_category AS
(
SELECT category
FROM superstore
GROUP BY category
ORDER BY SUM(profit)
LIMIT 1
),

best_region AS
(
SELECT region
FROM superstore
GROUP BY region
ORDER BY SUM(sales) DESC
LIMIT 1
),

best_customer AS
(
SELECT customer_name
FROM superstore
GROUP BY customer_name
ORDER BY SUM(sales) DESC
LIMIT 1
)

SELECT
r.total_sales,
r.total_profit,
r.profit_margin,
r.total_orders,
r.total_customers,
bc.category AS best_category,
wc.category AS worst_category,
br.region AS best_region,
bcu.customer_name AS best_customer
FROM report r
CROSS JOIN best_category bc
CROSS JOIN worst_category wc
CROSS JOIN best_region br
CROSS JOIN best_customer bcu;
