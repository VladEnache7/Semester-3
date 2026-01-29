USE Banks

------------ DROPS ------------
GO
DROP TABLE Transactions
DROP TABLE ATMs
DROP TABLE Cards
DROP TABLE BankAccounts
DROP TABLE Costumers

GO

------------ CREATES ------------
GO
CREATE TABLE Costumers (
	CID INT PRIMARY KEY IDENTITY(1, 1),
	CName VARCHAR(50),
	Dob DATE
)

CREATE TABLE BankAccounts ( 
	IBAN INT PRIMARY KEY IDENTITY(1, 1),
	Ballance INT,
	CID INT REFERENCES Costumers(CID)
)

CREATE TABLE Cards (
	CAID INT PRIMARY KEY IDENTITY(1001, 1),
	CVV AS CAID % 1000,
	IBAN INT REFERENCES BankAccounts(IBAN)
)


CREATE TABLE ATMs ( 
	AID INT PRIMARY KEY IDENTITY(1, 1),
	Addr VARCHAR(50)
)

CREATE TABLE Transactions ( 
	TID INT PRIMARY KEY IDENTITY(1, 1),
	AID INT REFERENCES ATMs(AID),
	CAID INT REFERENCES Cards(CAID),
	TTime DATETIME,
	SumOfMoney INT,
	UNIQUE(AID, CAID, TTIME)
)

INSERT INTO Costumers VALUES ('Costumer1', '1999-12-12'), ('Costumer2', '1999-12-12'), ('Costumer3', '1999-12-12'), ('Costumer4', '1999-12-12') 
INSERT INTO BankAccounts VALUES (1000, 1), (2000, 1), (3000, 1), (1000, 2), (1000, 3), (1000, 4) 
INSERT INTO Cards VALUES (1), (1), (1), (2), (3), (4), (5)
INSERT INTO ATMs VALUES ('Addr1'), ('Addr2')
INSERT INTO Transactions VALUES (1, 1001, '2023-12-12 18:00', 100), (2, 1001, '2023-12-12 18:05', 500), (1, 1002, '2023-12-12 18:00', 100),(1, 1002, '2023-12-12 18:05', 10000), (1, 1003, '2023-12-12 18:00', 100), (2, 1003, '2023-12-12 18:00', 100), (1, 1005, '2023-12-12 18:00', 100) 

SELECT * FROM Transactions
SELECT * FROM ATMs
SELECT * FROM Cards
SELECT * FROM BankAccounts
SELECT * FROM Costumers


------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspDeleteTransactions(@CAID INT)
AS
	
	IF NOT EXISTS(SELECT * FROM Cards WHERE CAID = @CAID)
	BEGIN
		RAISERROR('A CARD with this NUMBER does not exists', 16, 1)
		RETURN 
	END

	DELETE Transactions
	WHERE CAID = @CAID

GO

--EXEC uspDeleteTransactions 5555
EXEC uspDeleteTransactions 1002

SELECT * FROM Transactions

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vCardsAllATMs
AS
	SELECT CAID
	FROM Cards C
	WHERE NOT EXISTS (
		SELECT AID FROM ATMs
		EXCEPT
		SELECT AID FROM Transactions WHERE CAID = C.CAID)
go
	
SELECT * FROM vCardsAllATMs


------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufFilterCards (@S INT)
RETURNS TABLE
AS
RETURN 
		
		SELECT CAID, CVV
		FROM Cards
		WHERE CAID IN (SELECT CAID
						FROM Transactions
						GROUP BY CAID
						HAVING SUM(SumOfMoney) > @S)
GO

SELECT *
FROM ufFilterCards(300)

