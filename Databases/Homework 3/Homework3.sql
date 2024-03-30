USE AccountingCompanyDataBase;
GO

-- <<<<<<<<<<<<< A >>>>>>>>>>>>> -----------------------------------------------------------------------
-- modify the type of a column;

-- modify the salary from INT to FLOAT
CREATE PROCEDURE SetSalaryFloat
AS
BEGIN
    ALTER TABLE Employees
    ALTER COLUMN Salary FLOAT;
END;
GO

-- (Reverse operation) modify the salary from FLOAT to INT
CREATE PROCEDURE SetSalaryInt
AS
BEGIN
    ALTER TABLE Employees
    ALTER COLUMN Salary INT;
END;
GO

-- <<<<<<<<<<<<< B >>>>>>>>>>>>> -----------------------------------------------------------------------
-- add / remove a column;

-- add a column "DateOfBirth" to the table Employees
CREATE PROCEDURE AddDateOfBirth
AS
BEGIN
    ALTER TABLE Employees
    ADD DateOfBirth DATE;
END;
GO

-- (Reverse operation) remove the column "DateOfBirth" from the table Employees
CREATE PROCEDURE RemoveDateOfBirth
AS
BEGIN
    ALTER TABLE Employees
    DROP COLUMN DateOfBirth;
END;
GO

-- <<<<<<<<<<<<< C >>>>>>>>>>>>> -----------------------------------------------------------------------
-- add / remove a DEFAULT constraint;

-- add a DEFAULT constraint to the column "Salary" from the table Employees 
CREATE PROCEDURE AddDefaultSalary
AS
BEGIN
    ALTER TABLE Employees
    ADD CONSTRAINT DefaultSalary DEFAULT 0 FOR Salary;
END;
GO

-- (Reverse operation) remove the DEFAULT constraint from the column "Salary" from the table Employees
CREATE PROCEDURE RemoveDefaultSalary
AS
BEGIN
    ALTER TABLE Employees
    DROP CONSTRAINT DefaultSalary;
END;
GO

-- <<<<<<<<<<<<< D >>>>>>>>>>>>> -----------------------------------------------------------------------
-- add / remove a primary key;

-- remove the primary key on CNP
GO
CREATE PROCEDURE RemovePrimaryKeyCNP
AS
BEGIN
    ALTER TABLE Employees
    DROP CONSTRAINT PK_CNP;
END;
GO


-- (Reverse operation) add the primary key on CNP
GO
CREATE PROCEDURE AddPrimaryKeyCNP
AS
BEGIN
    ALTER TABLE Employees
    ADD CONSTRAINT PK_CNP PRIMARY KEY (CNP);
END;
GO

-- <<<<<<<<<<<<< E >>>>>>>>>>>>> -----------------------------------------------------------------------
-- add / remove a candidate key;

-- add the Employee Name as a candidate key
CREATE PROCEDURE AddCandidateKeyEmployeeName
AS
BEGIN
    ALTER TABLE Employees
    ADD CONSTRAINT CandidateKeyEmployeeName UNIQUE (EmployeeName);
END;
GO

EXECUTE AddCandidateKeyEmployeeName

-- (Reverse operation) remove the Employee Name as a candidate key
GO
CREATE PROCEDURE RemoveCandidateKeyEmployeeName
AS
BEGIN
    ALTER TABLE Employees
    DROP CONSTRAINT CandidateKeyEmployeeName;
END;
GO


-- <<<<<<<<<<<<< F >>>>>>>>>>>>> -----------------------------------------------------------------------
-- add / remove a foreign key;

-- remove the foreign key CompanyCUI from the table Employees   
CREATE PROCEDURE RemoveForeignKeyCompanyCUI
AS
BEGIN
    ALTER TABLE Employees
    DROP CONSTRAINT FK_CompanyCUI;
END;
GO

-- (Reverse operation) add the foreign key CompanyCUI from the table Employees
CREATE PROCEDURE AddForeignKeyCompanyCUI
AS
BEGIN
    ALTER TABLE Employees
    ADD CONSTRAINT FK_CompanyCUI FOREIGN KEY (CompanyCUI) REFERENCES Partners_Companies(CompanyCUI);
END;
GO

-- <<<<<<<<<<<<< G >>>>>>>>>>>>> -----------------------------------------------------------------------
-- create / drop a table.

-- create a table EmployeesCertificates
ALTER PROCEDURE CreateEmployeesCertificates
AS
BEGIN
    CREATE TABLE EmployeesCertificates (
        CertificateID INT PRIMARY KEY,
        EmployeeCNP DECIMAL(13, 0) ,
        CertificateName VARCHAR(50),
        CertificateDate DATE
    );
