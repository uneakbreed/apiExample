USE [DataMining]
GO

/****** Object:  Table [api].[dimAPI]    Script Date: 5/23/2022 1:51:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [api].[dimAPI](
	[APIServiceID] int IDENTITY(1,1),
	[DateUpdated] [DATETIME] DEFAULT GETDATE(),
	[ServiceName] [NVARCHAR](255) NOT NULL,
	[ServiceDescription] [NVARCHAR](255) NOT NULL,
	[apiKey] [NVARCHAR](255) NULL,
	[secretKey] [NVARCHAR](255) NULL,
	[Documentation_URL] [NVARCHAR](255) NULL,
	[Documentation_Json] [NVARCHAR](255) NULL,
	[apiURL] [NVARCHAR](255) NOT NULL,
	[ServiceType] [NVARCHAR](255) NULL,
	[AuthenticationHeader] [NVARCHAR](255) NULL,
	[ContentType] [NVARCHAR](255) NULL,
	[DateCreated] [DATETIME] DEFAULT GETDATE(),
	[DateExpired] [DATETIME] NULL,
	[ResponseHeaders] [NVARCHAR](MAX) NULL,
	[CallLimit] [INT] DEFAULT 1000 null,
	[hasPagination_PageBasedFlag] [BIT] DEFAULT 1,
	[hasPagination_KeyBasedFlag] [BIT] DEFAULT 0,
	[hasPagination_CursorBasedFlag] [BIT] DEFAULT 1
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

INSERT INTO api.dimAPI
(
    ServiceName,
    ServiceDescription,
    Documentation_URL,
    apiURL,
    DateExpired
)
VALUES
( 	
 'San Fransisco Gov.org'
, '"Doing Business As" data for any business that pays taxes in San Francisco.'
, 'https://dev.socrata.com/foundry/data.sfgov.org/g8m3-pdis'
, 'https://data.sfgov.org/resource/g8m3-pdis.json'
,'2999-12-31'	
)