USE AccountingCompanyDataBase

-- join the banks with the companies - see at which banks does the companies have accounts
SELECT DISTINCT P.Company_Name, B.BankName
FROM Partners_Companies P
INNER JOIN Companies_Banks CB ON P.CompanyCUI = CB.CompanyCUI
INNER JOIN Banks B ON CB.SWIFTCode = B.SWIFTCode

-- find the service/product that is at the same time an income and a payment
SELECT *
FROM Income I
JOIN Income_Services_Products ISP ON ISP.InvoiceNumber = I.InvoiceNumber
JOIN Services_Products SP ON SP.InternalCode = ISP.ProductCode
JOIN Payments_Services_Products PSP ON PSP.ProductCode = SP.InternalCode
JOIN Payments P ON P.InvoiceNumber = PSP.InvoiceNumber;


-- see all the services but those that were not used as payments will appear with NULL
SELECT *
FROM Services_Products SP
LEFT JOIN Payments_Services_Products PSP ON SP.InternalCode = PSP.ProductCode;

-- see all the offices, but those that do not have a company assigned will apear with NULL
SELECT *
FROM Partners_Companies PC
RIGHT JOIN Offices ON Offices.CompanyCUI = PC.CompanyCUI;

-- full join the Companies with the employees => 
-- it will be seen also the companies that do not have employees and employees without company
SELECT *
FROM Partners_Companies PC
FULL JOIN Employees E ON PC.CompanyCUI = E.CompanyCUI;

-- retrive the companies where the Accounting Firm has payments, and what products/services they offered
SELECT Company_Name, SPName
FROM Services_Products
JOIN Payments_Services_Products ON Services_Products.InternalCode = Payments_Services_Products.ProductCode
JOIN Payments ON Payments_Services_Products.InvoiceNumber = Payments.InvoiceNumber
JOIN Partners_Companies ON Payments.CompanyCUI = Partners_Companies.CompanyCUI;