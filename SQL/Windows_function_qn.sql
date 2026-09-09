--Assign a unique row number to every order based on sales.
SELECT order_id, customer_name,sales,
       ROW_NUMBER() OVER (ORDER BY sales DESC) AS  row_num
FROM superstore;

--Rank orders by sales.
SELECT order_id,sales,
       RANK() OVER (ORDER BY sales DESC) AS order_rank
FROM superstore;

--DENSE_RANK()
SELECT order_id ,sales,
       DENSE_RANK() OVER (ORDER BY sales DESC) AS dense_rnk
FROM superstore;

--Top 5 Products by Profit
SELECT product_name,sum(profit) AS total_profit,
       DENSE_RANK() OVER (ORDER BY SUM(profit) DESC) AS product_rnk
FROM superstore
GROUP BY product_name
ORDER BY total_profit desc
limit 5;

--Ranking Within Each Category
SELECT category,product_name,SUM(sales) AS total_sales,
       RANK() OVER(PARTITION BY category ORDER BY SUM(sales) desc) AS category_rnk
FROM superstore
GROUP BY category,product_name;

--Running Total
SELECT order_date,sales,
       SUM(sales) OVER(ORDER BY order_date) AS running_total
FROM superstore;

--Running Total by Year
SELECT order_date,sales,EXTRACT(YEAR FROM order_date) AS year,
       SUM(sales) OVER(PARTITION BY EXTRACT(YEAR FROM order_date) ORDER BY order_date) AS running_total_year
FROM superstore;

--Compare current sale with the previous order.
SELECT order_date,sales,
       LAG(sales) OVER(ORDER BY order_date) as previous_sales
FROM superstore;

--LEAD()
SELECT order_date,sales,
      LEAD(sales) OVER(ORDER BY order_date) AS lead_rnk
FROM superstore;

--Moving Average
SELECT order_date,sales,
       ROUND(
             AVG(sales) OVER(ORDER BY order_date 
			 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
			 2)
			 AS moving_avg
FROM superstore;

--First Order of Every Customer
SELECT *
FROM ( SELECT order_date,customer_name,sales,
       ROW_NUMBER() OVER( PARTITION BY customer_name ORDER BY order_date) as rn
	   FROM superstore) t
WHERE rn =1;








