--the dataset
SELECT * FROM pizza_sales

--total revenue
select SUM(total_price) AS total_revenue from pizza_sales

--average revenue per order
select SUM(total_price)/COUNT (DISTINCT order_id) AS average_revenue_per_order
FROM pizza_sales

--total pizzas sold
SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales

--total orders placed
SELECT COUNT(DISTINCT order_id) AS total_order FROM pizza_sales

--average pizzas per order
SELECT CAST (CAST(SUM(quantity) AS decimal(10,2))/CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS DECIMAL(10,2)) AS average_pizza_per_order FROM pizza_sales

--daily trend for total orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_order_count
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

--hourly trend for total orders
SELECT DATEPART(Hour, order_time) AS daily_hours, COUNT(DISTINCT order_id) AS total_order_count
FROM pizza_sales
GROUP BY DATEPART(Hour, order_time)
ORDER BY DATEPART(Hour, order_time)

--% of sales by pizza category
SELECT pizza_category, SUM(total_price) AS total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_of_pizza_category
FROM pizza_sales
GROUP BY pizza_category

--% of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS decimal(10,2))  AS total_sales, CAST (SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS percentage_of_pizza_size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) DESC

--total pizzas sold by pizza category
SELECT pizza_category, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizza_sold DESC

--top 5 best sellers by total pizzas sold
SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC

--bottom 5 best sellers by total pizzas sold
SELECT TOP 5 pizza_name, SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold ASC
