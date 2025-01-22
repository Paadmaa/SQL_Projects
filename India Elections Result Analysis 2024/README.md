# India Elections Result Analysis 2024

This repository contains a comprehensive SQL-based analysis of the 2024 Indian General Elections. The project demonstrates the use of structured query language (SQL) for extracting, transforming, and analyzing election data to derive meaningful insights.

## Project Structure

The repository is organized into the following components:

- **`data/`**: Contains raw election data in CSV format.
- **`sql/`**: Includes SQL scripts for data preprocessing, analysis, and insights generation.
- **`README.md`**: Documentation of the project.

## Objective

The primary goal of this project is to use SQL as the core tool for analyzing India's 2024 General Election results, focusing on:

- Constituency-level vote analysis.
- Party-wise performance evaluation.
- Regional and state-wise voter trends.
- Historical comparisons of election outcomes.

---

## SQL Usage in the Project

SQL serves as the backbone of this project. The following aspects of the analysis are achieved using SQL:

### 1. **Database Design**
   - **Schema Creation**: Tables were designed to store election data effectively, ensuring normalization and reducing redundancy.  
     For example:
     ```sql
     CREATE TABLE election_results (
         constituency_id INT PRIMARY KEY,
         constituency_name VARCHAR(100),
         state_name VARCHAR(100),
         party_name VARCHAR(100),
         candidate_name VARCHAR(100),
         votes_received INT,
         total_votes INT,
         voter_turnout FLOAT
     );
     ```

### 2. **Data Cleaning and Transformation**
   - Raw data from CSV files was cleaned using SQL commands to ensure accuracy and consistency.  
   - Example operations include:
     - Removing duplicate records.
     - Converting data types for consistency.
     - Handling missing or null values using `COALESCE` or conditional updates.  
     ```sql
     UPDATE election_results
     SET votes_received = 0
     WHERE votes_received IS NULL;
     ```

### 3. **Data Analysis**
   SQL queries were used to perform the following analyses:

   - **Constituency-Wise Winner Calculation**:
     ```sql
     SELECT 
         constituency_name, 
         state_name, 
         candidate_name, 
         party_name,
         MAX(votes_received) AS max_votes
     FROM election_results
     GROUP BY constituency_name, state_name, candidate_name, party_name;
     ```

   - **Party-Wise Vote Share**:
     ```sql
     SELECT 
         party_name, 
         SUM(votes_received) AS total_votes,
         ROUND(SUM(votes_received) * 100.0 / SUM(total_votes), 2) AS vote_share_percentage
     FROM election_results
     GROUP BY party_name
     ORDER BY total_votes DESC;
     ```

   - **State-Wise Voter Turnout**:
     ```sql
     SELECT 
         state_name, 
         AVG(voter_turnout) AS avg_turnout
     FROM election_results
     GROUP BY state_name
     ORDER BY avg_turnout DESC;
     ```

   - **Top Performing Parties**:
     ```sql
     SELECT 
         party_name, 
         COUNT(constituency_id) AS seats_won
     FROM election_results
     WHERE votes_received = (
         SELECT MAX(votes_received)
         FROM election_results AS inner_table
         WHERE inner_table.constituency_id = election_results.constituency_id
     )
     GROUP BY party_name
     ORDER BY seats_won DESC;
     ```

### 4. **Insights Derived**
   Using SQL queries, we derived the following insights:
   - **Party Performance**: Identified the party with the highest number of seats won and its vote share.
   - **Regional Trends**: Observed voter turnout and trends across states and union territories.
   - **Winning Margins**: Calculated the margin of victory for each constituency.
     ```sql
     SELECT 
         constituency_name, 
         state_name, 
         MAX(votes_received) - MIN(votes_received) AS winning_margin
     FROM election_results
     GROUP BY constituency_name, state_name;
     ```

---

## Data Files

- **`data/election_results_2024.csv`**: Constituency-wise election results, including state, party, candidate, votes received, total votes, and turnout.
- **`data/voter_turnout_2024.csv`**: State-wise voter turnout percentages.

---

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Paadmaa/SQL_Projects.git
   ```

2. **Set Up the Database**:
   - Create a database in your preferred SQL-compliant system (e.g., PostgreSQL, MySQL).
   - Execute the `create_tables.sql` script to define the schema.
   - Load the CSV data into the database.

3. **Run SQL Scripts**:
   - Execute `Input Command.sql` to clean and preprocess the data.
   - Use `Output Command.sql` to run queries and generate insights.

---

## Requirements

- **Database Management System**: PostgreSQL, MySQL, or equivalent.
- **Tools**: SQL client (e.g., pgAdmin, MySQL Workbench).

---

## Conclusion

This project showcases how SQL can be effectively used for large-scale data analysis. By focusing on structured data processing, it provides actionable insights into the 2024 Indian General Elections, including party performance, voter behavior, and regional dynamics.

---
