SELECT * FROM hr_data
limit 10;

--TOTAL EMPLOYEES
SELECT COUNT(*) FROM hr_data;

--CHECK NULL VALUES
SELECT COUNT(*) FROM hr_data WHERE age ISNULL OR 
attrition ISNULL OR
dailyrate ISNULL OR
employeenumber ISNULL OR
monthlyincome ISNULL;

--ATTRITION DISTRIBUTION(Yes/No)
SELECT Attrition, COUNT(*) FROM hr_data
GROUP BY Attrition;

--ATTRITION RATE
SELECT ROUND(
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS attrition_rate
FROM hr_data;

--DEPARTMENT WISE ATTRITION
SELECT Department, COUNT(*) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_left
FROM hr_data
GROUP BY department;

--SALARY VS ATTRITION
SELECT attrition, ROUND(AVG(monthlyincome),2) as avg_salary 
FROM hr_data
GROUP BY attrition;

--AVG WORKING YEARS
SELECT 
    AVG(TotalWorkingYears) 
FROM hr_data
WHERE Attrition = 'Yes';

--TENURE VS ATTRITION
SELECT yearsatcompany, count(*) as total ,
SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) As left_count
FROM hr_data
GROUP BY yearsatcompany
ORDER BY yearsatcompany;

--JOBROLE VS ATTRITION
SELECT JobRole, COUNT(*) AS Total,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_Count
FROM hr_data
GROUP BY JobRole
ORDER BY Left_Count DESC;

--TOP 3 HIGHEST PAID EMPLOYEES
SELECT * FROM 
(SELECT Department, EmployeeNumber,MonthlyIncome,
ROW_NUMBER() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS rnk 
FROM hr_data
)t
WHERE rnk <= 3;
