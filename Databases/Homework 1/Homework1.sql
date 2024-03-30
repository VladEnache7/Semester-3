USE AccountingCompanyDataBaseV2
CREATE TABLE Partners_Companies (
  CompanyCUI INT PRIMARY KEY,
  Company_Name VARCHAR(50),
  Phone VARCHAR(20),
  BusinessRegNumber INT,
  InternalCode INT
);


CREATE TABLE Employees (
  CNP DECIMAL(13, 0) PRIMARY KEY,
  EmployeeName VARCHAR(30),
  CompanyCUI INT FOREIGN KEY REFERENCES Partners_Companies(CompanyCUI),
  Salary INT,
  Employee_Address VARCHAR(50),
  EmploymentDate DATE
);



CREATE TABLE Offices (
  OfficeCode INT PRIMARY KEY,
  CompanyCUI INT FOREIGN KEY REFERENCES Partners_Companies(CompanyCUI),
  City VARCHAR(50),
  Street VARCHAR(50),
  Number INT,
  PostalCode INT
);

CREATE TABLE Banks (
  SWIFTCode VARCHAR(10) PRIMARY KEY,
  BankName VARCHAR(50),
  BankCity VARCHAR(50)
);

CREATE TABLE Companies_Banks (
  AccountNumber VARCHAR(50) PRIMARY KEY,
  CompanyCUI INT FOREIGN KEY REFERENCES Partners_Companies(CompanyCUI),
  SWIFTCode VARCHAR(10) FOREIGN KEY REFERENCES Banks(SWIFTCode)
);

CREATE TABLE Services_Products (
  InternalCode INT PRIMARY KEY,
  SPName VARCHAR(50),
  Quantity INT,
  PriceValue INT,
  VATRate INT,
  Currency VARCHAR(10)
);

CREATE TABLE Income (
  InvoiceNumber INT PRIMARY KEY,
  CompanyCUI INT FOREIGN KEY REFERENCES Partners_Companies(CompanyCUI),
  IncomeDate DATE,
  --IncomeValue INT
);

CREATE TABLE Income_Services_Products (
  ProductCode INT FOREIGN KEY REFERENCES Services_Products(InternalCode),
  InvoiceNumber INT FOREIGN KEY REFERENCES Income(InvoiceNumber),
  PRIMARY KEY (ProductCode, InvoiceNumber)
);

CREATE TABLE Payments (
  InvoiceNumber INT PRIMARY KEY,
  CompanyCUI INT FOREIGN KEY REFERENCES Partners_Companies(CompanyCUI),
  PaymentDate DATE,
  --PaymentValue INT
);



CREATE TABLE Payments_Services_Products (
  ProductCode INT FOREIGN KEY REFERENCES Services_Products(InternalCode),
  InvoiceNumber INT FOREIGN KEY REFERENCES Payments(InvoiceNumber),
  PRIMARY KEY (ProductCode, InvoiceNumber)
);


-- retrive the companies where the Accounting Firm has income, and what products/services they offered
SELECT Company_Name, SPName
FROM Services_Products
JOIN Income_Services_Products ON Services_Products.InternalCode = Income_Services_Products.ProductCode
JOIN Income ON Income_Services_Products.InvoiceNumber = Income.InvoiceNumber
JOIN Partners_Companies ON Income.CompanyCUI = Partners_Companies.CompanyCUI;

-- retrive the companies where the Accounting Firm has payments, and what products/services they offered
SELECT Company_Name, SPName
FROM Services_Products
JOIN Payments_Services_Products ON Services_Products.InternalCode = Payments_Services_Products.ProductCode
JOIN Payments ON Payments_Services_Products.InvoiceNumber = Payments.InvoiceNumber
JOIN Partners_Companies ON Payments.CompanyCUI = Partners_Companies.CompanyCUI;
