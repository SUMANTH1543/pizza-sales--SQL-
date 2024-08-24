--1.Retrieve the total number of orders placed.
select COUNT(order_id) as Total_orders
from orders;

--2.Calculate the total revenue generated from pizza sales.

-- revenue = quantity * price 
select 
ROUND(SUM(order_details.quantity * pizzas.price),2) as Total_revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

--3.Identify the highest-priced pizza.

SELECT TOP 1 pizza_types.name, pizzas.price
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC;
 

 --4.Identify the most common pizza size ordered.

select 
pizzas.size,
count(order_details.order_details_id) as no_of_orders
from order_details
join pizzas
on pizzas.pizza_id= order_details.pizza_id
group by size;


--5.List the top 5 most ordered pizza types along with their quantities.

SELECT TOP 5 pizza_types.name, sum(order_details.quantity) as order_count
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by order_count desc;

--6.Join the necessary tables to find the total quantity of each pizza category ordered.

select 
sum(order_details.quantity) as Total_quantity,
pizza_types.category
from pizza_types
join pizzas
on pizzas.pizza_type_id= pizza_types.pizza_type_id
join order_details 
on order_details.pizza_id= pizzas.pizza_id
group by category order by Total_quantity desc ;


--7.Join relevant tables to find the category-wise distribution of pizzas.

select 
count(name) as pizza_types,
category
from pizza_types
group by category

---8.Group the orders by date and calculate the average number of pizzas ordered per day.

 select avg(quantity) as avg_count from 
 (select
orders.date,
sum(order_details.quantity) as quantity
from orders
join order_details
on order_details.order_id= orders.order_id
group by date) order_quantity

--9.Determine the top 3 most ordered pizza types based on revenue.

select top 3 pizza_types.name,
ROUND(SUM(order_details.quantity * pizzas.price),2) as Total_revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types
on pizza_types.pizza_type_id= pizzas.pizza_type_id
group by name 
order by Total_revenue desc;


--10.Calculate the percentage contribution of each pizza type to total revenue.


select  pizza_types.category,
round(SUM(order_details.quantity * pizzas.price) /(select 
ROUND(SUM(order_details.quantity * pizzas.price),2) as Total_revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id) *100,2) as  revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types
on pizza_types.pizza_type_id= pizzas.pizza_type_id
group by category 
order by revenue desc;
