USE Seminar6

DROP TABLE RoutesStations -- We have to drop this first because the following 2 are referenced in this table
DROP TABLE Stations
DROP TABLE Routes
DROP TABLE Trains
DROP TABLE TrainTypes
GO -- DROPs and CREATEs are recomended to be in separate batch

CREATE TABLE TrainTypes
  (TTID INT PRIMARY KEY,
  TTName VARCHAR(100),
  TTDescription VARCHAR(500))

CREATE TABLE Trains
  (TID INT PRIMARY KEY,
  TName VARCHAR(100),
  TrainTypeID INT REFERENCES TrainTypes(TTID))

CREATE TABLE Routes
  (RID INT PRIMARY KEY,
  RName VARCHAR(100) UNIQUE,  -- Forgot about unique constrain
  TrainID INT REFERENCES Trains(TID))

CREATE TABLE Stations
  (SID INT PRIMARY KEY,
  SName VARCHAR(100) UNIQUE)

CREATE TABLE RoutesStations
  (RID INT REFERENCES Routes(RID),
  SID INT REFERENCES Stations(SID),
  Arrival TIME,
  Departure TIME,
  PRIMARY KEY(RID, SID))
GO

------------------------------ PROCEDURE ----------------------

CREATE OR ALTER PROCEDURE uspUpdateRoutesStations 
	(@RName VARCHAR(50), @SName VARCHAR(50), @Arrival TIME, @Departure TIME)
AS
	DECLARE @RID INT
	SET @RID = (SELECT RID FROM Routes WHERE RName = @RName)

	IF @RID IS NULL
	BEGIN
		RAISERROR('Route name not fount', 16, 1)
		RETURN 
	END

	DECLARE @SID INT
	SET @SID = (SELECT SID FROM Stations WHERE SName = @SName)

	IF @SID IS NULL
	BEGIN
		RAISERROR('Station name not fount', 16, 1)
		RETURN
	END

	IF EXISTS(SELECT * FROM RoutesStations WHERE RID = @RID AND SID = @SID)
	BEGIN
		UPDATE RoutesStations
		SET Arrival = @Arrival, Departure = @Departure
		WHERE RID = @RID AND SID = @SID
	END
	ELSE
		INSERT RoutesStations(RID, SID, Arrival, Departure)
		VALUES (@RID, @SID, @Arrival, @Departure)

GO


INSERT INTO TrainTypes VALUES (1, 'TT1', 'TT1')
INSERT INTO Trains VALUES (1, 'T1', 1),  (2, 'T2', 1),  (3, 'T3', 1)
INSERT INTO Stations VALUES (1, 'S1'), (2, 'S2'),(3, 'S3')
INSERT INTO Routes VALUES (1, 'R1', 1),  (2, 'R2', 2),  (3, 'R3', 3)
GO

SELECT * FROM Trains
SELECT * FROM TrainTypes
SELECT * FROM Stations
SELECT * FROM Routes
GO

EXEC uspUpdateRoutesStations 'R1', 'S1', '18:00', '18:10'
EXEC uspUpdateRoutesStations 'R1', 'S2', '18:00', '18:10'
EXEC uspUpdateRoutesStations 'R1', 'S3', '18:00', '18:10'
EXEC uspUpdateRoutesStations 'R2', 'S1', '18:00', '18:10'
EXEC uspUpdateRoutesStations 'R2', 'S2', '18:00', '18:10'
EXEC uspUpdateRoutesStations 'R3', 'S1', '18:00', '18:10'
--EXEC uspUpdateRoutesStations 'R8', 'S1', '18:00', '18:10'
--EXEC uspUpdateRoutesStations 'R1', 'S8', '18:00', '18:10'
GO
SELECT * FROM RoutesStations


------------------------------ VIEW ----------------------
GO

-- FIRST BUILD THE SELECT THAT DOES WHAT IS NEED AND THEN PUT IT IN A VIEW

CREATE OR ALTER VIEW vAllRoutesWithAllStations
AS
	SELECT RName
	FROM Routes R
	WHERE NOT EXISTS -- IF THERE ARE NO STATIONS THAT ARE NOT PART OF THE ROUTE
		(SELECT SID -- SELECT ALL THE STATIONS
		FROM Stations
		EXCEPT
		SELECT SID  -- REMOVE THOSE THAT ARE PART OF A ROUTE 
		FROM RoutesStations
		WHERE RID = R.RID)
GO

SELECT *
FROM vAllRoutesWithAllStations

GO
CREATE OR ALTER FUNCTION ufFilterStationsByNoOfRoutes(@R INT)
RETURNS TABLE 
	RETURN SELECT SName
		   FROM Stations
		   WHERE SID IN (SELECT SID					
						FROM RoutesStations
						GROUP BY SID
						HAVING COUNT(*) > @R)
GO
		
SELECT *
FROM ufFilterStationsByNoOfRoutes(0)
