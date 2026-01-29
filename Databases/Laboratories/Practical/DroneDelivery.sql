USE DroneDelivery

------------ DROPS ------------
GO
DROP TABLE Deliveries
DROP TABLE Customers
DROP TABLE PizzaShops
DROP TABLE Drones
DROP TABLE Models
DROP TABLE Manufacturers
GO


------------ CREATES ------------
GO
CREATE TABLE Manufacturers (
	MID INT PRIMARY KEY IDENTITY(1, 1),
	MName VARCHAR(50)
)

CREATE TABLE Models ( 
	MOID INT PRIMARY KEY IDENTITY(1, 1),
	MID INT REFERENCES Manufacturers(MID),
	MOName VARCHAR(50),
	BatteryLife INT,
	MaxSpeed INT
)

CREATE TABLE Drones (
	SerialNr INT PRIMARY KEY IDENTITY(1, 1),
	MOID INT REFERENCES Models(MOID),
)

CREATE TABLE PizzaShops (
	PID INT PRIMARY KEY IDENTITY(1, 1),
	PName VARCHAR(50) UNIQUE,
	PAddr VARCHAR(50)
)

CREATE TABLE Customers ( 
	CID INT PRIMARY KEY IDENTITY(1, 1),
	CName VARCHAR(50) UNIQUE,
	LoyaltyScore INT
)

CREATE TABLE Deliveries ( 
	DID INT PRIMARY KEY IDENTITY(1, 1),
	CID INT REFERENCES Customers,
	PID INT REFERENCES PizzaShops,
	DroneID INT REFERENCES Drones,
	Arrival DATETIME,
	UNIQUE (DroneID, Arrival)
	-- PRIMARY KEY(CID, PID, DroneID, Arrival)
)

INSERT INTO Manufacturers VALUES ('M1'), ('M2'), ('M3') 
INSERT INTO Models VALUES (1, 'MO1', 10, 40), (2, 'MO2', 10, 40), (3, 'MO3', 10, 40), (3, 'MO4', 10, 40) 
INSERT INTO Drones VALUES (1), (1), (1), (1), (1), (2), (2), (2), (2), (2), (3), (3), (3), (3)
INSERT INTO PizzaShops VALUES ('P1', 'A1'), ('P2', 'A2'), ('P3', 'A3'), ('P4', 'A4'), ('P5', 'A5') 
INSERT INTO Customers VALUES ('C1', 1), ('C2', 1), ('C3', 1), ('C4', 1), ('C5', 1)

SELECT * FROM Deliveries
SELECT * FROM Customers
SELECT * FROM PizzaShops
SELECT * FROM Drones
SELECT * FROM Models
SELECT * FROM Manufacturers

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspAddDelivery(@CostumerName VARCHAR(50), @ShopName VARCHAR(50), @DroneID INT, @Arrival DATETIME)
AS
	DECLARE @CID INT
	SET @CID = (SELECT CID FROM Customers WHERE CName = @CostumerName)
	IF @CID IS NULL
	BEGIN
		RAISERROR('A Customer with this name does not exists', 16, 1)
		RETURN 
	END

	DECLARE @PID INT
	SET @PID = (SELECT PID FROM PizzaShops WHERE PName = @ShopName)
	IF @PID IS NULL
	BEGIN
		RAISERROR('A Shop with this name does not exists', 16, 1)
		RETURN 
	END

	-- I forgot to verify this, I do not know how important this is and how many of grade would cost
	IF NOT EXISTS (SELECT * FROM Drones WHERE @DroneID = SerialNr)
	BEGIN
		RAISERROR('A Drone with this serial number does not exists', 16, 1)
		RETURN 
	END
	----------------------------------------------------------------------------------

	IF EXISTS (SELECT * FROM Deliveries WHERE DroneID = @DroneID AND Arrival = @Arrival)
	BEGIN
		RAISERROR('This drone is already used in this time', 16, 1)
		RETURN 
	END

	INSERT INTO Deliveries (PID, CID, DroneID, Arrival) VALUES (@PID, @CID, @DroneID, @Arrival)
	
