USE Zoo


------------ DROPS ------------
GO
DROP TABLE Visit
DROP TABLE Visitor
DROP TABLE DailyFood
DROP TABLE Food
DROP TABLE Animal
DROP TABLE Zoo
GO


------------ CREATES ------------
GO
CREATE TABLE Zoo (
	ZID INT PRIMARY KEY IDENTITY(1, 1),
	AdminName VARCHAR(50),
	ZName VARCHAR(50),
)

CREATE TABLE Animal ( 
	AID INT PRIMARY KEY IDENTITY(1, 1),
	AName VARCHAR(50),
	dob DATE,
	ZID INT REFERENCES Zoo(ZID)
)

CREATE TABLE Food (
	FID INT PRIMARY KEY IDENTITY(1, 1),
	FName VARCHAR(50)
)

CREATE TABLE DailyFood (
	AID INT REFERENCES Animal(AID),
	FID INT REFERENCES Food(FID),
	Quantity INT,
	PRIMARY KEY(AID, FID)
)

CREATE TABLE Visitor ( 
	VID INT PRIMARY KEY IDENTITY(1, 1),
	VName VARCHAR(50),
	dob DATE,
	VAge AS DATEDIFF(year, dob, GETDATE()), -- MAYBE DOB BECAUSE AGE HAS TO BE UPDATED
)

CREATE TABLE Visit ( 
	VisitID INT PRIMARY KEY IDENTITY(1, 1),
	ZID INT REFERENCES Zoo(ZID),
	VID INT REFERENCES Visitor(VID),
	VDay DATE,
	Price INT,
	UNIQUE(ZID, VID, VDay)
)



INSERT INTO Zoo VALUES ('Admin1', 'Z1'), ('Admin2', 'Z2'), ('Admin3', 'Z3')
INSERT INTO Animal VALUES ('A1', '2015-12-12', 1), ('A2', '2015-12-12', 1), ('A3', '2015-12-12', 1), ('A4', '2015-12-12', 2), ('A5', '2015-12-12', 2), ('A6', '2015-12-12', 3)
INSERT INTO Food VALUES ('F1'), ('F2'), ('F3'), ('F4'), ('F5'), ('F6'), ('F7') 
INSERT INTO DailyFood VALUES (1, 1, 10), (1, 2, 10), (1, 3, 10), (1, 4, 10), (2, 1, 10), (2, 4, 10)
INSERT INTO Visitor VALUES ('V1', '2001-01-03'), ('V2', '2003-01-03'), ('V3', '2003-01-03'), ('V4', '2003-01-03'), ('V5', '2003-01-03') 
INSERT INTO Visit VALUES (1, 1, '2023-12-12', 100), (1, 2, '2023-12-12', 100), (2, 3, '2023-12-12', 100), (2, 4, '2023-12-12', 100), (3, 5, '2023-12-12', 100)

SELECT * FROM Visit
SELECT * FROM Visitor
SELECT * FROM DailyFood
SELECT * FROM Food
SELECT * FROM Animal
SELECT * FROM Zoo


------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspDeleteFoodForAnimal(@AnimalName VARCHAR(50))
AS
	DECLARE @AID INT
	SET @AID = (SELECT AID FROM Animal WHERE AName = @AnimalName)
	IF @AID IS NULL
	BEGIN
		RAISERROR('The Animal with this name does not exists', 16, 1)
		RETURN 
	END

	DELETE DailyFood
	WHERE AID = @AID
GO

--EXEC uspDeleteFoodForAnimal 'A100' -- ERROR
EXEC uspDeleteFoodForAnimal 'A3'

SELECT * FROM DailyFood

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vUnpopularZoos
AS
	SELECT ZID
	FROM Visit
	GROUP BY ZID
	HAVING COUNT(*) <= ALL (SELECT COUNT(*)
							FROM Visit
							GROUP BY ZID)
go
	
SELECT * FROM vUnpopularZoos


------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufFVisitorsPopularZoos (@N INT)
RETURNS TABLE
AS
RETURN 
		
		SELECT VID
		FROM Visit
		WHERE ZID IN (SELECT ZID
					FROM Animal
					GROUP BY ZID
					HAVING COUNT(*) >= @N)


GO

SELECT *
FROM ufFVisitorsPopularZoos(3)