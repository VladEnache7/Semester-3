USE Cinematics

------------ DROPS ------------
GO
DROP TABLE EntryMoment
DROP TABLE Hero
DROP TABLE Cinematic
DROP TABLE Game
DROP TABLE Company
GO------------ CREATES ------------
GO
CREATE TABLE Company (
	CID INT PRIMARY KEY IDENTITY(1, 1),
	CName VARCHAR(50),
	CDesc VARCHAR(50),
	Website VARCHAR(50),
)

CREATE TABLE Game ( 
	GID INT PRIMARY KEY IDENTITY(1, 1),
	GName VARCHAR(50),
	Release DATE,
	CID INT REFERENCES Company(CID)
)

CREATE TABLE Cinematic (
	CINID INT PRIMARY KEY IDENTITY(1, 1),
	CINName VARCHAR(50),
	GID INT REFERENCES Game(GID)
)

CREATE TABLE Hero (
	HID INT PRIMARY KEY IDENTITY(1, 1),
	HName VARCHAR(50),
	HDesc VARCHAR(50),
	Importance INT
)

CREATE TABLE EntryMoment ( 
	CINID INT REFERENCES Cinematic(CINID),
	HID INT REFERENCES Hero(HID),
	ETime TIME,
	PRIMARY KEY(CINID, HID)
)


 
INSERT INTO Company VALUES ('C1', 'Description', 'Website'), ('C2', 'Description', 'Website'), ('C3', 'Description', 'Website')
INSERT INTO Game VALUES ('G1', '2014-12-12', 1), ('G2','2023-12-12', 1), ('G3','2023-12-12', 1), ('G4','2012-12-12', 2), ('G5','2023-12-12', 2), ('G6','2023-12-12', 3)  
INSERT INTO Cinematic VALUES ('CIN1', 1), ('CIN2', 1), ('CIN3', 1), ('CIN4', 4)--, ('CIN5', 2), ('CIN6', 3), ('CIN7', 4), ('CIN8', 5), ('CIN9', 6)  
INSERT INTO Hero VALUES ('H1', 'Description', 10), ('H2', 'Description', 10), ('H3', 'Description', 10), ('H4', 'Description', 10), ('H5', 'Description', 10)


SELECT * FROM Hero
SELECT * FROM Cinematic
SELECT * FROM Game
SELECT * FROM Company

------------------------- PROCEDURE -------------------------
GO
CREATE OR ALTER PROCEDURE uspAddEntryMoment (@HeroName VARCHAR(50), @CinematicName VARCHAR(50), @EntryMoment TIME)
AS
	DECLARE @HID INT
	SET @HID = (SELECT HID FROM Hero WHERE HName = @HeroName)
	IF @HID IS NULL
	BEGIN
		RAISERROR('A HERO with this name does not exists', 16, 1)
		RETURN 
	END

	DECLARE @CINID INT
	SET @CINID = (SELECT CINID FROM Cinematic WHERE CINName = @CinematicName)
	IF @CINID IS NULL
	BEGIN
		RAISERROR('A CINEMATIC with this name does not exists', 16, 1)
		RETURN 
	END

	IF EXISTS(SELECT * FROM EntryMoment WHERE HID = @HID AND CINID = @CINID)
	BEGIN
		UPDATE EntryMoment
		SET ETime = @EntryMoment
		WHERE HID = @HID AND CINID = @CINID
	END
	ELSE
		INSERT EntryMoment (HID, CINID, ETime) VALUES (@HID, @CINID, @EntryMoment)

GO

EXEC uspAddEntryMoment 'H1', 'CIN1', '00:02:33'
--EXEC uspAddEntryMoment 'H100', 'CIN1', '00:02:33'
--EXEC uspAddEntryMoment 'H1', 'CIN100', '00:02:33'

EXEC uspAddEntryMoment 'H1', 'CIN1', '00:22:44'
EXEC uspAddEntryMoment 'H1', 'CIN2', '00:02:33'
EXEC uspAddEntryMoment 'H1', 'CIN3', '00:02:33'
EXEC uspAddEntryMoment 'H1', 'CIN4', '00:02:33'
EXEC uspAddEntryMoment 'H2', 'CIN1', '00:02:33'
EXEC uspAddEntryMoment 'H2', 'CIN2', '00:02:33'
EXEC uspAddEntryMoment 'H2', 'CIN3', '00:02:33'
EXEC uspAddEntryMoment 'H2', 'CIN4', '00:02:33'
EXEC uspAddEntryMoment 'H3', 'CIN1', '00:02:33'
EXEC uspAddEntryMoment 'H3', 'CIN2', '00:02:33'
EXEC uspAddEntryMoment 'H5', 'CIN3', '00:02:33'
EXEC uspAddEntryMoment 'H4', 'CIN4', '00:02:33'

SELECT * FROM EntryMoment ORDER BY HID

------------------------- VIEW -------------------------
GO
CREATE OR ALTER VIEW vFilterHeros
AS
	SELECT HName, Importance
	FROM Hero H
	WHERE NOT EXISTS (
		SELECT CINID
		FROM Cinematic
		EXCEPT
		SELECT DISTINCT CINID
		FROM EntryMoment
		WHERE HID = H.HID)
		
go
	
SELECT * FROM vFilterHeros

------------------------- FUNCTION -------------------------
GO
CREATE OR ALTER FUNCTION ufGamesFromPeriod ()
RETURNS TABLE
AS
RETURN 
		
		SELECT C.CName, G.GName, CIN.CINName, G.Release
		FROM CompanY C
		INNER JOIN Game G ON G.CID = C.CID 
		INNER JOIN Cinematic CIN ON CIN.GID = G.GID
		WHERE G.Release >= '2000-12-02' AND G.Release <= '2016-01-01'
GO

SELECT *
FROM ufGamesFromPeriod()
