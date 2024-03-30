USE AccountingCompanyDataBase
-- ADD NEW TABLES, VIEWS & LINKING TO TESTS ----------
GO
-- PROCEDURE THAT ADDS TESTS
CREATE OR ALTER PROCEDURE AddTests(@name VARCHAR(50)) AS
    IF EXISTS (SELECT * FROM Tests WHERE Name = @name)
        PRINT 'Test ' + @name + ' already exists'
    ELSE
        INSERT INTO Tests(Name) VALUES (@name)
GO

-- PROCEDURE THAT ADDS TABLES
CREATE OR ALTER PROCEDURE AddTables(@name VARCHAR(50)) AS
    IF EXISTS (SELECT * FROM Tables WHERE Name = @name)
        PRINT 'Table ' + @name + ' already exists'
    ELSE
        INSERT INTO Tables(Name) VALUES (@name)
GO

-- PROCEDURE THAT ADDS VIEWS
CREATE OR ALTER PROCEDURE AddViews(@name VARCHAR(50)) AS
    IF EXISTS (SELECT * FROM Views WHERE Name = @name)
        PRINT 'View ' + @name + ' already exists'
    ELSE
        INSERT INTO Views(Name) VALUES (@name)
GO

-- PROCEDURE THAT ADDS LINKING BETWEEN TESTS AND TABLES
CREATE OR ALTER PROCEDURE AddTestsTables(@testName VARCHAR(50), @tableName VARCHAR(50), @NoOfRows INT, @Position INT) AS
    -- check if test exists
    IF NOT EXISTS (SELECT * FROM Tests WHERE Name = @testName)
    BEGIN
        PRINT 'Test ' + @testName + ' does not exist'
        RETURN
    END

    -- check if table exists
    IF NOT EXISTS (SELECT * FROM Tables WHERE Name = @tableName)
    BEGIN
        PRINT 'Table ' + @tableName + ' does not exist'
        RETURN
    END

    -- get the TestID from Tests
    DECLARE @testID INT
    SET @testID = (SELECT TestID FROM Tests WHERE Name = @testName)

    -- get the TableID from Tables
    DECLARE @tableID INT
    SET @tableID = (SELECT TableID FROM Tables WHERE Name = @tableName)

    -- check if link exists
    IF EXISTS (SELECT * FROM TestTables WHERE TestID = @testID AND TableID = @tableID)
    BEGIN
        PRINT 'Test-Table link already exists'
        RETURN
    END

    INSERT INTO TestTables(TestID, TableID, NoOfRows, Position) VALUES (@testID, @tableID, @NoOfRows, @Position)
GO

-- PROCEDURE THAT ADDS LINKING BETWEEN TESTS AND VIEWS
CREATE OR ALTER PROCEDURE AddTestsViews(@testName VARCHAR(50), @viewName VARCHAR(50)) AS
    -- check if test exists
    IF NOT EXISTS (SELECT * FROM Tests WHERE Name = @testName)
    BEGIN
        PRINT 'Test ' + @testName + ' does not exist'
        RETURN
    END

    -- check if view exists
    IF NOT EXISTS (SELECT * FROM Views WHERE Name = @viewName)
    BEGIN
        PRINT 'View ' + @viewName + ' does not exist'
        RETURN
    END

    -- get the TestID from Tests
    DECLARE @testID INT
    SET @testID = (SELECT TestID FROM Tests WHERE Name = @testName)

    -- get the ViewID from Views
    DECLARE @viewID INT
    SET @viewID = (SELECT ViewID FROM Views WHERE Name = @viewName)

    -- check if link exists
    IF EXISTS (SELECT * FROM TestViews WHERE TestID = @testName AND ViewID = @viewName)
    BEGIN
        PRINT 'Test-View link already exists'
        RETURN
    END
    
    INSERT INTO TestViews(TestID, ViewID) VALUES (@testID, @viewID)
GO

----------------------------------RUN-TEST--------------------------------------------------------------------

