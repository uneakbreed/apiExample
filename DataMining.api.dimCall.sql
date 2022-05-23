USE [DataMining]
GO

/****** Object:  Table [api].[dimCall]    Script Date: 5/23/2022 1:54:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [api].[dimCall](
	[CallID] INT IDENTITY(1,1),
	[CallName] [NVARCHAR](255) NOT NULL,
	[CallDesc] [NVARCHAR](MAX) NOT NULL,
	[APIServiceID] INT NOT NULL,
	[hasParameterRequirementFlag] BIT DEFAULT 0 NOT NULL,
	[APICall] [NVARCHAR](1500) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


INSERT INTO api.dimcall

VALUES
( 'query'
, '"Doing Business As" data for any business that pays taxes in San Francisco'
, 1
, 0	
, 'https://data.sfgov.org/resource/g8m3-pdis.json'
)



