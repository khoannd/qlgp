/****** Object:  Table [dbo].[DonationSession]    Script Date: 17/10/2016 10:42:37 CH ******/
DROP TABLE [dbo].[DonationSession]
GO

/****** Object:  Table [dbo].[DonationRank]    Script Date: 17/10/2016 10:42:37 CH ******/
DROP TABLE [dbo].[DonationRank]
GO

/****** Object:  Table [dbo].[Donation]    Script Date: 17/10/2016 10:42:37 CH ******/
DROP TABLE [dbo].[Donation]
GO

/****** Object:  Table [dbo].[Donation]    Script Date: 17/10/2016 10:42:37 CH ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Donation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParishionerID] [int] NOT NULL,
	[DonationLevel] [nvarchar](50) NULL,
	[CertificateID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[DonationRank]    Script Date: 17/10/2016 10:42:37 CH ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DonationRank](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [float] NOT NULL,
	[Level] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT [dbo].[DonationRank] ON 

GO
INSERT [dbo].[DonationRank] ([Id], [Value], [Level]) VALUES (2, 20000000, 1)
GO
INSERT [dbo].[DonationRank] ([Id], [Value], [Level]) VALUES (3, 50000000, 2)
GO
INSERT [dbo].[DonationRank] ([Id], [Value], [Level]) VALUES (4, 100000000, 3)
GO
INSERT [dbo].[DonationRank] ([Id], [Value], [Level]) VALUES (5, 500000000, 4)
GO
SET IDENTITY_INSERT [dbo].[DonationRank] OFF
GO
/****** Object:  Table [dbo].[DonationSession]    Script Date: 17/10/2016 10:42:37 CH ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DonationSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DonationDate] [date] NOT NULL,
	[ReceiptID] [nchar](10) NULL,
	[Note] [ntext] NULL,
	[DonationID] [int] NOT NULL,
	[Currency] [varchar](10) NOT NULL,
	[InputValue] [float] NOT NULL,
	[FinalValue] [float] NOT NULL,
	[ExchangeRate] [float] NOT NULL,
	[ReceiptDate] [char](8) NULL,
 CONSTRAINT [PK__tmp_ms_x__3214EC07E0522C65] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


