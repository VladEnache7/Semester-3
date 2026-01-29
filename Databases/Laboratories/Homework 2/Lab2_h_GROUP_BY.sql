USE AccountingCompanyDataBase

-- find the number of offices located in each city having more than 1 office
SELECT City, COUNT(*) 
FROM Offices
GROUP BY City
HAVING COUNT(*) > 1
ORDER BY City;

-- find the number of bank accounts of the FANG (Facebook, Amazon, Netflix, Google) companies
SELECT Company_Name, nrOfAccounts
FROM Partners_Companies PC
INNER JOIN (
SELECT CompanyCUI, COUNT(*) AS nrOfAccounts
FROM Companies_Banks CB
GROUP BY CB.CompanyCUI
HAVING CB.CompanyCUI IN ( 
	SELECT CompanyCUI
	FROM Partners_Companies
	WHERE Company_Name IN ('Meta', 'Amazon', 'Netflix', 'Google'))) AS Result
ON PC.CompanyCUI = Result.CompanyCUI
					
-- retrieve the average price for each VAT rate, filtering the results  
-- to include only VAT rates with an average price greater than $500 and being a payment more than 1 time
SELECT VATRate, AVG(Quantity * PriceValue) AS AVERAGE
FROM Services_Products SP
GROUP BY VATRate
HAVING AVG(Quantity * PriceValue) > 500


-- find the number of income transactions for each bank, providing insights into the banks most used by the partners to pay the company
SELECT TOP 5 B.BankName,  R.COUNT AS INCOME_TRANSACTIONS
FROM (
	SELECT SWIFTCode, COUNT(*) AS COUNT
	FROM Companies_Banks CB
	JOIN Income I ON CB.CompanyCUI = I.CompanyCUI
	GROUP BY SWIFTCode) AS R
INNER JOIN Banks B ON B.SWIFTCode = R.SWIFTCode
ORDER BY R.COUNT DESC


-- find the maximum and minimum salaries for each company, providing a range of salaries for each company.
SELECT CompanyCUI, MAX(Salary) AS MaximumSalary, MIN(Salary) AS MinimumSalary
FROM Employees
GROUP BY CompanyCUI;

-- find the company that have the average salaries grater the average salaries of all employees and order them descendent by average
SELECT PC.Company_Name, R.AVERAGE
FROM (
	SELECT CompanyCUI, AVG(Salary) AS AVERAGE
	FROM Employees
	GROUP BY CompanyCUI
	HAVING AVG(Salary) > (
		SELECT AVG(Salary)
		FROM Employees)
	) AS R 
INNER JOIN Partners_Companies PC ON PC.CompanyCUI = R.CompanyCUI
ORDER BY R.AVERAGE DESC
	
