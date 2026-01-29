-- the 3 views that will be used in testing
CREATE OR ALTER VIEW ViewAllServices
AS
	SELECT *
	FROM Services_Products

GO

CREATE OR ALTER VIEW ViewServiceAndInvoice
AS
	SELECT SERV.SPName, INCSERV.InvoiceNumber
	FROM Services_Products SERV
	INNER JOIN Income_Services_Products INCSERV ON SERV.InternalCode = INCSERV.ProductCode
GO

CREATE OR ALTER VIEW ViewNrOfServicesPerVat
AS
	SELECT SERV.VATRate, COUNT(*) AS NrOfServicesPerVat
	FROM Services_Products SERV
	INNER JOIN Income_Services_Products INCSERV ON SERV.InternalCode = INCSERV.ProductCode
	GROUP BY SERV.VATRate
GO

-- SELECT *
-- FROM Services_Products SERV
-- INNER JOIN Income_Services_Products INCSERV ON SERV.InternalCode = INCSERV.ProductCode
-- GROUP BY SERV.VATRate

-- procedure to populate the tables


-- @nrOfInsertions - the number of rows to be inserted
CREATE OR ALTER PROCEDURE PopulateServices_Products(@nrOfInsertions INT) AS
	-- take the maximum InternalCode from the table
	DECLARE @maxInternalCode INT
	SET @maxInternalCode = (SELECT MAX(InternalCode) FROM Services_Products)

	IF @maxInternalCode IS NULL BEGIN
		SET @maxInternalCode = 0
	END

	DECLARE @index INT
	SET @index = @maxInternalCode + 1

	DECLARE @ServiceName VARCHAR(50)

	-- When you use SET NOCOUNT ON, the message that indicates the number of rows that are affected by the T-SQL statement is not returned as part of the results.
	SET NOCOUNT ON

	WHILE @index < @nrOfInsertions + @maxInternalCode + 1 BEGIN
		-- have the service name as "Service" + index
		SET @ServiceName = 'Service' + CAST(@index AS VARCHAR(50))
		INSERT INTO Services_Products(InternalCode, SPName, Quantity, PriceValue, VATRate, Currency) VALUES
			(@index, @ServiceName, @index, @index, @index, 'EUR')
		SET @index = @index + 1
	END
	--PRINT 'PopulateServices_Products inserted ' + CAST(@@ROWCOUNT AS VARCHAR(50)) + ' rows'
GO

--EXEC PopulateServices_Products 200


GO
-- procedure to populate the Income table
CREATE OR ALTER PROCEDURE PopulateIncome(@nrOfInsertions INT) AS
	-- get the maximum CompanyCUI from Partners_Companies
	DECLARE @cui INT
	SET @CUI = (SELECT MAX(CompanyCUI) FROM Partners_Companies)

	IF @cui IS NULL BEGIN
		RAISERROR ('No data in the Partners_Companies table', 16, 1)
	END

	-- get the maximum InvoiceNumber
	DECLARE @maxInvoiceNumber INT
	SET @maxInvoiceNumber = (SELECT MAX(InvoiceNumber) FROM Income)

	IF @maxInvoiceNumber IS NULL BEGIN
		SET @maxInvoiceNumber = 0
	END

	SET NOCOUNT ON

	DECLARE @index INT
	SET @index = @maxInvoiceNumber + 1

	WHILE @index < @nrOfInsertions + @maxInvoiceNumber + 1 BEGIN
		INSERT INTO Income(InvoiceNumber, CompanyCUI, IncomeDate) VALUES
			(@index, @cui, GETDATE())
		SET @index = @index + 1
	END
	--PRINT 'PopulateIncome inserted ' + CAST(@@ROWCOUNT AS VARCHAR(50)) + ' rows'
GO

-- EXEC PopulateIncome 2

GO
CREATE OR ALTER PROCEDURE PopulateIncome_Services_Products(@nrOfInsertions INT) AS
	-- get the maximum id from Income_Services_Products
	DECLARE @maxID INT
	SET @maxID = (SELECT MAX(ID) FROM Income_Services_Products)

	IF @maxID IS NULL BEGIN
		SET @maxID = 0
	END

	SET NOCOUNT ON

	-- get the maximum InvoiceNumber
	DECLARE @maxInvoiceNumber INT
	SET @maxInvoiceNumber = (SELECT MAX(InvoiceNumber) FROM Income)
	--PRINT 'maxInvoiceNumber = ' + CAST(@maxInvoiceNumber AS VARCHAR(50))

	IF @maxInvoiceNumber IS NULL BEGIN
		RAISERROR ('No data in the Income table', 16, 1)
	END

	-- get the maximum InternalCode from Services_Products
	DECLARE @maxInternalCode INT
	SET @maxInternalCode = (SELECT MAX(InternalCode) FROM Services_Products)
	--PRINT 'maxInternalCode = ' + CAST(@maxInternalCode AS VARCHAR(50))

	IF @maxInternalCode IS NULL BEGIN
		RAISERROR ('No data in the Services_Products table', 16, 1)
	END

	DECLARE @index INT
	SET @index = @maxID + 1

	WHILE @index < @nrOfInsertions + @maxID + 1 BEGIN
		INSERT INTO Income_Services_Products(ProductCode, InvoiceNumber) VALUES
			(@maxInternalCode, @maxInvoiceNumber)
		SET @index = @index + 1
	END

	-- GET THE NUMBER OF ROWS AFEECTED BY THE LAST STATEMENT

	--PRINT 'PopulateIncome_Services_Products inserted ' + CAST(@@ROWCOUNT AS VARCHAR(50)) + ' rows'
GO

-- EXEC PopulateIncome_Services_Products 200





