USE PracticalExam925_1

------------ DROPS ------------
GO
DROP TABLE Transactions
DROP TABLE ATMs
DROP TABLE Cards
DROP TABLE Accounts
DROP TABLE Costumers
GO

------------ CREATES ------------
GO
CREATE TABLE Costumers (
	CID INT PRIMARY KEY,
	CName VARCHAR(50),
	DOB DATE
)
CREATE TABLE Accounts ( -- maybe to have AID as primary key
	IBAN DECIMAL(12,0) PRIMARY KEY, -- here VARCHAR because IBAN is alphanumeric
	Ballance INT,
	Holder INT REFERENCES Costumers(CID)
)

CREATE TABLE Cards (
	NR DECIMAL(12,0) PRIMARY KEY,
	CVV INT,
	IBAN DECIMAL(12,0) REFERENCES Accounts(IBAN),
	-- CHECK (CVV>=100 AND CVV<=999)
)

CREATE TABLE ATMs (
	AID INT PRIMARY KEY,
	ATMAddress VARCHAR(100)
)

CREATE TABLE Transactions ( -- here I forgot TID INT PRIMARY KEY
	CardNr DECIMAL(12,0) REFERENCES Cards(NR),
	ATMID INT REFERENCES ATMs(AID),
	Ammount INT,
	-- Time DATETIME
	-- PRIMARY KEY(CardNr, ATMID, Time) - but it's better to have TID as Primary Key
)

INSERT INTO Costumers VALUES (1, 'ALEX', '12.12.2000')
INSERT INTO Accounts VALUES (123456789, 2000, 1), (123456781, 3000, 1)
INSERT INTO Cards VALUES (33334444, 444, 123456789), (33335555, 555, 123456789)
INSERT INTO ATMs VALUES (1, 'a1'), (2, 'a2'), (3, 'a3')
INSERT INTO Transactions VALUES (33334444, 1, 1000), (33334444, 2, 1000), (33334444, 3, 1000), (33335555, 1, 1000), (33335555, 2, 1000), (33335555, 3, 1000)

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspDeleteTransactions(@CardNr INT)
AS
	IF NOT EXISTS(SELECT * FROM Cards WHERE NR = @CardNr)
	BEGIN
		RAISERROR('The card number does not exists', 16, 1)
		RETURN 
	END

	DELETE Transactions
	WHERE CardNr = @CardNr

GO

--EXEC uspDeleteTransactions 33335555

GO
SELECT * FROM Transactions

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vTransAllATMs
AS
	SELECT NR
	FROM Cards C
	WHERE NOT EXISTS(
		SELECT AID FROM ATMs -- FROM ALL ATMS
		EXCEPT -- REMOVE THOSE USED FOR TRANSACTIONS OF CARD NR
		SELECT DISTINCT ATMID 
		FROM Transactions
		WHERE CardNr = C.NR)

	--select sq.CardNumber
	--from (    -> from transactions select distinct pairs of cards and atms
	--	SELECT distinct t.CardNumber, t.AtmId
	--	FROM Transactions t
	--) as sq
	--GROUP BY sq.CardNumber -> group by cards
	--HAVING COUNT(*) = (SELECT COUNT(*) FROM ATM) -> select those cards used at all atms
GO
SELECT * FROM vTransAllATMs


------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufTransGraterAmmounts (@Sum INT)
RETURNS TABLE
AS
RETURN 
		SELECT CardNr, CardNr % 1000 AS CVV
		FROM Transactions
		GROUP BY CardNr
		HAVING SUM(Ammount) > @Sum

GO

SELECT *
FROM ufTransGraterAmmounts(2000)