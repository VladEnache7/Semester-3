USE AccountingCompanyDataBase

-- see the Offices at which companies with 1 employee have account
SELECT *
FROM Offices 
WHERE CompanyCUI IN (
	SELECT CompanyCUI
	FROM Employees
	GROUP BY CompanyCUI
	HAVING COUNT(*) = 1);

-- see the name of the companies from which the Accounting firm has incomes with a total value greater then 15k
SELECT PC.Company_Name
FROM Income I
INNER JOIN Partners_Companies PC ON I.CompanyCUI = PC.CompanyCUI
WHERE InvoiceNumber IN (
	SELECT InvoiceNumber
	FROM Income_Services_Products
	WHERE ProductCode IN (
		SELECT InternalCode
		FROM Services_Products
		WHERE Quantity * PriceValue >= 15000
		)
	)

