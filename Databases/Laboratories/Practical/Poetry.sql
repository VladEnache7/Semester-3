USE Poetry

------------ DROPS ------------
GO
DROP TABLE Evaluations
DROP TABLE Judges
DROP TABLE Poems
DROP TABLE Competitions
DROP TABLE Awards
DROP TABLE Users
GO

------------ CREATES ------------
GO
CREATE TABLE Users (
	USID INT PRIMARY KEY,  -- maybe IDENTITY(1, 1) would help me introducing data
	UName VARCHAR(50),
	PenName VARCHAR(50), -- UNIQUE - I completly forgot about it - after finishing creating the tables REREAD, CHECK THE CONSTRAINTS
	yob DATE
)

CREATE TABLE Awards ( 
	AID INT PRIMARY KEY,  -- maybe IDENTITY(1, 1) would help me introducing data
	AName VARCHAR(50),
	USID INT REFERENCES Users(USID)
)

CREATE TABLE Competitions (
	CID INT PRIMARY KEY,  -- maybe IDENTITY(1, 1) would help me introducing data
	CYear DATE,
	CWeek INT,
	-- UNIQUE(CYear, CWeek) - a competition is defined by its year and week, thus unique
)

CREATE TABLE Poems (
	PID INT PRIMARY KEY,  -- maybe IDENTITY(1, 1) would help me introducing data
	Title VARCHAR(100),
	PText VARCHAR(100),
	USID INT REFERENCES Users(USID),
	CID INT REFERENCES Competitions(CID),
)

CREATE TABLE Judges ( 
	JID INT PRIMARY KEY, -- maybe IDENTITY(1, 1) would help me introducing data
	JName VARCHAR(50)
)

CREATE TABLE Evaluations ( 
	JID INT REFERENCES Judges,
	PID INT REFERENCES Poems,
	Points INT CHECK(Points > 1 AND Points < 10), -- ( >= 1 AND <= 10)
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

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspDeleteJudge(@JudgeName VARCHAR(50))
AS
	
	IF NOT EXISTS(SELECT * FROM Judges WHERE JName = @JudgeName)
	BEGIN
		RAISERROR('A Judge with this name does not exists', 16, 1)
		RETURN 
	END

	DECLARE JudgeCursor CURSOR FOR
		SELECT JID
		FROM Judges
		WHERE JName = @JudgeName

	OPEN JudgeCursor
	DECLARE @JID INT
	FETCH FROM JudgeCursor INTO @JID

	WHILE @@FETCH_STATUS = 0
    BEGIN
		DELETE Evaluations
		WHERE JID = @JID

		DELETE Judges
		WHERE JID = @JID

		FETCH NEXT FROM JudgeCursor INTO @JID
		-- FETCH JudgeCursor INTO @JID
	END

	CLOSE JudgeCursor
	DEALLOCATE JudgeCursor

GO

--EXEC uspDeleteJudge 'J100'
--EXEC uspDeleteJudge 'J2'

--SELECT * FROM Evaluations

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vFilterCompetitions
AS
	SELECT CYear, CWeek
	FROM Competitions C
	WHERE CID IN (
		SELECT CID 
		FROM Poems P
		-- WHERE P.PID NOT IN (SELECT DISTINCT PID FROM Evaluations WHERE Points >= 5) -- remove the poems that have at least one evaluation 5+
		INNER JOIN (SELECT PID
					FROM Evaluations E
					GROUP BY PID
					HAVING MAX(Points) < 5)	E ON P.PID = E.PID -- HAVE ONLY THE POEMS WITH MAX(EVALUATIONS) < 5
		GROUP BY CID
		HAVING COUNT(*) >= 2) -- 10 
go
	
SELECT * FROM vFilterCompetitions


------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufFilterUsers (@P INT)
RETURNS TABLE
AS
RETURN 
		SELECT UName, PenName
		FROM Users
		WHERE USID IN (SELECT U.USID
						FROM Users U
						INNER JOIN Poems P ON U.USID = P.USID
						GROUP BY U.USID
						HAVING COUNT(*) > @P)
GO

SELECT *
FROM ufFilterUsers(1)