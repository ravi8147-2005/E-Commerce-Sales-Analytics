--Classify each order as High, Medium, or Low Sales.
SELECT order_id,sales,
CASE WHEN sales >=1000 THEN 'High Sales'
WHEN sales >= 500 THEN 'Medium Sales'
ELSE 'Low Sales' END AS sales_category
from superstore;

--Classify Profitability
SELECT order_id,profit,
CASE WHEN profit >0 THEN 'Profit'
WHEN profit = 0 THEN 'Break Even'
ELSE 'loss' END AS profit_status
from superstore;

--Discount Classification
SELECT discount,
CASE WHEN discount = 0 THEN 'No Discount'
WHEN discount <=0.20 THEN 'low discount'
WHEN discount <=0.50 THEN 'Medium Dsicount'
ELSE 'High Discount' END as discount_level
from superstore;

--Customer Type
SELECT customer_name,SUM(sales) as total_sales,
CASE WHEN SUM(sales) >=10000 THEN 'Premium Customer'
WHEN SUM(sales) >= 5000 THEN 'Gold Customer'
ELSE 'Regular Customer' END AS customer_type
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC;

--Product Performance
SELECT product_name,sum(profit) AS total_profit,
CASE WHEN SUM(profit) >5000 THEN 'Excellent'
WHEN SUM(profit) > 1000 THEN 'Good'
WHEN SUM(profit) > 0 THEN 'Average'
ELSE 'Loss Making' END AS Product_status
FROM superstore
GROUP BY product_name;


