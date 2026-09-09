--Total Sales by Category
select category,sum(sales) as total_sales
from superstore
group by category
order by total_sales desc;

--Total Profit by Category
select category,sum(profit) as total_profit
from superstore
group by category
order by total_profit desc;

---Profit Margin by Category
select category,sum(sales) as total_sales,sum(profit) as total_profit,
ROUND( sum(profit)/sum(sales))*100,2 as profit_margin
from superstore
group by category
order by profit_margin desc;

--Total Sales by Region
select region ,sum(sales) as total_sales
from superstore
group by region
order by total_sales desc;

--Total Profit by Region
select region ,sum(profit) as total_profit
from superstore
group by region
order by total_profit desc;

--Sales by Segment
select segment,sum(sales) as total_sales
from superstore
group by segment
order by total_sales desc;

--Profit by Segment
select segment,sum(profit) as total_profit
from superstore
group by segment
order by total_profit desc;

--select segment,sum(sales) as total_sales
from superstore
group by segment
order by total_sales desc;

--Top 10 States by Sales
select state,sum(sales) as total_sales
from superstore
group by state
order by total_sales desc
limit 10;

--Bottom 10 States by Profit
select state , sum(profit) as total_profit
from superstore
group by state
order by total_profit asc
limit 10;

--Sales by Ship Mode
select ship_mode,sum(sales) as total_sales
from superstore
group by ship_mode
order by total_sales desc;

--Sales by Sub-Category
select sub_category,sum(sales) as total_sales
from superstore
group by sub_category
order by total_sales desc;

--Profit by Sub-Category
select sub_category ,sum(profit) as total_profit
from superstore
group by sub_category
order by total_profit desc;

--Top 10 Customers by Sales
select customer_name,sum(sales) as total_sales
from superstore
group by customer_name
order by total_sales desc
limit 10;

--Top 10 Customers by Profit
select customer_name ,sum(profit) as total_profit
from superstore
group by customer_name
order by total_profit desc
limit 10;

--Top 10 Products by Sales
select product_name,sum(sales) as total_sales
from superstore
group by product_name
order by total_sales desc
limit 10;

--Top 10 Products by Profit
select product_name , sum(profit) as total_profit
from superstore
group by product_name
order by total_profit desc
limit 10;

select * from superstore;
