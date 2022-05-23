USE [Staging]
GO

/****** Object:  Table [dbo].[api_SFDBA]    Script Date: 5/23/2022 2:25:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[api_SFDBA](
	[ttxid] [NVARCHAR](MAX) NULL,
	[certificate_number] [NVARCHAR](MAX) NULL,
	[ownership_name] [NVARCHAR](MAX) NULL,
	[dba_name] [NVARCHAR](MAX) NULL,
	[full_business_address] [NVARCHAR](MAX) NULL,
	[city] [NVARCHAR](MAX) NULL,
	[state] [NVARCHAR](MAX) NULL,
	[business_zip] [NVARCHAR](MAX) NULL,
	[dba_start_date] [NVARCHAR](MAX) NULL,
	[location_end_date] [NVARCHAR](MAX) NULL,
	[mailing_address_1] [NVARCHAR](MAX) NULL,
	[mail_city] [NVARCHAR](MAX) NULL,
	[mail_zipcode] [NVARCHAR](MAX) NULL,
	[mail_state] [NVARCHAR](MAX) NULL,
	[naic_code] [NVARCHAR](MAX) NULL,
	[naic_code_description] [NVARCHAR](MAX) NULL,
	[parking_tax] [NVARCHAR](MAX) NULL,
	[transient_occupancy_tax] [NVARCHAR](MAX) NULL,
	[supervisor_district] [NVARCHAR](MAX) NULL,
	[neighborhoods_analysis_boundaries] [NVARCHAR](MAX) NULL,
	[uniqueid] [NVARCHAR](MAX) NULL,
	[:@computed_region_6qbp_sg9q] [NVARCHAR](MAX) NULL,
	[:@computed_region_qgnn_b9vv] [NVARCHAR](MAX) NULL,
	[:@computed_region_26cr_cadq] [NVARCHAR](MAX) NULL,
	[:@computed_region_ajp5_b2md] [NVARCHAR](MAX) NULL,
	[:@computed_region_jwn9_ihcz] [NVARCHAR](MAX) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


