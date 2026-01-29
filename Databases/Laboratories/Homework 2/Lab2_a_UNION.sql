USE AccountingCompanyDataBase

--show all the services/products that are payments or incomes of the company
SELECT SPName, (Quantity * PriceValue) AS TOTAL_PRICE
FROM Income I
INNER JOIN Income_Services_Products ISP ON I.InvoiceNumber = ISP.InvoiceNumber
INNER JOIN Services_Products SP ON SP.InternalCode = ISP.ProductCode
UNION
SELECT SPName, (Quantity * PriceValue) AS TOTAL_PRICE
FROM Payments P
INNER JOIN Payments_Services_Products PSP ON P.InvoiceNumber = PSP.InvoiceNumber
INNER JOIN Services_Products SP ON SP.InternalCode = PSP.ProductCode;

-- show all Services_Products that have been payd/purchad with a total price grater than 10k
SELECT SPName, (Quantity * PriceValue) AS TOTAL_PRICE
FROM Services_Products
WHERE (InternalCode IN (SELECT ProductCode
						FROM Income_Services_Products)
	OR InternalCode IN (SELECT ProductCode
						FROM Payments_Services_Products))
	AND Quantity * PriceValue > 10000;


