USE [DataWarehouse]
GO

/****** Object:  Table [dbo].[RegisteredBusinessLocations_SanFransisco]    Script Date: 5/23/2022 2:26:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RegisteredBusinessLocations_SanFransisco](
	[LocationId] [NVARCHAR](255) NULL,
	[BusinessAccountNumber] [FLOAT] NULL,
	[OwnershipName] [NVARCHAR](255) NULL,
	[DBAName] [NVARCHAR](255) NULL,
	[StreetAddress] [NVARCHAR](255) NULL,
	[City] [NVARCHAR](255) NULL,
	[State] [NVARCHAR](255) NULL,
	[SourceZipcode] [FLOAT] NULL,
	[BusinessStartDate] [DATETIME] NULL,
	[BusinessEndDate] [DATETIME] NULL,
	[LocationStartDate] [DATETIME] NULL,
	[LocationEndDate] [DATETIME] NULL,
	[MailAddress] [NVARCHAR](255) NULL,
	[MailCity] [NVARCHAR](255) NULL,
	[MailZipcode] [FLOAT] NULL,
	[MailState] [NVARCHAR](255) NULL,
	[NAICSCode] [NVARCHAR](255) NULL,
	[NAICSCodeDescription] [NVARCHAR](255) NULL,
	[ParkingTax] [BIT] NOT NULL,
	[TransientOccupancyTax] [BIT] NOT NULL,
	[LICCode] [NVARCHAR](255) NULL,
	[LICCodeDescription] [NVARCHAR](255) NULL,
	[SupervisorDistrict] [FLOAT] NULL,
	[Neighborhoods-AnalysisBoundaries] [NVARCHAR](255) NULL,
	[BusinessCorridor] [NVARCHAR](255) NULL,
	[BusinessLocation] [NVARCHAR](255) NULL,
	[UniqueID] [NVARCHAR](255) NULL,
	[SFFindNeighborhoods] [FLOAT] NULL,
	[CurrentPoliceDistricts] [FLOAT] NULL,
	[CurrentSupervisorDistricts] [FLOAT] NULL,
	[AnalysisNeighborhoods] [FLOAT] NULL,
	[Neighborhoods] [FLOAT] NULL
) ON [PRIMARY]
GO


