select * from superstore;
--Show me all orders where sales are greater than $1000
select * from superstore
where sales >1000;

--Find all loss-making orders.
select * from superstore
where profit < 0;

--Find all Technology category orders.
select * from superstore
where category = 'Technology';

--Find all orders from California.
select * from superstore
where state='California';

--Find all orders from the West region
select * from superstore 
where region = 'West';

--Find products with discounts greater than 30%.
select * from superstore
where discount >0.30;

--Find orders with quantity greater than 10.
select * from superstore
where quantity >10;

--Find all orders placed in 2017
select * from superstore
where extract(year from order_date)=2017;

--Find customers whose names start with "S"
select * from superstore
where customer_name like 'S%';

---Furniture orders with negative profit
select * from superstore
where category='Furniture'
and profit <0;
--Technology orders in the West region.
select * from superstore
where category='Technology' and region='West';

--Orders from California OR Texas.
select * from superstore
where state = 'California' or state='Texas';

--Orders with discounts between 20% and 50%.
select * from superstore
where discount  between 0.20 and 0.50;

--Orders only from these states.
select * from superstore
where state in('California','Texas','Florida');















