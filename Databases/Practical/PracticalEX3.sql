------------ DROPS ------------
GO
DROP TABLE ActorRole
DROP TABLE Actor
DROP TABLE CinemaProduction
DROP TABLE Movie
DROP TABLE StageDirector
DROP TABLE Company
GO

------------ CREATES ------------
GO
CREATE TABLE Company (
	CID INT PRIMARY KEY,
	CName VARCHAR(50)
)

CREATE TABLE StageDirector ( 
	SDID INT PRIMARY KEY,
	SDName VARCHAR(50),
	NrAwords INT
)

CREATE TABLE Movie (
	MID INT PRIMARY KEY,
	MName VARCHAR(50),
	ReleaseDate DATE,
	CID INT REFERENCES Company,
	SDID INT REFERENCES StageDirector
)

CREATE TABLE CinemaProduction (
	CPID INT PRIMARY KEY,
	Title VARCHAR(100),
	MID INT REFERENCES Movie
)

CREATE TABLE Actor ( 
	AID INT PRIMARY KEY,
	AName VARCHAR(50),
	Ranking INT
)

CREATE TABLE ActorRole ( 
	RID INT PRIMARY KEY IDENTITY(1, 1),
	CPID INT REFERENCES CinemaProduction,
	AID INT REFERENCES Actor,
	EntryMoment INT
)

INSERT INTO Company VALUES (1, 'C1')
INSERT INTO StageDirector VALUES (1, 'SD1', 10), (2, 'SD2', 20)
INSERT INTO Movie VALUES (1, 'M1', '2018-01-01', 1, 1), (2, 'M2', '2018-02-02', 1, 2), (3, 'M3', '2018-02-02', 1, 2)
INSERT INTO CinemaProduction VALUES (1, 'CP1', 1), (2, 'CP2', 2), (3, 'CP3', 2), (4, 'CP4', 2), (5, 'CP5', 2), (6, 'CP6', 3)
INSERT INTO Actor VALUES (1, 'a1', 1), (2, 'a2', 2), (3, 'a3', 3)
--INSERT INTO Roles VALUES (1, 1, 1, 1), (2, 1, 2, 3), (3, 1, 3, 2), (4, 2, 1, 1), (5, 2, 2, 2)

SELECT * FROM Company
SELECT * FROM StageDirector
SELECT * FROM Movie
SELECT * FROM CinemaProduction
SELECT * FROM Actor

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspAddRole(@CinemaProduction VARCHAR(50), @ActorName VARCHAR(50),  @EntryMoment INT)
AS
	DECLARE @AID INT
	SET @AID = (SELECT AID FROM Actor WHERE AName = @ActorName)
	IF @AID IS NULL
	BEGIN
		RAISERROR('The Actor does not exists', 16, 1)
		RETURN 
	END

	DECLARE @CPID INT
	SET @CPID = (SELECT CPID FROM CinemaProduction WHERE Title = @CinemaProduction)
	IF @CPID IS NULL
	BEGIN
		RAISERROR('The CinemaProduction does not exists', 16, 1)
		RETURN 
	END

	IF EXISTS (SELECT * FROM ActorRole WHERE CPID = @CPID AND AID = @AID AND EntryMoment = @EntryMoment)
	BEGIN 
		RAISERROR('The Role already exists', 16, 1)
		RETURN 
	END

	INSERT INTO ActorRole(AID, CPID, EntryMoment) VALUES (@AID, @CPID, @EntryMoment)

GO
--(2, 1, 2, 3), (3, 1, 3, 2), (4, 2, 1, 1), (5, 2, 2, 2)
EXEC uspAddRole 'cp1', 'a1', 1
EXEC uspAddRole 'cp1', 'a2', 3
EXEC uspAddRole 'cp1', 'a3', 2
EXEC uspAddRole 'cp2', 'a1', 1
EXEC uspAddRole 'cp2', 'a2', 2

SELECT * FROM ActorRole
------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vActorsAllProductions
AS
	SELECT AName
	FROM Actor A
	WHERE NOT EXISTS(
		SELECT CPID FROM CinemaProduction -- FROM ALL ATMS
		EXCEPT -- REMOVE THOSE USED FOR TRANSACTIONS OF CARD NR
		SELECT DISTINCT CPID 
		FROM ActorRole
		WHERE AID = A.AID)
GO
SELECT * FROM vActorsAllProductions

------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufFilterMovies (@P INT)
RETURNS TABLE
AS
RETURN 
		SELECT MName
		FROM Movie
		WHERE MID IN (
			SELECT M.MID
			FROM Movie M
			INNER JOIN CinemaProduction CP ON M.MID = CP.MID
			WHERE ReleaseDate > '2018-01-01'
			GROUP BY M.MID
			HAVING COUNT(*) > @P)
GO

SELECT *
FROM ufFilterMovies(3)