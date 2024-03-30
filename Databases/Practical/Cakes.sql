USE Cakes

------------ DROPS ------------
GO
DROP TABLE OrdersCakes
DROP TABLE Orders
DROP TABLE ChefsCakes
DROP TABLE Cakes
DROP TABLE CakeTypes
DROP TABLE Chefs
GO
------------ CREATES ------------
GO
CREATE TABLE Chefs (
	CHID INT PRIMARY KEY,
	CHName VARCHAR(50),
	CHGender VARCHAR(50),
	CHdob DATE
)

CREATE TABLE CakeTypes (
	CTID INT PRIMARY KEY,
	CTName VARCHAR(50),
	CTDescprition VARCHAR(50),
)


CREATE TABLE Cakes ( 
	CID INT PRIMARY KEY,
	CName VARCHAR(50),
	CShape VARCHAR(50),
	CWeight FLOAT, -- it was INT but maybe FLOAT is better
	CPrice FLOAT, -- it was INT but maybe FLOAT is better
	CTID INT REFERENCES CakeTypes -- SQL Server will assume that the foreign key references the primary key of the other table, but is good practice to put CakeTypes(CTID)
)


CREATE TABLE ChefsCakes (
	CHID INT REFERENCES Chefs,
	CID INT REFERENCES Cakes,
	PRIMARY KEY(CHID, CID)
)

CREATE TABLE Orders ( 
	OID INT PRIMARY KEY,
	ODate DATE
)

CREATE TABLE OrdersCakes ( 
	OID INT REFERENCES Orders,
	CID INT REFERENCES Cakes,
	NrPieces INT
	PRIMARY KEY(OID, CID)
)

INSERT INTO Chefs VALUES (1, 'CH1', 'M', '1999-01-01'), (2, 'CH2', 'M', '1999-01-01'), (3, 'CH3', 'M', '1999-01-01')
INSERT INTO CakeTypes VALUES (1, 'CT1', 'D'), (2, 'CT2', 'D')
INSERT INTO Cakes VALUES (1, 'C1', 'OVAL', 1, 100, 1), (2, 'C2', 'OVAL', 1, 200, 1), (3, 'C3', 'OVAL', 1, 300, 2)
INSERT INTO ChefsCakes VALUES (1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1)
INSERT INTO Orders VALUES (1, '2023-12-12'), (2, '2023-12-13'), (3, '2023-12-14')


SELECT * FROM Chefs
SELECT * FROM CakeTypes
SELECT * FROM Cakes
SELECT * FROM ChefsCakes
SELECT * FROM Orders

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspAddCakeToOrder(@OID INT, @CakeName VARCHAR(50),  @NrPieces INT)
AS
	IF @NrPieces <= 0
	BEGIN
		RAISERROR('Nr of pieces cannot be negative or 0', 16, 1)
		RETURN 
	END

	DECLARE @CID INT
	SET @CID = (SELECT CID FROM Cakes WHERE CName = @CakeName)
	IF @CID IS NULL
	BEGIN
		RAISERROR('The Cake does not exists', 16, 1)
		RETURN 
	END
	
	IF (SELECT OID FROM Orders WHERE OID = @OID) IS NULL
	BEGIN
		RAISERROR('The order id does not exists', 16, 1)
		RETURN 
	END

	IF EXISTS (SELECT * FROM OrdersCakes WHERE OID = @OID AND CID = @CID)
	BEGIN 
		UPDATE OrdersCakes
		SET NrPieces = @NrPieces
		WHERE  OID = @OID AND CID = @CID
	END
	ELSE
		INSERT OrdersCakes(OID, CID, NrPieces) VALUES (@OID, @CID, @NrPieces)

GO
-- WILL HAVE ERRORS
--EXEC uspAddCakeToOrder 1, 'C1', -1
--EXEC uspAddCakeToOrder 100, 'C1', 1
--EXEC uspAddCakeToOrder 1, 'C100', 1

--
EXEC uspAddCakeToOrder 1, 'C1', 3
EXEC uspAddCakeToOrder 1, 'C2', 3
EXEC uspAddCakeToOrder 1, 'C3', 3
EXEC uspAddCakeToOrder 1, 'C1', 5 -- WILL UPDATE CAKE 1 TO 5

SELECT * FROM OrdersCakes

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vChefsAllCakes
AS
	SELECT CHName
	FROM Chefs C
	WHERE NOT EXISTS(
		SELECT CID FROM Cakes -- FROM ALL CAKES
		EXCEPT -- REMOVE THOSE KNONW BY CHEF C
		SELECT CID 
		FROM ChefsCakes
		WHERE CHID = C.CHID)
GO
SELECT * FROM vChefsAllCakes


------------------------- FUNCTION ------------------------- LIST THE CAKES THAT HAVE THE SUM OF ORDERS NR OF PICES MORE THAN P AND ARE OF A GIVEN TYPE
GO
CREATE OR ALTER FUNCTION ufFilterCakes (@P INT, @CakeType VARCHAR(50))
RETURNS TABLE
AS
RETURN 
		SELECT CName
		FROM Cakes C
		INNER JOIN CakeTypes CT ON C.CTID = CT.CTID
		WHERE CT.CTName = @CakeType AND C.CID IN (
			SELECT CID
			FROM OrdersCakes
			WHERE NrPieces > @P)
GO

SELECT *
FROM ufFilterCakes(2, 'CT1')

SELECT *
FROM Orders O1
RIGHT JOIN Orders O2 ON O1.OID = O2.OID