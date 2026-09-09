--Categories with Sales Greater Than $700,000
--NORMAL QUERY
SELECT category,sum(sales) as total_sales
from superstore
group by category
having sum(sales) >700000;
--without CTEs
SELECT * 
FROM (SELECT category,
             SUM(sales) as total_sales
	  FROM superstore
	  GROUP BY category
	  ) AS category_sales
WHERE total_sales >700000;
--With CTEs
WITH category_sales AS(
  SELECT category,
         SUM(sales) AS total_sales
		 FROM superstore
		 GROUP BY CATEGORY
)
SELECT * FROM category_sales
WHERE total_sales >700000;

---High Profit States
WITH state_profit AS (
 SELECT state, SUM(profit) AS total_profit
        FROM superstore
        GROUP BY state
)
SELECT * FROM state_profit
WHERE total_profit > 10000;

--Top 10 Customers
WITH top10_customer AS (
 SELECT customer_name,
        SUM(sales) AS total_sales
		FROM superstore
		GROUP BY customer_name
)
SELECT * FROM top10_customer
ORDER BY total_sales DESC
LIMIT 10;

--Loss-Making Products
WITH loss_making_product AS (
SELECT product_name,SUM(profit) AS total_profit
       FROM superstore
	   GROUP BY product_name)
SELECT * FROM loss_making_product
WHERE total_profit <0
ORDER BY total_profit;

--Average Sales by Category
WITH avg_sales_category AS (
SELECT category,AVG(sales) as avg_sales
       FROM superstore
	   GROUP BY category)
SELECT *
FROM avg_sales_category;

--Products Above Overall Average Sales
WITH  above_avg_sales AS (
SELECT AVG(sales) as avg_sales
       FROM superstore
)
SELECT product_name,sales
FROM  superstore , above_avg_sales
WHERE sales >avg_sales;

--Rank Products by Profit Using a CTE
WITH product_profit AS (
SELECT product_name,
       SUM(profit) AS total_profit
	   FROM superstore
	   GROUP BY product_name
)
SELECT product_name,
       total_profit,
	   DENSE_RANK() OVER (ORDER BY total_profit DESC) AS profit_rnk
FROM product_profit;

--Monthly Sales
WITH monthly_sales AS(
SELECT 
       DATE_TRUNC('MONTH', order_date) AS month,
	   SUM(sales) AS total_sales
	   FROM superstore
	   GROUP BY DATE_TRUNC('MONTH', order_date)
)
SELECT * 
FROM monthly_sales
ORDER BY month;

--Customers with Sales Greater Than Average Customer Sales
WITH customer_sales AS (
SELECT customer_name,
       SUM(sales) AS total_sales
	   FROM superstore
	   GROUP BY customer_name
),
avg_customer AS (
SELECT 
       AVG(total_sales) AS avg_sales
	   FROM customer_sales
)
SELECT *
FROM customer_sales
WHERE total_sales >(
SELECT avg_sales
FROM avg_customer
);

--Highest Profit Product in Each Category
WITH profit_product AS (
SELECT category,
       product_name,
	   SUM(profit) AS total_profit
	   FROM superstore
	   GROUP BY category,product_name
),
ranked_product AS(
SELECT *,
DENSE_RANK() OVER (PARTITiON BY category ORDER BY total_profit DESC) AS rnk
FROM profit_product
)
SELECT 
       category,
	   product_name,
	   total_profit
	   FROM ranked_product
WHERE rnk=1
ORDER BY total_profit desc;


  