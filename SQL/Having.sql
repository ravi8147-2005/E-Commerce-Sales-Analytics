--Show only categories whose total sales are greater than $700,000.
select category,sum(sales) as total_sales
from superstore
group by category
having sum(sales) >700000;

--Show states with profit greater than $10,000.
select state,sum(profit) as total_profit
from superstore
group by state
having sum(profit) >10000;

--Show customers whose total purchases exceed $10,000.
select customer_name,sum(sales) as total_sales
from superstore
group by customer_name
having sum(sales) > 10000
order by total_sales desc;

--Show products with negative total profit.
select product_name ,sum(profit) as total_profit
from superstore
group by product_name
having sum(profit) <0
order by total_profit asc;

--Show sub-categories with profit margin greater than 20%.
select sub_category,
sum(sales) as total_sales,
sum(profit) as total_profit,
round( (sum(profit)/sum(sales))*100,
2
) as profit_margin
from superstore
group by sub_category
having (sum(profit)/sum(sales))*100>20
order by profit_margin desc;










