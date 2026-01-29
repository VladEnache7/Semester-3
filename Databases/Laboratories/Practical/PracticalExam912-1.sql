USE PracticalExam925_1

------------ DROPS ------------
GO
DROP TABLE Purchases
DROP TABLE Prez_Shoes
DROP TABLE Shoes
DROP TABLE ShoeModels
DROP TABLE Woman
DROP TABLE PrezentationShops
DROP TABLE Purchases

GO

------------ CREATES ------------
GO
CREATE TABLE PrezentationShops (
	PID INT PRIMARY KEY,
	PName VARCHAR(50),
	City VARCHAR(50)
)
CREATE TABLE Woman (
	WID INT PRIMARY KEY, 
	WName VARCHAR(50),
	MaxAmount INT 
)

CREATE TABLE ShoeModels (
	SMID INT PRIMARY KEY, 
	SMName VARCHAR(50),
	Season VARCHAR(50),
)

CREATE TABLE Shoes (
	SID INT PRIMARY KEY, 
	Price INT,
	SMID INT REFERENCES ShoeModels
)

CREATE TABLE Prez_Shoes ( 
	PSID INT PRIMARY KEY IDENTITY(1, 1), 
	PID INT REFERENCES PrezentationShops,
	SID INT REFERENCES Shoes,
	NrOfPairs INT
	-- here will be better PRIMARY KEY(PID, SID) in order to not have more pairs of shops & shoes------------
)

CREATE TABLE Purchases ( 
	BUYID INT PRIMARY KEY IDENTITY(1, 1), 
	WID INT REFERENCES Woman,
	SID INT REFERENCES Shoes,
	NumberOfPairs INT, 
	SpentAmount INT
)

INSERT INTO PrezentationShops VALUES (5, 'PS5', 'CLUJ'), (2, 'PS2', 'CLUJ'), (3, 'PS3', 'CLUJ'), (4, 'PS4', 'CLUJ')
INSERT INTO Woman VALUES (1, 'MARIA', 1000), (2, 'VALENTINA', 3000)
INSERT INTO ShoeModels VALUES (1, 'BIG', 'WINTER'), (2, 'SMALL', 'SUMMER')
INSERT INTO Shoes VALUES (1, 100, 1), (2, 200, 1), (3, 300, 2)
INSERT INTO Purchases VALUES (1, 1, 2, 200), (1, 2, 1, 200), (1, 3, 1, 300), (2, 1, 1, 100), (2, 2, 1, 200), (2, 3, 1, 300)

SELECT * FROM PrezentationShops
SELECT * FROM Woman
SELECT * FROM ShoeModels
SELECT * FROM Shoes
SELECT * FROM Purchases


------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspAddShoeToPresentation(@SID INT, @PID INT, @NrOfPairs INT)
AS
	IF NOT EXISTS(SELECT * FROM Shoes WHERE SID = @SID)
	BEGIN
		RAISERROR('The Shoe number does not exists', 16, 1)
		RETURN 
	END
	IF NOT EXISTS(SELECT * FROM PrezentationShops WHERE PID = @PID)
	BEGIN
		RAISERROR('The PrezentationShop number does not exists', 16, 1)
		RETURN 
	END

	IF EXISTS (SELECT * FROM Prez_Shoes WHERE SID = @SID AND PID = @PID)
	BEGIN
		UPDATE Prez_Shoes
		SET NrOfPairs = NrOfPairs + @NrOfPairs
	END
	ELSE
		INSERT INTO Prez_Shoes(SID, PID, NrOfPairs) VALUES (@SID, @PID, @NrOfPairs)
GO

EXEC uspAddShoeToPresentation 1, 1, 10
EXEC uspAddShoeToPresentation 1, 2, 10
EXEC uspAddShoeToPresentation 1, 3, 10
EXEC uspAddShoeToPresentation 1, 4, 10
EXEC uspAddShoeToPresentation 1, 5, 10
EXEC uspAddShoeToPresentation 2, 1, 10
EXEC uspAddShoeToPresentation 2, 2, 10
EXEC uspAddShoeToPresentation 2, 3, 10
EXEC uspAddShoeToPresentation 2, 4, 10
EXEC uspAddShoeToPresentation 3, 1, 10
EXEC uspAddShoeToPresentation 3, 2, 10
EXEC uspAddShoeToPresentation 3, 3, 10



SELECT * FROM Prez_Shoes

GO
SELECT * FROM Transactions

------------------------- VIEW ------------------------- I do not understand how I can do it because a view cannot have parameters
GO
CREATE OR ALTER VIEW vTransAllATMs
AS
	SELECT W.WName, SM.Season
	FROM Woman W
	INNER JOIN Purchases P ON W.WID = P.WID
	INNER JOIN Shoes S ON S.SID = P.SID
	INNER JOIN ShoeModels SM ON SM.SMID = S.SMID
	GROUP BY W.WName, SM.Season
GO
SELECT * FROM vTransAllATMs

GO																-- in a function there can be a given shoe model
CREATE OR ALTER FUNCTION vTransAllATMs2 (@SMName VARCHAR(50))
RETURNS TABLE
AS
RETURN 
	SELECT  W.WName
	FROM Woman W
	INNER JOIN Purchases P ON W.WID = P.WID
	INNER JOIN Shoes S ON S.SID = P.SID
	INNER JOIN ShoeModels SM ON SM.SMID = S.SMID
	GROUP BY W.WName, SM.SMName
	HAVING SUM(NumberOfPairs) > 2 AND SM.SMName = @SMName
GO
SELECT * FROM vTransAllATMs2('BIG')


------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufTransGraterAmmounts (@T INT)
RETURNS TABLE
AS
RETURN 
		SELECT SID
		FROM (SELECT SID, PID 
			FROM Prez_Shoes
			GROUP BY SID, PID) RES
		GROUP BY RES.SID
		HAVING COUNT(RES.PID) > @T
GO

SELECT *
FROM ufTransGraterAmmounts(3)