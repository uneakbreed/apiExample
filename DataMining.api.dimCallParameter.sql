USE [DataMining]
GO

/****** Object:  Table [api].[dimCallParameter]    Script Date: 5/23/2022 1:55:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [api].[dimCallParameter](
	[CallParameterID] INT IDENTITY(1,1),
	[CallID] INT NOT NULL,
	[ParameterID] INT NOT NULL,
	[isRequiredFlag] BIT DEFAULT 0 NOT NULL,
	[isInputParameterFlag] BIT DEFAULT 0 NOT NULL
) ON [PRIMARY]
GO


