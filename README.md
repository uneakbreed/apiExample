# apiExample
An example of paginating through an api call and loading it into SQL Server. This example uses dynamic .SQL to allow for multiple calls to run. I've built out the general table structure but only fully populated columns/rows for a specific example using Registered Businesses that pay taxes in San Francisco, CA. This is a very quick build and doesn't have PKs and FKs or any FK constraints as would be built out for PRD.

Link: https://data.sfgov.org/Economy-and-Community/Registered-Business-Locations-San-Francisco/g8m3-pdis/data


DATABASES
  1) DataMining - the table that contains all the information on your data mining sources. In this case there is one schema "api" used to store api info.
  2) Staging - where the call get loaded and stored
  3) DataWarehouse - the production db. An upsert/merge statement from Staging-->DataWarehouse would handle the final load/transform in the ETL process


DATABASE TABLES: (NOTE: not all columns have data and there are rows missing in subsequent tables. Only the columns/rows pertaining to the SF DBA api call is complete).

1) DataMining
    * api.dimAPI            - API sources, descriptions, documentation needed, apiKeys,  apiURLs and any additional information needed for the api call.
    * api.dimCall           - call functions for every API along with a flag indicating if the call has a parameter required.
    * api.dimCallParameter  - parameters that can be used or returned in an apiCall and flags indicating if the parameter is required or if it can be an input
    * api.dimETL            - provides the staging/destination tablenames as well as the queries needed to transform JSON format and load into .SQL table
    * api.dimParameter      - parameters for every API call

  3) Staging
    * dbo.api_AlphaVantage  - Staging table for stock price snapshots
    * dbo.api_SFDBA         - Staging table for SF DBA load

  5) DataWarehouse
    * dbo.StockTickerPriceSnapshot                  - prod table for stock price snapshots
    * dbo.RegisteredBusinessLocations_SanFransisco  - prod table for SF DBA load


PROCEDURES:
  1) DataMining.api.getAPI

    This is a limited demo, as this pre-supposes a one-time load, so is only an insert into where is null.
    Since this data is slowly changing dimension, there would be a follow-up upsert/merge proc.
    Optimization ultimately would be replacing this .SQL proc with python code to load and paginate much faster. 

    The proof of concept is to paginate through an API to insert into a staging table to eventually get to a DataWarehouse db
    This demo uses dynamic sql so you can store the query for the call, tablenames of the API call separately. 

    The full version would iterate through multiple API calls and paginate through each one until complete, utilizing an additional schedule column 
    The idea is to have enough information in dim tables to allow for a while loop to iterate through each active API based on frequency of update and upsert/merge     to existing datasets.
    This informaiton can then be used as a pipeline profiler for prospects, but also to append existing clients with additional attribute data. 
