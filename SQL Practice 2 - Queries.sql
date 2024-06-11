-- 2.1 Select the last name of all employees.

SELECT
	LastName
FROM
	Employees

-- 2.2 Select the last name of all employees, without duplicates.

SELECT DISTINCT
	LastName
FROM
	Employees

-- 2.3 Select all the data of employees whose last name is "Smith".

SELECT
	*
FROM 
	Employees
WHERE 
	LastName = 'Smith'

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".

SELECT
	*
FROM 
	Employees
WHERE 
	LastName 
IN
	('Smith', 'Doe')

-- 2.5 Select all the data of employees that work in department 14.

SELECT
	*
FROM
	Employees
WHERE
	Department = 14

-- 2.6 Select all the data of employees that work in department 37 or department 77.

SELECT
	*
FROM
	Employees
WHERE
	Department 
IN
	(37, 77)

-- 2.7 Select all the data of employees whose last name begins with an "S".

SELECT
	*
FROM
	Employees
WHERE
	LastName
LIKE 
	'S%'

-- 2.8 Select the sum of all the departments' budgets.

SELECT
	SUM(Budget)
FROM
	Departments

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).

SELECT 
	Department,
	COUNT(*) as Total_Employees
FROM
	Employees
GROUP BY
	Department

-- 2.10 Select all the data of employees, including each employee's department's data.

SELECT 
	e.*,
	d.*
FROM 
	Employees e
JOIN
	Departments d 
ON
	d.Code = e.Department

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.

SELECT 
	e.Name,
	e.LastName,
	d.Name,
	d.Budget
FROM 
	Employees e
JOIN
	Departments d 
ON
	d.Code = e.Department

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.

SELECT 
	e.Name,
	e.LastName
FROM 
	Employees e
JOIN
	Departments d 
ON
	d.Code = e.Department
WHERE
	e.Department
IN (
	SELECT 
		Code
	FROM 
		Departments d2
	WHERE 
		d2.Budget > 60000
	)

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.

SELECT 
	*
FROM 
	Departments
WHERE
	Budget > (
		SELECT 
			AVG(Budget)
		FROM
			Departments
			)

-- 2.14 Select the names of departments with more than two employees.

SELECT 
	d.Name
FROM
	Departments d
WHERE
	d.Code
IN			--Subquery gives the code where 3+ employees are working in (1,2,3,..) and from this list we choose the names in the main query
	(
	SELECT
		Department
	FROM
		Employees
	GROUP BY
		Department
	HAVING 
		COUNT(*) > 2
		)

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
-- LIMIT function doesnt work here (SMSS)
SELECT
    e.Name,
    e.LastName
FROM 
    Employees e
JOIN
    (
        SELECT 
            d.Code
        FROM
            Departments d
        ORDER BY
            d.Budget
        OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
    ) AS second_lowest_budget_department
ON
    e.Department = second_lowest_budget_department.Code;

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.

insert into 
	departments 
values
	(11, 'Quality Assurance', 40000);
insert into 
	employees 
values
	(847219811, 'Mary', 'Moore', 11);

-- 2.17 Reduce the budget of all departments by 10%.

UPDATE
	Departments
SET
	Budget = Budget * 0.9

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).

UPDATE
	Employees
SET
	Department = 14
WHERE
	Department = 77

-- 2.19 Delete from the table all employees in the IT department (code 14).

DELETE FROM
	Employees
WHERE 
	Department = 14

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.

DELETE FROM
	Employees
WHERE 
	Department 
IN (
	SELECT 
		Code 
	FROM 
		Departments
	WHERE 
		Budget >= 60000
	)

-- 2.21 Delete from the table all employees.

DELETE FROM
	Employees
