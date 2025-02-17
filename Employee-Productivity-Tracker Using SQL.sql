CREATE DATABASE IF NOT EXISTS EmployeeProductivity;
USE EmployeeProductivity;

CREATE TABLE Raw_Employees (
    Employee_ID INT PRIMARY KEY,
    Department VARCHAR(100),
    Gender VARCHAR(10),  -- Assuming Gender is stored as "Male"/"Female"
    Age INT,
    Job_Title VARCHAR(255),
    Hire_Date VARCHAR(50),  -- Will convert to DATE later
    Years_At_Company INT,
    Education_Level VARCHAR(100),
    Performance_Score INT,
    Monthly_Salary FLOAT,
    Work_Hours_Per_Week INT,
    Projects_Handled INT,
    Overtime_Hours INT,
    Sick_Days INT,
    Remote_Work_Frequency INT,
    Team_Size INT,
    Training_Hours INT,
    Promotions INT,
    Employee_Satisfaction_Score FLOAT,
    Resigned BOOLEAN 
);

DESCRIBE TABLE Raw_Employees;

CREATE INDEX idx_department ON Raw_Employees (Department);
CREATE INDEX idx_job_title ON Raw_Employees (Job_Title);
CREATE INDEX idx_performance_score ON Raw_Employees (Performance_Score);
CREATE INDEX idx_resigned ON Raw_Employees (Resigned);

ALTER TABLE Raw_Employees  
MODIFY COLUMN Education_Level VARCHAR(50);

ALTER TABLE Raw_Employees  
MODIFY COLUMN Resigned ENUM('TRUE', 'FALSE');

SHOW PROCESSLIST;

SELECT COUNT(*) FROM Raw_Employees;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Extended_Employee_Performance_and_Productivity_Data.csv'
INTO TABLE Raw_Employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Raw_Employees;

-- Data Cleaning 
SELECT Employee_ID, COUNT(*)
FROM RAW_Employees
GROUP BY Employee_ID
HAVING COUNT(*) > 1;

SELECT * FROM Raw_Employees
WHERE Employee_ID IS NULL 
   OR Department IS NULL 
   OR Job_Title = ''
   OR Monthly_Salary IS NULL;

ALTER TABLE Raw_Employees 
MODIFY COLUMN Hire_Date DATE;

ALTER TABLE Raw_Employees 
MODIFY COLUMN Resigned TINYINT(1);

UPDATE Raw_Employees 
SET Department = TRIM(LOWER(Department));

UPDATE Raw_Employees 
SET Job_Title = 'Software Engineer' 
WHERE Job_Title IN ('SDE', 'Developer', 'Software Engr.');

DESCRIBE Raw_Employees;

SELECT * FROM Raw_Employees 
LIMIT 20;

-- EDA
-- Basic stats
SELECT 
    COUNT(*) AS Total_Employees, 
    AVG(Monthly_Salary) AS Avg_Salary, 
    AVG(Performance_Score) AS Avg_Performance 
FROM Raw_Employees;

-- Department-wise Employee Distribution
SELECT Department, COUNT(*) AS Employee_Count 
FROM Raw_Employees 
GROUP BY Department 
ORDER BY Employee_Count DESC;

-- Performance Score Distribution 
SELECT Performance_Score, COUNT(*) AS Count 
FROM Raw_Employees 
GROUP BY Performance_Score 
ORDER BY Performance_Score;

-- Attrition Analysis (Employes who resigned)
SELECT Department, COUNT(*) AS Resigned_Employees 
FROM Raw_Employees 
WHERE Resigned = 1 
GROUP BY Department 
ORDER BY Resigned_Employees DESC;

-- Salary Trends by job title
SELECT Job_Title, AVG(Monthly_Salary) AS Avg_Salary 
FROM Raw_Employees 
GROUP BY Job_Title 
ORDER BY Avg_Salary DESC;

-- Impact of Overtime on Performance 
SELECT 
    CASE 
        WHEN Overtime_Hours = 0 THEN 'No Overtime'
        WHEN Overtime_Hours BETWEEN 1 AND 10 THEN 'Low Overtime'
        WHEN Overtime_Hours BETWEEN 11 AND 20 THEN 'Moderate Overtime'
        ELSE 'High Overtime'
    END AS Overtime_Category,
    AVG(Performance_Score) AS Avg_Performance
FROM Raw_Employees 
GROUP BY Overtime_Category 
ORDER BY Avg_Performance DESC;

-- Ranking system for employee productivity tracker

ALTER TABLE Raw_Employees  
ADD COLUMN Productivity_Score FLOAT;
UPDATE Raw_Employees  
SET Productivity_Score =  
    (Performance_Score * 3 +  
     Employee_Satisfaction_Score * 1.5 +  
     Work_Hours_Per_Week * 1 -  
     Sick_Days * 10 +  
     Promotions * 1.5 -  
     Overtime_Hours * 6);
     
     SELECT Employee_ID, Productivity_Score  
FROM Raw_Employees  
ORDER BY Productivity_Score DESC  
LIMIT 20;


SELECT 
    Employee_ID,
    (Performance_Score * 3 + 
     Employee_Satisfaction_Score * 1.5 + 
     Work_Hours_Per_Week * 1 - 
     Sick_Days * 10 + 
     Promotions * 1.5 - 
     Overtime_Hours * 6) AS Productivity_Score
FROM Raw_Employees
ORDER BY Productivity_Score DESC;


SELECT 
    Employee_ID,
    Productivity_Score,
    CASE 
        WHEN Productivity_Score >= 70 THEN 'High Performer'
        WHEN Productivity_Score BETWEEN 50 AND 69 THEN 'Moderate Performer'
        ELSE 'Low Performer'
    END AS Performance_Category
FROM (
    SELECT 
        Employee_ID,
        (Performance_Score * 3 + 
     Employee_Satisfaction_Score * 1.5 + 
     Work_Hours_Per_Week * 1 - 
     Sick_Days * 10 + 
     Promotions * 1.5 - 
     Overtime_Hours * 6) AS Productivity_Score
    FROM Raw_Employees
) AS Scores
ORDER BY Productivity_Score DESC;

SELECT Productivity_Score FROM Raw_Employees;

-- Exporting data for Vizualization 
SELECT 
    Employee_ID,
    Department,
    Performance_Score,
    Employee_Satisfaction_Score,
    Work_Hours_Per_Week,
    Sick_Days,
    Overtime_Hours,
    Promotions,
    Team_Size,
    Productivity_Score,
    CASE 
        WHEN Productivity_Score >= 110 THEN 'High Performer'
        WHEN Productivity_Score BETWEEN 40 AND 109 THEN 'Moderate Performer'
        ELSE 'Low Performer'
    END AS Performance_Category
FROM Raw_Employees
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Productivity_Analysis.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';






