USE AccountingCompanyDataBase

-- see top 25% employees by salary employed in 2023 -> the most valuable recent interns
SELECT TOP 25 PERCENT *
FROM (
	SELECT *
	FROM Employees
	WHERE EmploymentDate LIKE '%2023%'
	) AS E
ORDER BY E.Salary DESC;

-- list the number of employees for those companies that have employees with more than 300k anualy 
SELECT PC.Company_Name, E.NR_EMPLOYEES_more_300k
FROM (
	SELECT CompanyCUI, COUNT(*) AS NR_EMPLOYEES_more_300k
	FROM Employees 
	WHERE Salary >= 300000
	GROUP BY CompanyCUI) AS E
INNER JOIN Partners_Companies PC ON E.CompanyCUI = PC.CompanyCUI

