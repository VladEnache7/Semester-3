-- update data – for at least 3 tables;
-- DONE - updated Banks, Employees & Services_Products

USE AccountingCompanyDataBase
-- update the city from romanian to english
UPDATE Banks
SET BankCity = 'Bucharest, Romania'
WHERE BankCity LIKE '%București%';

-- update rows having only the cities, to also have the countries
UPDATE Banks
SET BankCity = CONCAT(BankCity, ', Romania')
WHERE BankCity NOT LIKE '%,%';

-- I forgot to add the comma, so I'll update it now
UPDATE Banks
SET BankCity = 'Bucharest, Romania'
WHERE BankCity = 'BucharestRomania';

UPDATE Banks
SET BankCity = 'Cluj-Napoca, Romania'
WHERE BankCity = 'Cluj-NapocaRomania';

-- find the employees that work at tesla
SELECT *
FROM Employees E
WHERE CompanyCUI IN (
	SELECT CompanyCUI
	FROM Partners_Companies
	WHERE Company_Name = 'Tesla'
	)

-- yeeey, Tesla is on big profits
-- increse the salary of the employee with 5% of those with that work at Tesla
UPDATE Employees
SET Salary = Salary / 100 * 105
WHERE CompanyCUI IN (
	SELECT CompanyCUI
	FROM Partners_Companies
	WHERE Company_Name = 'Tesla'
	)

-- the govern rised some of the VAT (TVA) 
UPDATE Services_Products
SET VATRate = VATRate + 2
WHERE VATRate BETWEEN 4 AND 6;