CREATE OR ALTER PROCEDURE runTest (@testName VARCHAR(50)) AS
BEGIN
    BEGIN TRY
        PRINT 'BEGIN TRANSACTION'
        BEGIN TRANSACTION ROLLBACKIfError;
		
        -- check if test exists
        IF NOT EXISTS (SELECT * FROM Tests WHERE Name = @testName)
        BEGIN
            PRINT 'Test ' + @testName + ' does not exist'
            RETURN
        END

        PRINT 'Running test ' + @testName

        -- get the TestID from Tests
        DECLARE @testID INT
        SET @testID = (SELECT TestID FROM Tests WHERE Name = @testName)

        INSERT INTO TestRuns(Description) VALUES (@testName) -- to have an id
		DECLARE @testRunID INT
        SET @testRunID = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))
    
        -- get the tables linked to this test
        DECLARE TablesCursor CURSOR SCROLL FOR
            SELECT Tables.TableID, Tables.Name, TestTables.NoOfRows 
            FROM Tables
            INNER JOIN TestTables ON Tables.TableID = TestTables.TableID
            WHERE TestTables.TestID = @testID
            ORDER BY TestTables.Position

        -- declare the variables for measuring time
        DECLARE @currentTestStartTime DATETIME
        DECLARE @currentTestEndTime DATETIME
        DECLARE @entireTestStartTime DATETIME
        DECLARE @entireTestEndTime DATETIME
    
        -- declare the variables for the table name, the number of rows and table id
        DECLARE @tableName VARCHAR(50), @noOfRows INT, @tableID INT

        SET @entireTestStartTime = GETDATE()


        ---------------- DELETE all data from the tables linked to this test ---------------
        DECLARE @deleteCommand VARCHAR(100)

        OPEN TablesCursor
        FETCH FIRST FROM TablesCursor INTO @tableID, @tableName, @noOfRows
    

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @deleteCommand = 'DELETE FROM ' + @tableName
            EXEC (@deleteCommand)
			PRINT @deleteCommand
            FETCH NEXT FROM TablesCursor INTO @tableID, @tableName, @noOfRows	
            
        END

        CLOSE TablesCursor

        ----------------- POPULATE the tables with data -----------------
        DECLARE @insertCommand VARCHAR(100)

        OPEN TablesCursor
        FETCH LAST FROM TablesCursor INTO @tableID, @tableName, @noOfRows

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @currentTestStartTime = GETDATE()

            SET @insertCommand = 'Populate' + @tableName + ' ' + CONVERT(VARCHAR(10), @noOfRows)
        
            EXEC(@insertCommand)

            SET @currentTestEndTime = GETDATE()

            PRINT @insertCommand + ' took ' + CONVERT(VARCHAR(50), DATEDIFF(MILLISECOND, @currentTestStartTime, @currentTestEndTime)) + ' milliseconds'

            -- add the times to the TestRunTables table
            INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt) VALUES (@testRunID, @tableID, @currentTestStartTime, @currentTestEndTime)

            -- go to next table
            FETCH PRIOR FROM TablesCursor INTO @tableID, @tableName, @noOfRows
        END

        CLOSE TablesCursor
        DEALLOCATE TablesCursor

        ----------------- EVALUATE THE VIEWS -----------------

        -- get the views linked to this test
        DECLARE ViewsCursor CURSOR FOR
            SELECT Views.ViewID, Views.Name
            FROM Views
            INNER JOIN TestViews ON Views.ViewID = TestViews.ViewID
            WHERE TestViews.TestID = @testID

        -- declare the variables for the view name and view id
        DECLARE @viewName VARCHAR(50), @viewID INT

        OPEN ViewsCursor
        FETCH FROM ViewsCursor INTO @viewID, @viewName

        DECLARE @viewCommand VARCHAR(100)   

		DECLARE @dummyTable TABLE (dummy INT)

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @currentTestStartTime = GETDATE()

            SET @viewCommand = 'SELECT * INTO #tempTable FROM ' + @viewName

            -- execute the view without outputing the results of the select

            EXEC(@viewCommand)

            IF OBJECT_ID('tempdb..#tempTable') IS NOT NULL
                DROP TABLE #tempTable

            SET @currentTestEndTime = GETDATE()

            PRINT @viewCommand + ' took ' + CONVERT(VARCHAR(50), DATEDIFF(MILLISECOND, @currentTestStartTime, @currentTestEndTime)) + ' milliseconds'

            -- add the times to the TestRunViews table
            INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) VALUES (@testRunID, @viewID, @currentTestStartTime, @currentTestEndTime)

            -- go to next view
            FETCH NEXT FROM ViewsCursor INTO @viewID, @viewName
        END

        CLOSE ViewsCursor
        		DEALLOCATE ViewsCursor

		SET @entireTestEndTime = GETDATE()

		PRINT 'Test ' + @testName + ' took ' + CONVERT(VARCHAR(50), DATEDIFF(MILLISECOND, @entireTestStartTime, @entireTestEndTime)) + ' milliseconds'

		-- update the TestRuns table with the entire test time
        UPDATE TestRuns SET StartAt = @entireTestStartTime, EndAt = @entireTestEndTime WHERE TestRunID = @testRunID

		PRINT 'COMMIT'
		COMMIT TRANSACTION ROLLBACKIfError;

	END TRY
	BEGIN CATCH
		PRINT 'ERROR_MESSAGE: ' + ERROR_MESSAGE()
        PRINT 'ROLLBACK'
        -- if cursors allocated, deallocate them
        IF CURSOR_STATUS('global', 'TablesCursor') >= 0
            DEALLOCATE TablesCursor
        IF CURSOR_STATUS('global', 'ViewsCursor') >= 0
            DEALLOCATE ViewsCursor
		ROLLBACK TRANSACTION ROLLBACKIfError;
	END CATCH;
END;
GO

--SELECT * FROM TestRuns

--EXEC runTest 'testInsertDelete100k'
--EXEC runTest 'testEvaluateViews'

--SELECT * FROM Income_Services_Products

--SELECT * FROM Income

--SELECT * FROM Services_Products


--EXEC AddTests 'testInsertDelete1000'

--EXEC AddTestsTables 'testInsertDelete1000', 'Income_Services_Products', 1000, 1
--EXEC AddTestsTables 'testInsertDelete1000', 'Services_Products', 1000, 2
--EXEC AddTestsTables 'testInsertDelete1000', 'Income', 1000, 3

--EXEC AddTests 'testInsertDelete10k'

--EXEC AddTestsTables 'testInsertDelete10k', 'Income_Services_Products', 10000, 1
--EXEC AddTestsTables 'testInsertDelete10k', 'Services_Products', 10000, 2
--EXEC AddTestsTables 'testInsertDelete10k', 'Income', 10000, 3

--EXEC AddTests 'testInsertDelete100k'

--EXEC AddTestsTables 'testInsertDelete100k', 'Income_Services_Products', 100000, 1
--EXEC AddTestsTables 'testInsertDelete100k', 'Services_Products', 100000, 2
--EXEC AddTestsTables 'testInsertDelete100k', 'Income', 100000, 3