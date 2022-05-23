USE [DataMining]
GO

/****** Object:  Table [api].[dimETL]    Script Date: 5/23/2022 1:57:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [api].[dimETL](
	[ETL_APIServiceID] [INT] IDENTITY(1,1) NOT NULL,
	[APIServiceID] [INT] NOT NULL,
	[callID] [INT] NOT NULL,
	[OutputQuery1] [NVARCHAR](MAX) NULL,
	[OutputQuery2] [NVARCHAR](MAX) NULL,
	[StagingServerInstanceName] [NVARCHAR](250) NULL,
	[StagingTableName] [NVARCHAR](250) NULL,
	[DestinationServerInstanceName] [NVARCHAR](250) NULL,
	[DestinationTableName] [NVARCHAR](250) NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


INSERT INTO api.dimETL
(
    APIServiceID,
    callID,
    OutputQuery1,
    OutputQuery2,
    StagingTableName,
    DestinationTableName
)
VALUES

(
  1
, 1
, 'INSERT INTO Staging.dbo.api_SFDBA    SELECT d.*    FROM (      SELECT * FROM OPENJSON ((SELECT * FROM 	'
, '))      WITH (       [ttxid] NVARCHAR(MAX),       [certificate_number] NVARCHAR(MAX),       [ownership_name] NVARCHAR(MAX)       , [dba_name] NVARCHAR(MAX)       , [full_business_address] NVARCHAR(MAX)       , [city] NVARCHAR(MAX)       , [state] NVARCHAR(MAX)       , [business_zip] NVARCHAR(MAX)       , [dba_start_date] NVARCHAR(MAX)       , [location_end_date] NVARCHAR(MAX)       , [mailing_address_1] NVARCHAR(MAX)       , [mail_city] NVARCHAR(MAX)       , [mail_zipcode] NVARCHAR(MAX)       , [mail_state] NVARCHAR(MAX)       , [naic_code] NVARCHAR(MAX)       , [naic_code_description] NVARCHAR(MAX)       , [parking_tax] NVARCHAR(MAX)       , [transient_occupancy_tax] NVARCHAR(MAX)       , [supervisor_district] NVARCHAR(MAX)       , [neighborhoods_analysis_boundaries] NVARCHAR(MAX)       , [uniqueid] NVARCHAR(MAX)       , [:@computed_region_6qbp_sg9q] NVARCHAR(MAX)       , [:@computed_region_qgnn_b9vv] NVARCHAR(MAX)       , [:@computed_region_26cr_cadq] NVARCHAR(MAX)       , [:@computed_region_ajp5_b2md] NVARCHAR(MAX)       , [:@computed_region_jwn9_ihcz] NVARCHAR(MAX)         ) AS JsonColumns    ) d    LEFT JOIN Staging.dbo.api_SFDBA api  WITH (NOLOCK) ON     api.ttxid = d.ttxid    Where api.ttxid is null'  	
, 'Staging.dbo.api_SFDBA'	
, 'DataWarehouse.dbo.RegisteredBusinessLocations_SanFrancisco'
)
