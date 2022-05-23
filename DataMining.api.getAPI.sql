USE datamining; 
GO
CREATE PROCEDURE api.getAPI AS
/*
SF DBA Example from here:  https://data.sfgov.org/Economy-and-Community/Registered-Business-Locations-San-Francisco/g8m3-pdis/data

This is a limited demo, as this pre-supposes a one-time load, so is only an insert into where is null.
Since this data is slowly changing dimension, there would be a follow-up upsert/merge proc.

The proof of concept is to paginate through an API to insert into a staging table to eventually get to a DataWarehouse db
This demo uses dynamic sql so you can store the query for the call, tablenames of the API call separately. 

The full version would iterate through multiple API calls and paginate through each one until complete, utilizing an additional schedule column 
The idea is to have enough information in dim tables to allow for a while loop to iterate through each active API based on frequency of update and upsert/merge to existing datasets.
This informaiton can then be used as a pipeline profiler for prospects, but also to append existing clients with additional attribute data. 



************************************************************
						DYNAMIC SQL
1. How to get sp_executesql result into a variable 
	* https://stackoverflow.com/questions/803211/how-to-get-sp-executesql-result-into-a-variable

2. How to pass a table variable through dynamic sql
	* https://stackoverflow.com/questions/4626292/how-to-use-table-variable-in-a-dynamic-sql-statement

*/



