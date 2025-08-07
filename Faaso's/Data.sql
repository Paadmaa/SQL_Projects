-- Drop table if exists for PostgreSQL
DROP TABLE IF EXISTS driver;
CREATE TABLE driver (
    driver_id INTEGER,
    reg_date DATE
);

-- Insert data into driver table
INSERT INTO driver (driver_id, reg_date) 
VALUES 
    (1, '2021-01-01'),
    (2, '2021-01-03'),
    (3, '2021-01-08'),
    (4, '2021-01-15');

-- Drop table if exists for ingredients
DROP TABLE IF EXISTS ingredients;
CREATE TABLE ingredients (
    ingredients_id INTEGER,
    ingredients_name VARCHAR(60)
);

-- Insert data into ingredients table
INSERT INTO ingredients (ingredients_id, ingredients_name) 
VALUES 
    (1, 'BBQ Chicken'),
    (2, 'Chilli Sauce'),
    (3, 'Chicken'),
    (4, 'Cheese'),
    (5, 'Kebab'),
    (6, 'Mushrooms'),
    (7, 'Onions'),
    (8, 'Egg'),
    (9, 'Peppers'),
    (10, 'schezwan sauce'),
    (11, 'Tomatoes'),
    (12, 'Tomato Sauce');

-- Drop table if exists for rolls
DROP TABLE IF EXISTS rolls;
CREATE TABLE rolls (
    roll_id INTEGER,
    roll_name VARCHAR(30)
);

-- Insert data into rolls table
INSERT INTO rolls (roll_id, roll_name) 
VALUES 
    (1, 'Non Veg Roll'),
    (2, 'Veg Roll');

-- Drop table if exists for rolls_recipes
DROP TABLE IF EXISTS rolls_recipes;
CREATE TABLE rolls_recipes (
    roll_id INTEGER,
    ingredients VARCHAR(24)
);

-- Insert data into rolls_recipes table
INSERT INTO rolls_recipes (roll_id, ingredients) 
VALUES 
    (1, '1,2,3,4,5,6,8,10'),
    (2, '4,6,7,9,11,12');

-- Drop table if exists for driver_order
DROP TABLE IF EXISTS driver_order;
CREATE TABLE driver_order (
    order_id INTEGER,
    driver_id INTEGER,
    pickup_time TIMESTAMP,
    distance VARCHAR(7),
    duration VARCHAR(10),
    cancellation VARCHAR(23)
);

-- Insert data into driver_order table
INSERT INTO driver_order (order_id, driver_id, pickup_time, distance, duration, cancellation) 
VALUES 
    (1, 1, '2021-01-01 18:15:34', '20km', '32 minutes', ''),
    (2, 1, '2021-01-01 19:10:54', '20km', '27 minutes', ''),
    (3, 1, '2021-01-03 00:12:37', '13.4km', '20 mins', 'NaN'),
    (4, 2, '2021-01-04 13:53:03', '23.4', '40', 'NaN'),
    (5, 3, '2021-01-08 21:10:57', '10', '15', 'NaN'),
    (6, 3, NULL, NULL, NULL, 'Cancellation'),
    (7, 2, '2020-08-08 21:30:45', '25km', '25mins', NULL),
    (8, 2, '2020-10-10 00:15:02', '23.4 km', '15 minute', NULL),
    (9, 2, NULL,NULL,NULL,'Customer Cancellation'),
    (10 ,1,'2020-11-11 18:50:20','10km','10minutes',NULL);

-- Drop table if exists for customer_orders
DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
    order_id INTEGER,
    customer_id INTEGER,
    roll_id INTEGER,
    not_include_items VARCHAR(4),
    extra_items_included VARCHAR(4),
    order_date TIMESTAMP
);

-- Insert data into customer_orders table
INSERT INTO customer_orders (
   order_id,
   customer_id,
   roll_id,
   not_include_items,
   extra_items_included,
   order_date
)
VALUES 
   (1 ,101 ,1 ,'','','2021-01-01 18:05:02'),
   (2 ,101 ,1 ,'','','2021-01-01 19:00:52'),
   (3 ,102 ,1 ,'','','2021-02-02 23:51:23'),
   (3 ,102 ,2 ,'','NaN','2021-02-02 23:51:23'),
   (4 ,103 ,1 ,'4','','2021-04-04 13:23:46'),
   (4 ,103 ,1 ,'4','','2021-04-04 13:23:46'),
   (4 ,103 ,2 ,'4','','2021-04-04 13:23:46'),
   (5 ,104 ,1 ,NULL,'1','2021-08-08 21:00:29'),
   (6 ,101 ,2 ,NULL,NULL,'2021-08-08 21:03:13'),
   (7 ,105 ,2 ,NULL,'1','2021-08-08 21:20:29'),
   (8 ,102 ,1 ,NULL,NULL,'2021-09-09 23:54:33'),
   (9 ,103 ,1 ,'4','1,5','2021-10-10 11:22:59'),
   (10 ,104 ,1,NULL,NULL,'2020-11-11 ');

select * from customer_orders;
select * from driver_order;
select * from ingredients;
select * from driver;
select * from rolls;
select * from rolls_recipes;

-- 1.How many rools were ordered?
select count(roll_id) from customer_orders;

-- 2.How many unique customer orders were made?
select count(distinct(customer_id)) from customer_orders;

-- 3.How many successful orders were delivered by each driver?
SELECT driver_id,COUNT(DISTINCT(order_id)) FROM driver_order
WHERE cancellation NOT IN ('Cancellation','Customer Cancellation')
GROUP BY driver_id;

-- 4.How many of each type of roll was delivered?
SELECT roll_id,COUNT(roll_id) FROM
customer_orders WHERE order_id IN (
SELECT order_id FROM
(SELECT *,
CASE WHEN cancellation IN ('Cancellation','Customer Cancellation')
THEN 'c' ELSE 'nc' 
END AS order_cancel_details FROM driver_order) 
WHERE order_cancel_details ='nc')
GROUP BY roll_id;

-- 5.How many Veg & Non-veg Rolls were ordered by each customer?
SELECT a.*,b.roll_name FROM
(
SELECT customer_id,roll_id,COUNT(roll_id) AS cnt
FROM customer_orders
GROUP BY customer_id,roll_id
) AS a
INNER JOIN rolls b ON a.roll_id = b.roll_id;