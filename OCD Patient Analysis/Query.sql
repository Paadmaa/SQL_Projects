CREATE TABLE ocd_patients (
    patient_id INT,
    age INT,
    gender VARCHAR(10),
    ethnicity VARCHAR(20),
    marital_status VARCHAR(15),
    education_level VARCHAR(20),
    ocd_diagnosis_date DATE,
    duration_of_symptoms INT,
    previous_diagnoses VARCHAR(50),
    family_history_of_ocd VARCHAR(3),
    obsession_type VARCHAR(30),
    compulsion_type VARCHAR(30),
    y_bocs_score_obsessions INT,
    y_bocs_score_compulsions INT,
    depression_diagnosis VARCHAR(3),
    anxiety_diagnosis VARCHAR(3),
    medications VARCHAR(50)
);

-- DROP TABLE ocd_patients;
SELECT * FROM ocd_patients;

# -- 1. Count & Pct of F vs M that have OCD & -- Average Obsession Score by Gender
WITH data AS (
    SELECT
        gender,
        COUNT(patient_id) AS patient_count,
        ROUND(AVG(y_bocs_score_obsessions), 2) AS avg_obs_score
    FROM ocd_patients
    GROUP BY gender
    ORDER BY patient_count
)

SELECT
    SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END) AS count_female,
    SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END) AS count_male,

    ROUND(SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END) /
        (SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END) + 
         SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END)) * 100, 2) AS pct_female,

    ROUND(SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END) /
        (SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END) + 
         SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END)) * 100, 2) AS pct_male

FROM data;


# -- 2. Count of Patients by Ethnicity and their respective Average Obsession Score

SELECT
    ethnicity,
    COUNT(patient_id) AS patient_count,
    AVG(y_bocs_score_obsessions) AS obs_score
FROM ocd_patients
GROUP BY ethnicity
ORDER BY patient_count;


# -- 3. Number of people diagnosed with OCD MoM

SELECT
    DATE_TRUNC('month', ocd_diagnosis_date) AS month,
    COUNT(patient_id) AS patient_count
FROM ocd_patients
GROUP BY month
ORDER BY month;


# -- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score
SELECT
    obsession_type,
    COUNT(patient_id) AS patient_count,
    ROUND(AVG(y_bocs_score_obsessions), 2) AS obs_score
FROM ocd_patients
GROUP BY obsession_type
ORDER BY patient_count;


# -- 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score

SELECT
    compulsion_type,
    COUNT(patient_id) AS patient_count,
    ROUND(AVG(y_bocs_score_obsessions), 2) AS obs_score
FROM ocd_patients
GROUP BY compulsion_type
ORDER BY patient_count;


