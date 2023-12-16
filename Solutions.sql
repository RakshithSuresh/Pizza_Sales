select * from pizza_sales;

-- KPI Requirements
-- Total Revenue
select sum(total_price) as Total_Revenue
from pizza_sales;

-- Average Order Value
select (sum(total_price)/ count(distinct order_id)) as Average_Order_Value
from pizza_sales;

-- Total Pizzas Sold
select sum(quantity) as total_pizzas_sold
from pizza_sales;

-- Total Orders
select count(distinct(order_id)) as total_orders
from pizza_sales;

-- Average Pizzas Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS avg_pizzas_order
FROM pizza_sales;

-- Daily Trend for Orders
-- DATENAME used to convert order_date to string and retrieve the name of the date
select DATENAME(dw,order_date) as  order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(dw,order_date)
order by total_orders ASC;


-- Hourly Trend for Total Orders
select DATEPART(HOUR, order_time) as order_time, count(distinct order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time) ASC;

-- Percentage of Sales by Pizza Category
select pizza_category, cast(sum(total_price) as decimal(10,2)) as Total_Sales,cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales where MONTH(order_date) = 1) as decimal(10,2)) as Percentage_of_Sales
from pizza_sales
where MONTH(order_date) = 1
group by pizza_category
order by Percentage_of_Sales;

-- Percentage of Sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales,cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales where DATEPART(quarter, order_date) =1) as decimal(10,2)) as Percentage_of_Sales
from pizza_sales
where DATEPART(quarter, order_date)=1
group by pizza_size
order by Percentage_of_Sales desc;

-- total pizza sold by pizza category
select pizza_category, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_category
order by total_pizzas_sold;

-- Top 5 Best sellers by Total Pizzas Sold
select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name
order by total_pizzas_sold desc;

-- Bottom 5 Worst sellers by Total Pizzas Sold
select top 5 pizza_name, sum(quantity) as total_pizzas_sold
from pizza_sales
group by pizza_name
order by total_pizzas_sold asc;