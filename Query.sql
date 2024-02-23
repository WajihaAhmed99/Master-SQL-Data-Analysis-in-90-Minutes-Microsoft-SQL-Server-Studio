--SELECT statement
--selecting all the data
SELECT *
FROM Employee

--selecting specfic columns
SELECT
Emplyee_id,
First_name,
Last_name
FROM Employee

--selecting top rows
SELECT Top 5
First_name,
Department_id
FROM Employee

SELECT Top 5 *
FROM Employee

--Distnict function
SELECT DISTINCT(First_name)
FROM Employee

SELECT DISTINCT *
FROM Employee

--Aggregrated function
SELECT
COUNT(*)
FROM Employee

SELECT
COUNT(Emplyee_id)
FROM Employee

SELECT
COUNT(DISTINCT Emplyee_id)
FROM Employee

SELECT
MAX(Income_per_month) AS max_income
FROM Employee

SELECT
MIN(Income_per_month) AS min_income
FROM Employee

SELECT
AVG(Income_per_month) avg_income
FROM Employee

SELECT
SUM(Income_per_month) AS sum_income
FROM Employee

-- from error --
SELECT *
FROM Employee

SELECT *
FROM [SQL Practices file].dbo.Employee

SELECT *
FROM Employee

-- WHERE Statement --
-- Equal to and not equal to --
SELECT *
FROM Employee
WHERE Gender = 'M'

SELECT *
FROM Employee
WHERE Income_per_month = 65000

SELECT *
FROM Employee
WHERE Gender <> 'M'

--Grater then and less then --
SELECT *
FROM Employee
WHERE Income_per_month > 65000

SELECT *
FROM Employee
WHERE Income_per_month < 95000

SELECT *
FROM Employee
WHERE Income_per_month <= 50000

SELECT *
FROM Employee
WHERE Income_per_month BETWEEN 60000 AND 70000

-- Conditions in different columns --
SELECT *
FROM Employee
WHERE Gender = 'F' AND Income_per_month <= 50000

SELECT *
FROM Employee
WHERE Gender = 'F' OR Income_per_month <= 50000

-- Multiple conditions in single column --
SELECT *
FROM Employee
WHERE First_name IN ('Emma' , 'Ava')

SELECT *
FROM Employee
WHERE Income_per_month IN (65000, 95000)

-- Like --
SELECT *
FROM Employee
WHERE First_name LIKE '%E%'

SELECT *
FROM Employee
WHERE First_name LIKE 'E%'

SELECT *
FROM Employee
WHERE First_name LIKE '%E'

-- GROUP BY Statement
SELECT
Gender,
COUNT(Gender) AS gender_count
FROM Employee
GROUP BY Gender

SELECT
Gender,
COUNT(Gender) AS gender_count,
AVG(Income_per_month) avg_income
FROM Employee
GROUP BY Gender


-- ORDER BY STATEMENT
SELECT
Emplyee_id,
Gender,
Income_per_month
FROM Employee
ORDER BY Income_per_month DESC

SELECT
Emplyee_id,
Gender,
Income_per_month
FROM Employee
ORDER BY Income_per_month ASC

SELECT
Gender,
COUNT(Gender) AS gender_count,
AVG(Income_per_month) avg_income
FROM Employee
GROUP BY Gender
ORDER BY avg_income DESC

--Having clause --
SELECT
First_name,
AVG(Income_per_month) AS avg_income
FROM Employee
GROUP BY First_name
HAVING AVG(Income_per_month) >80000

--joins--
--INNER JOIN --
SELECT *
FROM Employee
INNER JOIN Department
ON Employee.Department_id = Department.Department_id
INNER JOIN [Order]
ON Employee.Emplyee_id = [Order].Employee_id

-- FULL OUTER JOIN--
SELECT *
FROM Employee
FULL OUTER JOIN Department
ON Employee.Department_id = Department.Department_id
FULL OUTER JOIN [Order]
ON Employee.Emplyee_id = [Order].Employee_id

-- LEFT JOIN --
SELECT *
FROM Employee
LEFT JOIN Department
ON Employee.Department_id = Department.Department_id
LEFT JOIN [Order]
ON Employee.Emplyee_id = [Order].Employee_id

