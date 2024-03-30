USE PracticalExam

------------ DROPS ------------
GO
DROP TABLE Payment
DROP TABLE Booking
DROP TABLE Property
DROP TABLE Email
DROP TABLE Customer
GO

------------ CREATES ------------
GO
CREATE TABLE Customer (
	CID INT PRIMARY KEY IDENTITY(1, 1),
	Username VARCHAR(50) UNIQUE,
	Nationality VARCHAR(50),
	dob DATE
)

CREATE TABLE Email ( 
	EID INT PRIMARY KEY IDENTITY(1, 1),
	EmailAddr VARCHAR(50),
	CID INT REFERENCES Customer(CID)
)

CREATE TABLE Property (
	PID INT PRIMARY KEY IDENTITY(1, 1),
	PName VARCHAR(50),
	Descript VARCHAR(50),
	Addr VARCHAR(50),
	CheckIn TIME,
	CheckOut TIME,
	NrOfPeople INT,
	Price INT,
	FreeCancelation BIT
)

CREATE TABLE Booking (
	BID INT PRIMARY KEY IDENTITY(1, 1),
	CID INT REFERENCES Customer(CID),
	PID INT REFERENCES Property(PID),
	StartDate DATE,
	EndDate DATE
)

CREATE TABLE Payment ( 
	PAYID INT IDENTITY(1, 1),
	Amount INT,
	PDate DATE,
	PType VARCHAR(50),
	BID INT REFERENCES Booking(BID),
)

INSERT INTO Customer VALUES ('U1', 'N1', '1999-12-12'), ('U2', 'N2', '1999-12-12'), ('U3', 'N3', '1999-12-12')
INSERT INTO Email VALUES ('E1', 1), ('E1', 2), ('E1', 3), ('E1', 3)
INSERT INTO Property VALUES ('P1', 'DESCR', 'ADDR', '15:00', '10:00', 10, 500, 1), ('P2', 'DESCR', 'ADDR', '15:00', '10:00', 5, 100, 1) 
INSERT INTO Booking VALUES (1,  1, '2023-12-12', '2023-12-15'), (1,  1, '2023-12-12', '2023-12-15'), (2,  1, '2023-12-12', '2023-12-15'), (2,  1, '2023-12-12', '2023-12-15'), (3,  1, '2023-12-12', '2023-12-15')



SELECT * FROM Booking
SELECT * FROM Property
SELECT * FROM Email
SELECT * FROM Customer
GO

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspAddPayment(@Amount INT, @PDate DATE, @Type VARCHAR(50), @BID INT)
AS
	
	IF NOT EXISTS(SELECT * FROM Booking WHERE BID = @BID)
	BEGIN
		RAISERROR('A BOOKING with this NUMBER does not exists', 16, 1)
		RETURN 
	END

	DECLARE @STARTDATE DATE
	SET @STARTDATE = (SELECT StartDate FROM Booking WHERE BID = @BID)

	DECLARE @ENDDATE DATE
	SET @ENDDATE = (SELECT EndDate FROM Booking WHERE BID = @BID)

	DECLARE @NrOfDays INT
	SET @NrOfDays = DATEDIFF(DAY, @STARTDATE, @ENDDATE)

	DECLARE @TOTALPRICE INT
	SET @TOTALPRICE = @NrOfDays * (SELECT Price FROM Property WHERE PID IN (SELECT PID FROM Booking WHERE BID = @BID))
	
	IF (SELECT SUM(Amount) FROM Payment WHERE BID = @BID GROUP BY BID) + @Amount > @TOTALPRICE 
	BEGIN
		RAISERROR('THE SUM OF PAYMENTS EXCEED TOTAL PRICE', 16, 1)
		RETURN 
	END
	ELSE
		INSERT Payment VALUES (@Amount, @PDate, @Type, @BID)
GO

--EXEC uspDeleteJudge 'J100'
EXEC uspAddPayment 500, '2023-12-12', 'PayPal', 1
EXEC uspAddPayment 500, '2023-12-12', 'PayPal', 1
EXEC uspAddPayment 500, '2023-12-12', 'PayPal', 1
--EXEC uspAddPayment 501, '2023-12-12', 'PayPal', 1 -- error

EXEC uspAddPayment 500, '2023-12-12', 'PayPal', 3
EXEC uspAddPayment 500, '2023-12-12', 'PayPal', 3


SELECT COUNT(*) FROM Payment

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vFilterUsers
AS
	SELECT Username
	FROM Customer C
	WHERE CID IN (
		SELECT CID
		FROM Booking
		GROUP BY CID
		HAVING COUNT(*) >= ALL(SELECT COUNT(*)
							FROM Booking
							GROUP BY CID))
	
go
	
SELECT * FROM vFilterUsers

------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION dbo.ufNrOfCostumersPayPal (@R INT)
RETURNS INT
AS
BEGIN
	DECLARE @REZ INT
	SET @REZ = (SELECT COUNT(CID)
				FROM 
					(SELECT CID, B.BID
					FROM Booking B
					INNER JOIN Payment P ON B.BID = P.BID
					WHERE PType = 'PayPal'
					GROUP BY CID, B.BID) R
					GROUP BY CID
					HAVING COUNT(*) < @R)
	RETURN @REZ
END
GO


--SELECT dbo.ufNrOfCostumersPayPal(2)
