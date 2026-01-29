USE AccountingCompanyDataBase

-- find the companies that have offices
SELECT *
FROM Partners_Companies PC
WHERE EXISTS (
	SELECT *
	FROM Offices O
	WHERE O.CompanyCUI = PC.CompanyCUI)

-- find the employees that works at a company having accounts at LIBRA
SELECT *
FROM Employees E
WHERE EXISTS ( 
	SELECT *
	FROM Partners_Companies PC
	WHERE E.CompanyCUI = PC.CompanyCUI 
		AND PC.CompanyCUI IN (
			SELECT CompanyCUI
			FROM Companies_Banks CB
			INNER JOIN Banks B ON CB.SWIFTCode = B.SWIFTCode
			WHERE B.BankName LIKE '%LIBRA%'))