/***************************************************************
					SET VARIABLES
****************************************************************/
--DECLARE Dates (will be used to append the tablename
DECLARE @today DATE = CAST(GETDATE() AS DATE)	--get today's date
DECLARE @dateformat CHAR(8) = CONVERT(CHAR(8), @today, 112)  --YYYYMMDD


-- Declaration related to the Object.
DECLARE @token INT;
DECLARE @ret INT;


--APIService
DECLARE @apiServiceID INT  = 1 --San Fransisco GOv

--Create workingdata table to store JSON call in tabular format
DECLARE @tableroot NVARCHAR(100) = 'Workingdata.dbo.JSon_CallID'
DECLARE @WorkingDataTable NVARCHAR(250) = @tableroot+CAST(@apiServiceID AS NVARCHAR(5))+'_'+@dateformat
DECLARE @WorkingDataTableCreate NVARCHAR(250) = '  DROP TABLE IF EXISTS '+@WorkingDataTable+'  CREATE TABLE '+@WorkingDataTable+'  (   [Json_Table] [NVARCHAR](MAX) NULL  ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]  '

--Drop WorkingData table once job is complete
DECLARE @dropWorkingData NVARCHAR(250) = 'DROP TABLE IF EXISTS '+@tableroot+CAST(@apiServiceID AS NVARCHAR(5))+'_'+@dateformat

--OutputQuery variable. Query to insert into WorkingData. Broken into two steps for Dynamic SQL
DECLARE @OutputQuery NVARCHAR(MAX) = 
					(SELECT OutputQuery1 
					FROM datamining.api.dimETL 
					WHERE APIServiceID = @APIServiceID)
					+
					@WorkingDataTable
					+
					(SELECT OutputQuery2 
					FROM datamining.api.dimETL 
					WHERE APIServiceID = @APIServiceID)

--SELECT @OutputQuery
--get name of StagingTable. Intermediary table for ELT.
DECLARE @StagingTableName NVARCHAR(250) = (SELECT StagingTableName FROM DataMining.api.dimETL WHERE APIServiceID = @apiServiceID)

--RecordCount, used to determine Offset
DECLARE @RecordCount int
DECLARE @AllRecordsDef NVARCHAR(500);

DECLARE @getAllRecords NVARCHAR(250) = 'SELECT @AllRecordsValueOUT = (SELECT COUNT(*) FROM '+@StagingTableName+')'

SET @AllRecordsDef = '@AllRecordsValueOUT int OUTPUT';



-- get URL for API call
DECLARE @urlprefix NVARCHAR(MAX);
DECLARE @url NVARCHAR(MAX);


-- Define the urlprefix of the call
SET @urlprefix = (SELECT apiURL FROM datamining.api.dimAPI WHERE apiServiceID = @apiServiceID)

--LIMIT of how many records I can pull in the call.
DECLARE @limit INT = (SELECT  CallLimit FROM datamining.api.dimAPI WHERE apiserviceid =@apiServiceID )

--@orderid. variable to determine ORDER BY in call
DECLARE @orderID AS NVARCHAR(32) = 'ttxid'


-- Create table to insert json string. used in @insertJson variable
DROP TABLE IF EXISTS #json
CREATE TABLE #json (Json_Table NVARCHAR(MAX))

--create JSON Table variable to temporarily hold value. as this value will be updated. If this table is ever NULL (from the update) then there was a failure in the call and the proc will return out of loop
DECLARE @json TABLE (Json_Table NVARCHAR(max))

DECLARE @insertJSON NVARCHAR(250) = 'DELETE FROM '+@WorkingDataTable+' INSERT INTO '+@WorkingDataTable+' SELECT * FROM #json'


--SET @RecordCount
exec sp_executesql @getAllRecords, @AllRecordsDef, @AllRecordsValueOUT = @RecordCount OUTPUT;


--SET OFFSET
DECLARE  @Offset INT = CASE WHEN @RecordCount=0 THEN 0 ELSE @RecordCount+1 end

	set @url = @urlprefix + '?$limit='+CAST(@limit AS NVARCHAR(5))+'&$offset='+CAST(@offset AS nvarchar(10))+'&$order='+@orderID


--iteration
DECLARE @iteration INT = 1



	-- This creates the new object.
	EXEC @ret = sp_OACreate 'MSXML2.XMLHTTP', @token OUT;

	-- This calls the necessary methods.
	EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url, 'false';
	EXEC @ret = sp_OAMethod @token, 'send'

	-- Grab the responseText property, and insert the JSON string into a table temporarily. This is very important, if you don't do this step you'll run into problems.
	INSERT into #json (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'


--create workingdata table used to save json from api call
EXEC sp_executesql @WorkingDataTableCreate

WHILE (1=1)
AND @ret = 0																--successfully reached site
AND NOT EXISTS (SELECT * FROM #json WHERE Json_Table LIKE '%Site Currently Unavailable%')		--site is available
AND EXISTS (SELECT * FROM #Json) 

BEGIN
	
	-- get count of records in staging table
	EXEC sp_executesql @getAllRecords, @AllRecordsDef, @AllRecordsValueOUT = @RecordCount OUTPUT;

	--Print record total prior to run
	PRINT('Total of '+cast(@RecordCount AS nvarchar(12))+ ' records in staging table.')


	--Offset
	SELECT @Offset = CASE WHEN @RecordCount=0 THEN 0 ELSE @RecordCount+1 end
	PRINT('Offset: '+cast(@Offset AS nvarchar(12)))

	SELECT @url = @urlprefix + '?$limit='+CAST(@limit AS NVARCHAR(5))+'&$offset='+CAST(@offset AS nvarchar(10))+'&$order='+@orderID




	-- This creates the new object.
	EXEC @ret = sp_OACreate 'MSXML2.XMLHTTP', @token OUT;

	-- This calls the necessary methods.
	EXEC @ret = sp_OAMethod @token, 'open', NULL, 'GET', @url, 'false';
	--EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Authentication', @authHeader;
	--EXEC @ret = sp_OAMethod @token, 'setRequestHeader', NULL, 'Content-type', @contentType;
	EXEC @ret = sp_OAMethod @token, 'send'

	-- Grab the responseText property, and insert the JSON string into a table temporarily. This is very important, if you don't do this step you'll run into problems.
	DELETE FROM @json
	INSERT into @json (Json_Table) EXEC sp_OAGetProperty @token, 'responseText'

	UPDATE #json
	SET Json_Table = (SELECT Json_table FROM @json)


	EXEC sp_executesql @insertJSON
	


 
		-- Parse the Metadata
		EXEC sp_executesql @OutputQuery

		PRINT('Increment '+CAST(@iteration AS NVARCHAR(10)) +' complete')
		WAITFOR DELAY '00:03';		--wait for 10 seconds before the next run
		SELECT @iteration = @iteration+1	--increase increment

END

--EXEC sp_executesql @dropWorkingData		--drop WorkingData table once job is completed for the day. Will be commented out for testing.


--another proc to run upsert/merge statement of the Staging Table to the DataWarehouse table
