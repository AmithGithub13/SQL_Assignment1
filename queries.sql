--1.Create two tables: EmployeeDetails and EmployeeSalary.Columns for EmployeeDetails: EmpId FullName ManagerId DateOfJoining City && Columns for EmployeeSalary: : EmpId Project Salary Variable.

-- Create table EmployeeDetails
CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(255),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(255)
);

-- Create table EmployeeSalary
CREATE TABLE EmployeeSalary (
    EmpId INT PRIMARY KEY,
    Project VARCHAR(255),
    Salary DECIMAL(10, 2),
    Variable DECIMAL(10, 2)
);


--2.SQL Query to fetch records that are present in one table but not in another table.

--Fetch records present in EmployeeDetails but not in EmployeeSalary
--Using LEFT JOIN:
SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;
--Using NOT EXISTS:
SELECT EmployeeDetails.*
FROM EmployeeDetails
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeSalary
    WHERE EmployeeSalary.EmpId = EmployeeDetails.EmpId
);

--Fetch records present in EmployeeSalary but not in EmployeeDetails:
--Using LEFT JOIN:
SELECT EmployeeSalary.*
FROM EmployeeSalary
LEFT JOIN EmployeeDetails ON EmployeeSalary.EmpId = EmployeeDetails.EmpId
WHERE EmployeeDetails.EmpId IS NULL;
--Using NOT EXISTS:
SELECT EmployeeSalary.*
FROM EmployeeSalary
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeDetails
    WHERE EmployeeDetails.EmpId = EmployeeSalary.EmpId
);

--3.SQL query to fetch all the employees who are not working on any project.
SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;

--4.SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

--5.Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
SELECT EmployeeDetails.*
FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;

--6.Write an SQL query to fetch a project-wise count of employees.
SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;

--7.Fetch employee names and salaries even if the salary value is not present for the employee.
SELECT EmployeeDetails.FullName, COALESCE(EmployeeSalary.Salary, 'N/A') AS Salary
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;

--8.Write an SQL query to fetch all the Employees who are also managers.
SELECT E1.*
FROM EmployeeDetails E1
JOIN EmployeeDetails E2 ON E1.EmpId = E2.ManagerId;

--9.Write an SQL query to fetch duplicate records from EmployeeDetails.
SELECT EmpId, COUNT(*) as DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId
HAVING COUNT(*) > 1;

--10.Write an SQL query to fetch only odd rows from the table.
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNumber
    FROM EmployeeDetails
) AS T
WHERE T.RowNumber % 2 = 1;

--11.Write a query to find the 3rd highest salary from a table without top or limit keyword.
SELECT MAX(Salary) AS ThirdHighestSalary
FROM EmployeeSalary
WHERE Salary < (
    SELECT MAX(Salary)
    FROM EmployeeSalary
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM EmployeeSalary
    )
);