GO

--EXEC uspAddDelivery 'C100', 'P1', 1, '2023-12-12 18:00'
--EXEC uspAddDelivery 'C1', 'P100', 1, '2023-12-12 18:00'
EXEC uspAddDelivery 'C1', 'P1', 1, '2023-12-12 18:00'
EXEC uspAddDelivery 'C1', 'P1', 2, '2023-12-12 18:01'
EXEC uspAddDelivery 'C2', 'P1', 3, '2023-12-12 18:02'
EXEC uspAddDelivery 'C3', 'P1', 4, '2023-12-12 18:03'
EXEC uspAddDelivery 'C3', 'P1', 5, '2023-12-12 18:04'
EXEC uspAddDelivery 'C3', 'P1', 1, '2023-12-12 18:05'
GO
SELECT * FROM Deliveries

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vFavoriteManufacturers
AS
	SELECT MName
	FROM Manufacturers MA
	WHERE MID IN (SELECT MID
				FROM Drones D
				INNER JOIN Models M ON D.MOID = M.MOID
				GROUP BY M.MID
				HAVING COUNT(*) >= ALL (SELECT COUNT(*)
										FROM Drones D
										INNER JOIN Models M ON D.MOID = M.MOID
										GROUP BY M.MID))

go
	
SELECT * FROM vFavoriteManufacturers

------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufTopCostumers (@D INT)
RETURNS TABLE
AS
RETURN 
		SELECT CName
		FROM Customers
		WHERE CID IN (SELECT CID
						FROM Deliveries 
						GROUP BY CID 
						HAVING COUNT(*) > @D) -- >= very important AT LEAST means >=
GO

SELECT *
FROM ufTopCostumers(1)

SELECT * FROM Deliveries

--------------------------- MULTIPLE ANSWERS: 1AB 2E 3A ----------------
DROP TABLE R
CREATE TABLE R (
	RID INT PRIMARY KEY,
	A1 VARCHAR(100),
	K2 INT UNIQUE,
	A2 INT, 
	A3 INT, 
	A4 INT, 
	A5 CHAR(2), 
	A6 INT
)

INSERT INTO R (RID, A1, K2, A2, A3, A4, A5, A6) VALUES
(2, 'Punctu-acela de miscare, mult mai slab ca boaba spumii,', 100, 1, 3, 3, 'M1', 22),
(3, 'E stapanul fara margini peste marginile lumii...', 200, 1, 3, 3, 'M1', 22),
(4, 'De-atunci negura eterna se desface in fasii,', 150, 2, 3, 4, 'M1', 23),
(5, 'De atunci rasare lumea, luna, soare si stihii...', 700, 2, 4, 4, 'M2', 29),
(6, 'De atunci si pana astazi colonii de lumi pierdute', 300, 3, 4, 5, 'M2', 29),
(7, 'Vin din sure vai de chaos pe carari necunoscute', 350, 3, 4, 5, 'M5', 23),
(8, 'Si in roiuri luminoase izvorand din infinit,', 400, 3, 5, 7, 'M5', 29),
(9, 'Sunt atrase in viata de un dor nemarginit.', 500, 4, 5, 7, 'M2', 30),
(10, 'Iar in lumea asta mare, noi copii ai lumii mici,', 450, 4, 5, 7, 'M7', 30),
(11, 'Facem pe pamantul nostru musunoaie de furnici;', 250, 4, 6, 7, 'M7', 30),
(12, 'Microscopice popoare, regi, osteni si invatati', 800, 5, 6, 7, 'M6', 22),
(13, 'Ne succedem generatii si ne credem minunati;', 750, 5, 6, 7, 'M6', 23);

SELECT * FROM R