END;
GO

-- (Reverse operation) drop the table EmployeesCertificates
CREATE PROCEDURE DropEmployeesCertificates
AS
BEGIN
    DROP TABLE EmployeesCertificates;
END;
GO

-- Create a new table that holds the current version of the database schema.
-- Write a stored procedure that receives as a parameter a version number and brings the database to that version

DROP TABLE  VersionHistory;
CREATE TABLE VersionHistory (
    HistoryID INT IDENTITY(1,1) NOT NULL,
    DataBaseVersion INT NOT NULL
);
INSERT INTO VersionHistory VALUES (0);

DROP TABLE ProcedureTable;
CREATE TABLE ProcedureTable (
    DataBaseVersion INT IDENTITY(1, 1) PRIMARY KEY,
    ForwardProcedure VARCHAR(50),
    BackwardProcedure VARCHAR(50)
);
GO



INSERT INTO ProcedureTable VALUES 
('SetSalaryFloat', 'SetSalaryInt'),
('AddDateOfBirth', 'RemoveDateOfBirth'),
('AddDefaultSalary', 'RemoveDefaultSalary'),
('RemovePrimaryKeyCNP', 'AddPrimaryKeyCNP'),
('AddCandidateKeyEmployeeName', 'RemoveCandidateKeyEmployeeName'),
('RemoveForeignKeyCompanyCUI', 'AddForeignKeyCompanyCUI'),
('CreateEmployeesCertificates', 'DropEmployeesCertificates');
GO

SELECT * FROM VersionHistory;
SELECT * FROM ProcedureTable;


ALTER PROCEDURE GoToVersion (@InputVersion INT)
AS
	BEGIN TRANSACTION ROLLBACKIfError;
	BEGIN TRY
		DECLARE @currentVersion INT;
		SET @currentVersion = (SELECT TOP 1 DataBaseVersion 
								FROM VersionHistory 
								ORDER BY HistoryID DESC);

		IF @currentVersion = @InputVersion
			BEGIN
				PRINT 'The current version is equal to InputVersion';
				RETURN;
			END;

		IF @InputVersion < 0
			BEGIN
				RAISERROR ('It is not possible for the version to be negative', 16, 1); -- 16	Indicates general errors that can be corrected by the user.
			END;

		IF @InputVersion > (SELECT MAX(DataBaseVersion) FROM ProcedureTable)
			BEGIN
				RAISERROR ('The input version cannot be greater than the maximum version', 16, 1); -- 16	Indicates general errors that can be corrected by the user.
			END;

		PRINT 'Going from version ' + CAST(@currentVersion AS VARCHAR(10)) + ' to version ' + CAST(@InputVersion AS VARCHAR(10));

		-- if the current version is smaller than the input version, we need to go forward
		WHILE @currentVersion < @InputVersion
			BEGIN
				SET @currentVersion = @currentVersion + 1;

				DECLARE @forwardProcedure VARCHAR(50);
				SET @forwardProcedure = (SELECT ForwardProcedure FROM ProcedureTable WHERE DataBaseVersion = @currentVersion);

				-- execute the procedure
				EXEC(@forwardProcedure);
            
				-- print the name of the procedure that was executed
				PRINT 'Executed procedure: ' + @forwardProcedure + ' to upgrade to version ' + CAST(@currentVersion AS VARCHAR(10));
			END;

		-- if the current version is greater than the input version, we need to go backwards
		WHILE @currentVersion > @InputVersion
			BEGIN

				DECLARE @backwardProcedure VARCHAR(50);
				SET @backwardProcedure = (SELECT BackwardProcedure FROM ProcedureTable WHERE DataBaseVersion = @currentVersion);
            
				EXEC(@backwardProcedure);
            
				-- print the name of the procedure that was executed
				PRINT 'Executed procedure: ' + @backwardProcedure + ' to downgraded from version ' + CAST(@currentVersion AS VARCHAR(10));

				SET @currentVersion = @currentVersion - 1;
			END;

		INSERT INTO VersionHistory VALUES (@InputVersion);
		PRINT 'COMMIT'
		COMMIT TRANSACTION ROLLBACKIfError;

	END TRY
	BEGIN CATCH
		PRINT 'Error at ' + ERROR_PROCEDURE() + ' ' + ERROR_MESSAGE();
		ROLLBACK TRANSACTION ROLLBACKIfError;
	END CATCH;
GO

USE AccountingCompanyDataBase
EXECUTE GoToVersion 7

