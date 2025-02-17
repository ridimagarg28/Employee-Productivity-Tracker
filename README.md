# Employee Productivity Tracker using SQL

## 📌 Project Overview
This project focuses on analyzing and tracking employee productivity using SQL. The dataset consists of various employee performance metrics, including work hours, performance scores, promotions, and satisfaction levels. A **Productivity Scoring Model** was developed to rank employees into **High, Moderate, and Low Performers**, enabling data-driven decision-making for workforce management.

## 🚀 Features
- **Data Cleaning & Transformation:** Handled missing values, corrected data types, and ensured data integrity using SQL queries.
- **Productivity Scoring Model:** Implemented a weighted formula to calculate employee productivity based on multiple performance factors.
- **Ranking System:** Categorized employees as **High, Moderate, or Low Performers** based on their productivity scores.
- **Optimized Query Performance:** Used **indexing and efficient SQL queries** to improve query execution speed.
- 
## 📂 Dataset
The dataset includes the following key attributes:
- **Employee ID** (Unique identifier)
- **Department, Job Title** (Employee work details)
- **Performance Score, Satisfaction Score** (Work performance indicators)
- **Work Hours per Week, Overtime Hours** (Workload tracking)
- **Promotions, Sick Days, Resignation Status** (Employee progress tracking)

## ⚙️ Technology Stack
- **SQL (MySQL Workbench)** – Data storage, cleaning, transformation, and analytics.

## 📖 SQL Implementation Steps
1. **Database & Table Creation:** Created the `Raw_Employees` table and defined appropriate data types.
2. **Data Cleaning:** Standardized column values, removed duplicates, and fixed data inconsistencies.
3. **Computed Productivity Score:** Used a weighted formula incorporating multiple performance metrics.
4. **Implemented Ranking System:** Classified employees into performance categories based on computed scores.
5. **Query Optimization:** Utilized indexing for efficient querying.

## 📊 Productivity Score Formula
```sql
UPDATE Raw_Employees
SET Productivity_Score =  
    (Performance_Score * 3 +  
     Employee_Satisfaction_Score * 1.5 +  
     Work_Hours_Per_Week * 1 -  
     Sick_Days * 10 +  
     Promotions * 1.5 -  
     Overtime_Hours * 6);
```

## 🔥 Key Insights
- Identified top-performing employees based on calculated **Productivity Scores**.
- Analyzed trends in **work hours, performance, and employee satisfaction**.
- Helped in workforce optimization by identifying areas for **improvement and training**.

## 📌 How to Use
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/Employee-Productivity-Tracker.git
   ```
2. **Import the Dataset** into MySQL Workbench.
3. **Run SQL Queries** for data cleaning, transformation, and analysis.
4. **Visualize Results** using Tableau for better insights.

## 🏆 Future Enhancements
- Automate data updates using stored procedures.
- Implement a **real-time dashboard** for monitoring employee performance.
- Integrate with **HR systems** for better workforce planning.

## 🤝 Contributing
Feel free to fork this repository and submit pull requests for improvements.

