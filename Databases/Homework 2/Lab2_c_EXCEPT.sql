USE AccountingCompanyDataBase

-- show the services/product that are not in the income table (they may be payments)
SELECT SPName
FROM Services_Products
WHERE InternalCode NOT IN (
	SELECT ProductCode
	FROM Income_Services_Products)

-- show the companies that do not have more than 2 employees
SELECT Company_Name
FROM Partners_Companies
EXCEPT
SELECT Company_Name
FROM Partners_Companies PC
INNER JOIN Employees E ON PC.CompanyCUI = E.CompanyCUI
GROUP BY Company_Name
HAVING COUNT(*) > 2;

