# SQL Customer Sales Analysis

This repository contains a beginner-level SQL project focused on analyzing customer sales data. The project demonstrates how SQL can be utilized to extract meaningful insights from sales datasets, aiding in business decision-making processes.

## Project Overview

The primary objectives of this project include:

- **Sales Performance Evaluation**: Assessing total sales over specific periods to identify trends and patterns.
- **Customer Behavior Analysis**: Understanding purchasing behaviors to identify top customers and their preferences.
- **Product Performance Analysis**: Determining best-selling products and categories to inform inventory and marketing strategies.

## Repository Structure

The repository is organized as follows:

- **`data/`**: Contains CSV files with raw sales data.
- **`sql/`**: Includes SQL scripts used for data analysis.
- **`README.md`**: Provides an overview of the project and instructions for replication.

## Data Files

The `data/` directory includes the following CSV files:

- **`sales_data.csv`**: Contains transaction records with fields such as transaction ID, customer ID, product ID, quantity, price, and transaction date.
- **`customers.csv`**: Includes customer information like customer ID, name, contact details, and region.
- **`products.csv`**: Lists product details including product ID, name, category, and price.

## SQL Scripts

The `sql/` directory comprises scripts that perform various analyses:

- **`create_tables.sql`**: Defines the schema for importing CSV data into SQL tables.
- **`data_cleaning.sql`**: Contains queries to clean and preprocess the data, such as handling missing values and correcting data types.
- **`sales_analysis.sql`**: Includes queries to analyze sales performance, customer behavior, and product performance.

## Key Analyses

1. **Total Sales Over Time**:
   - Querying total sales per month to identify seasonal trends.
   - Example query:
     ```sql
     SELECT
         DATE_TRUNC('month', transaction_date) AS month,
         SUM(quantity * price) AS total_sales
     FROM
         sales_data
     GROUP BY
         month
     ORDER BY
         month;
     ```

2. **Top Customers**:
   - Identifying customers with the highest total spending.
   - Example query:
     ```sql
     SELECT
         c.customer_id,
         c.name,
         SUM(s.quantity * s.price) AS total_spent
     FROM
         sales_data s
     JOIN
         customers c ON s.customer_id = c.customer_id
     GROUP BY
         c.customer_id, c.name
     ORDER BY
         total_spent DESC
     LIMIT 10;
     ```

3. **Best-Selling Products**:
   - Determining products with the highest sales volume.
   - Example query:
     ```sql
     SELECT
         p.product_id,
         p.name,
         SUM(s.quantity) AS total_quantity_sold
     FROM
         sales_data s
     JOIN
         products p ON s.product_id = p.product_id
     GROUP BY
         p.product_id, p.name
     ORDER BY
         total_quantity_sold DESC
     LIMIT 10;
     ```

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Paadmaa/SQL_Projects.git
   ```

2. **Navigate to the Project Directory**:
   ```bash
   cd SQL_Projects/SQL\ Customer\ Sales\ Analysis
   ```

3. **Set Up the Database**:
   - Use the `create_tables.sql` script to create the necessary tables in your SQL database.
   - Import the CSV data into the corresponding tables.

4. **Run Analysis Scripts**:
   - Execute the queries in `sales_analysis.sql` to perform the analyses.

## Conclusion

This project serves as a practical introduction to using SQL for sales data analysis. By following the provided scripts and utilizing the sample data, users can learn how to perform essential analyses that are applicable in real-world business scenarios.
 