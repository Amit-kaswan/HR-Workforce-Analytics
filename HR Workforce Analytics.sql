CREATE DATABASE HR_Analytics;

USE HR_Analytics;

RENAME TABLE Project_1_hr_employee_master_v2 TO Employees;

Select * from employees;

-- Workforce Summary
SELECT COUNT(*) AS Total_Employees
FROM Employees;

-- What is the average salary of employees?
SELECT round(AVG(salary))
FROM employees;

-- Average Age
SELECT ROUND(AVG(Age),2) AS Average_Age
FROM Employees;

-- Average Experience
SELECT ROUND(AVG(Experienceyears),2) AS Average_Experience
FROM Employees;

-- Module 2: Employee Distribution
-- Department Distribution

-- How many employees are in each department?
SELECT
    Department,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Department
ORDER BY Employee_Count DESC;

-- Gender Distribution
SELECT
    Gender,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY Gender;

-- City Distribution
SELECT
    City,
    COUNT(*) AS Employee_Count
FROM Employees
GROUP BY City
ORDER BY Employee_Count DESC;

-- Department-wise Attrition

SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END) AS Employees_Left,
    ROUND(
        SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employees
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- Job Satisfaction vs Attrition

SELECT
    JobSatisfaction,
    COUNT(*) AS Total_Employees,
    SUM(CASE
            WHEN Attrition='Yes' THEN 1
            ELSE 0
        END) AS Employees_Left,
    ROUND(
        SUM(CASE
                WHEN Attrition='Yes' THEN 1
                ELSE 0
            END) *100.0/COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- Work-Life Balance

SELECT
    WorkLifeBalance,
    COUNT(*) AS Total_Employees,
    SUM(CASE
            WHEN Attrition='Yes' THEN 1
            ELSE 0
        END) AS Employees_Left,
    ROUND(
        SUM(CASE
                WHEN Attrition='Yes' THEN 1
                ELSE 0
            END)*100.0/COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employees
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;

-- Salary Band

SELECT
    'Salary Band',
    COUNT(*) AS Total_Employees,
    SUM(CASE
            WHEN Attrition='Yes' THEN 1
            ELSE 0
        END) AS Employees_Left,
    ROUND(
        SUM(CASE
                WHEN Attrition='Yes' THEN 1
                ELSE 0
            END)*100.0/COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employees
GROUP BY 'Salary Band'
ORDER BY Attrition_Rate DESC;

-- Overtime

SELECT
    Overtime,
    COUNT(*) AS Total_Employees,
    SUM(CASE
            WHEN Attrition='Yes' THEN 1
            ELSE 0
        END) AS Employees_Left,
    ROUND(
        SUM(CASE
                WHEN Attrition='Yes' THEN 1
                ELSE 0
            END)*100.0/COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employees
GROUP BY Overtime;


-- Business Reporting & Filtering
-- Employees Who Left

SELECT *
FROM Employees
WHERE Attrition = 'Yes';

-- High Salary Employees
-- Find employees earning more than ₹15 lakh.

ALTER TABLE Employees
RENAME COLUMN `ï»¿EmployeeID` TO EmployeeID;

SELECT EmployeeID,
       EmployeeName,
       Department,
       Salary
FROM Employees
WHERE Salary > 1500000
ORDER BY Salary DESC;

-- HR wants one report showing employee count, average salary, minimum salary, maximum salary, and average experience for each department.

SELECT
    Department,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(Salary),2) AS Avg_Salary,
    MIN(Salary) AS Min_Salary,
    MAX(Salary) AS Max_Salary,
    ROUND(AVG(Experienceyears),2) AS Avg_Experience
FROM Employees
GROUP BY Department
ORDER BY Avg_Salary DESC;

-- Top 10 Highest Paid Employees

SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary
FROM Employees
ORDER BY Salary DESC
LIMIT 10;

-- Bottom 10 Salaries

SELECT
    EmployeeID,
    EmployeeName,
    Salary
FROM Employees
ORDER BY Salary ASC
LIMIT 10;

-- Department Salary Ranking

SELECT
    Department,
    ROUND(AVG(Salary),2) AS Avg_Salary
FROM Employees
GROUP BY Department
ORDER BY Avg_Salary DESC;

-- Employees Above Company Average Salary

SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary
FROM Employees
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
);

-- Department with Highest Attrition

SELECT
    Department,
    ROUND(
        SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS Attrition_Rate
FROM Employees
GROUP BY Department
ORDER BY Attrition_Rate DESC
LIMIT 1;

-- Find the five youngest employees.

Select age , employeename , employeeid 
from employees 
order BY AGE Asc
limit 5;

-- Find employees whose salary is greater than the average salary and whose experience is more than 10 years.

Select salary , experienceyears , Employeename
from employees
where Experienceyears > 10 and salary > 
( Select Avg(salary) as Avg_salary
from employees);

-- Find the department with the largest workforce.

Select Count(*) as Total_employees , department
from employees
group by department
order by Total_employees DESC
Limit 1;

-- "Show me the top 3 highest-paid employees in each department."

select employeename , salary , department , 
row_number () Over (order by salary DESC ) as Salary_rank
from employees;

-- Rank Employees Within Each Department

SELECT
    EmployeeName,
    Department,
    Salary,
    RANK() OVER (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS Department_Rank
FROM Employees;

-- Top Earner in Every Department

WITH SalaryRank AS
(
    SELECT
        EmployeeName,
        Department,
        Salary,
        ROW_NUMBER() OVER
        (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS rn
    FROM Employees
)

SELECT *
FROM SalaryRank
WHERE rn = 1;

-- Employees Earning Above Department Average

SELECT
    e.EmployeeName,
    e.Department,
    e.Salary
FROM Employees e
JOIN
(
    SELECT
        Department,
        AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY Department
) d
ON e.Department = d.Department
WHERE e.Salary > d.AvgSalary;