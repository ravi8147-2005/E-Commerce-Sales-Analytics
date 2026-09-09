--Create Category Sales Summary View
CREATE VIEW category_summary AS
SELECT category,
       SUM(sales) AS total_sales,
	   SUM(Profit) AS total_profit
FROM superstore
GROUP BY category;
--Retrieving
SELECT * FROM category_summary;

--Customer Sales Summary View
CREATE VIEW customer_summary AS
SELECT customer_name,
       SUM(sales) AS total_sales,
	   SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_name;

SELECT * FROM customer_summary
ORDER BY total_sales DESC;

--Product Profit View
CREATE VIEW product_profit AS 
SELECT product_name,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name;

SELECT * FROM product_profit
ORDER BY total_profit DESC;

--State Sales View
CREATE VIEW state_summary AS 
SELECT state,
       SUM(profit) AS total_profit,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY state;

SELECT * FROM state_summary
ORDER BY total_sales DESC;

--Monthly Sales View
CREATE VIEW monthly_summary AS 
SELECT DATE_TRUNC('MONTH',order_date) AS month,
       SUM(profit) AS total_profit,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY DATE_TRUNC('MONTH' ,order_date);

SELECT * FROM monthly_summary
ORDER BY MONTH;

--High Value Customers View
CREATE VIEW high_customers AS
SELECT customer_name,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
HAVING SUM(sales) > 10000;

SELECT * FROM high_customers
ORDER BY total_sales DESC;

--Loss-Making Products View
CREATE VIEW loss_making_product AS
SELECT product_name,
       SUM(profit) as total_profit
FROM superstore
GROUP BY product_name
HAVING SUM(profit) <0;

SELECT * FROM loss_making_product
ORDER BY total_profit ;

--Update a View
CREATE OR REPLACE VIEW category_summary AS
SELECT category,
       SUM(sales) AS total_sales,
	   SUM(profit) AS total_profit,
	   ROUND((SUM(profit)/SUM(sales))* 100,2) AS profit_margin
FROM superstore
GROUP BY category;

SELECT * FROM category_summary;

--List All Views
SELECT table_name
FROM information_schema.views
WHERE table_schema = 'public';






