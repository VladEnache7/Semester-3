USE AccountingCompanyDataBase

-- intersect the companies that have accounts at LIBRA with those that have account at ALPHA
SELECT Company_Name
FROM Partners_Companies
WHERE CompanyCUI IN (
	SELECT CompanyCUI
	FROM Companies_Banks CB
	INNER JOIN Banks B ON B.SWIFTCode = CB.SWIFTCode
	WHERE B.BankName = ' LIBRA BANK S.A.')
INTERSECT 
SELECT Company_Name
FROM Partners_Companies
WHERE CompanyCUI IN (
	SELECT CompanyCUI
	FROM Companies_Banks CB
	INNER JOIN Banks B ON B.SWIFTCode = CB.SWIFTCode
	WHERE B.BankName = 'Alpha Bank România')

-- show the Services that have entries in the Income table
SELECT SPName
FROM Services_Products
WHERE InternalCode IN (
	SELECT ProductCode
	FROM Income_Services_Products)