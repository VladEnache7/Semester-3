USE AccountingCompanyDataBase

-- RETURNS ALL THE COMPANIES THAT HAVE AT LEAST ONE EMPLOYEE WITH A SALARY GREATER THAN 290K
SELECT Company_Name
FROM Partners_Companies
WHERE CompanyCUI = ANY 
	(SELECT CompanyCUI
	FROM Employees
	WHERE Salary > 290000)

-- rewrite it with aggregation operator
SELECT Company_Name
FROM Partners_Companies PC
WHERE CompanyCUI IN 
	(SELECT CompanyCUI
	FROM Employees 
	WHERE Salary > 290000
	GROUP BY CompanyCUI)

-- List employees earning a salary higher than all employees that works at Apple
SELECT EmployeeName, Salary
FROM Employees
WHERE Salary > ALL 
	(SELECT Salary
	FROM Employees
	WHERE CompanyCUI IN 
		(SELECT CompanyCUI
		FROM Partners_Companies
		WHERE Company_Name = 'Apple'))

-- rewrite with MAX
SELECT EmployeeName, Salary
FROM Employees
WHERE Salary >  
	(SELECT MAX(Salary)
	FROM Employees
	WHERE CompanyCUI IN 
		(SELECT CompanyCUI
		FROM Partners_Companies
		WHERE Company_Name = 'Apple'))


-- LIST THE PRODUCT WITH THE LOWEST PRICE
SELECT *
FROM Services_Products
WHERE PriceValue <= ALL
	(SELECT PriceValue
	FROM Services_Products)

SELECT *
FROM Services_Products
WHERE PriceValue = 
	(SELECT MIN(PriceValue)
	FROM Services_Products)

-- LIST THE SERVICE OF THE FIRST 3 INCOME 
SELECT SP.SPName
FROM Services_Products SP
INNER JOIN Income_Services_Products ISP ON SP.InternalCode = ISP.ProductCode
WHERE ISP.InvoiceNumber = ANY
	(SELECT TOP 3 InvoiceNumber
	FROM Income
	ORDER BY IncomeDate)

-- REWRITE WITH IN
SELECT SP.SPName
FROM Services_Products SP
INNER JOIN Income_Services_Products ISP ON SP.InternalCode = ISP.ProductCode
WHERE ISP.InvoiceNumber IN 
	(SELECT TOP 3 InvoiceNumber
	FROM Income
	ORDER BY IncomeDate)