SELECT r1.RID, r1.K2, COUNT(*) NumRows
FROM R r1 INNER JOIN R r2 ON r1.A2 = r2.A3
INNER JOIN R r3 ON r2.A3 = r3.A4
WHERE r1.A1 LIKE '_%'
GROUP BY r1.RID, r1.K2
HAVING COUNT(*) >= 6



SELECT r1.A6, MAX(r1.A2) MaxA2
FROM R r1
WHERE r1.A5 IN ('M1', 'M2')
GROUP BY r1.A6
EXCEPT
SELECT DISTINCT r2.A6, r2.A2
FROM R r2

GO
CREATE OR ALTER FUNCTION ufF1(@A5 CHAR(2))
	RETURNS INT
	BEGIN
	RETURN
		(SELECT COUNT(*)
		FROM R
		WHERE A5 = @A5)
	END
GO

CREATE TABLE InsertLog (
	A5Value VARCHAR(20),
	NumRows INT,
	DateTimeOp DATETIME)
GO
CREATE OR ALTER TRIGGER TrOnInsert
ON R
FOR INSERT
AS
	INSERT InsertLog(A5Value, NumRows, DateTimeOp)
	SELECT i.A5, dbo.ufF1(i.A5), GETDATE()
	FROM inserted i
GO

INSERT R(RID, K2, A5) VALUES
(14, 14, 'M1'), (15, 15, 'M1'), (16, 16, 'M2')
INSERT R(RID, K2, A5) VALUES
(17, 17, 'M1'), (18, 18, 'M3')

SELECT * FROM InsertLog

------------ CREATES ------------
GO
CREATE TABLE Users (
	USID INT PRIMARY KEY,
	UName VARCHAR(50),
	PenName VARCHAR(50),
	yob DATE
)

CREATE TABLE Awards ( 
	AID INT PRIMARY KEY,
	AName VARCHAR(50),
	USID INT REFERENCES Users(USID)
)

CREATE TABLE Competitions (
	cID INT PRIMARY KEY,
	CYear DATE,
	CWeek INT
)

CREATE TABLE Poems (
	PID INT PRIMARY KEY,
	Title VARCHAR(100),
	PText VARCHAR(100),
	USID INT REFERENCES Users(USID),
	CID INT REFERENCES Competitions(CID),
)

CREATE TABLE Judges ( 
	JID INT PRIMARY KEY,
	JName VARCHAR(50)
)

CREATE TABLE Evaluations ( 
	JID INT REFERENCES Judges,
	PID INT REFERENCES Poems,
	Points INT CHECK(Points > 1 AND Points < 10)
	PRIMARY KEY(JID, PID)
)

INSERT INTO Users VALUES (1, 'U1', 'PEN1', '1999-01-01'), (2, 'U2', 'PEN2', '1999-01-01'), (3, 'U3', 'PEN3', '1999-01-01') 
INSERT INTO Awards VALUES (1, 'A1', 1), (2, 'A2', 1), (3, 'A3', 1), (4, 'A4', 2), (5, 'A5', 2), (6, 'A6', 3)
INSERT INTO Competitions VALUES (1, '2023-12-12', 48), (2, '2023-12-20', 49), (3, '2023-12-22', 50), (4, '2023-12-27', 51)
INSERT INTO Judges VALUES (1, 'J1'), (2, 'J2'), (3, 'J2'), (4, 'J4'), (5, 'J5'), (6, 'J6')
INSERT INTO Poems VALUES (1, 'P1', 'T1', 1, 1), (2, 'P2', 'T2', 2, 1), (3, 'P3', 'T3', 3, 1), (4, 'P4', 'T4', 1, 1), (5, 'P5', 'T5', 2, 2) 
INSERT INTO Evaluations VALUES (1, 1, 4), (1, 2, 4), (1, 3, 5), (1, 4, 9), (1, 5, 4), (2, 1, 3), (2, 2, 3), (3, 2, 2)


SELECT * FROM Users
SELECT * FROM Awards
SELECT * FROM Competitions
SELECT * FROM Judges
SELECT * FROM Poems
SELECT * FROM Evaluations