--RIGHT JOIN --
SELECT *
FROM Employee
RIGHT JOIN Department
ON Employee.Department_id = Department.Department_id
RIGHT JOIN [Order]
ON Employee.Emplyee_id = [Order].Employee_id

--selecting specific columns, filters, group by, order by clause by using join statement --
SELECT 
First_name,
Income_per_month,
Department_name,
Order_Amount,
[Order].Employee_id
FROM Employee
INNER JOIN Department
ON Employee.Department_id = Department.Department_id
INNER JOIN [Order]
ON Employee.Emplyee_id = [Order].Employee_id

SELECT 
Department_name,
AVG(Order_Amount) AS avg_amount
FROM Employee
INNER JOIN Department
ON Employee.Department_id = Department.Department_id
INNER JOIN [Order]
ON Employee.Emplyee_id = [Order].Employee_id
GROUP BY Department_name
ORDER BY avg_amount DESC

SELECT 
Department_name,
AVG(Income_per_month) AS avg_income,
Gender
FROM Employee
INNER JOIN Department
ON Employee.Department_id = Department.Department_id
WHERE Gender= 'F'
GROUP BY Department_name, Gender
ORDER BY avg_income DESC

-- Identifying and deleting Null values --
-- Identify null values
SELECT *
FROM [Order]
WHERE 
Order_id IS NULL
OR Employee_id IS NULL
OR Order_date IS NULL
OR Order_Amount IS NULL 

-- Deleting null values --
DELETE FROM [Order]
WHERE 
Order_id IS NULL
OR Employee_id IS NULL
OR Order_date IS NULL
OR Order_Amount IS NULL 

--	Identify and deleting duplicate values --
-- Identify duplicate values --
SELECT
Order_id,
Employee_id,
Order_date,
Order_Amount,
COUNT(*)
FROM [Order]
GROUP BY 
Order_id,
Employee_id,
Order_date,
Order_Amount
HAVING COUNT(*) > 1

--deleting duplicate values --
WITH DuplicateCTE AS (
SELECT Order_id, Employee_id, Order_date, Order_Amount, Row_Number() OVER (PARTITION BY Order_id, Employee_id, Order_date, Order_Amount ORDER BY (SELECT NULL)) AS RowNumber
FROM [Order]
)
DELETE  FROM DuplicateCTE WHERE RowNumber >1

-- Extract year, month and day from date --
SELECT
Employee_id,
Order_date,
YEAR(Order_date) AS year,
MONTH(Order_date) AS month,
Day(Order_date) AS day
FROM [Order]
-- Extract age from date of birth --
SELECT
First_name,
Last_name,
DATEDIFF(YEAR, DOB, GETDATE()) AS age
FROM Employee

--Case statement --
SELECT
Emplyee_id,
Gender = CASE
   When Gender = 'F' THEN 'Female'
   WHEN Gender = 'M' THEN 'Male'
   ELSE Gender
   END
FROM Employee

SELECT
First_name,
DOB,
Income_per_month = CASE  
   WHEN Income_per_month BETWEEN 30000 AND 60000 THEN 'Low'
   WHEN Income_per_month BETWEEN 61000 AND 90000 THEN 'Average'
   WHEN Income_per_month BETWEEN 91000 AND 120000 THEN 'High'
   ELSE TRY_CAST(Income_per_month AS VARCHAR)
   END 
FROM Employee

 -- Combine two column --
 SELECT
 Emplyee_id,
 DOB,
 CONCAT(First_name, ' ', Last_name) AS Full_name
 FROM Employee

 -- Spliting of columns--
 SELECT
 Emplyee_id,
 DOB,
 LEFT(Emplyee_id, 2) AS usual_code,
 RIGHT(Emplyee_id, 2) AS employee_id
 FROM Employee

 -- Update data in existing table --
 UPDATE Employee
 SET Gender = CASE
   When Gender = 'F' THEN 'Female'
   WHEN Gender = 'M' THEN 'Male'
   ELSE Gender
   END

   -- Updating data by creating new column --
   ALTER TABLE Employee
   ADD Full_name AS CONCAT(First_name, ' ', Last_name) 


   SELECT *
   FROM Employee