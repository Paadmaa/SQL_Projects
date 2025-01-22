# OCD Patient Data Analysis

## Dataset Overview
This project involves analyzing a dataset of 1,500 OCD (Obsessive-Compulsive Disorder) patients to extract meaningful insights about their demographics, symptoms, comorbidities, and treatments.

### Columns Description:
1. **Patient ID**: Unique identifier for each patient.
2. **Age**: Age of the patient.
3. **Gender**: Gender of the patient (e.g., Male, Female).
4. **Ethnicity**: Ethnic background of the patient.
5. **Marital Status**: Current marital status (e.g., Single, Married).
6. **Education Level**: Highest level of education achieved.
7. **OCD Diagnosis Date**: The date when the patient was diagnosed with OCD.
8. **Duration of Symptoms (months)**: How long the patient has experienced symptoms.
9. **Previous Diagnoses**: Other diagnosed conditions (e.g., MDD, PTSD).
10. **Family History of OCD**: Whether OCD runs in the family (Yes/No).
11. **Obsession Type**: Type of obsession (e.g., Harm-related, Contamination).
12. **Compulsion Type**: Type of compulsion (e.g., Checking, Washing).
13. **Y-BOCS Score (Obsessions)**: Severity score for obsessions.
14. **Y-BOCS Score (Compulsions)**: Severity score for compulsions.
15. **Depression Diagnosis**: Whether the patient is diagnosed with depression (Yes/No).
16. **Anxiety Diagnosis**: Whether the patient is diagnosed with anxiety (Yes/No).
17. **Medications**: Medications prescribed (e.g., SSRI, Benzodiazepine).

---

## Problem Statement
The goal of this project is to:
1. Understand the demographic and clinical characteristics of OCD patients.
2. Identify common obsession and compulsion types.
3. Explore the relationship between symptoms, comorbidities, and treatments.
4. Analyze trends in OCD diagnoses over time.
5. Examine factors influencing the severity of OCD.

---

## Approach

### 1. Data Cleaning
- Convert dates to a standard format for temporal analysis.
- Ensure categorical values are consistent (e.g., "Yes"/"No" responses).
- Identify and handle any anomalies or outliers.

### 2. Exploratory Data Analysis (EDA)
- Summarize demographic attributes (e.g., gender, ethnicity, marital status).
- Analyze obsession and compulsion patterns across different groups.
- Evaluate the distribution of Y-BOCS scores (severity indicators).
- Investigate comorbidities (e.g., depression, anxiety) and their treatments.

### 3. Insights and Visualization
- Visualize trends in OCD diagnoses over time.
- Highlight the most common obsession and compulsion types.
- Compare Y-BOCS scores across age groups, genders, and ethnicities.
- Analyze the impact of comorbidities on OCD severity and treatment.

### 4. Statistical Analysis
- Correlation between symptoms and family history.
- Relationship between Y-BOCS scores and treatment types.

---

## Initial Observations

### 1. Gender Distribution
- Males and females are equally represented in the dataset.

### 2. Obsession and Compulsion Types
- Harm-related obsessions and checking compulsions are the most common.

### 3. Duration of Symptoms
- Patients have experienced symptoms for an average of 150 months (~12.5 years).

### 4. Family History
- A significant percentage of patients report a family history of OCD.

### 5. Comorbidities
- Depression and anxiety frequently co-occur with OCD.

---

## Solution

### SQL Queries
- Perform demographic analysis (e.g., age and gender trends).
- Identify the most common obsession and compulsion types.
- Calculate average Y-BOCS scores for different groups.
- Explore medication effectiveness across comorbid conditions.

### Visualization Tools
- Use tools like Power BI or Python for in-depth graphical analysis.

---

## Results
- Insights into patient demographics, OCD patterns, and treatment effectiveness.
- Evidence-based recommendations for clinicians and researchers.

---

## How to Run
1. Load the dataset into your preferred SQL environment or analysis tool.
2. Use the provided SQL queries for analysis.
3. Visualize results using tools like Power BI, Tableau, or Python.

---

## Future Scope
- Expand the analysis with additional clinical and environmental data.
- Conduct predictive modeling to identify high-risk groups.
- Explore longitudinal trends in OCD severity and treatment outcomes.
