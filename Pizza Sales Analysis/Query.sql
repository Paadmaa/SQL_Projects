CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,  -- Unique identifier for each pizza
    pizza_type_id VARCHAR(50) NOT NULL,  -- Type of pizza
    size CHAR(2) NOT NULL,  -- Size of the pizza (S, M, L, etc.)
    price NUMERIC(5, 2) NOT NULL  -- Price of the pizza with up to 2 decimal places
);

ALTER TABLE pizzas
ALTER COLUMN size TYPE CHAR(3);

SELECT * FROM pizzas;

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    ingredients TEXT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL
);

CREATE TABLE order_details (
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id VARCHAR(50) NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY(order_details_id)
);

SELECT * FROM order_details;

-- Basic:
-- 1.Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS total_orders FROM orders;

-- 2.Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(public.order_details.quantity * public.pizzas.price),2) AS total_sales
FROM 
    public.order_details
JOIN 
    public.pizzas
ON 
    public.pizzas.pizza_id = public.order_details.pizza_id;


-- 3.Identify the highest-priced pizza.

SELECT public.pizza_types.name, public.pizzas.price
FROM public.pizza_types JOIN public.pizzas
ON public.pizza_types.pizza_type_id = public.pizzas.pizza_type_id
ORDER BY public.pizzas.price DESC;

-- 4.Identify the most common pizza size ordered.

SELECT quantity, COUNT(order_details_id)
FROM order_details GROUP BY quantity;

SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size ORDER BY order_count DESC;

-- 5.List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name,
SUM(order_details.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC;


-- Intermediate:

-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.category,
SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- 2.Determine the distribution of orders by hour of the day.

SELECT 
    EXTRACT(HOUR FROM time) AS hour, 
    COUNT(order_id) AS order_count
FROM 
    orders
GROUP BY 
    EXTRACT(HOUR FROM time)
ORDER BY 
    hour;


-- 3.Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, COUNT(name) FROM pizza_types
GROUP BY category;

-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity),0) AS avg_pizza_ordered_per_day FROM 
(SELECT orders.date, SUM(order_details.quantity) AS quantity
FROM orders JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.date) AS order_quantity;

-- 5.Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name,
SUM(order_details.quantity * pizzas.price) AS Revenue
FROM pizza_types JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Revenue
LIMIT 3;

-- Advanced:

-- 1.Calculate the percentage contribution of each pizza type to total revenue.

SELECT pizza_types.category,
(SUM(order_details.quantity * pizzas.price) / (SELECT ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_sales
FROM order_details JOIN pizzas
ON pizzas.pizza_id = order_details.pizza_id)) * 100 AS Revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Revenue DESC;

-- 2.Analyze the cumulative revenue generated over time.

SELECT date,SUM(Revenue) OVER (ORDER BY date) AS cum_revenue
FROM
(SELECT orders.date,SUM(order_details.quantity * pizzas.price) AS Revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
JOIN orders
ON orders.order_id = order_details.order_id
GROUP BY orders.date) AS sales;


-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
    name, 
    Revenue 
FROM (
    SELECT 
        category, 
        name, 
        Revenue,
        RANK() OVER(PARTITION BY category ORDER BY Revenue DESC) AS rn
    FROM (
        SELECT 
            pizza_types.category, 
            pizza_types.name,
            SUM(order_details.quantity * pizzas.price) AS Revenue
        FROM 
            pizza_types
        JOIN pizzas
            ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN order_details
            ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY 
            pizza_types.category, 
            pizza_types.name
    ) AS A
) AS B
WHERE rn <= 3;
