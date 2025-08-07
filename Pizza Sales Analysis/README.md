# Pizza Sales Analysis Project

This project analyzes a dataset of pizza sales to extract key business insights. The analysis is divided into three sections: Basic, Intermediate, and Advanced, addressing various questions using SQL queries. The results provide valuable insights for decision-makers and showcase analytical and data visualization skills to recruiters.

---

## Dataset Overview

The project uses three primary tables:

1. **orders**:
   - Contains details about orders, including:
     - `order_id`: Unique identifier for each order.
     - `date`: Date of the order.
     - `time`: Time of the order.

2. **order_details**:
   - Contains details about individual pizzas in an order:
     - `order_details_id`: Unique identifier for each detail.
     - `order_id`: Foreign key linking to the orders table.
     - `pizza_id`: Identifier for the pizza.
     - `quantity`: Number of pizzas ordered.

3. **pizza_types**:
   - Contains details about pizza categories:
     - `pizza_type_id`: Unique identifier for the pizza type.
     - `name`: Name of the pizza.
     - `category`: Category of the pizza (e.g., Chicken, Vegetarian).
     - `ingredients`: List of ingredients.

4. **pizzas**:
   - Contains details about pizzas:
     - `pizza_id`: Unique identifier for the pizza.
     - `pizza_type_id`: Foreign key linking to the pizza_types table.
     - `size`: Size of the pizza.
     - `price`: Price of the pizza.

---

## Key Questions Answered

### Basic Questions

1. **Retrieve the total number of orders placed:**
   - Query:
     ```sql
     SELECT COUNT(order_id) AS total_orders FROM orders;
     ```

2. **Calculate the total revenue generated from pizza sales:**
   - Query:
     ```sql
     SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue
     FROM order_details
     JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;
     ```

3. **Identify the highest-priced pizza:**
   - Query:
     ```sql
     SELECT name, price FROM pizzas ORDER BY price DESC LIMIT 1;
     ```

4. **Identify the most common pizza size ordered:**
   - Query:
     ```sql
     SELECT size, COUNT(size) AS count FROM pizzas GROUP BY size ORDER BY count DESC LIMIT 1;
     ```

5. **List the top 5 most ordered pizza types along with their quantities:**
   - Query:
     ```sql
     SELECT pizza_id, SUM(quantity) AS total_quantity
     FROM order_details
     GROUP BY pizza_id
     ORDER BY total_quantity DESC
     LIMIT 5;
     ```

### Intermediate Questions

6. **Find the total quantity of each pizza category ordered:**
   - Query:
     ```sql
     SELECT pizza_types.category, SUM(order_details.quantity) AS total_quantity
     FROM order_details
     JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
     JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
     GROUP BY pizza_types.category;
     ```

7. **Determine the distribution of orders by hour of the day:**
   - Query:
     ```sql
     SELECT EXTRACT(HOUR FROM time) AS hour, COUNT(order_id) AS order_count
     FROM orders
     GROUP BY hour
     ORDER BY hour;
     ```

8. **Find the category-wise distribution of pizzas:**
   - Query:
     ```sql
     SELECT pizza_types.category, COUNT(order_details.pizza_id) AS total_pizzas
     FROM order_details
     JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
     JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
     GROUP BY pizza_types.category;
     ```

9. **Group orders by date and calculate the average number of pizzas ordered per day:**
   - Query:
     ```sql
     SELECT date, AVG(order_details.quantity) AS avg_pizzas_per_day
     FROM orders
     JOIN order_details ON orders.order_id = order_details.order_id
     GROUP BY date;
     ```

10. **Determine the top 3 most ordered pizza types based on revenue:**
    - Query:
      ```sql
      SELECT name, Revenue
      FROM (
          SELECT category, name, Revenue,
          RANK() OVER(PARTITION BY category ORDER BY Revenue DESC) AS rn
          FROM (
              SELECT pizza_types.category, pizza_types.name,
              SUM(order_details.quantity * pizzas.price) AS Revenue
              FROM pizza_types
              JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
              JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
              GROUP BY pizza_types.category, pizza_types.name
          ) AS A
      ) AS B
      WHERE rn <= 3;
      ```

### Advanced Questions

11. **Calculate the percentage contribution of each pizza type to total revenue:**
    - Query:
      ```sql
      SELECT name, 
             SUM(order_details.quantity * pizzas.price) / SUM(SUM(order_details.quantity * pizzas.price)) OVER () * 100 AS percentage_contribution
      FROM pizza_types
      JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
      JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
      GROUP BY name;
      ```

12. **Analyze the cumulative revenue generated over time:**
    - Query:
      ```sql
      SELECT date, SUM(revenue) OVER (ORDER BY date) AS cumulative_revenue
      FROM (
          SELECT orders.date, SUM(order_details.quantity * pizzas.price) AS revenue
          FROM orders
          JOIN order_details ON orders.order_id = order_details.order_id
          JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
          GROUP BY orders.date
      ) AS daily_revenue;
      ```

13. **Determine the top 3 most ordered pizza types by revenue for each category:**
    - Query:
      ```sql
      SELECT category, name, Revenue
      FROM (
          SELECT category, name, Revenue,
          RANK() OVER(PARTITION BY category ORDER BY Revenue DESC) AS rank
          FROM (
              SELECT pizza_types.category, pizza_types.name,
              SUM(order_details.quantity * pizzas.price) AS Revenue
              FROM pizza_types
              JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
              JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
              GROUP BY pizza_types.category, pizza_types.name
          ) AS ranked_revenues
      ) AS ranked
      WHERE rank <= 3;
      ```

---

## Key Learnings

- Proficiency in SQL concepts such as joins, grouping, ranking, and aggregate functions.
- Effective use of PostgreSQL-specific functions like `EXTRACT()` and `RANK()`.
- Ability to transform raw data into actionable insights for business decisions.

---

## How to Use

1. Clone this repository.
2. Import the provided datasets into your PostgreSQL database.
3. Run the SQL queries provided in this README or in the SQL scripts to replicate the analysis.

---

### Contact
For further queries or collaboration, feel free to reach out via [LinkedIn](www.linkedin.com/in/padmach-behera).
