USE [DataMining]
GO

/****** Object:  Table [api].[dimParameter]    Script Date: 5/23/2022 1:58:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [api].[dimParameter](
	[ParameterID] INT IDENTITY(1,1) NOT NULL,
	[Parameter] [NVARCHAR](255) NOT NULL,
	[Description] [NVARCHAR](255) NULL,
	[ParameterType] [NVARCHAR](255) NULL,
	[DataType] [NVARCHAR](255) NULL,
	[APIServiceID] INT NULL
) ON [PRIMARY]
GO


