/****** Object:  Table [dbo].[Account]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[DioceseId] [int] NOT NULL,
	[ParishId] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Class]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[RoomNo] [nvarchar](50) NULL,
	[Year] [int] NOT NULL,
	[Note] [nvarchar](200) NULL,
	[ClassGroupId] [int] NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClassGroup]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Year] [int] NOT NULL,
	[Note] [nvarchar](200) NULL,
	[ManagedBy] [int] NULL,
	[ParishId] [int] NOT NULL,
 CONSTRAINT [PK_ClassGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClassMember]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassMember](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParishionerId] [int] NOT NULL,
	[ClassId] [int] NOT NULL,
	[Position] [int] NOT NULL,
	[IsDone] [bit] NOT NULL CONSTRAINT [DF_ClassMember_IsDone]  DEFAULT ((0)),
	[Note] [nvarchar](200) NULL,
 CONSTRAINT [PK_ClassMember] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Community]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Community](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_Community_IsDefault]  DEFAULT ((0)),
	[ParentId] [int] NULL,
	[ParishId] [int] NOT NULL,
 CONSTRAINT [PK_Community] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Configuration]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuration](
	[ParishId] [int] NOT NULL,
	[MultipleParishionerAdding] [int] NOT NULL CONSTRAINT [DF_Configuration_MultipleParishionerAdding]  DEFAULT ((0)),
	[ParishionerCodeGeneration] [int] NOT NULL CONSTRAINT [DF_Configuration_ParishionerCodeGeneration]  DEFAULT ((1)),
	[ParishionerPrefix] [nvarchar](50) NULL,
	[ParishionerCharacterNumber] [int] NOT NULL CONSTRAINT [DF_Configuration_CharacterNumber]  DEFAULT ((1)),
	[FamilyCodeGeneration] [int] NOT NULL CONSTRAINT [DF_Configuration_FamilyCodeGeneration]  DEFAULT ((1)),
	[FamilyPrefix] [nvarchar](50) NULL,
	[FamilyCharacterNumber] [int] NOT NULL CONSTRAINT [DF_Configuration_FamilyCharacterNumber]  DEFAULT ((1)),
	[BaptismTemplate] [nvarchar](max) NULL,
	[HolyCommunionTemplate] [nvarchar](max) NULL,
	[ConfirmationTemplate] [nvarchar](max) NULL,
	[MatrimonyTemplate] [nvarchar](max) NULL,
	[SacramentTemplate] [nvarchar](max) NULL,
 CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED 
(
	[ParishId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConstructionPermit]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConstructionPermit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PermitType] [int] NOT NULL,
	[ParishId] [int] NOT NULL,
	[Description] [nvarchar](500) NULL,
	[FilePath] [nvarchar](255) NULL,
	[PermitStatus] [int] NOT NULL,
	[Note] [text] NULL,
 CONSTRAINT [PK_BuildingPermit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChristianSuggestion]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChristianSuggestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ChristianSuggestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeaconRequisitionComment]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeaconRequisitionComment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [ntext] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[PriestId] [int] NULL,
	[ParishionerId] [int] NULL,
	[ParishId] [int] NOT NULL,
	[VocationDeaconRequisitionId] [int] NOT NULL,
 CONSTRAINT [PK_DeaconRequisitionComment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeaconRequisitionSession]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeaconRequisitionSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionName] [nvarchar](15) NOT NULL,
	[SessionCode] [nvarchar](15) NOT NULL,
	[Year] [datetime] NOT NULL,
	[DeadlineForPriest] [datetime] NOT NULL,
	[DeadlineForParish] [datetime] NULL,
	[Status] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[DeaconOrdinationMassParish] [nvarchar](255) NULL,
	[DeaconOrdinationMassTime] [datetime] NULL,
 CONSTRAINT [PK_RequestBecomeDeaconSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Diocese]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diocese](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](200) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[Website] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Bishop] [nvarchar](100) NULL,
	[Church] [nvarchar](100) NULL,
 CONSTRAINT [PK_Diocese] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Family]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Family](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [varchar](20) NULL,
	[Address] [nvarchar](100) NULL,
	[Note] [nvarchar](200) NULL,
	[DomicileStatus] [int] NOT NULL CONSTRAINT [DF_Family_DomicileStatus]  DEFAULT ((0)),
	[DomicilePlace] [nvarchar](100) NULL,
	[IsCounted] [bit] NOT NULL CONSTRAINT [DF_Family_IsCounted]  DEFAULT ((1)),
	[Status] [int] NOT NULL,
	[CommunityId] [int] NOT NULL,
 CONSTRAINT [PK_Family] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FamilyMember]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FamilyMember](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FamilyId] [int] NOT NULL,
	[ParishionerId] [int] NOT NULL,
	[Position] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[IsHouseholder] [bit] NOT NULL CONSTRAINT [DF_FamilyMember_IsHouseholder]  DEFAULT ((0)),
 CONSTRAINT [PK_FamilyMember] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FamilyMigrationRequest]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FamilyMigrationRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FamilyId] [int] NOT NULL,
	[ToParishId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[FromCommunityId] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_FamilyMigrationRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeneralStatus]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[GeneralStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
	[Key] [varchar](10) NOT NULL,
 CONSTRAINT [PK_GeneralStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LeaveVocationRequisition]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveVocationRequisition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VocationId] [int] NOT NULL,
	[ApplyDate] [datetime] NOT NULL,
	[EffectiveDate] [datetime] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_LeaveVocationRequisition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Matrimony]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Matrimony](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HusbandId] [int] NOT NULL,
	[WifeId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Number] [nvarchar](100) NULL,
	[Date] [char](8) NULL,
	[Place] [nvarchar](100) NULL,
	[Priest] [nvarchar](100) NULL,
	[FirstWitness] [nvarchar](100) NULL,
	[SecondWitness] [nvarchar](100) NULL,
	[Status] [int] NOT NULL,
	[Note] [nvarchar](200) NULL,
	[SacramentGroupId] [int] NULL,
 CONSTRAINT [PK_Matrimony] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Message]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[ParishId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Parish]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Parish](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[Website] [nvarchar](100) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[ImageUrl] [nvarchar](200) NULL,
	[Priest] [nvarchar](100) NULL,
	[VicariateId] [int] NOT NULL,
	[PriestId] [int] NULL,
	[Ward] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[Province] [nvarchar](100) NULL,
 CONSTRAINT [PK_Parish] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Parishioner]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Parishioner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[ImageUrl] [nvarchar](100) NULL,
	[ChristianName] [nvarchar](100) NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Gender] [int] NOT NULL,
	[BirthDate] [char](8) NULL,
	[BirthPlace] [nvarchar](100) NULL,
	[FatherName] [nvarchar](100) NULL,
	[MotherName] [nvarchar](100) NULL,
	[IsCounted] [bit] NOT NULL CONSTRAINT [DF_Parishioner_IsCounted]  DEFAULT ((1)),
	[Status] [int] NOT NULL,
	[DomicileStatus] [int] NOT NULL,
	[DomicilePlace] [nvarchar](100) NULL,
	[Education] [nvarchar](100) NULL,
	[IsStudying] [bit] NOT NULL CONSTRAINT [DF_Parishioner_IsStudying]  DEFAULT ((0)),
	[Career] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[Phone] [varchar](20) NULL,
	[MobilePhone] [varchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Note] [nvarchar](200) NULL,
	[IsCatechumen] [bit] NOT NULL CONSTRAINT [DF_Parishioner_IsCatechumen]  DEFAULT ((0)),
	[IsDead] [bit] NOT NULL CONSTRAINT [DF_Parishioner_IsDead]  DEFAULT ((0)),
	[DeadDate] [char](8) NULL,
	[IsMarried] [bit] NOT NULL CONSTRAINT [DF_Parishioner_IsMarried]  DEFAULT ((0)),
	[IsSingle] [bit] NOT NULL CONSTRAINT [DF_Parishioner_IsSingle]  DEFAULT ((0)),
	[CommunityId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](100) NULL,
	[LastUpdatedBy] [varchar](100) NULL,
 CONSTRAINT [PK_Parishioner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ParishionerMigrationRequest]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParishionerMigrationRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParishionerId] [int] NOT NULL,
	[ToParishId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[FromCommunityId] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_ParishionerMigrationRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ParishManager]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ParishManager](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParishId] [int] NULL,
	[PriestId] [int] NOT NULL,
	[StartDate] [varchar](8) NOT NULL,
	[EndDate] [varchar](8) NULL,
	[Position] [int] NULL,
	[PositionName] [nvarchar](50) NULL,
	[IdThuyenChuyenLinhMuc] [int] NULL,
	[TakenDate] [datetime] NULL,
	[StatusId] [int] NULL,
	[Code] [varchar](100) NULL,
 CONSTRAINT [PK_ParishManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlaceSuggestion]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaceSuggestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_PlaceSuggestion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Priest]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Priest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChristianName] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[BirthDate] [char](10) NULL,
	[DioceseId] [int] NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[ParishionerId] [int] NULL,
 CONSTRAINT [PK_Priest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReligiousCommunity]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReligiousCommunity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Type] [int] NOT NULL,
	[DirectorId] [int] NULL,
	[ViceDirectorId] [int] NULL,
 CONSTRAINT [PK_ReligiousCommunity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReligiousCommunityBase]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReligiousCommunityBase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReligiousCommunityId] [int] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[ParishId] [int] NULL,
	[IsHeadquarter] [nchar](10) NULL,
	[ManagerId] [int] NOT NULL,
 CONSTRAINT [PK_ReligiousCommunityBase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReligiousCommunityManagementTerm]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReligiousCommunityManagementTerm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VocationId] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[IsDirector] [bit] NULL,
	[ReligiousCommunityId] [int] NULL,
	[ReligiousCommunityBaseId] [int] NULL,
 CONSTRAINT [PK_ReligiousCommunityManagementTerm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sacrament]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sacrament](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SacramentGroupId] [int] NULL,
	[ParishionerId] [int] NOT NULL,
	[Number] [varchar](50) NULL,
	[Type] [int] NOT NULL,
	[Patron] [nvarchar](100) NULL,
	[Note] [nvarchar](100) NULL,
	[Date] [char](8) NULL,
	[Giver] [nvarchar](100) NULL,
	[ReceivedPlace] [nvarchar](100) NULL,
 CONSTRAINT [PK_Sacrament] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SacramentGroup]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SacramentGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [char](8) NULL,
	[Type] [int] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Giver] [nvarchar](100) NULL,
	[ReceivedPlace] [nvarchar](100) NULL,
	[ParishId] [int] NOT NULL,
 CONSTRAINT [PK_SacramentGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SeminaryYear]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeminaryYear](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StartAt] [datetime] NOT NULL,
	[EndAt] [datetime] NOT NULL,
	[SeminaryName] [nvarchar](255) NOT NULL,
	[SeminaryYearCode] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_SeminaryYear] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Society]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Society](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[EstablishedDate] [char](8) NULL,
	[ManagedBy] [int] NULL,
	[ParishId] [int] NOT NULL,
 CONSTRAINT [PK_Society] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SocietyMember]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocietyMember](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SocietyId] [int] NOT NULL,
	[ParishionerId] [int] NOT NULL,
	[Position] [int] NOT NULL,
	[Note] [nvarchar](200) NULL,
 CONSTRAINT [PK_SocietyMember] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThuyenChuyenLinhMuc]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ThuyenChuyenLinhMuc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NgayQuyetDinh] [varchar](8) NOT NULL,
	[NgayHieuLuc] [varchar](8) NOT NULL,
	[NguoiQuyetDinh] [nvarchar](200) NULL,
	[MoTa] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_ThuyenChuyenLinhMuc] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_VaiTro] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ValueSet]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ValueSet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[Definition] [ntext] NOT NULL,
	[Note] [nvarchar](200) NULL,
	[Category] [varchar](50) NOT NULL,
 CONSTRAINT [PK__ValueSet__3214EC07281F476D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vicariate]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vicariate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DioceseId] [int] NOT NULL,
	[ParishId] [int] NULL,
 CONSTRAINT [PK_Vicariate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vocation]    Script Date: 11/04/2016 10:30:41 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vocation](
	[ParishionerId] [int] NOT NULL,
	[Date1] [char](8) NULL,
	[Date2] [char](8) NULL,
	[Date3] [char](8) NULL,
	[Date4] [char](8) NULL,
	[Date5] [char](8) NULL,
	[Date6] [char](8) NULL,
	[Date7] [char](8) NULL,
	[Date8] [char](8) NULL,
	[Date9] [char](8) NULL,
	[Seminary] [nvarchar](100) NULL,
	[SeminaryAddress] [nvarchar](100) NULL,
	[Position] [int] NOT NULL,
	[ServedPlace] [nvarchar](100) NULL,
	[ServedAddress] [nvarchar](100) NULL,
	[Phone] [varchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[Note] [nvarchar](200) NULL,
	[IsLeft] [bit] NOT NULL CONSTRAINT [DF_Vocation_IsLeft]  DEFAULT ((0)),
 CONSTRAINT [PK_Vocation] PRIMARY KEY CLUSTERED 
(
	[ParishionerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VocationDeaconRequisitionSession]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VocationDeaconRequisitionSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VocationId] [int] NOT NULL,
	[DeaconRequisitionSessionId] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_VocationRequestBecomeDeaconSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VocationExchangeReligiousCommunityBase]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VocationExchangeReligiousCommunityBase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OldReligiousCommunityBaseId] [int] NOT NULL,
	[NewReligiousCommunityBaseId] [int] NOT NULL,
	[VocationId] [int] NOT NULL,
	[DecisionDate] [datetime] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
 CONSTRAINT [PK_VocationReligiousCommunityBaseDisplacement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VocationSeminaryYear]    Script Date: 12/04/2016 6:08:58 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VocationSeminaryYear](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VocationId] [int] NOT NULL,
	[SeminaryYearId] [int] NOT NULL,
	[ActualStart] [datetime] NOT NULL,
	[ActualEnd] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_VocationSeminaryYear] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (2, N'admin', N'e10adc3949ba59abbe56e057f20f883e', N'Minh Khôi', CAST(N'2014-10-02 00:00:00.000' AS DateTime), 1, 1, 1, NULL)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (3, N'manager', N'e10adc3949ba59abbe56e057f20f883e', N'Huỳnh Minh Khôi', CAST(N'2014-10-12 00:00:00.000' AS DateTime), 1, 2, 1, 1)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (4, N'teacher', N'e10adc3949ba59abbe56e057f20f883e', N'Minh Quân', CAST(N'2014-10-22 00:00:00.000' AS DateTime), 1, 4, 1, 1)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (5, N'staff', N'e10adc3949ba59abbe56e057f20f883e', N'Minh Thư', CAST(N'2014-11-01 00:00:00.000' AS DateTime), 1, 3, 1, 1)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (6, N'manager2', N'e10adc3949ba59abbe56e057f20f883e', N'Lương Quốc Trung', CAST(N'2014-11-04 10:25:03.030' AS DateTime), 1, 2, 1, 9)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (7, N'staff2', N'e10adc3949ba59abbe56e057f20f883e', N'Nguyễn Quốc Minh', CAST(N'2014-11-04 10:43:40.507' AS DateTime), 1, 3, 1, 8)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (9, N'staff3', N'e10adc3949ba59abbe56e057f20f883e', N'Phong Linh', CAST(N'2014-11-16 15:10:42.583' AS DateTime), 1, 3, 1, 3)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (10, N'teacher2', N'e10adc3949ba59abbe56e057f20f883e', N'Lê Trọng Cường', CAST(N'2014-11-16 15:12:27.113' AS DateTime), 1, 4, 1, 9)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (11, N'manager3', N'e10adc3949ba59abbe56e057f20f883e', N'Huỳnh Văn Hải', CAST(N'2014-11-25 08:49:50.140' AS DateTime), 1, 2, 1, 7)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (12, N'manager4', N'e10adc3949ba59abbe56e057f20f883e', N'Khôi', CAST(N'2014-11-28 09:56:33.137' AS DateTime), 1, 2, 1, 1)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (13, N'managertanphong', N'e10adc3949ba59abbe56e057f20f883e', N'Huỳnh Minh Tuấn', CAST(N'2014-11-28 16:18:27.000' AS DateTime), 1, 2, 1, 12)
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (14, N'managerquangtay', N'e10adc3949ba59abbe56e057f20f883e', N'Huỳnh Minh Tuấn', CAST(N'2014-11-28 17:08:21.620' AS DateTime), 1, 2, 1, 13)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([Id], [Name], [RoomNo], [Year], [Note], [ClassGroupId]) VALUES (1, N'Rửa tội', N'sadfsadf', 2014, N'ghi chú test', 1)
INSERT [dbo].[Class] ([Id], [Name], [RoomNo], [Year], [Note], [ClassGroupId]) VALUES (2, N'honphoi', N'123', 2014, NULL, 2)
INSERT [dbo].[Class] ([Id], [Name], [RoomNo], [Year], [Note], [ClassGroupId]) VALUES (3, N'Lop2014', NULL, 2014, NULL, 2)
SET IDENTITY_INSERT [dbo].[Class] OFF
SET IDENTITY_INSERT [dbo].[ClassGroup] ON 

INSERT [dbo].[ClassGroup] ([Id], [Name], [Year], [Note], [ManagedBy], [ParishId]) VALUES (1, N'Rửa tội A', 2014, N'test', NULL, 1)
INSERT [dbo].[ClassGroup] ([Id], [Name], [Year], [Note], [ManagedBy], [ParishId]) VALUES (2, N'Demo2014', 2014, N'abc', 134, 1)
SET IDENTITY_INSERT [dbo].[ClassGroup] OFF
SET IDENTITY_INSERT [dbo].[ClassMember] ON 

INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (1, 119, 1, 1, 0, N' ')
INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (2, 134, 2, 1, 0, N' ')
INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (3, 133, 2, 2, 1, N' ')
INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (4, 150, 2, 2, 0, N' ')
INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (5, 155, 2, 2, 1, N' ')
INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (6, 151, 3, 1, 0, N' ')
INSERT [dbo].[ClassMember] ([Id], [ParishionerId], [ClassId], [Position], [IsDone], [Note]) VALUES (7, 150, 3, 1, 0, N' ')
SET IDENTITY_INSERT [dbo].[ClassMember] OFF
SET IDENTITY_INSERT [dbo].[Community] ON 

INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (1, N'Ngoài xứ', 1, NULL, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (2, N'Đông Đường', 0, NULL, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (3, N'Đồng Lãng', 0, NULL, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (4, N'Tân Cường', 0, NULL, 2)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (5, N'Tích Thuận', 0, NULL, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (6, N'Tân Thuận', 0, NULL, 3)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (7, N'Đông Đông', 0, 2, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (8, N'Đông Tây', 0, 2, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (9, N'Đông Bắc', 0, 2, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (10, N'Đông Nam', 0, 2, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (11, N'Gia Định', 0, NULL, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (12, N'Mỹ Lợi', 0, NULL, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (13, N'Mỹ Lợi 1', 0, 12, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (14, N'Mỹ Lợi 2', 0, 12, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (15, N'Đồng Lân', 0, 3, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (16, N'Đồng Không', 0, 3, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (17, N'Đồng Tiến', 0, 3, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (19, N'Tích Tân', 0, 5, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (26, N'Tích Phong', 0, 5, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (27, N'Ngoài xứ', 1, NULL, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (28, N'Gia Phong', 0, NULL, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (29, N'Phong Gia', 0, 28, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (30, N'Phong Lưu', 0, 28, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (31, N'Ngoài xứ', 1, NULL, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (32, N'Quang Phú', 0, NULL, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (33, N'Tân Phong', 0, NULL, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (34, N'Tài Phong', 0, NULL, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (35, N'Quang Tây', 0, 32, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (36, N'Quang Đông', 0, 32, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (37, N'Gia Định 1', 0, 11, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (38, N'Gia Định 2', 0, 11, 9)
SET IDENTITY_INSERT [dbo].[Community] OFF
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (1, 0, 1, N'GXTN', 3, 1, N'GĐTN', 2, N'
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                       
                                       
                                       
                                       
                                       <p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Phận: <b>[TenGiaoPhan]</b> <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Hạt: &nbsp; &nbsp;<b>[TenGiaoHat]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Xứ: &nbsp;&nbsp;&nbsp;<b>[TenGiaoXu]</b> <o:p></o:p></span></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:16.0pt;
font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">CHỨNG CHỈ BÍ TÍCH<o:p></o:p></span></b></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Linh mục chánh xứ: <b>[TenLinhMucGui]</b>, giáo xứ: <b>[TenGiaoXu]<o:p></o:p></b></span></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">CHỨNG NHẬN<o:p></o:p></span></b></p><p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Anh (chị): &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[HoTen] </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Sinh ngày: &nbsp; &nbsp; &nbsp; &nbsp;<b>[NgaySinh] </b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b>[NoiSinh] </b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Con Ông: <b>&nbsp; &nbsp; &nbsp; &nbsp; [TenCha]</b> <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">và Bà:&nbsp; <b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [TenMe]</b>
<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">ĐÃ LÃNH NHẬN BÍ TÍCH RỬA
TỘI <o:p></o:p></span></b></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Ngày: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[NgayRuaToi]
</b>&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b>[NoiRuaToi]</b> &nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Do: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[ChaRuaToi]</b> <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Người đỡ đầu: &nbsp;<b>[NguoiDoDauRuaToi]
<o:p></o:p></b></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Sổ rửa tội số: &nbsp; &nbsp;<b>[SoRuaToi]</b> <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Làm
tại <b>[TenGiaoXu]</b>,<b> </b>[NgayThangNam]&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINH
MỤC PHỤ TRÁCH </span></b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Ký
tên và đóng dấu)&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt">



























































</p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [TenLinhMucGui]</span></b><o:p></o:p></p>
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    ', N'
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        <p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Phận: &nbsp;<b>[TenGiaoPhan]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Hạt: &nbsp; &nbsp;<b>[TenGiaoHat]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Xứ: &nbsp;&nbsp;&nbsp; <b>[TenGiaoXu]</b> <o:p></o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:16.0pt;
font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">CHỨNG CHỈ BÍ TÍCH<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Linh mục chánh xứ: <b>[TenLinhMucGui]</b>, giáo xứ: <b>[TenGiaoXu]<o:p></o:p></b></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">CHỨNG NHẬN<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Anh (chị): &nbsp; &nbsp; &nbsp;<b>[HoTen]
</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Sinh ngày: &nbsp; &nbsp;&nbsp;<b>[NgaySinh]
</b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại:&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[NoiSinh]
</b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Con Ông: <b>&nbsp; &nbsp; &nbsp; [TenCha]</b>
<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">và Bà:&nbsp; <b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;[TenMe]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:99.25pt"><b><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">ĐÃ LÃNH NHẬN BÍ TÍCH XƯNG TỘI VÀ RƯỚC LỄ LẦN ĐẦU<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Ngày: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b>[NgayRuocLe]
</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[NoiRuocLe] </b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Do: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[ChaRuocLe]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Sổ XTRL số:&nbsp;<b>[SoRuocLe]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Làm
tại <b>[TenGiaoXu]</b>,<b> </b>[NgayThangNam]&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINH
MỤC PHỤ TRÁCH </span></b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Ký
tên và đóng dấu)&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [TenLinhMucGui]</span></b><o:p></o:p></p>
                                        
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    ', N'
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        <p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Phận: &nbsp;<b>[TenGiaoPhan]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Hạt: &nbsp;&nbsp; <b>[TenGiaoHat]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Xứ: &nbsp;&nbsp;&nbsp; <b>[TenGiaoXu]</b> <o:p></o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:16.0pt;
font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">CHỨNG CHỈ BÍ TÍCH<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Linh mục chánh xứ: <b>[TenLinhMucGui]</b>, giáo xứ: <b>[TenGiaoXu]<o:p></o:p></b></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">CHỨNG NHẬN<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Anh (chị): &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[HoTen]
</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Sinh ngày: &nbsp; &nbsp; &nbsp; &nbsp;<b>[NgaySinh]
</b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b>[NoiSinh]
</b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Con Ông: <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [TenCha]</b>
<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">và Bà:&nbsp; <b>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [TenMe]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">ĐÃ LÃNH NHẬN BÍ TÍCH
THÊM SỨC<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Ngày: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>[NgayThemSuc] </b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>[NoiThemSuc] </b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Do: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<b>[ChaThemSuc]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:70.9pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Người đỡ đầu:  <b>[NguoiDoDauThemSuc]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Số thêm sức: &nbsp; <b>[SoThemSuc]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Làm
tại <b>[TenGiaoXu]</b>,<b> </b>[NgayThangNam]&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINH
MỤC PHỤ TRÁCH </span></b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Ký
tên và đóng dấu)&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [TenLinhMucGui]</span></b><o:p></o:p></p>
                                        
                                        
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    ', N'
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        <p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">Giáo Phận:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[TenGiaoPhan]<o:p></o:p></b></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">Giáo Hạt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[TenGiaoHat]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">Giáo Xứ:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[TenGiaoXu]</b><o:p></o:p></span></p><p class="MsoNormal" align="center" style="margin-top:0in;margin-right:0in;
margin-bottom:0in;margin-left:4.55pt;margin-bottom:.0001pt;text-align:center;
line-height:150%"><b><span style="font-size:16.0pt;line-height:150%;font-family:
" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";color:black"="">GIẤY
CHỨNG NHẬN KẾT HÔN</span></b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p></o:p></span></p><p class="MsoNormal" align="center" style="margin-top:0in;margin-right:0in;
margin-bottom:0in;margin-left:4.55pt;margin-bottom:.0001pt;text-align:center;
line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" align="center" style="margin-top:0in;margin-right:0in;
margin-bottom:0in;margin-left:4.55pt;margin-bottom:.0001pt;text-align:center;
line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Linh mục chánh xứ: <b>[TenLinhMucGui]</b><o:p></o:p></span></p><p class="MsoNormal" align="center" style="margin-top:0in;margin-right:0in;
margin-bottom:0in;margin-left:4.55pt;margin-bottom:.0001pt;text-align:center;
line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" align="center" style="margin-top:0in;margin-right:0in;
margin-bottom:0in;margin-left:4.55pt;margin-bottom:.0001pt;text-align:center;
line-height:150%"><b><span style="font-size:12.0pt;line-height:150%;font-family:
" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";color:black"="">CHỨNG
NHẬN<o:p></o:p></span></b></p><p class="MsoNormal" align="center" style="margin-top:0in;margin-right:0in;
margin-bottom:0in;margin-left:4.55pt;margin-bottom:.0001pt;text-align:center;
line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:269.35pt"><b><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">BÊN NAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BÊN
NỮ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:286.1pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:56.7pt 269.35pt 318.95pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">Anh:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[HoTenNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>Chị:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[HoTenNu]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:56.7pt 148.85pt 269.35pt 318.95pt 425.25pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">Sinh ngày: <b>[NgaySinhNam]&nbsp;&nbsp;&nbsp;&nbsp; </b>tại: <b>[NoiSinhNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>Sinh ngày:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[NgaySinhNu]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>tại: <b>[NoiSinhNu]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:56.7pt 148.85pt 269.35pt 318.95pt 425.25pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">RT ngày:&nbsp;&nbsp; <b>[NgayRuaToiNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>số: <b>[SoRuaToiNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>RT ngày:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[NgayRuaToiNu]&nbsp; </b>số: <b>[SoRuaToiNu]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:56.7pt 269.35pt 318.95pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">Con Ông:&nbsp;&nbsp; <b>[TenChaNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>Con
Ông:&nbsp; <b>[TenChaNu]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:56.7pt 269.35pt 318.95pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">và Bà:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[TenMeNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>và
Bà:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[TenMeNu]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:78.0pt 269.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">Thuộc giáo xứ: <b>[GiaoXuNam]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>Thuộc
giáo xứ: <b>[GiaoXuNu]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:.85in"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>ĐÃ LÃNH
NHẬN BÍ TÍCH HÔN PHỐI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 148.35pt 286.1pt 349.55pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ngày: <b>[NgayThangNamHP]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>Tại nhà thờ: <b>[NoiHonPhoi]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 224.95pt 328.4pt 349.55pt 363.3pt 394.05pt 424.75pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Trước mặt
Linh mục: <b>[LinhMucChung]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 224.95pt 244.95pt 264.95pt 286.1pt 307.25pt 328.4pt 349.55pt 363.3pt 394.05pt 424.75pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Và hai
nhân chứng:<o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 134.85pt 224.95pt 244.95pt 264.95pt 286.1pt 307.25pt 328.4pt 349.55pt 363.3pt 394.05pt 424.75pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.&nbsp; <b>[NguoiChung1]<o:p></o:p></b></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 134.85pt 224.95pt 244.95pt 264.95pt 286.1pt 307.25pt 328.4pt 349.55pt 363.3pt 394.05pt 424.75pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. &nbsp;<b>[NguoiChung2]</b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:148.35pt 244.95pt 286.1pt 363.3pt 394.05pt 424.75pt 455.45pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:148.35pt 244.95pt 286.1pt 363.3pt 394.05pt 424.75pt 455.45pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">Trích sổ hôn phối số: <b>[SoHonPhoi] <o:p></o:p></b></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:center 368.55pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Làm
tại <b>[TenGiaoXu]</b>, [NgayThangNam]<o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:center 368.55pt"><b><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINH
MỤC PHỤ TRÁCH</span></b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:center 368.55pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Ký
tên và đóng dấu)<o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 134.85pt 148.35pt 161.85pt 204.95pt 224.95pt 244.95pt 264.95pt 286.1pt 307.25pt 328.4pt 349.55pt 363.3pt 394.05pt 424.75pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:24.75pt 44.85pt .85in 134.85pt 148.35pt 161.85pt 204.95pt 224.95pt 244.95pt 264.95pt 286.1pt 307.25pt 328.4pt 349.55pt 363.3pt 394.05pt 424.75pt 455.45pt 480.35pt 500.35pt 520.35pt 540.35pt 560.35pt 580.35pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%">



































































</p><p class="MsoNormal" style="margin-top:0in;margin-right:0in;margin-bottom:0in;
margin-left:4.55pt;margin-bottom:.0001pt;line-height:150%;tab-stops:center 368.55pt"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<b>[TenLinhMucGui]</b><o:p></o:p></span></p>
                                        
                                        
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    ', N'
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        <p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Phận:  <b>[TenGiaoPhan]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Hạt: &nbsp; &nbsp;<b>[TenGiaoHat]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:56.7pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Giáo Xứ: &nbsp; &nbsp;<b>[TenGiaoXu]</b><o:p></o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:150%"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:16.0pt;
font-family:" times="" new="" roman","serif";mso-fareast-font-family:"times="" roman";="" color:black"="">CHỨNG CHỈ BÍ TÍCH<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Linh mục chánh xứ: <b>[TenLinhMucGui]</b>, giáo xứ: <b>[TenGiaoXu]<o:p></o:p></b></span></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">CHỨNG NHẬN<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-bottom:0in;margin-bottom:.0001pt;
text-align:center;line-height:normal"><b><span style="font-size:13.0pt;
mso-bidi-font-size:11.0pt;font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Anh (chị): &nbsp; &nbsp; &nbsp;&nbsp;<b>[HoTen]
</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Sinh ngày:&nbsp; &nbsp;&nbsp; <b>[NgaySinh]
</b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại:&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[NoiSinh]
</b>&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Con Ông: <b>&nbsp; &nbsp; &nbsp; [TenCha]</b>
<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">và Bà:&nbsp; <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [TenMe]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:63.8pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">ĐÃ LÃNH NHẬN BÍ TÍCH RỬA
TỘI <o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Ngày: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[NgayRuaToi] </b>&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[NoiRuaToi]</b> &nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Do: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[ChaRuaToi]</b> <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Người đỡ đầu: &nbsp;<b>[NguoiDoDauRuaToi]
<o:p></o:p></b></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Số rửa tội: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[SoRuaToi]</b></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><b><br></b></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt;"><span style="font-weight: 700;">ĐÃ LÃNH NHẬN BÍ TÍCH XƯNG TỘI VÀ RƯỚC LỄ LẦN ĐẦU<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt;"><span times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp;Ngày: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="font-weight: 700;">[NgayRuocLe]</span><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt;"><span times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp;Tại: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<span style="font-weight: 700;">[NoiRuocLe] &nbsp;&nbsp;</span><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt;"><span times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp;Do: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="font-weight: 700;">[ChaRuocLe]</span><o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt;"><span times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp;Sổ XTRL số: &nbsp; &nbsp;<span style="font-weight: 700;">[SoRuocLe]</span></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt;"><span times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"=""><span style="font-weight: 700;"><br></span></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">ĐÃ LÃNH NHẬN BÍ TÍCH
THÊM SỨC<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Ngày: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[NgayThemSuc] </b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Tại: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>[NoiThemSuc] </b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Do: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<b>[ChaThemSuc]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Người đỡ đầu: &nbsp;<b>[NguoiDoDauThemSuc]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;text-indent:
14.2pt;line-height:150%;tab-stops:85.05pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">Số thêm sức: &nbsp; &nbsp;<b>[SoThemSuc]</b><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Làm
tại <b>[TenGiaoXu]</b>,<b> </b>[NgayThangNam]&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
normal;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LINH
MỤC PHỤ TRÁCH </span></b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Ký
tên và đóng dấu)&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p><p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%"><span style="font-family:" times="" new="" roman","serif";mso-fareast-font-family:="" "times="" roman";color:black"=""><o:p><br></o:p></span></p>

<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
150%;tab-stops:center 311.85pt"><b><span style="font-family:" times="" new="" roman","serif";="" mso-fareast-font-family:"times="" roman";color:black"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [TenLinhMucGui]</span></b><o:p></o:p></p>
                                        
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    ')
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (9, 1, 1, N'GXAD', 2, 1, N'GĐAD', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (12, 0, 1, N'GXTP', 1, 1, N'GĐTP', 1, N'
                                        
                                    ', N'
                                        
                                    ', N'
                                        
                                    ', N'
                                        
                                    ', N'
                                        
                                    ')
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (13, 0, 1, N'GXQT', 1, 1, NULL, 1, N'
                                        
                                    ', N'
                                        
                                    ', N'
                                        
                                    ', N'
                                        
                                    ', N'ALO SDFSDF<div>[TenGiaoPhan]<br></div>')
SET IDENTITY_INSERT [dbo].[ConstructionPermit] ON 

INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (2, 2, 3, N'ssss', N'UploadFiles/Koala.jpg', 2, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (6, 2, 9, NULL, N'UploadFiles/NguThu Team.xlsx', 3, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (8, 1, 3, NULL, N'UploadFiles/Hydrangeas.jpg', 3, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (9, 1, 7, NULL, NULL, 2, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (10, 3, 1, N'aa', NULL, 3, N'aa')
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (13, 2, 3, N'22', N'UploadFiles/Yêu cầu cho nhóm Ngũ Thử.docx', 1, N'66')
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (14, 3, 3, NULL, NULL, 1, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (17, 2, 13, NULL, NULL, 1, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (19, 2, 13, NULL, NULL, 1, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (34, 1, 9, NULL, NULL, 1, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (39, 2, 8, NULL, NULL, 1, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (40, 3, 2, NULL, N'UploadFiles/Bảng mô tả yêu cầu của chương trình quản lý TGM.docx', 3, NULL)
SET IDENTITY_INSERT [dbo].[ConstructionPermit] OFF
SET IDENTITY_INSERT [dbo].[ChristianSuggestion] ON 

INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (1, N'Đaminh')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (2, N'Giuse')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (3, N'Mattheu')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (4, N'Phanxicô')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (5, N'Phaolô')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (6, N'Phêrô')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (7, N'Rosa')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (8, N'Gioakim')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (9, N'Phêrô Tự')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (10, N'Antôn')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (11, N'Anrê')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (12, N'Henricô')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (13, N'Luca')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (14, N'Simon')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (15, N'Tôma')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (16, N'Anna')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (17, N'Catarina')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (18, N'Clara')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (19, N'Inê')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (20, N'Maria')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (21, N'Lucia')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (22, N'Têrêsa')
INSERT [dbo].[ChristianSuggestion] ([Id], [Name]) VALUES (23, N'Vincentê')
SET IDENTITY_INSERT [dbo].[ChristianSuggestion] OFF
SET IDENTITY_INSERT [dbo].[Diocese] ON 

INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church]) VALUES (1, N'/Content/assets/avatars/giaophan.jpg', N'Hồ Chí Minh', N'12/4 Xô Viết Nghệ Tĩnh', N'www.toathanh.com.vn', N'0909 090 909', N'tuanhmsilver#abc@gmail.com', N'Đaminh Nguyễn Văn A', N'Toa nha Chanh xu')
INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church]) VALUES (2, N'/Content/assets/avatars/giaophan.jpg', N'Đà Lạt', N'aa', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Diocese] OFF
SET IDENTITY_INSERT [dbo].[Family] ON 

INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (3, N'MGĐTN01', N'Tuấn - Quân', N'0932044068', N'66/16 Tây H?', N'Nothing to do here', 0, NULL, 1, -1, 5)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (7, N'GĐTN01', N'Khôi - Tuấn', N'0932 044 023', N'66/16 ?p Ninh Bình Xã Ninh Thu?n', N'test ghi chú các b?n', 0, NULL, 0, 1, 8)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (10, N'GĐTN02', N'Khôi - Quân', N'0844 688 8741', N'128 Chung cu Lô A Lý Thu?ng Ki?t', N'ttttttt', 0, NULL, 1, -1, 9)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (11, N'GĐTN03', N'Mẫn - Thành', N'0838 463 2154', N'66/16 Xô Vi?t Ngh? Tinh', N'asdfasdfasdf', 0, NULL, 0, 1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (12, N'GĐTN04', N'Khôi - Mẫn Mẫn', N'0846 987 7796', N'test', N'asdasasdasdasd', 0, NULL, 1, -1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (17, N'GĐTN05', N'Khôi - Trung', N'0838 403 154', N'sdfsdfdsf65448', N'sdfsdfsdfasdfasdf', 0, NULL, 1, -1, 9)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (18, N'GĐTN06', N'Trung - Mai', NULL, N'test d?a ch? nhà', N'dfgdfgslkgjgjks;dfklg', 0, NULL, 1, -1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (19, N'GĐTN07', N'Phong - Phương', N'0838 403 248', N'66/16 XVNT', N'test ghi chu', 0, NULL, 1, -1, 8)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (20, N'GĐTN08', N'Lê - Mận', N'0838 403 624', N'123 Xô Vi?t Ngh? Tinh', N'test', 0, NULL, 1, -1, 8)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (21, N'GĐTN09', N'Mẫn - Vy', N'0838 402 4444', N'123 Lô A Quang Trung', N'test ghi chú', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (22, N'GĐTN10', N'Phong - Lê', N'0832 184 8787', N'123 XVNT Phong K?', N'sdafasdfasdfasdfasdf', 0, NULL, 1, 0, 9)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (23, N'GĐTN11', N'Mẫn - Lưu', N'0838 403 624', N'123123 AAAAa', N'test', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (24, N'GĐTN12', N'Phong - Lưu', N'0843 154 8787', N'sadfasdfasdfa', N'asdfasdfasdfasdf', 0, NULL, 1, 1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (25, N'GĐTN13', N'Mẫn - Lưu', N'0838 403 2454', N'66/16 Xô Vi?t Ngh? Tinh', N'sdfasfasdfasdfasdf', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (26, N'GĐTN14', N'Lê - Thanh', N'0834 848 487', N'qwerqwerqwerqwer', N'asdfasfasfafsdf', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (27, N'GĐTN15', N'Khôi - Mẫn', N'0838 465 215', N'66/16 Xô Vi?t Ngh? Tinh', N'test ghi chú nè', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (28, N'GĐTN16', N'Mẫn - Đạt', N'0838 403 2454', N'24234234', N'sadfasdfasdf', 0, NULL, 1, -1, 8)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (35, N'GĐTN17', N'Hậu - Vân', N'0832 165 484', N'66/16 Xô Vi?t Ngh? Tinh', N'asdasdasdadadadad', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (36, N'GĐTN18', N'Khanh - Đức', N'0932 232 323', N'66/16 Xô Vi?t Ngh? Tinh P.21 QBT', N'test ghi chú', 0, NULL, 1, 0, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (37, N'GĐTN19', N'Phong - Kim', N'0838 403 624', N'qwerqwrqwerqwer', N'test', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (38, N'GĐTN20', N'Khang - Phụng', N'0838 403 624', N'66/16 Hoàng Qu?c Vi?t', N'test ghi chú', 0, NULL, 1, 1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (39, N'GĐTN21', N'Phong - Vân', N'0838 403 624', N'66/15 Xô Vi?t Ngh? Tinh', N'093204423', 0, NULL, 1, -1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (40, N'GĐTN22', N'Phong - Lữ', N'0838 403 624', N'66/16 Xô Vi?t Ngh? Tinh', NULL, 0, NULL, 1, -1, 16)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (41, N'GĐTN23', N'Trung - Quốc', N'8038 403 624', N'123/A Lãng Ðông', NULL, 0, NULL, 1, 1, 17)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (42, N'GĐTN24', N'Lưu - Mẫn', N'0838 403 624', N'66/16 CMT8', N'ghi chú thông tin', 0, NULL, 1, 1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (43, N'GĐTN25', N'Lượng - Khối', N'0838 403 624', N'66/16 Xô Vi?t Ngh? Tinh', N'test ghi chú tuấn', 0, NULL, 1, 0, 19)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (44, N'GĐTN26', N'Văn - Quốc', N'0129 312 313', NULL, NULL, 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (45, N'GĐTN27', N'Phong - Lê', N'0932 040 423', N'66/16 Xô Vi?t Ngh? Tinh', N'test ghi chú', 0, NULL, 1, 1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (46, N'GĐTN28', N'Mẫn - Phương', N'0838 403 624', N'66/16 Ngô Tất Tố', N'Test thử ghi chú nha em', 0, NULL, 1, 1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (47, N'GĐTN29', N'Linh - Lực', N'0831 222 4444', N'123 Quang Trung Phường 10 Gò Vấp', N'test edit thông tin gia đình', 2, N'alo 123', 1, -1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (48, N'GĐTN30', N'Phong - Lưu', N'0838 403 624', N'123 Trần Quốc Lượng P 19. Q BT', N'asdfasdfasdfasdf', 0, NULL, 1, -1, 17)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (51, N'GĐTN31', N'Mẫn - Trung', N'0838 403 624', N'66/16 Lâm Phong', N'nhà này có nhiều hơn 1 người', 0, NULL, 1, 1, 15)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (52, N'GĐTN32', N'Phong - Ngữ', N'0846 321 5487', N'321 Trần Quốc Toản', N'test ghi chú về đây', 0, N'', 1, 1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (53, N'GĐTN33', N'Phương - Linh', N'0123 456 7897', N'123 BCDEF', N'test ghi chú abc def', 1, N'Thị Nghè', 1, 1, 14)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (54, N'GĐTN34', N'Tỉnh - Dung', N'0932 044 023', N'123/8 Hàm Nghi P.21 Q Phú Nhuận', N'Gia đình có 2 người đã bị chuyển xứ', 0, NULL, 1, -1, 17)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (55, N'GĐTN35', N'Phong - Lâm', N'0932 044 0423', NULL, NULL, 1, N'Thị Nghè', 1, 1, 11)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (56, N'GĐTN32', N'Vàng - Bạc', N'0932 204 4087', N'66/16 Xô Viết Nghệ Tĩnh', N'test ghi chú', 0, NULL, 1, 1, 15)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (57, N'GĐTN33', N'Kha - Lân', N'9032 404 4484', NULL, NULL, 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (58, N'GĐTN33', N'Linh - Phú', NULL, NULL, NULL, 0, NULL, 1, -1, 16)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (63, N'GĐTN33', N'Tấn - Mai', NULL, NULL, NULL, 0, NULL, 1, 0, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (64, N'GĐTN34', N'Minh - Phong', N'0932 044 023', N'123 Tô Hiến Thành', N'test ghi chú', 0, NULL, 0, 1, 9)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (65, N'GĐTN35', N'Cát - Vàng', NULL, NULL, NULL, 0, NULL, 1, 1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (66, N'GĐTN36', N'Linh - Vương', NULL, NULL, N'test ghi chú', 0, NULL, 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (67, N'GĐTN37', N'Phong - Lưu', N'0932 044 023', N'66/16 Xô Viết Nghệ Tĩnh', NULL, 0, N'thị nghè', 1, 1, 26)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (68, N'GĐTN38', N'Tân - Bình', N'0932 040 423', N'66/16 Xô Viết Nghệ Tĩnh', N'ABCDEF', 2, N'abcdef', 1, -1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (69, N'GĐTN38', N'Khôi - Tuấn', NULL, NULL, NULL, 0, N'', 1, 1, 11)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (70, N'GĐTN39', N'Phong - Lưu', N'0932 023 023', N'66/16 Xô Viết Nghệ Tĩnh', NULL, 0, N'', 1, 1, 11)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (71, N'GĐTN38', N'Khôi - Phụng', NULL, NULL, NULL, 0, NULL, 1, -1, 17)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (72, N'GĐTN39', N'Khôi - Phụng', NULL, NULL, NULL, 0, NULL, 1, -1, 17)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (73, N'GĐTN40', N'Khôi - Phụng', NULL, NULL, NULL, 0, NULL, 1, 1, 17)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (74, N'GĐTN41', N'Phong - Vân', N'0838 403 624', N'66/12A XVNT P.21 Quận Bình Thạnh', NULL, 0, NULL, 1, 1, 10)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (75, N'GĐTN42', N'Vân - Lan', NULL, NULL, NULL, 0, NULL, 1, 1, 26)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (76, N'GĐTN43', N'Thiên - Thu', NULL, NULL, NULL, 1, N'Thị Nghè', 1, 1, 13)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (77, N'GĐTN43', N'Nhã - Thanh', N'0838 422 3311', N'123 CMT8', NULL, 0, NULL, 1, 1, 7)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId]) VALUES (78, N'GĐTN44', N'Khôi - Thu', NULL, NULL, NULL, 0, NULL, 1, 1, 17)
SET IDENTITY_INSERT [dbo].[Family] OFF
SET IDENTITY_INSERT [dbo].[FamilyMember] ON 

INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (1, 3, 14, 1, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (2, 3, 15, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (6, 7, 119, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (7, 10, 106, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (8, 11, 115, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (9, 12, 104, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (10, 12, 103, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (11, 17, 107, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (12, 18, 106, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (13, 18, 125, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (14, 18, 104, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (15, 18, 116, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (16, 19, 111, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (17, 20, 125, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (18, 21, 111, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (19, 22, 63, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (20, 23, 125, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (21, 24, 61, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (22, 25, 39, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (23, 26, 119, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (24, 26, 79, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (25, 27, 115, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (26, 28, 122, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (27, 35, 111, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (28, 36, 106, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (29, 37, 74, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (30, 38, 74, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (31, 39, 25, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (32, 40, 25, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (33, 41, 25, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (34, 42, 116, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (35, 42, 56, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (36, 43, 82, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (37, 44, 105, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (38, 44, 104, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (39, 45, 79, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (40, 45, 71, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (41, 45, 100, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (42, 46, 98, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (43, 47, 99, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (44, 48, 101, 19, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (45, 51, 136, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (46, 47, 135, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (48, 51, 102, 8, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (49, 51, 78, 21, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (50, 48, 94, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (51, 52, 95, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (54, 52, 77, 21, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (55, 53, 104, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (56, 53, 5, 9, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (57, 53, 100, 19, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (59, 54, 93, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (60, 54, 139, 5, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (61, 54, 140, 8, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (62, 55, 60, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (63, 55, 5, 21, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (65, 52, 138, 6, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (66, 42, 138, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (67, 44, 138, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (68, 44, 101, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (69, 44, 135, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (70, 52, 124, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (71, 56, 144, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (74, 57, 122, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (75, 58, 12, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (76, 63, 84, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (77, 63, 73, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (78, 64, 112, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (79, 65, 31, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (80, 66, 122, 23, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (81, 66, 145, 7, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (82, 67, 147, 12, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (83, 66, 124, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (86, 67, 103, 18, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (87, 67, 153, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (88, 67, 93, 7, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (89, 67, 102, 3, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (90, 67, 150, 3, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (91, 66, 150, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (92, 67, 176, 6, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (93, 67, 177, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (94, 68, 76, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (95, 67, 180, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (96, 65, 93, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (97, 65, 180, 14, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (98, 69, 53, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (99, 70, 165, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (100, 70, 193, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (101, 70, 189, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (102, 67, 187, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (103, 71, 182, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (104, 71, 142, 3, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (105, 72, 182, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (106, 72, 142, 3, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (107, 73, 182, 23, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (108, 73, 142, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (110, 73, 179, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (111, 67, 188, 5, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (112, 73, 201, 5, 0, 0)
GO
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (113, 73, 203, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (114, 67, 203, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (115, 65, 201, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (116, 63, 203, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (118, 46, 201, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (119, 46, 203, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (120, 45, 201, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (121, 45, 203, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (122, 42, 203, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (123, 42, 201, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (124, 74, 205, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (125, 74, 206, 3, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (126, 41, 208, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (127, 75, 176, 2, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (128, 75, 208, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (129, 74, 209, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (130, 76, 209, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (131, 76, 207, 3, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (132, 77, 159, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (133, 77, 150, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (134, 75, 150, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (135, 77, 215, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (136, 74, 180, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (137, 74, 169, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (138, 74, 215, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (139, 74, 216, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (140, 56, 158, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (141, 56, 5, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (142, 56, 217, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (143, 51, 218, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (144, 77, 219, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (145, 78, 220, 23, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (146, 78, 221, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (147, 77, 222, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (148, 73, 222, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (149, 73, 54, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (150, 78, 93, 4, 0, 0)
SET IDENTITY_INSERT [dbo].[FamilyMember] OFF
SET IDENTITY_INSERT [dbo].[FamilyMigrationRequest] ON 

INSERT [dbo].[FamilyMigrationRequest] ([Id], [FamilyId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (1, 55, 9, CAST(N'2014-11-14 13:00:45.577' AS DateTime), 10, 2)
INSERT [dbo].[FamilyMigrationRequest] ([Id], [FamilyId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (2, 53, 9, CAST(N'2014-11-14 13:00:45.643' AS DateTime), 8, 2)
INSERT [dbo].[FamilyMigrationRequest] ([Id], [FamilyId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (9, 69, 9, CAST(N'2014-11-29 15:29:13.913' AS DateTime), 10, 2)
INSERT [dbo].[FamilyMigrationRequest] ([Id], [FamilyId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (10, 70, 9, CAST(N'2014-11-29 15:29:14.017' AS DateTime), 10, 2)
INSERT [dbo].[FamilyMigrationRequest] ([Id], [FamilyId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (13, 76, 9, CAST(N'2014-12-05 13:40:39.413' AS DateTime), 10, 2)
SET IDENTITY_INSERT [dbo].[FamilyMigrationRequest] OFF
SET IDENTITY_INSERT [dbo].[GeneralStatus] ON 

INSERT [dbo].[GeneralStatus] ([Id], [Status], [Key]) VALUES (1, N'Đã gởi giấy mời', N'TCLM')
INSERT [dbo].[GeneralStatus] ([Id], [Status], [Key]) VALUES (2, N'Đã gởi quyết định', N'TCLM')
INSERT [dbo].[GeneralStatus] ([Id], [Status], [Key]) VALUES (3, N'Đã nhận nhiệm vụ', N'TCLM')
SET IDENTITY_INSERT [dbo].[GeneralStatus] OFF
SET IDENTITY_INSERT [dbo].[Matrimony] ON 

INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (34, 121, 116, N'Trung - Mẫn', N'01224687998', N'20140714', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (36, 125, 118, N'Minh - Trinh', N'0932044023', N'20140424', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (37, 119, 118, N'Lữ - Trinh', N'0932040423', N'20140331', NULL, NULL, NULL, NULL, 2, N'test ghi chu', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (38, 119, 104, N'Lữ - Ngọc', N'0932044023', N'20141021', NULL, NULL, NULL, NULL, 2, N'test', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (39, 73, 94, N'Thánh - Lân', N'0963321548', N'19930200', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (40, 117, 113, N'Thái - Linh', N'0932044023', N'20141027', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (43, 119, 123, N'Lữ - Công', N'0963215455', N'20140928', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (44, 114, 95, N'Thanh - Vân', N'0123465487557', N'20141026', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (45, 115, 122, N'Tuấn - Kha', N'6546548484', N'20140831', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (46, 124, 104, N'Hưng - Ngọc', N'093210565578', N'20141028', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (47, 132, 130, N'Lãng - Phượng', N'09324056487', N'20141026', NULL, NULL, NULL, NULL, 4, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (48, 119, 127, N'Lữ - Phượng', N'0932045648', N'20141026', NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (51, 121, 110, N'Trung - Anh', N'09932165487', N'20141026', NULL, NULL, NULL, NULL, 5, N'test ghi chú', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (52, 124, 89, N'Hưng - Thanh', N'093204405648', N'20141027', NULL, NULL, NULL, NULL, 2, N'sdaasdfasdf', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (53, 103, 123, N'Cát - Công', N'0932044023', N'20141015', N'Hồ Chí Minh', N'Giuse Huỳnh Phong Vân', N'abc', N'def', 3, N'test hôn phối', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (54, 124, 5, N'Hưng - Linh', N'083246548787', N'19951000', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (55, 112, 116, N'Lưu - Mẫn', N'0912312312', N'20141027', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (56, 157, 12, N'Khôi - Linh', N'093284878787', N'20081018', NULL, NULL, NULL, NULL, 0, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (57, 158, 5, N'Phong - Linh', N'0993218487', N'20130802', NULL, NULL, NULL, NULL, 0, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (58, 159, 150, N'Thừa - Phụng', N'123456789', N'20140200', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (61, 160, 23, N'Tài - Trinh', N'09321848787', N'20141027', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (62, 107, 161, N'Phạm - Liên', N'01246879687', N'20131010', N'Tiền Giang', N'Giuse Huỳnh Phong Vân', N'Giuse Phong Vinh', N'Mattheu Phong Vũ', 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (63, 163, 94, N'Lâm - Lân', N'093204408787', N'20131001', NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (64, 166, 162, N'Long - Phú', N'09321548487', N'20141121', N'Tiền Giang', N'Đaminh Huỳnh Trọng Luân', N'Gioakim Huỳnh Minh Tuấn', N'Phanxicô Huỳnh Phúc Mẫn', 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (65, 147, 6, N'Long - Thư', N'HP13', N'20141104', N'Đồng Nai', N'Giuse Huỳnh Phong Vân', N'Rosa Huỳnh Minh Tuấn', N'Giuse Lê Minh Quân', 3, N'ertgfsfgsdfg', 5)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (66, 119, 89, N'Lữ - Thanh', N'0122416548', N'20141105', N'Tây Ninh', N'Đaminh Huỳnh Trọng Luân', NULL, NULL, 2, NULL, 6)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (67, 156, 97, N'Đạt - Vân', N'096321848787', N'20141111', NULL, NULL, NULL, NULL, 5, N'test test', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (70, 151, 102, N'Trấn - Thương', N'012345648787', N'20141027', NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (71, 156, 63, N'Đạt - Lê', N'093204423', N'20141103', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (72, 156, 131, N'Đạt - Linh', N'012336548787', N'19931002', NULL, NULL, NULL, NULL, 5, N'test ghi chú', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (73, 178, 179, N'Tuấn - Quân', N'01234878796', N'20141230', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (76, 111, 179, N'Tuấn - Quân', N'012315648787', N'19951220', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (78, 112, 161, N'Lưu - Liên', N'012365487', N'19951020', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (79, 114, 22, N'Thanh - Phượng', N'0126648787', N'20081020', NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (80, 180, 169, N'Thương - Ngọc', N'0123654878', N'20141104', N'Hồ Chí Minh', N'Giuse Huỳnh Phong Vân', N'Đaminh Đỗ Thành Tài', N'Maria Thanh Loan', 2, N'pms', 5)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (81, 187, 20, N'Nhật - Hồng', N'099123123', N'20141128', N'Nha Trang', N'Giuse Huỳnh Phong Vân', N'Giuse Nguyễn Linh Vân', N'Đaminh Phong Nguyễn Thanh', 3, N'abc', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (82, 188, 98, N'Khôi - Phương', N'0123155', N'20141102', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (83, 190, 191, N'Quân - Linh', N'09123123123', N'20141128', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (84, 192, 191, N'Phú - Linh', N'09998123123', N'20141113', NULL, NULL, NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (85, 193, 93, N'Lưu - Hà', N'093230123123', N'20141118', NULL, NULL, NULL, NULL, 2, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (86, 180, 141, N'Thương - Nữ', N'0123648878', N'20091123', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (87, 196, 197, N'Vendetta - Uyên', N'HP13', N'20141130', N'Hồ Chí Minh', N'Phêrô Trương Tấn Trọng', N'Violet', N'Rose', 1, N'Ruby', 8)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (88, 198, 199, N'Phi - Pumpa', NULL, N'20141130', N'Hồ Chí Minh', N'Phêrô Trương Tấn Trọng', NULL, NULL, 5, NULL, 8)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (89, 200, 201, N'Cleric - Saint', NULL, N'20141105', N'Tây Ninh', N'Đaminh Huỳnh Trọng Luân', NULL, NULL, 5, NULL, 6)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (90, 195, 83, N'Giả - Ngọc', N'013', N'20141104', N'Hồ Chí Minh', N'Giuse Huỳnh Phong Vân', N'violet', N'rosa', 1, NULL, 5)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (92, 177, 194, N'Thành - Hải', NULL, N'20141130', N'Hồ Chí Minh', N'Phêrô Trương Tấn Trọng', NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (96, 16, 201, N'Khôi - Saint', N'01236487878', N'19931020', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (97, 203, 201, N'Đại - Saint', N'01236548487', N'19941020', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (98, 205, 206, N'Phong - Vân', N'01234446879', N'19900716', N'Đông Nam', N'Antôn Nguyễn Văn Trung', N'Giuse Huỳnh Tấn Phát', N'Rosa Phạm Ngọc Linh', 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (100, 176, 208, N'Vân - Lan', N'0912344123123', N'20141200', N'Đông Nam', N'Giuse Huỳnh Phong Vân', NULL, NULL, 2, N'test', 12)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (101, 209, 207, N'Thiên - Thu', N'012345123', N'20121002', N'Đông Nam', N'Giuse Huỳnh Phong Vân', NULL, NULL, 1, NULL, 16)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (102, 200, 210, N'Cleric - Linh', N'0123654848', N'20141201', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (103, 211, 97, N'Quang - Vân', N'01234564878', N'19931020', NULL, NULL, NULL, NULL, 1, N'test', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (104, 211, 142, N'Quang - Phụng', N'012365465487', N'19931020', NULL, NULL, NULL, NULL, 5, N'test', NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (105, 211, 212, N'Quang - Linh', N'01236546548', N'20141203', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (106, 213, 95, N'Mỹ - Vân', N'01233654654', N'20051020', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (107, 214, 54, N'Quân - Lâm', N'1236546548', N'20141210', NULL, NULL, NULL, NULL, 5, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (108, 214, 168, N'Quân - Đổi', N'012336548', N'20091211', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (109, 220, 221, N'Khôi - Thu', N'012316546548', N'20141104', N'Hồ Chí Minh', N'Giuse Huỳnh Phong Vân', NULL, NULL, 5, NULL, 5)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (115, 222, 100, N'Lai - Linh', N'321321654654', N'20141215', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Matrimony] ([Id], [HusbandId], [WifeId], [Name], [Number], [Date], [Place], [Priest], [FirstWitness], [SecondWitness], [Status], [Note], [SacramentGroupId]) VALUES (116, 164, 207, N'Phú - Thu', N'12321651654', N'20141203', NULL, NULL, NULL, NULL, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Matrimony] OFF
SET IDENTITY_INSERT [dbo].[Message] ON 

INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (1, 2, 1, CAST(N'2014-11-28 09:05:50.853' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (2, 2, 2, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (3, 2, 3, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (4, 2, 5, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (5, 2, 6, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (6, 2, 7, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (7, 2, 8, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (8, 2, 9, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (9, 2, 10, CAST(N'2014-11-28 09:05:50.870' AS DateTime), N'Thư chào!', N'Kính gửi linh mục các xứ!<br>Tôi tên là Giuse Huỳnh Minh Tuấn, từ hôm nay tôi sẽ trở thành giám mục quản lý giáo phận Hồ Chí Minh.<br>Rất mong nhận được sự hợp tác và hỗ trợ của các vị.<br>Tôi xin chân thành cảm ơn!<br>Thân,<br>Tuan')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (11, 3, 9, CAST(N'2014-12-14 23:42:08.250' AS DateTime), N'Hệ thống: Thông tin hôn phối', N'Giáo dân Anrê Đỗ Thị Lai thuộc Giáo xứ Thị Nghè vừa thêm hôn phối với giáo dân Rosa Huỳnh Phúc Linh thuộc giáo xứ của bạn')
INSERT [dbo].[Message] ([Id], [AccountId], [ParishId], [CreatedDate], [Title], [Content]) VALUES (12, 6, 1, CAST(N'2014-12-14 23:43:51.473' AS DateTime), N'Hệ thống: Thông tin hôn phối', N'Giáo dân Maria Lê Minh Thu thuộc Giáo xứ Bình Lợi vừa thêm hôn phối với giáo dân Đaminh Huỳnh Phong Phú thuộc giáo xứ của bạn')
SET IDENTITY_INSERT [dbo].[Message] OFF
SET IDENTITY_INSERT [dbo].[Parish] ON 

INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (1, N'Thị Nghè', N'66/16 XVNT', N'www.gxthinghe.com', N'0935 484 8777', N'gxthinghe@gmail.com', N'/Images/Parishes/9ae8b05d-f25b-4582-b156-0faf22627f08.jpg', N'Giuse Đỗ Trọng Cát', 1, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (2, N'Bạch Đằng', N'ABC', N'www.abc.com', N'6546548', N'gxabc@gmail.com', N'abc', N'Antôn Đỗ Văn Thanh', 1, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (3, N'Tân Bình', N'abc', N'www.abc.com', N'0932 045 656', N'khoihm93@gmail.com', NULL, NULL, 1, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (5, N'Tân Định', N'asdfasdfasdf', N'www.abc.com', N'0936 426 5484', N'khoihm@gmail.com', NULL, NULL, 2, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (6, N'Bình Tân', N'sdfsdfasdf', N'www.apapa.com', N'1231 231 2312', N'khoihm@gmail.com', NULL, NULL, 2, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (7, N'Thủ Đức', N'asdfasdfasdf', N'www.123123.com', N'1234 234 2342', N'asdsdfsdf@yahoo.com', NULL, NULL, 4, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (8, N'Phú Nhuận', N'qwerqwerqwer', N'www.1234902348.com', N'2342 342 3423', N'khoihm93@gmail.com', NULL, NULL, 4, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (9, N'Bình Lợi', N'65 An Dương Vương', N'www.gxbinhloi.com', N'0965 465 4848', N'gxbinhloi@gmail.com', NULL, N'Gioakim Huỳnh Phúc Mẫn', 4, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (10, N'Thuận An', N'sdafaskl;dfjasldfjk', N'www.123123.com', N'2903 409 2384', N'khoihm@gmail.com', NULL, NULL, 5, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (12, N'Tân Phong', N'66/16 Xô Viết Nghệ Tĩnh', N'www.tanbinh.com', N'0838 402 634', N'tanbinh@gmail.com', N'/Images/Parishes/7499919f-9642-430f-a639-d276e2843a8b.jpg', N'Phêrô Trương Tấn Trọng', 6, NULL, N'', N'', N'')
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province]) VALUES (13, N'Quang Tây', N'126 Tô Ký', N'www.quangtay.com', N'0843 434 343', N'quangtay@gmail.com', N'/Images/Parishes/1a639e4e-21ef-4531-a26f-1a603a091f02.jpg', N'Antôn Nguyễn Văn Trung', 7, NULL, N'', N'', N'')
SET IDENTITY_INSERT [dbo].[Parish] OFF
SET IDENTITY_INSERT [dbo].[Parishioner] ON 

INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (3, N'MGD001', NULL, N'Đaminh', N'Huỳnh Minh Khôi', 1, N'19930302', N'HCM', N'Huỳnh Văn Hải', N'Nguyễn Thị Thanh Phi', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'1900-01-23 00:00:00.000' AS DateTime), NULL, N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (5, N'MGD002', NULL, N'Antôn', N'Huỳnh Ánh Linh', 0, N'19901200', N'Đồng Nai', N'Huỳnh Văn A', N'Nguyễn Thị B', 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'1900-01-23 00:00:00.000' AS DateTime), NULL, N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (6, N'MGD003', NULL, N'Gioakim', N'Huỳnh Minh Thư', 0, N'19970700', N'Hồ Chí Minh', N'Huỳnh Văn Hải', N'Nguyễn Thị Thanh Phi', 1, 1, 0, N'', N'Cấp II', 0, N'Học sinh', N'66/16 Xô Viết Nghệ Tĩnh', N'0838 403 624', N'0932 646 487', N'minhthu@gmail.com', NULL, 0, 0, N'        ', 1, 0, 9, CAST(N'2014-10-10 00:46:48.027' AS DateTime), NULL, N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (7, N'MGD004', NULL, N'Giuse', N'Huỳnh Văn Hải', 1, N'19980800', N'Hồ Chí Minh', N'Huỳnh Văn Thành', N'Nguyễn Thị Ngọc', 1, 1, 0, NULL, N'Đại học', 0, N'Nhân viên', N'66/16 Xô Viết Nghệ Tĩnh', N'0838 403 624', N'0932 040 423', N'vanhai@gmail.com', NULL, 0, 0, N'        ', 0, 0, 3, CAST(N'2014-10-10 00:49:17.060' AS DateTime), NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (8, N'MGD005', NULL, N'Phaolô', N'Lê Minh Quang', 1, N'20011224', N'Đồng Nai', N'Lê Văn A', N'Nguyễn Thị C', 1, 1, 0, N'', N'Đại học', 1, N'Sinh viên', N'66/15 Lô 2A', N'0836 487 984', N'0932 168 478', N'leminhquang@gmail.com', N'Test ghi chú', 1, 0, N'        ', 0, 1, 3, CAST(N'2014-10-10 01:06:20.140' AS DateTime), NULL, N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (12, N'MGD006', NULL, N'Phanxicô', N'Nguyễn Thị Ngọc Linh', 0, N'19980000', N'Hồ Chí Minh', N'Nguyễn Thanh Long', N'Hồ Ngọc Phương', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 16, CAST(N'2014-10-11 09:32:31.960' AS DateTime), NULL, N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (13, N'MGD004', NULL, N'Phêrô Tự', N'Huỳnh Ánh Lâm', 1, N'20141015', N'Hồ Chí Minh', N'Giuse Huỳnh Văn Hải', N'Gioakim Huỳnh Minh Thư', 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-13 13:23:20.500' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (14, N'MGD003', NULL, N'Giuse', N'Huỳnh Quang Khải', 1, N'20141001', N'Tây Ninh', N'Đaminh Huỳnh Minh Khôi', N'Antôn Huỳnh Ánh Linh', 0, 1, 0, NULL, N'Cấp II', 0, N'Buôn bán', NULL, N'0839 464 8621', N'0932 040 423', NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-13 13:36:24.397' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (15, N'MGD005', NULL, N'Giuse', N'Huỳnh Anh Tuấn', 1, N'20141008', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', N'Antôn Huỳnh Ánh Linh', 1, 1, 0, NULL, N'Cấp III', 0, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-13 16:39:45.027' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (16, N'MGD006', NULL, N'Giuse', N'Huỳnh Minh Khôi', 1, N'20141016', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', N'Antôn Huỳnh Ánh Linh', 1, 0, 2, N'deffff', N'Cấp II', 0, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh', NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 33, CAST(N'2014-10-13 16:41:05.763' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (20, N'MGD007', NULL, N'Gioakim', N'Huỳnh Minh Hồng', 0, N'20140510', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 2, CAST(N'2014-10-14 09:01:25.830' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (21, N'MGD008', NULL, N'Giuse', N'Huỳnh Minh Tuấn', 1, N'20141200', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, N'0932 040 423', N'0838 403 624', N'khoihm@gmail.com', NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-14 09:21:56.880' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (22, N'MGD009', NULL, N'Giuse', N'Huỳnh Ngọc Phượng', 0, N'20140101', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, N'khoihm@gmail.com', NULL, 0, 0, N'        ', 1, 0, 2, CAST(N'2014-10-14 09:38:58.277' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (23, N'MGD010', NULL, N'Gioakim', N'Huỳnh Tú Trinh', 0, N'20141200', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 8, CAST(N'2014-10-14 09:41:20.810' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (25, N'MGD012', NULL, N'Gioakim', N'Huỳnh Lâm Phong', 1, N'20141008', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-10-14 09:43:30.167' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (27, N'MGD013', NULL, N'Phaolô', N'Lương Quốc Trung', 1, N'19930308', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 8, CAST(N'2014-10-14 10:56:39.027' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (28, N'MGD014', NULL, N'Gioakim', N'Lương Bằng Quang', 1, N'19960000', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-14 10:57:15.443' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (29, N'MGD015', NULL, N'Rosa', N'Lương Mộng Hảo', 0, N'        ', NULL, N'Giuse Huỳnh Minh Tuấn', N'Giuse Huỳnh Ngọc Phượng', 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-14 10:58:28.827' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (31, N'MGD016', NULL, N'Mattheu', N'Lương Trọng Cát', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-14 11:06:25.250' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (32, N'MGD017', NULL, N'Mattheu', N'Gia Cát Trọng', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-14 11:11:38.010' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (33, N'MGD018', NULL, N'Phêrô', N'Huỳnh Ngọc Long', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-19 15:49:27.850' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (36, N'1', NULL, N'Rosa', N'Nguyễn Thị Thanh Hằng', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-19 15:55:54.053' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (37, N'2', NULL, N'Gioakim', N'Nguyễn Thị Thanh Phương', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2014-10-19 15:56:22.313' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (38, N'3', NULL, N'Phaolô', N'Huỳnh Thanh Tuấn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2014-10-19 15:59:21.533' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (39, N'4', NULL, N'Giuse', N'Huỳnh Lam Ngọc', 0, N'20141009', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-19 16:46:44.627' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (40, N'5', NULL, N'Giuse', N'Huỳnh Thanh Hải', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-19 17:19:46.293' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (41, N'6', NULL, N'Đaminh', N'Võ Văn Phú', 1, N'        ', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-19 17:20:15.003' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (48, N'7', NULL, N'Giuse', N'Huỳnh Ngọc Long', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-19 17:39:49.690' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (49, N'8', NULL, N'Antôn', N'Phan Đăng Cường', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-19 17:40:20.960' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (50, N'9', NULL, N'Rosa', N'Lê Thị Hà', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-19 17:40:45.473' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (51, N'10', NULL, N'Rosa', N'Đỗ Thị Hường', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-19 17:41:05.100' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (52, N'11', NULL, N'Giuse', N'Huỳnh Ngọc Quang', 1, N'19911020', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-19 17:46:50.693' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (53, N'GXTN1', NULL, NULL, N'Huỳnh Minh Khôi', 1, N'20141022', NULL, N'Phêrô Huỳnh Ngọc Long', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, N'', N'Cấp II', 0, N'Nhân viên', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 11, CAST(N'2014-10-20 09:58:17.947' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (54, N'GXTN2', NULL, N'Têrêsa', N'Huỳnh Ngọc Lâm', 0, N'19961108', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-10-20 10:14:10.280' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (55, N'GXTN3', NULL, N'Phanxicô', N'Phan Xích Lân', 1, N'19501200', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-20 10:14:47.600' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (56, N'GXTN4', NULL, N'Giuse', N'Huỳnh Thanh Lân', 1, N'19931223', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-20 10:42:54.453' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (57, N'GXTN5', NULL, NULL, N'Phan Ngọc Long', 1, N'20141022', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-20 12:49:14.830' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (58, N'GXTN6', NULL, N'Mattheu', N'Ngọc Hân', 0, N'19931200', NULL, N'Phanxicô Huỳnh Ngọc Lâm', N'Gioakim Huỳnh Minh Hồng', 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-20 14:14:38.390' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (59, N'GXTN7', NULL, NULL, N'Huỳnh Công Đức', 1, N'19930000', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-21 08:50:47.327' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (60, N'GXTN8', NULL, NULL, N'Huỳnh Minh Phong', 1, N'20140800', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 11, CAST(N'2014-10-21 09:59:51.923' AS DateTime), N'manager', N'manager2')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (61, N'GXTN9', NULL, N'Mattheu', N'Huỳnh Văn Lượng', 1, N'20141006', N'Tiền Giang', N'Đaminh Huỳnh Minh Khôi', N'Giuse Huỳnh Ngọc Phượng', 1, 1, 0, NULL, N'Trung học', 0, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', N'0965 248 484', N'khoihm93@gmail.com', N'Ghi chu', 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-23 10:09:17.993' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (62, N'GXTN10', NULL, N'Phêrô', N'Gia Cát Biển', 1, N'20141022', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Giuse Huỳnh Ngọc Phượng', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-23 10:11:32.667' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (63, N'GXTN11', NULL, N'Gioakim', N'Huỳnh Thị Hồng Lê', 0, N'19701100', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-10-23 12:30:10.207' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (64, N'GXTN12', NULL, N'Phêrô Tự', N'Bùi Thị Thu', 1, N'19981000', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-23 12:32:04.740' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (65, N'GXTN13', NULL, N'Phêrô Tự', N'Bùi Thị Đông', 0, N'19910700', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-23 12:32:29.450' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (66, N'GXTN14', NULL, N'Phêrô Tự', N'Lưu Lượng', 1, N'19951019', N'Tiền Giang', N'Giuse Huỳnh Minh Tuấn', N'Gioakim Huỳnh Minh Thư', 1, 1, 0, NULL, N'Trung học', 1, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh Phường 21', N'0838 403 624', N'0932 044 023', N'khoihm93@gmail.com', N'ABC', 1, 0, N'        ', 0, 1, 3, CAST(N'2014-10-24 09:21:00.500' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (67, N'GXTN15', NULL, N'Mattheu', N'Phan Văn Tự', 1, N'19980800', N'Đồng Nai', N'Giuse Huỳnh Minh Tuấn', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, NULL, N'Cấp III', 0, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh', NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-24 09:24:33.983' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (68, N'GXTN16', NULL, N'Giuse', N'Huỳnh Phong Lưu', 1, N'19960000', N'Đồng Nai', N'Giuse Huỳnh Minh Tuấn', N'Gioakim Huỳnh Minh Hồng', 1, 1, 0, N'', N'Cấp II', 0, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 400 423', N'0835 465 4654', N'khoihm93@gmail.com', N'asdfasdfasdfasdfasd', 1, 0, N'        ', 0, 1, 5, CAST(N'2014-10-24 09:26:31.547' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (69, N'GXTN17', NULL, N'Giuse', N'Huỳnh Lộc Lộc', 1, N'19941018', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Gioakim Huỳnh Minh Hồng', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-25 12:36:28.783' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (70, N'GXTN18', NULL, N'Phaolô', N'Huỳnh Ngọc Phú', 1, N'19951110', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-25 14:55:15.540' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (71, N'GXTN19', NULL, N'Mattheu', N'Huỳnh Minh Kha', 1, N'19941200', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Gioakim Huỳnh Minh Thư', 1, 1, 0, N'', N'Cấp III', 0, N'Nhân viên', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 040 423', N'0843 546 484', N'khoihm93@gmail.com', N'KhoihM', 0, 0, N'        ', 0, 1, 15, CAST(N'2014-10-26 08:36:19.720' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (72, N'GXTN20', NULL, N'Giuse', N'a', 1, N'20141014', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-26 09:42:07.750' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (73, N'GXTN21', NULL, N'Mattheu', N'Huỳnh Văn Thánh', 1, N'19911000', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', N'Gioakim Nguyễn Thị Thanh Phương', 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 11, CAST(N'2014-10-26 09:42:55.957' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (74, N'GXTN22', NULL, N'Gioakim', N'Huỳnh Gia Cát Tấn', 1, N'20140928', N'Đồng Nai', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-26 09:51:56.090' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (75, N'GXTN23', NULL, N'Gioakim', N'Phan Ngọc Long', 1, N'19981000', N'Tiền Giang', N'Đaminh Huỳnh Minh Khôi', NULL, 1, 1, 0, NULL, N'Trên Đại học', 1, N'Công nhân', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-26 09:57:27.853' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (76, N'GXTN24', NULL, N'Phêrô Tự', N'Phan Ngọc Lâm Tuấn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', N'Cấp III', 1, N'Nông dân', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-26 09:58:47.370' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (77, N'GXTN25', NULL, N'Giuse', N'Huỳnh Lâm Phan', 1, N'19981220', N'Tiền Giang', NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141116', 0, 1, 7, CAST(N'2014-10-26 10:09:49.843' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (78, N'GXTN26', NULL, N'Giuse', N'Huỳnh Cảm Tử', 1, N'20140928', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, N'66/16 Lâm Phong', N'0838 403 624', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-10-26 15:28:10.070' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (79, N'GXTN27', NULL, N'Mattheu', N'Huỳnh Cảm Biến Thịnh', 1, N'20141006', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-26 15:28:39.510' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (80, N'GXTN28', NULL, N'Antôn', N'Phan Ngọc Hành', 0, N'20141006', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141009', 0, 1, 5, CAST(N'2014-10-26 15:29:14.427' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (81, N'GXTN29', NULL, N'Phêrô Tự', N'Huỳnh Quốc Phương', 1, N'19930302', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Phanxicô Nguyễn Thị Ngọc Linh', 0, 1, 1, N'Lâm Đồng', N'Cao đẳng', 1, N'Thiết kế đồ họa', N'66/1A Lô B', N'0838 403 624', N'0932 040 423', N'phuong@yahoo.com', N'Test thử ghi chú
ABC', 1, 0, N'        ', 0, 1, 5, CAST(N'2014-10-26 17:30:39.387' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (82, N'GXTN30', NULL, N'Gioakim', N'Huỳnh Minh Lương', 1, N'19931224', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, N'        ', 1, 1, 26, CAST(N'2014-10-26 17:50:41.073' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (83, N'GXTN31', NULL, N'Phanxicô', N'Nguyễn Thị Khánh Ngọc', 0, N'19930308', N'Hồ Chí Minh', N'Giuse Huỳnh Thanh Lân', N'Giuse Huỳnh Lam Ngọc', 1, 1, 1, N'Gia Lai', N'Trung học', 1, N'Buôn bán', N'12A Nguyễn Huệ', N'0838 403 624', N'0932 040 423', N'khoihm93@gmail.com', N'Test thử chức năng load edit
Test xuống hàng', 0, 0, N'        ', 1, 0, 3, CAST(N'2014-10-26 23:27:01.990' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (84, N'GXTN32', NULL, N'Đaminh', N'Huỳnh Tấn Tài', 1, N'19940623', N'Tiền Giang', N'Giuse Huỳnh Tấn Tài', N'Rosa Nguyễn Thị Thanh Hằng', 1, 1, 0, N'', N'Đại học', 1, N'Công nhân', N'123 Ngô Tất Tố', N'0838 403 6555', N'0923 040 432', N'taitai@gmail.com', N'Test edit giáo dân
Test thử xuống hàng', 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-27 14:42:14.627' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (85, N'GXTN33', NULL, N'Mattheu', N'Huỳnh Nhơn Lộc', 1, N'19931223', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-27 17:31:37.193' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (86, N'GXTN34', NULL, N'Phaolô', N'Ngô Văn Thành', 1, N'19930502', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-27 17:33:35.113' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (87, N'GXTN35', NULL, N'Phêrô Tự', N'Tạ Vĩnh Nhân', 1, N'19930504', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-27 17:34:04.090' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (88, N'GXTN36', NULL, N'Gioakim', N'Huỳnh Văn Kháng', 1, N'20141007', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-27 17:36:39.087' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (89, N'GXTN37', NULL, N'Phanxicô', N'Huỳnh Văn Thanh', 0, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141112', 1, 0, 17, CAST(N'2014-10-27 17:37:30.123' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (90, N'GXTN38', NULL, N'Giuse', N'Lê Văn Vàng', 1, N'20140928', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-27 17:44:12.820' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (91, N'GXTN39', NULL, N'Giuse', N'Văn Phong Thành', 1, N'20141005', N'Tiền Giang', N'Phaolô Lê Minh Quang', N'Rosa Lương Mộng Hảo', 1, 1, 0, N'', N'Cấp I', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:20:28.897' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (92, N'GXTN40', NULL, N'Phanxicô', N'Phan Xích Văn', 1, N'19930303', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-28 08:22:03.063' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (93, N'GXTN41', NULL, N'Mattheu', N'Huỳnh Ngọc Hà', 0, N'20140811', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-10-28 08:24:05.587' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (94, N'GXTN42', NULL, N'Rosa', N'Huỳnh Thái Lân', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 8, CAST(N'2014-10-28 08:24:26.053' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (95, N'GXTN43', NULL, N'Đaminh', N'Huỳnh Vân Vân', 0, N'19950300', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-28 08:24:57.430' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (96, N'GXTN44', NULL, N'Giuse', N'Phan Văn Ngọc', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-28 08:26:21.637' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (97, N'GXTN45', NULL, N'Phanxicô', N'Huỳnh Ngọc Vân', 0, N'20061112', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'        ', 1, 0, 10, CAST(N'2014-10-28 08:28:44.303' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (98, N'GXTN46', NULL, N'Phanxicô', N'Huỳnh Ngọc Phương', 0, N'20141006', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-28 08:29:44.473' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (99, N'GXTN47', NULL, N'Phanxicô', N'Huỳnh Văn Linh', 0, N'        ', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 14, CAST(N'2014-10-28 08:31:06.207' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (100, N'GXTN48', NULL, N'Rosa', N'Huỳnh Phúc Linh', 0, N'20141014', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 14, CAST(N'2014-10-28 08:31:54.893' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (101, N'GXTN49', NULL, N'Rosa', N'Thái Văn Linh', 0, N'        ', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 11, CAST(N'2014-10-28 08:33:03.943' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (102, N'GXTN50', NULL, N'Giuse', N'Huỳnh Phúc Thương', 0, N'20141103', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-10-28 08:34:36.233' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (103, N'GXTN51', NULL, N'Đaminh', N'Huỳnh Tấn Cát', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141125', 1, 0, 10, CAST(N'2014-10-28 08:36:48.403' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (104, N'GXTN52', NULL, N'Phanxicô', N'Huỳnh Long Ngọc', 0, N'        ', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 14, CAST(N'2014-10-28 08:38:22.700' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (105, N'GXTN53', NULL, N'Phaolô', N'Nguyễn Văn Buồn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:39:44.387' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (106, N'GXTN54', NULL, N'Mattheu', N'Huỳnh Phan Văn', 1, N'19931222', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-10-28 08:41:51.133' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (107, N'GXTN55', NULL, N'Mattheu', N'Huỳnh Văn Phạm', 1, N'20031200', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-10-28 08:44:08.927' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (108, N'GXTN56', NULL, N'Phaolô', N'Võ Hoàng Thịnh', 1, N'        ', NULL, N'Mattheu Huỳnh Nhơn Lộc', N'Giuse Huỳnh Văn Thanh', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:49:04.277' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (109, N'GXTN57', NULL, N'Phêrô Tự', N'Phạm Hoàng Thủ', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:50:27.217' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (110, N'GXTN58', NULL, N'Giuse', N'Phan Trung Anh', 0, N'20121000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 19, CAST(N'2014-10-28 13:16:46.503' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (111, N'GXTN59', NULL, N'Gioakim', N'Huỳnh Minh Tuấn', 1, N'20141014', N'Tiền Giang', N'Phaolô Nguyễn Văn Buồn', N'Đaminh Huỳnh Vân Vân', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 3, CAST(N'2014-10-30 08:43:31.687' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (112, N'GXTN60', NULL, N'Phanxicô', N'Nguyễn Phong Lưu', 1, N'20141013', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-10-30 08:43:58.790' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (113, N'GXTN61', NULL, N'Mattheu', N'Nguyễn Thị Ngọc Linh', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 5, CAST(N'2014-10-30 08:53:35.140' AS DateTime), N'manager', N'staff')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (114, N'GXTN62', NULL, N'Mattheu', N'Nguyễn Thanh', 1, N'20141016', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-30 15:40:27.697' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (115, N'GXTN63', NULL, N'Phaolô', N'Huỳnh Tuấn', 1, N'20141005', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-30 15:52:58.000' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (116, N'GXTN64', NULL, N'Giuse', N'Huỳnh Mẫn Mẫn', 0, N'20141014', NULL, NULL, NULL, 1, 1, 0, N'', N'Cấp II', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-10-30 15:57:57.860' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (117, N'GXTN65', NULL, N'Antôn', N'Nguyễn Thành Thái', 1, N'20141006', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 17, CAST(N'2014-10-30 17:16:20.020' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (118, N'GXTN66', NULL, N'Rosa', N'Nguyễn Thị Trinh', 0, N'19950602', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 8, CAST(N'2014-10-30 17:17:01.950' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (119, N'GXTN67', NULL, N'Phanxicô', N'Huỳnh Vân Lữ', 1, N'20141006', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Giuse Huỳnh Lam Ngọc', 1, 0, 0, N'', N'Cao đẳng', 1, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', NULL, NULL, NULL, NULL, 0, 1, N'20141117', 1, 0, 10, CAST(N'2014-10-31 08:09:08.057' AS DateTime), N'manager', N'manager')
GO
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (120, N'GXTN68', NULL, N'Phêrô', N'Nguyễn Phong Thịnh', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-31 08:11:50.033' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (121, N'GXTN69', NULL, N'Phanxicô', N'Phan Minh Trung', 1, N'19930800', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 8, CAST(N'2014-10-31 10:28:58.143' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (122, N'GXTN70', NULL, N'Mattheu', N'Huỳnh Minh Kha', 0, N'20141014', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-31 12:44:37.887' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (123, N'GXTN71', NULL, N'Mattheu', N'Nguyễn Thành Công', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, N'6532 154 8787', NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-01 11:41:54.360' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (124, N'GXTN72', NULL, N'Phêrô Tự', N'Phan Văn Hưng', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, N'0932 405 4878', NULL, NULL, 0, 1, N'20141110', 1, 0, 10, CAST(N'2014-11-02 10:24:05.690' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (125, N'GXTN73', NULL, N'Giuse', N'Huỳnh Văn Minh', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-02 10:46:38.043' AS DateTime), N'manager', N'staff')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (126, N'GXTN74', NULL, N'Phanxicô', N'Huỳnh Ảnh Thủ', 1, N'        ', NULL, NULL, NULL, 1, 0, 2, N'an thưa', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-02 21:54:11.267' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (127, N'GXTN75', NULL, N'Mattheu', N'Huỳnh Văn Phượng', 0, N'20141026', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 13, CAST(N'2014-11-02 22:15:42.953' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (128, N'GXTN76', NULL, N'Phanxicô', N'Phan Văn Phong', 0, N'        ', NULL, NULL, NULL, 1, 0, 2, N'unknow', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-02 22:16:34.960' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (129, N'GXTN77', NULL, N'Gioakim', N'Huỳnh Lâm Quang', 0, N'20140908', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 14, CAST(N'2014-11-02 22:17:01.503' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (130, N'GXTN78', NULL, N'Phaolô', N'Lâm Phượng', 0, N'20140707', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 14, CAST(N'2014-11-02 22:17:49.857' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (131, N'GXTN79', NULL, N'Mattheu', N'Huỳnh Phượng Linh', 0, N'20140407', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 11, CAST(N'2014-11-02 22:19:25.947' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (132, N'GXTN80', NULL, N'Phêrô Tự', N'Hà Lãng', 1, N'20141027', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 11, CAST(N'2014-11-02 22:25:10.793' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (133, N'GXTN77', NULL, N'Phêrô', N'Ngô Gia Thành', 1, N'19981000', N'Tây Ninh', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, NULL, N'Cấp III', 0, N'Nhân viên', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 8, CAST(N'2014-11-07 09:37:58.793' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (134, N'GXTN78', NULL, N'Antôn', N'Thái Phú Trạch', 1, N'20140928', N'Tây Ninh', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 2, N'test', N'Cấp III', 0, N'Nội trợ', N'66/16 Xố Viết Nghệ Tĩnh', N'0838 403 624', N'0932 040 423', N'thaiphutrach@gmail.com', N'Test', 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-07 09:54:17.837' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (135, N'GXTN79', NULL, N'Mattheu', N'Huỳnh Văn Sáng', 1, N'20141026', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Minh Thư', 1, 1, 2, N'abc', N'Cấp III', 0, N'Nhân viên', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-11-09 11:07:48.023' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (136, N'GXTN80', NULL, N'Gioakim', N'Huỳnh Phúc Mẫn', 1, N'20141119', NULL, N'Antôn Phan Đăng Cường', NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141102', 0, 1, 10, CAST(N'2014-11-09 11:51:00.823' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (137, N'GXTN81', NULL, N'Mattheu', N'Lã Quốc Phong', 1, N'20141026', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-11 04:43:47.560' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (138, N'GXTN82', NULL, N'Phêrô Tự', N'Liên Thanh Phương', 1, N'20141027', N'Tiền Giang', N'Gioakim Huỳnh Gia Cát Tấn', N'Giuse Huỳnh Ngọc Phượng', 0, 0, 0, N'', N'Cấp III', 0, N'Nhân viên', NULL, N'0838 463 2154', N'0932 044 0874', N'khoihm93@gmail.com', NULL, 0, 1, N'20141103', 0, 1, 1, CAST(N'2014-11-12 12:24:16.277' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (139, N'GXTN83', NULL, N'Phanxicô', N'Quách Tỉnh', 1, N'19500000', N'Tiền Giang', NULL, NULL, 1, 1, 0, NULL, N'Trên Đại học', 1, N'Nghề tự do', N'66/16 XVNT', NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 16, CAST(N'2014-11-12 13:39:15.933' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (140, N'GXTN84', NULL, N'Gioakim', N'Phương Văn Gia', 1, N'20141103', N'Tiền Giang', NULL, NULL, 0, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-11-12 13:55:53.397' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (141, N'GXTN85', NULL, N'Mattheu', N'Huỳnh Ngọc Nữ', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-12 16:29:34.800' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (142, N'GXTN86', NULL, N'Giuse', N'Huỳnh Văn Phụng', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-11-16 09:59:35.460' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (143, N'GXTN87', NULL, N'Phêrô Tự', N'Phan Văn Bạc', 1, N'19930302', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Giuse Huỳnh Ngọc Phượng', 1, 1, 0, NULL, N'Trung học', 0, N'Buôn bán', NULL, N'0838 403 624', N'0932 404 023', N'khoihm93@gmail.com', N'test ghi chu', 0, 0, N'        ', 0, 1, 15, CAST(N'2014-11-19 09:16:05.057' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (144, N'GXTN88', NULL, N'Phaolô', N'Phan Văn Kim', 0, N'19930228', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-11-19 09:16:26.597' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (145, N'GXTN89', NULL, N'Gioakim', N'Phan Văn Đồng', 0, N'19900000', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141109', 0, 1, 10, CAST(N'2014-11-19 09:16:54.377' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (146, N'GXTN90', NULL, N'Phanxicô', N'Đỗ Ngọc Hường', 1, N'19950800', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-19 14:33:48.203' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (147, N'GXTN91', NULL, N'Giuse', N'Đỗ Huỳnh Long', 1, N'19980000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 9, CAST(N'2014-11-19 14:36:47.347' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (148, N'GXTN92', NULL, N'Phanxicô', N'Phong Lưu Hồ', 1, N'20140525', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-19 14:38:46.173' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (149, N'GXTN93', NULL, N'Phêrô', N'Lưu Phước Hải', 1, N'19971021', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 8, CAST(N'2014-11-19 14:45:22.503' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (150, N'GXTN94', NULL, N'Phanxicô', N'Trương Linh Phụng', 0, N'19930518', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', N'Đại học', 0, N'Buôn bán', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-19 14:48:20.873' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (151, N'GXTN95', NULL, N'Mattheu', N'Đỗ Thị Trấn', 1, N'19981015', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 10, CAST(N'2014-11-19 14:50:55.400' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (152, N'GXTN96', NULL, N'Giuse', N'Đỗ Minh Luân', 1, N'20140831', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-19 14:51:47.733' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (153, N'GXTN97', NULL, N'Mattheu', N'Huỳnh Lam Phúc', 1, N'20140930', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 26, CAST(N'2014-11-19 14:54:35.777' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (154, N'GXTN98', NULL, N'Phaolô', N'Đỗ Ngọc Thùy', 0, N'20141027', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2014-11-19 14:56:31.013' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (155, N'GXTN99', NULL, N'Mattheu', N'Đỗ Minh Lộc', 1, N'20121124', N'Tây Ninh', N'Antôn Nguyễn Thành Thái', NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-20 12:22:07.623' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (156, N'GXTN100', NULL, N'Phanxicô', N'Đỗ Thành Đạt', 1, N'19981202', N'Tiền Giang', N'Giuse Đỗ Minh Luân', N'Giuse Huỳnh Lam Ngọc', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 10, CAST(N'2014-11-20 12:32:54.357' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (157, N'GXTN101', NULL, N'Mattheu', N'Huỳnh Minh Khôi', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 12:46:39.767' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (158, N'GXTN102', NULL, N'Mattheu', N'Huỳnh Quốc Phong', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-20 12:48:24.460' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (159, N'GXTN103', NULL, N'Mattheu', N'Đỗ Văn Thừa', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'123 CMT8', N'0838 422 3311', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-11-20 12:49:36.470' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (160, N'GXTN104', NULL, N'Gioakim', N'Đỗ Hữu Tài', 1, N'20031000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-20 13:00:36.390' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (161, N'GXTN105', NULL, N'Mattheu', N'Phan Thái Liên', 0, N'19950302', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-11-20 13:47:00.510' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (162, N'GXTN106', NULL, N'Mattheu', N'Huỳnh Trọng Phú', 0, N'        ', NULL, N'Đaminh Phan Văn Long', N'Giuse Huỳnh Ngọc Phượng', 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141111', 1, 0, 10, CAST(N'2014-11-20 13:50:47.163' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (163, N'GXTN107', NULL, N'Antôn', N'Đỗ Gia Lâm', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 13:51:39.333' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (164, N'GXTN108', NULL, N'Đaminh', N'Huỳnh Phong Phú', 1, N'19931000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 14:26:46.460' AS DateTime), N'manager', N'manager2')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (165, N'GXTN109', NULL, N'Mattheu', N'Huỳnh Tấn Trung', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 11, CAST(N'2014-11-20 14:27:20.497' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (166, N'GXTN110', NULL, N'Đaminh', N'Phan Văn Long', 1, N'19981110', N'Tiền Giang', N'Gioakim Huỳnh Gia Cát Tấn', N'Giuse Huỳnh Lam Ngọc', 1, 1, 0, N'', N'Cấp III', 0, N'Buôn bán', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 14:27:48.857' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (167, N'GXTN111', NULL, N'Mattheu', N'Huỳnh Ngọc Hải', 0, N'20121031', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-27 08:11:00.697' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (168, N'GXTN112', NULL, N'Phanxicô', N'Huỳnh Văn Đổi', 0, N'20141027', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141212', 1, 0, 8, CAST(N'2014-11-27 08:11:37.157' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (169, N'GXTN113', NULL, N'Mattheu', N'Đỗ Hồng Ngọc', 0, N'19950302', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, N'', N'Cao đẳng', 0, N'Buôn bán', N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', N'0932 044 023', N'hongngoc@gmail.com', N'test ghi chú', 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-27 08:13:27.367' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (170, N'GXTN114', NULL, N'Mattheu', N'Đỗ Hoàng Kim', 1, N'19951002', NULL, NULL, NULL, 1, 1, 0, N'', N'Cao đẳng', 1, N'Buôn bán', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-11-27 10:10:27.140' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (171, N'GXTN115', NULL, N'Mattheu', N'Huỳnh Văn Cát', 1, N'20141102', NULL, NULL, NULL, 1, -1, 2, N'abc', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-11-27 10:14:27.560' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (172, N'GXTN116', NULL, N'Phaolô', N'Hoàng Kim Tuấn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 19, CAST(N'2014-11-27 10:15:08.673' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (173, N'GXTN117', NULL, N'Phêrô Tự', N'Đỗ Thị Lai', 0, N'20040902', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 10:15:47.753' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (174, N'GXTN118', NULL, N'Phêrô', N'Đỗ Thành Lân', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 10:23:14.490' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (175, N'GXTN119', NULL, N'Antôn', N'Mai Văn Linh', 1, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 10:40:53.563' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (176, N'GXTN120', NULL, N'Antôn', N'Huỳnh Phúc Vân', 1, N'20051202', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', N'Trung học', 1, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-11-27 11:04:56.387' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (177, N'GXTN121', NULL, N'Phêrô', N'Lai Văn Thành', 1, N'20091127', NULL, NULL, NULL, 1, 1, 1, N'Tân Định', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-27 11:05:39.267' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (178, N'GXTN122', NULL, N'Antôn', N'Lê Minh Tuấn', 1, N'19950902', N'Tiền Giang', N'Antôn Nguyễn Thành Thái', N'Phêrô Tự Bùi Thị Đông', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-27 15:38:49.243' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (179, N'GXTN123', NULL, N'Phêrô', N'Huỳnh Minh Quân', 0, N'20011210', N'Hồ Chí Minh', NULL, NULL, 1, 0, 2, N'Tân Phong', N'Trung học', 1, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-11-27 15:39:34.977' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (180, N'GXTN124', NULL, N'Mattheu', N'Huỳnh Lưu Thương', 1, N'19961210', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', NULL, NULL, NULL, 0, 1, N'20141212', 1, 0, 10, CAST(N'2014-11-27 18:03:32.083' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (181, N'GXTN125', NULL, N'Phanxicô', N'Huỳnh Hữu Lộc', 1, N'20141026', NULL, NULL, NULL, 1, -1, 2, N'thị nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-27 23:44:25.830' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (182, N'GXTN126', NULL, N'Giuse', N'Huỳnh Minh Khôi', 1, N'19950502', NULL, NULL, NULL, 1, 0, 2, N'abc', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 23:46:43.987' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (187, N'GXTN127', NULL, N'Anrê', N'Huỳnh Long Nhật', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-28 09:32:12.720' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (188, N'GXTN128', NULL, N'Phêrô Tự', N'Huỳnh Minh Khôi', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', N'Cấp III', 1, N'Nhân viên', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-28 10:02:07.287' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (189, N'GXTN129', NULL, N'Đaminh', N'Huỳnh Văn Phú', 1, N'19931020', N'Tây Ninh', N'Gioakim Đỗ Hữu Tài', N'Rosa Lê Thị Hà', 1, 1, 0, N'', N'Cấp I', 0, N'Buôn bán', NULL, N'0838 403 624', N'0932 040 423', N'phuvan@gmail.com', N'ghi chú chung', 0, 0, N'        ', 0, 1, 11, CAST(N'2014-11-28 10:22:09.867' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (190, N'GXTP1', NULL, N'Antôn', N'Huỳnh Ngọc Quân', 1, N'19931200', N'Tây Ninh', N'Giuse Huỳnh Ngọc Long', N'Đaminh Huỳnh Văn Phúc', 1, 1, 0, NULL, N'Đại học', 0, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh', N'0838 403 625', N'0932 040 423', N'quan@gmail.com', N'ghi chú thông tin', 0, 0, N'        ', 1, 0, 29, CAST(N'2014-11-28 16:26:10.233' AS DateTime), N'managertanphong', N'managertanphong')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (191, N'GXTP2', NULL, N'Antôn', N'Huỳnh Phúc Linh', 0, N'20091020', N'Tiền Giang', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 30, CAST(N'2014-11-28 16:27:49.820' AS DateTime), N'managertanphong', N'managertanphong')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (192, N'GXTP3', NULL, N'Anrê', N'Huỳnh Quốc Phú', 1, N'19930200', N'Tây Ninh', NULL, NULL, 1, 1, 0, NULL, N'Cấp III', 1, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 30, CAST(N'2014-11-28 16:33:37.760' AS DateTime), N'managertanphong', N'managertanphong')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (193, N'GXTN130', NULL, N'Catarina', N'Huỳnh Minh Lưu', 1, N'20141027', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 11, CAST(N'2014-11-28 17:17:31.550' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (194, N'GXTN129', NULL, N'Clara', N'Đỗ Thành Hải', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-30 12:56:25.690' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (195, N'GXTN130', NULL, N'Vincentê', N'Lâm Phong Giả', 1, N'19921020', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-30 13:24:50.840' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (196, N'GXTN131', NULL, N'Vincentê', N'Vendetta', 1, N'19901130', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 16, CAST(N'2014-11-30 15:53:13.500' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (197, N'GXTN132', NULL, N'Têrêsa', N'Hạ Uyên', 0, N'19901114', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-30 15:53:52.543' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (198, N'GXTN133', NULL, N'Phêrô', N'Trần Phi', 1, N'19901113', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 8, CAST(N'2014-11-30 15:57:09.740' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (199, N'GXTN134', NULL, N'Simon', N'Pumpa', 0, N'19901127', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-11-30 15:57:23.707' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (200, N'GXTN135', NULL, N'Clara', N'Cleric', 1, N'19961105', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-11-30 16:10:40.000' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (201, N'GXTN136', NULL, N'Catarina', N'Ngô Quang Phụng', 0, N'19951121', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-30 16:10:56.947' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (202, N'GXTN137', NULL, N'Antôn', N'Huỳnh Thánh Tôn', 1, N'19901002', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 13, CAST(N'2014-11-30 16:23:35.067' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (203, N'GXTN137', NULL, N'Tôma', N'Nguyễn Quang Đại', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'19901110', 1, 0, 7, CAST(N'2014-12-01 15:44:50.960' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (204, N'GXTN138', NULL, N'Antôn', N'Nguyễn Thành Công', 0, N'        ', NULL, NULL, NULL, 1, -1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-12-01 19:47:27.813' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (205, N'GXTN139', NULL, N'Giuse', N'Huỳnh Quốc Phong', 1, N'19651012', N'Đà Lạt', NULL, NULL, 1, 1, 0, N'', N'Trên Đại học', 0, N'Nhân viên', N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', N'0932 040 423', N'phong@gmail.com', NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-05 06:24:40.867' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (206, N'GXTN140', NULL, N'Rosa', N'Nguyễn Ngọc Vân', 0, N'        ', N'Tây Ninh', NULL, NULL, 1, 0, 0, N'', N'Đại học', 0, N'Nội trợ', N'66/A XVNT P.21 Quận Bình Thạnh TP HCM', N'0838 403 624', N'0932 288 7654', NULL, NULL, 0, 1, N'19920302', 1, 0, 10, CAST(N'2014-12-05 06:30:07.890' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (207, N'GXTN141', NULL, N'Maria', N'Lê Minh Thu', 0, N'19971101', N'Hải Phòng', NULL, NULL, 1, 1, 1, N'Thị Nghè', N'Cấp III', 0, N'Học sinh', N'102/2A Ngô Tất Tố P.19 Quận Bình Thạnh TP HCM', N'0838 462 167', N'0938 391 602', N'minhthu@gmail.com', NULL, 0, 0, N'        ', 1, 0, 13, CAST(N'2014-12-05 07:01:54.237' AS DateTime), N'manager', N'manager2')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (208, N'GXTN142', NULL, N'Clara', N'Đỗ Ngọc Lan', 0, N'19901210', N'Hồ Chí Minh', NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'19901210', 1, 0, 26, CAST(N'2014-12-05 08:20:17.787' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (209, N'GXTN143', NULL, N'Vincentê', N'Huỳnh Quốc Thiên', 1, N'19930302', NULL, N'Giuse Huỳnh Quốc Phong', N'Rosa Nguyễn Ngọc Vân', 1, 0, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141210', 1, 0, 13, CAST(N'2014-12-05 13:11:25.363' AS DateTime), N'manager', N'manager2')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (210, N'GXTN143', NULL, N'Têrêsa', N'Nguyễn Thị Ngọc Linh', 0, N'        ', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'19901109', 1, 0, 10, CAST(N'2014-12-11 21:42:18.853' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (211, N'GXTN144', NULL, N'Henricô', N'Huỳnh Quốc Quang', 1, N'19931012', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-13 16:45:18.330' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (212, N'GXTN145', NULL, N'Catarina', N'Nguyễn Ngọc Phương Linh', 0, N'20031115', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-12-14 07:36:08.633' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (213, N'GXTN146', NULL, N'Antôn', N'Trần Âu Mỹ', 1, N'19901112', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-14 07:38:03.567' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (214, N'GXTN147', NULL, N'Simon', N'Huỳnh Phúc Quân', 1, N'19900302', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-14 08:08:22.603' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (215, N'GXTN148', NULL, N'Antôn', N'Đỗ Thành Tài', 1, N'20101115', N'Tây Ninh', NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-12-14 08:20:20.660' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (216, N'GXTN149', NULL, N'Gioakim', N'Phan Quang Trị', 1, N'19901010', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', NULL, NULL, NULL, 0, 1, N'20141201', 0, 1, 10, CAST(N'2014-12-14 09:06:45.463' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (217, N'GXTN150', NULL, N'Đaminh', N'Quốc Mạnh Tùng', 1, N'19901010', NULL, NULL, NULL, 1, 0, 2, N'Bình Lợi', N'Cấp III', 0, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-12-14 09:35:23.790' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (218, N'GXTN151', NULL, N'Anrê', N'Phan Quang Tú', 1, N'19891112', NULL, NULL, NULL, 1, 0, 2, N'Tân Bình', NULL, 0, NULL, N'66/16 Lâm Phong', N'0838 403 624', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-12-14 09:36:32.993' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (219, N'GXTN152', NULL, N'Đaminh', N'Phạm Hữu Lộc', 1, N'20141201', N'Nha Trang', N'Antôn Nguyễn Thành Thái', N'Giuse Huỳnh Ngọc Phượng', 1, 0, 0, N'', N'Cao đẳng', 0, N'Nghề tự do', N'123 CMT8', N'0838 422 3311', NULL, NULL, NULL, 0, 1, N'        ', 0, 1, 7, CAST(N'2014-12-14 18:12:06.930' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (220, N'GXTN153', NULL, N'Clara', N'Lại Quốc Khôi', 1, N'19930302', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-12-14 20:22:50.763' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (221, N'GXTN154', NULL, N'Gioakim', N'Phan Thị Thu', 0, N'19891012', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-12-14 20:23:14.530' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (222, N'GXTN155', NULL, N'Anrê', N'Đỗ Thị Lai', 1, N'19901101', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'123 CMT8', N'0838 422 3311', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-12-14 20:27:23.800' AS DateTime), N'manager', N'manager')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (223, N'GXTN156', NULL, NULL, N'Lưu Thị Linh', 0, N'19901012', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-12-14 22:51:05.153' AS DateTime), N'manager', N'manager')
GO
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy]) VALUES (224, N'GXTN157', NULL, NULL, N'Lưu Lung Linh', 0, N'        ', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-12-14 22:55:47.813' AS DateTime), N'manager', N'manager')
SET IDENTITY_INSERT [dbo].[Parishioner] OFF
SET IDENTITY_INSERT [dbo].[ParishionerMigrationRequest] ON 

INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (3, 132, 9, CAST(N'2014-11-05 13:42:45.987' AS DateTime), 2, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (4, 131, 9, CAST(N'2014-11-05 13:44:03.760' AS DateTime), 3, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (5, 130, 9, CAST(N'2014-11-05 14:07:08.543' AS DateTime), 5, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (6, 130, 9, CAST(N'2014-11-05 14:07:27.040' AS DateTime), 2, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (7, 129, 9, CAST(N'2014-11-05 14:07:27.047' AS DateTime), 2, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (10, 128, NULL, CAST(N'2014-11-05 14:21:27.930' AS DateTime), 2, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (13, 126, NULL, CAST(N'2014-11-05 14:23:15.627' AS DateTime), 5, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (14, 60, 9, CAST(N'2014-11-14 13:00:45.533' AS DateTime), 3, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (15, 104, 9, CAST(N'2014-11-14 13:00:45.627' AS DateTime), 5, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (16, 100, 9, CAST(N'2014-11-14 13:00:45.633' AS DateTime), 5, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (21, 101, 9, CAST(N'2014-11-16 17:21:05.620' AS DateTime), 5, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (23, 127, 9, CAST(N'2014-11-17 08:27:18.690' AS DateTime), 15, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (30, 99, 9, CAST(N'2014-11-19 15:56:23.177' AS DateTime), 5, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (37, 73, 9, CAST(N'2014-11-24 20:17:43.023' AS DateTime), 7, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (47, 176, 5, CAST(N'2014-11-27 11:04:58.523' AS DateTime), 10, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (54, 53, 9, CAST(N'2014-11-29 15:29:13.787' AS DateTime), 10, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (55, 165, 9, CAST(N'2014-11-29 15:29:13.967' AS DateTime), 10, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (56, 193, 9, CAST(N'2014-11-29 15:29:13.987' AS DateTime), 10, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (57, 189, 9, CAST(N'2014-11-29 15:29:14.003' AS DateTime), 10, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (62, 182, NULL, CAST(N'2014-12-01 13:39:28.867' AS DateTime), 17, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (63, 179, 12, CAST(N'2014-12-01 13:42:40.453' AS DateTime), 17, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (64, 16, NULL, CAST(N'2014-12-01 13:46:28.520' AS DateTime), 33, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (65, 202, 9, CAST(N'2014-12-01 14:10:35.077' AS DateTime), 33, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (67, 209, 9, CAST(N'2014-12-05 13:40:39.380' AS DateTime), 10, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (68, 207, 9, CAST(N'2014-12-05 13:40:39.397' AS DateTime), 10, 2)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (69, 217, 9, CAST(N'2014-12-14 09:35:24.020' AS DateTime), 15, 1)
INSERT [dbo].[ParishionerMigrationRequest] ([Id], [ParishionerId], [ToParishId], [CreatedDate], [FromCommunityId], [Status]) VALUES (70, 218, 3, CAST(N'2014-12-14 09:36:33.137' AS DateTime), 15, 1)
SET IDENTITY_INSERT [dbo].[ParishionerMigrationRequest] OFF
SET IDENTITY_INSERT [dbo].[PlaceSuggestion] ON 

INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (1, N'Hồ Chí Minh')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (2, N'Tây Ninh')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (3, N'Cà Mau')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (4, N'An Giang')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (5, N'Tiền Giang')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (6, N'Đồng Nai')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (7, N'Nha Trang')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (8, N'Đà Lạt')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (9, N'Quảng Ninh')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (10, N'Hải Phòng')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (11, N'Hà Nội')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (12, N'Long An')
INSERT [dbo].[PlaceSuggestion] ([Id], [Name]) VALUES (13, N'Vũng Tàu')
SET IDENTITY_INSERT [dbo].[PlaceSuggestion] OFF
SET IDENTITY_INSERT [dbo].[Priest] ON 

INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone]) VALUES (1, N'Đaminh', N'Huỳnh Trọng Luân', N'19800702', 1, 3)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone]) VALUES (2, N'Giuse', N'Huỳnh Phong Vân', N'19821202', 1, 3)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone]) VALUES (4, N'Phêrô', N'Trương Tấn Trọng', N'19810901', 1, 3)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone]) VALUES (5, N'Antôn', N'Nguyễn Văn Trung', N'19791204', 1, 3)
SET IDENTITY_INSERT [dbo].[Priest] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Quản trị')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Quản lý')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (3, N'Nhập liệu')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (4, N'Giáo lý viên')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Sacrament] ON 

INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (1, NULL, 12, N'08321456487', 1, N'Đaminh Nguyễn Thành Long', NULL, N'20141000', N'', N'Đông đường')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (2, NULL, 12, N'08636544848', 2, NULL, NULL, N'20141016', N'Phêrô Huỳnh Văn Hải', N'Đông Lãng')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (3, NULL, 62, N'', 1, N'', NULL, N'19951000', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (4, NULL, 62, N'', 2, NULL, NULL, N'20001218', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (5, NULL, 62, N'', 3, N'', NULL, N'20101200', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (6, NULL, 63, N'', 1, N'Giuse Huỳnh Phong Vân', NULL, N'        ', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (7, NULL, 66, N'', 1, N'', NULL, N'20141022', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (8, NULL, 66, N'', 2, NULL, NULL, N'20141002', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (9, NULL, 66, N'', 3, N'', NULL, N'20141013', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (10, 1, 23, NULL, 2, NULL, NULL, N'20141002', N'Giuse Huynh Minh Khoi', N'TPHCM')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (11, NULL, 69, N'0932040423', 1, N'', NULL, N'20140513', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (12, NULL, 69, N'0963215465', 2, NULL, NULL, N'20140928', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (13, 2, 60, N'0165324568', 1, N'Maria Uyên My', N'pms', N'20141009', N'sdfgsfgsdfg', N'gsdfgsdfgsdfg')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (14, 2, 70, N'0165487987', 1, N'Giuse Huỳnh Minh Tuấn', N'abc', N'20141009', N'sdfgsfgsdfg', N'gsdfgsdfgsdfg')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (15, 2, 54, N'0123654879', 1, N'Giuse Đỗ Văn Thành', N'def', N'20141009', N'sdfgsfgsdfg', N'gsdfgsdfgsdfg')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (16, NULL, 76, N'0932040423', 1, N'Phêrô Trương Tấn Trọng', NULL, N'20010928', N'Antôn Nguyễn Văn Trung', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (17, NULL, 76, N'', 2, NULL, NULL, N'20111000', N'Phêrô Trương Tấn Trọng', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (18, NULL, 76, N'', 3, N'Antôn Nguyễn Văn Trung', NULL, N'20141009', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (19, NULL, 77, N'', 1, N'', NULL, N'20001022', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (20, NULL, 77, N'', 2, NULL, NULL, N'20111022', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (21, NULL, 77, N'', 3, N'', NULL, N'20141014', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (22, NULL, 83, N'0900000', 1, N'Phêrô Trương Tấn Trọng', NULL, N'20140602', N'Antôn Nguyễn Văn Trung', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (23, NULL, 83, N'09000001', 2, NULL, NULL, N'20141007', N'Phêrô Trương Tấn Trọng', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (24, NULL, 83, N'09000002', 3, N'Đaminh Huỳnh Trọng Luân', NULL, N'20141025', N'Antôn Nguyễn Văn Trung', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (37, NULL, 84, N'024719860', 1, N'Antôn Nguyễn Văn Trung', NULL, N'20130823', N'Giuse Huỳnh Phong Vân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (38, NULL, 119, N'0932044023', 1, N'Giuse Huỳnh Phong Vân', NULL, N'20141015', N'Phêrô Trương Tấn Trọng', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (39, NULL, 120, N'09320489621', 2, NULL, NULL, N'20141015', N'Giuse Huỳnh Phong Vân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (40, NULL, 117, N'0944487899', 3, N'Đaminh Huỳnh Trọng Luân', NULL, N'20141008', N'Phêrô Trương Tấn Trọng', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (41, 3, 116, N'dsfgdsfgdfg', 2, NULL, N'dsgffsdgsdfg', N'20141014', N'Giuse Huỳnh Phong Vân', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (42, 4, 135, N'', 1, N'', NULL, N'20141028', N'Giuse Huỳnh Phong Vân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (43, NULL, 152, N'0934878743', 1, N'', NULL, N'20141104', N'', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (44, NULL, 153, N'093204048787', 2, NULL, NULL, N'20141026', N'Đaminh Huỳnh Trọng Luân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (45, NULL, 154, N'093207407078787', 1, N'', NULL, N'20141103', N'', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (46, NULL, 163, N'0963215487', 1, N'Giuse Huỳnh Phong Vân', NULL, N'19981002', N'Antôn Nguyễn Văn Trung', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (47, NULL, 163, N'0963215487', 1, N'Giuse Huỳnh Phong Vân', NULL, N'19981002', N'Antôn Nguyễn Văn Trung', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (48, NULL, 166, N'09633215487', 1, N'Giuse Huỳnh Phong Vân', NULL, N'19981112', N'Giuse Huỳnh Phong Vân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (49, NULL, 166, N'09635245487', 2, NULL, NULL, N'20011120', N'Giuse Huỳnh Phong Vân', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (50, NULL, 166, N'06848787865', 3, N'Giuse Huỳnh Phong Vân', NULL, N'20141027', N'Antôn Nguyễn Văn Trung', N'Hồ Chí Minh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (51, NULL, 162, N'0963548787', 1, N'Đaminh Huỳnh Trọng Luân', NULL, N'19981102', N'Đaminh Huỳnh Trọng Luân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (52, NULL, 162, N'08632165487', 2, NULL, NULL, N'20141112', N'Phêrô Trương Tấn Trọng', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (53, NULL, 162, N'0936548787', 3, N'Giuse Huỳnh Phong Vân', NULL, N'20140929', N'Đaminh Huỳnh Trọng Luân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (54, NULL, 180, N'', 1, N'Đaminh Huỳnh Trọng Luân', NULL, N'20141104', N'Phêrô Trương Tấn Trọng', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (55, NULL, 180, N'', 2, NULL, NULL, N'20141119', N'Giuse Huỳnh Phong Vân', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (56, NULL, 180, N'', 3, N'Giuse Huỳnh Phong Vân', NULL, N'20141122', N'Phêrô Trương Tấn Trọng', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (57, 4, 172, NULL, 1, NULL, NULL, N'20141028', N'Giuse Huỳnh Phong Vân', N'Tiền Giang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (58, 7, 182, N'', 3, N'', NULL, N'20141128', N'Đaminh Huỳnh Trọng Luân', N'Hồ Chí Minh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (59, 7, 179, N'', 3, N'', NULL, N'20141128', N'Đaminh Huỳnh Trọng Luân', N'Hồ Chí Minh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (60, NULL, 187, N'', 1, N'', NULL, N'19951102', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (61, NULL, 187, N'', 2, NULL, NULL, N'20141220', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (62, NULL, 187, N'', 1, N'', NULL, N'19951102', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (63, NULL, 187, N'', 2, NULL, NULL, N'20141220', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (64, NULL, 188, N'', 1, N'', NULL, N'20141104', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (65, NULL, 188, N'', 2, NULL, NULL, N'20141113', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (66, NULL, 188, N'', 3, N'', NULL, N'20141127', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (67, NULL, 188, N'', 1, N'', NULL, N'20141104', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (68, NULL, 188, N'', 2, NULL, NULL, N'20141113', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (69, NULL, 188, N'', 3, N'', NULL, N'20141127', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (70, NULL, 189, N'0932131321231', 1, N'Đaminh Huỳnh Trọng Luân', NULL, N'20141210', N'Giuse Huỳnh Phong Vân', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (71, NULL, 189, N'09123123123', 2, NULL, NULL, N'20051120', N'Giuse Huỳnh Phong Vân', N'Nha Trang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (72, NULL, 189, N'01282039494', 3, N'Đaminh Huỳnh Trọng Luân', NULL, N'20141127', N'Antôn Nguyễn Văn Trung', N'Đà Lạt')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (73, NULL, 190, N'0922293855', 1, N'Giuse Huỳnh Phong Vân', NULL, N'20031200', N'Đaminh Huỳnh Trọng Luân', N'Tây Ninh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (74, NULL, 190, N'09123565355', 2, NULL, NULL, N'20050200', N'Giuse Huỳnh Phong Vân', N'Nha Trang')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (75, NULL, 190, N'099123213123', 3, N'Giuse Huỳnh Phong Vân', NULL, N'20141126', N'Phêrô Trương Tấn Trọng', N'Hồ Chí Minh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (76, NULL, 191, N'', 1, N'', NULL, N'20041111', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (77, NULL, 191, N'', 2, NULL, NULL, N'20121200', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (78, NULL, 191, N'', 3, N'', NULL, N'20141126', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (79, NULL, 192, N'', 1, N'', NULL, N'19951200', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (80, NULL, 192, N'', 2, NULL, NULL, N'20001000', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (81, NULL, 193, N'', 1, N'', NULL, N'20141104', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (82, NULL, 193, N'', 2, NULL, NULL, N'20141119', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (83, NULL, 193, N'', 3, N'', NULL, N'20141126', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (84, NULL, 202, N'', 1, N'', NULL, N'20141027', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (85, NULL, 202, N'', 2, NULL, NULL, N'20141114', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (86, NULL, 202, N'', 3, N'', NULL, N'20141124', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (87, NULL, 203, N'', 1, N'', NULL, N'19900914', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (88, NULL, 203, N'', 2, NULL, NULL, N'20140210', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (89, NULL, 203, N'', 3, N'', NULL, N'20140801', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (91, NULL, 204, N'', 2, NULL, NULL, N'20141112', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (92, NULL, 204, N'', 3, N'', NULL, N'20141112', N'', N'')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (93, NULL, 205, N'0123456789', 1, N'Giuse Huỳnh Phong Vân', NULL, N'19651112', N'Phêrô Trương Tấn Trọng', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (94, NULL, 205, N'0123456777', 2, NULL, NULL, N'19731112', N'Giuse Huỳnh Phong Vân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (95, NULL, 205, N'0123456888', 3, N'Giuse Huỳnh Phong Vân', NULL, N'19791112', N'Phêrô Trương Tấn Trọng', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (96, NULL, 206, N'0123456654', 1, N'Đaminh Huỳnh Trọng Luân', NULL, N'19671117', N'Phêrô Trương Tấn Trọng', N'Đông Bắc')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (97, NULL, 206, N'0987674123', 2, NULL, NULL, N'19751118', N'Giuse Huỳnh Phong Vân', N'Đông Bắc')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (98, NULL, 206, N'0468955463', 3, N'Đaminh Huỳnh Trọng Luân', NULL, N'19811122', N'Giuse Huỳnh Phong Vân', N'Đông Bắc')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (99, NULL, 205, N'0123456789', 1, N'Giuse Huỳnh Phong Vân', NULL, N'19651112', N'Phêrô Trương Tấn Trọng', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (100, NULL, 205, N'0123456777', 2, NULL, NULL, N'19731112', N'Giuse Huỳnh Phong Vân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (101, NULL, 205, N'0123456888', 3, N'Giuse Huỳnh Phong Vân', NULL, N'19791112', N'Phêrô Trương Tấn Trọng', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (102, NULL, 207, N'0345126952', 1, N'Đaminh Huỳnh Trọng Luân', NULL, N'19980102', N'Phêrô Trương Tấn Trọng', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (103, NULL, 207, N'0639874123', 2, NULL, NULL, N'20061012', N'Phêrô Trương Tấn Trọng', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (104, NULL, 207, N'03321654877', 3, N'Đaminh Huỳnh Trọng Luân', NULL, N'20121126', N'Giuse Huỳnh Phong Vân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (105, 9, 208, N'', 1, N'', NULL, N'19940200', N'Giuse Huỳnh Phong Vân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (106, 10, 208, N'', 2, NULL, NULL, N'20021200', N'Giuse Huỳnh Phong Vân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (107, 11, 208, N'012365487', 3, N'Giuse Đỗ Thành Long', N'test', N'20060623', N'Giuse Huỳnh Phong Vân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (108, 13, 209, N'', 1, N'', NULL, N'19940000', N'Đaminh Huỳnh Trọng Luân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (109, 14, 209, N'', 2, NULL, NULL, N'20040112', N'Đaminh Huỳnh Trọng Luân', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (110, 15, 209, N'', 3, N'', NULL, N'20100212', N'Antôn Nguyễn Văn Trung', N'Đông Nam')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (120, 2, 167, NULL, 1, NULL, NULL, N'20141113', N'Antôn Nguyễn Văn Trung', N'Hồ Chí Minh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (121, 2, 158, NULL, 1, NULL, NULL, N'19901210', N'Antôn Nguyễn Văn Trung', N'Hồ Chí Minh')
GO
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (122, 2, 82, NULL, 1, NULL, NULL, N'20001202', N'Antôn Nguyễn Văn Trung', N'Hồ Chí Minh')
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (123, 2, 71, NULL, 1, NULL, NULL, N'20001125', N'Antôn Nguyễn Văn Trung', N'Hồ Chí Minh')
SET IDENTITY_INSERT [dbo].[Sacrament] OFF
SET IDENTITY_INSERT [dbo].[SacramentGroup] ON 

INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (1, N'20141002', 2, N'Đợt bí tích ngày 02 tháng 10 năm 2014', N'Giuse Huynh Minh Khoi', N'TPHCM', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (2, N'20141001', 1, N'Đợt bí tích ngày 1 tháng 10 năm 2014', N'Antôn Nguyễn Văn Trung', N'Hồ Chí Minh', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (3, N'20141014', 2, N'Đợt bí tích ngày 14 tháng 10 năm 2014', N'Giuse Huỳnh Phong Vân', N'Tây Ninh', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (4, N'20141211', 1, N'Đợt bí tích ngày 11 tháng 12 năm 2014', N'Giuse Huỳnh Phong Vân', N'Tiền Giang', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (5, N'20141104', 4, N'Đợt bí tích ngày 04 tháng 11 năm 2014', N'Giuse Huỳnh Phong Vân', N'Hồ Chí Minh', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (6, N'20141105', 4, N'Đợt bí tích ngày 05 tháng 11 năm 2014', N'Đaminh Huỳnh Trọng Luân', N'Tây Ninh', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (7, N'20141128', 3, N'Đợt bí tích ngày 28 tháng 11 năm 2014', N'Đaminh Huỳnh Trọng Luân', N'Hồ Chí Minh', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (8, N'20141130', 4, N'Đợt bí tích ngày 30 tháng 11 năm 2014', N'Phêrô Trương Tấn Trọng', N'Hồ Chí Minh', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (9, N'19940223', 1, N'Đợt bí tích ngày 23 tháng 02 năm 1994', N'Giuse Huỳnh Phong Vân', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (10, N'20021200', 2, N'Đợt bí tích tháng 12 năm 2002', N'Giuse Huỳnh Phong Vân', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (11, N'20060623', 3, N'Đợt bí tích ngày 23 tháng 6 năm 2006', N'Giuse Huỳnh Phong Vân', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (12, N'20141200', 4, N'Đợt bí tích tháng 12 năm 2014', N'Giuse Huỳnh Phong Vân', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (13, N'19931223', 1, N'Đợt bí tích ngày 23 tháng 12 năm 1993', N'Đaminh Huỳnh Trọng Luân', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (14, N'20040112', 2, N'Đợt bí tích ngày 12 tháng 1 năm 2004', N'Đaminh Huỳnh Trọng Luân', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (15, N'20100212', 3, N'Đợt bí tích ngày 12 tháng 2 năm 2010', N'Antôn Nguyễn Văn Trung', N'Đông Nam', 1)
INSERT [dbo].[SacramentGroup] ([Id], [Date], [Type], [Description], [Giver], [ReceivedPlace], [ParishId]) VALUES (16, N'20121002', 4, N'Đợt bí tích ngày 2 tháng 10 năm 2012', N'Giuse Huỳnh Phong Vân', N'Đông Nam', 1)
SET IDENTITY_INSERT [dbo].[SacramentGroup] OFF
SET IDENTITY_INSERT [dbo].[SeminaryYear] ON 

INSERT [dbo].[SeminaryYear] ([Id], [StartAt], [EndAt], [SeminaryName], [SeminaryYearCode]) VALUES (2, CAST(N'2015-02-01 00:00:00.000' AS DateTime), CAST(N'2020-02-01 00:00:00.000' AS DateTime), N'Đại chủng viện thánh Giuse Xuân Lộc', N'X')
INSERT [dbo].[SeminaryYear] ([Id], [StartAt], [EndAt], [SeminaryName], [SeminaryYearCode]) VALUES (3, CAST(N'2014-02-01 00:00:00.000' AS DateTime), CAST(N'2019-02-01 00:00:00.000' AS DateTime), N'Đại chủng viện thánh Giuse Xuân Lộc', N'IX')
INSERT [dbo].[SeminaryYear] ([Id], [StartAt], [EndAt], [SeminaryName], [SeminaryYearCode]) VALUES (4, CAST(N'2015-02-01 00:00:00.000' AS DateTime), CAST(N'2020-02-01 00:00:00.000' AS DateTime), N'Đại chủng viên thánh Giuse Sài Gòn', N'XX')
SET IDENTITY_INSERT [dbo].[SeminaryYear] OFF
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (1, N'Chánh xứ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (2, N'Phó xứ')
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
SET IDENTITY_INSERT [dbo].[ValueSet] ON 

INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (1, N'1', N'Xây dựng nhà thờ', NULL, N'PermitType')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (3, N'2', N'Xây dựng nhà xứ', NULL, N'PermitType')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (4, N'3', N'Xây dựng nhà giáo lý', NULL, N'PermitType')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (5, N'1', N'Chờ duyệt', NULL, N'PermitStatus')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (6, N'2', N'Ðã duyệt', NULL, N'PermitStatus')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (7, N'3', N'Từ chối', NULL, N'PermitStatus')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (8, N'0', N'Thành viên', NULL, N'HDLM')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (9, N'1', N'Hội trưởng', NULL, N'HDLM')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (10, N'2', N'Hội phó', NULL, N'HDLM')
SET IDENTITY_INSERT [dbo].[ValueSet] OFF
SET IDENTITY_INSERT [dbo].[Vicariate] ON 

INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (1, N'Bình Thạnh', 1, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (2, N'Tân Bình', 1, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (4, N'Bình Tân', 1, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (5, N'Thủ Đức', 1, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (6, N'Tân Thuận', 1, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (7, N'Quang Trung', 1, NULL)
SET IDENTITY_INSERT [dbo].[Vicariate] OFF
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (117, N'20141121', N'        ', N'20141113', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 4, NULL, NULL, N'', N'', N'', 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (120, N'20140908', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 0)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (122, N'20141112', N'        ', N'20141110', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (123, N'20141112', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (124, N'20141113', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (125, N'20141113', N'        ', N'20141120', N'20141111', N'20141126', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 0)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (197, N'20141202', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 0)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (208, N'20121200', N'20130400', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (209, N'20141203', N'20141205', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft]) VALUES (211, N'20141201', N'20141209', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1)
/****** Object:  Index [CK_ValueSet]    Script Date: 11/04/2016 10:30:41 SA ******/
ALTER TABLE [dbo].[ValueSet] ADD  CONSTRAINT [CK_ValueSet] UNIQUE NONCLUSTERED 
(
	[Code] ASC,
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Diocese] FOREIGN KEY([DioceseId])
REFERENCES [dbo].[Diocese] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Diocese]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Parish]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_Class_ClassGroup] FOREIGN KEY([ClassGroupId])
REFERENCES [dbo].[ClassGroup] ([Id])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_ClassGroup]
GO
ALTER TABLE [dbo].[ClassGroup]  WITH CHECK ADD  CONSTRAINT [FK_ClassGroup_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[ClassGroup] CHECK CONSTRAINT [FK_ClassGroup_Parish]
GO
ALTER TABLE [dbo].[ClassGroup]  WITH CHECK ADD  CONSTRAINT [FK_ClassGroup_Parishioner] FOREIGN KEY([ManagedBy])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[ClassGroup] CHECK CONSTRAINT [FK_ClassGroup_Parishioner]
GO
ALTER TABLE [dbo].[ClassMember]  WITH CHECK ADD  CONSTRAINT [FK_ClassMember_Class] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Class] ([Id])
GO
ALTER TABLE [dbo].[ClassMember] CHECK CONSTRAINT [FK_ClassMember_Class]
GO
ALTER TABLE [dbo].[ClassMember]  WITH CHECK ADD  CONSTRAINT [FK_ClassMember_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[ClassMember] CHECK CONSTRAINT [FK_ClassMember_Parishioner]
GO
ALTER TABLE [dbo].[Community]  WITH CHECK ADD  CONSTRAINT [FK_Community_Community] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Community] ([Id])
GO
ALTER TABLE [dbo].[Community] CHECK CONSTRAINT [FK_Community_Community]
GO
ALTER TABLE [dbo].[Community]  WITH CHECK ADD  CONSTRAINT [FK_Community_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[Community] CHECK CONSTRAINT [FK_Community_Parish]
GO
ALTER TABLE [dbo].[Configuration]  WITH CHECK ADD  CONSTRAINT [FK_Configuration_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[Configuration] CHECK CONSTRAINT [FK_Configuration_Parish]
GO
ALTER TABLE [dbo].[ConstructionPermit]  WITH CHECK ADD  CONSTRAINT [FK_ConstructionPermit_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[ConstructionPermit] CHECK CONSTRAINT [FK_ConstructionPermit_Parish]
GO
ALTER TABLE [dbo].[DeaconRequisitionComment]  WITH CHECK ADD  CONSTRAINT [FK_DeaconRequisitionComment_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[DeaconRequisitionComment] CHECK CONSTRAINT [FK_DeaconRequisitionComment_Parish]
GO
ALTER TABLE [dbo].[DeaconRequisitionComment]  WITH CHECK ADD  CONSTRAINT [FK_DeaconRequisitionComment_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[DeaconRequisitionComment] CHECK CONSTRAINT [FK_DeaconRequisitionComment_Parishioner]
GO
ALTER TABLE [dbo].[DeaconRequisitionComment]  WITH CHECK ADD  CONSTRAINT [FK_DeaconRequisitionComment_Priest] FOREIGN KEY([PriestId])
REFERENCES [dbo].[Priest] ([Id])
GO
ALTER TABLE [dbo].[DeaconRequisitionComment] CHECK CONSTRAINT [FK_DeaconRequisitionComment_Priest]
GO
ALTER TABLE [dbo].[DeaconRequisitionComment]  WITH CHECK ADD  CONSTRAINT [FK_DeaconRequisitionComment_VocationDeaconRequisitionSession] FOREIGN KEY([VocationDeaconRequisitionId])
REFERENCES [dbo].[VocationDeaconRequisitionSession] ([Id])
GO
ALTER TABLE [dbo].[DeaconRequisitionComment] CHECK CONSTRAINT [FK_DeaconRequisitionComment_VocationDeaconRequisitionSession]
GO
ALTER TABLE [dbo].[Family]  WITH CHECK ADD  CONSTRAINT [FK_Family_Community] FOREIGN KEY([CommunityId])
REFERENCES [dbo].[Community] ([Id])
GO
ALTER TABLE [dbo].[Family] CHECK CONSTRAINT [FK_Family_Community]
GO
ALTER TABLE [dbo].[FamilyMember]  WITH CHECK ADD  CONSTRAINT [FK_FamilyMember_Family] FOREIGN KEY([FamilyId])
REFERENCES [dbo].[Family] ([Id])
GO
ALTER TABLE [dbo].[FamilyMember] CHECK CONSTRAINT [FK_FamilyMember_Family]
GO
ALTER TABLE [dbo].[FamilyMember]  WITH CHECK ADD  CONSTRAINT [FK_FamilyMember_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[FamilyMember] CHECK CONSTRAINT [FK_FamilyMember_Parishioner]
GO
ALTER TABLE [dbo].[FamilyMigrationRequest]  WITH CHECK ADD  CONSTRAINT [FK_FamilyMigrationRequest_Community] FOREIGN KEY([FromCommunityId])
REFERENCES [dbo].[Community] ([Id])
GO
ALTER TABLE [dbo].[FamilyMigrationRequest] CHECK CONSTRAINT [FK_FamilyMigrationRequest_Community]
GO
ALTER TABLE [dbo].[FamilyMigrationRequest]  WITH CHECK ADD  CONSTRAINT [FK_FamilyMigrationRequest_Family] FOREIGN KEY([FamilyId])
REFERENCES [dbo].[Family] ([Id])
GO
ALTER TABLE [dbo].[FamilyMigrationRequest] CHECK CONSTRAINT [FK_FamilyMigrationRequest_Family]
GO
ALTER TABLE [dbo].[FamilyMigrationRequest]  WITH CHECK ADD  CONSTRAINT [FK_FamilyMigrationRequest_Parish2] FOREIGN KEY([ToParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[FamilyMigrationRequest] CHECK CONSTRAINT [FK_FamilyMigrationRequest_Parish2]
GO
ALTER TABLE [dbo].[LeaveVocationRequisition]  WITH CHECK ADD  CONSTRAINT [FK_LeaveVocationRequisition_Vocation] FOREIGN KEY([VocationId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[LeaveVocationRequisition] CHECK CONSTRAINT [FK_LeaveVocationRequisition_Vocation]
GO
ALTER TABLE [dbo].[Matrimony]  WITH CHECK ADD  CONSTRAINT [FK_Matrimony_Parishioner] FOREIGN KEY([HusbandId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[Matrimony] CHECK CONSTRAINT [FK_Matrimony_Parishioner]
GO
ALTER TABLE [dbo].[Matrimony]  WITH CHECK ADD  CONSTRAINT [FK_Matrimony_Parishioner1] FOREIGN KEY([WifeId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[Matrimony] CHECK CONSTRAINT [FK_Matrimony_Parishioner1]
GO
ALTER TABLE [dbo].[Matrimony]  WITH CHECK ADD  CONSTRAINT [FK_Matrimony_SacramentGroup] FOREIGN KEY([SacramentGroupId])
REFERENCES [dbo].[SacramentGroup] ([Id])
GO
ALTER TABLE [dbo].[Matrimony] CHECK CONSTRAINT [FK_Matrimony_SacramentGroup]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Account]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Parish]
GO
ALTER TABLE [dbo].[Parish]  WITH CHECK ADD  CONSTRAINT [FK_Parish_Priest] FOREIGN KEY([PriestId])
REFERENCES [dbo].[Priest] ([Id])
GO
ALTER TABLE [dbo].[Parish] CHECK CONSTRAINT [FK_Parish_Priest]
GO
ALTER TABLE [dbo].[Parish]  WITH CHECK ADD  CONSTRAINT [FK_Parish_Vicariate] FOREIGN KEY([VicariateId])
REFERENCES [dbo].[Vicariate] ([Id])
GO
ALTER TABLE [dbo].[Parish] CHECK CONSTRAINT [FK_Parish_Vicariate]
GO
ALTER TABLE [dbo].[Parishioner]  WITH CHECK ADD  CONSTRAINT [FK_Parishioner_Community] FOREIGN KEY([CommunityId])
REFERENCES [dbo].[Community] ([Id])
GO
ALTER TABLE [dbo].[Parishioner] CHECK CONSTRAINT [FK_Parishioner_Community]
GO
ALTER TABLE [dbo].[ParishionerMigrationRequest]  WITH CHECK ADD  CONSTRAINT [FK_ParishionerMigrationRequest_Community] FOREIGN KEY([FromCommunityId])
REFERENCES [dbo].[Community] ([Id])
GO
ALTER TABLE [dbo].[ParishionerMigrationRequest] CHECK CONSTRAINT [FK_ParishionerMigrationRequest_Community]
GO
ALTER TABLE [dbo].[ParishionerMigrationRequest]  WITH CHECK ADD  CONSTRAINT [FK_ParishionerMigrationRequest_Parish2] FOREIGN KEY([ToParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[ParishionerMigrationRequest] CHECK CONSTRAINT [FK_ParishionerMigrationRequest_Parish2]
GO
ALTER TABLE [dbo].[ParishionerMigrationRequest]  WITH CHECK ADD  CONSTRAINT [FK_ParishionerMigrationRequest_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[ParishionerMigrationRequest] CHECK CONSTRAINT [FK_ParishionerMigrationRequest_Parishioner]
GO
ALTER TABLE [dbo].[ParishManager]  WITH CHECK ADD  CONSTRAINT [FK_ParishManager_GeneralStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[GeneralStatus] ([Id])
GO
ALTER TABLE [dbo].[ParishManager] CHECK CONSTRAINT [FK_ParishManager_GeneralStatus]
GO
ALTER TABLE [dbo].[ParishManager]  WITH CHECK ADD  CONSTRAINT [FK_ParishManager_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[ParishManager] CHECK CONSTRAINT [FK_ParishManager_Parish]
GO
ALTER TABLE [dbo].[ParishManager]  WITH CHECK ADD  CONSTRAINT [FK_ParishManager_Priest] FOREIGN KEY([PriestId])
REFERENCES [dbo].[Priest] ([Id])
GO
ALTER TABLE [dbo].[ParishManager] CHECK CONSTRAINT [FK_ParishManager_Priest]
GO
ALTER TABLE [dbo].[ParishManager]  WITH CHECK ADD  CONSTRAINT [FK_ParishManager_ThuyenChuyenLinhMuc] FOREIGN KEY([IdThuyenChuyenLinhMuc])
REFERENCES [dbo].[ThuyenChuyenLinhMuc] ([Id])
GO
ALTER TABLE [dbo].[ParishManager] CHECK CONSTRAINT [FK_ParishManager_ThuyenChuyenLinhMuc]
GO
ALTER TABLE [dbo].[ParishManager]  WITH CHECK ADD  CONSTRAINT [FK_ParishManager_VaiTro] FOREIGN KEY([Position])
REFERENCES [dbo].[VaiTro] ([Id])
GO
ALTER TABLE [dbo].[ParishManager] CHECK CONSTRAINT [FK_ParishManager_VaiTro]
GO
ALTER TABLE [dbo].[Priest]  WITH CHECK ADD  CONSTRAINT [FK_Priest_Diocese] FOREIGN KEY([DioceseId])
REFERENCES [dbo].[Diocese] ([Id])
GO
ALTER TABLE [dbo].[Priest] CHECK CONSTRAINT [FK_Priest_Diocese]
GO
ALTER TABLE [dbo].[Priest]  WITH CHECK ADD  CONSTRAINT [FK_Priest_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[Priest] CHECK CONSTRAINT [FK_Priest_Parishioner]
GO
ALTER TABLE [dbo].[ReligiousCommunity]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunity_Vocation] FOREIGN KEY([DirectorId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[ReligiousCommunity] CHECK CONSTRAINT [FK_ReligiousCommunity_Vocation]
GO
ALTER TABLE [dbo].[ReligiousCommunity]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunity_Vocation1] FOREIGN KEY([ViceDirectorId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[ReligiousCommunity] CHECK CONSTRAINT [FK_ReligiousCommunity_Vocation1]
GO
ALTER TABLE [dbo].[ReligiousCommunityBase]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunityBase_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[ReligiousCommunityBase] CHECK CONSTRAINT [FK_ReligiousCommunityBase_Parish]
GO
ALTER TABLE [dbo].[ReligiousCommunityBase]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunityBase_ReligiousCommunity] FOREIGN KEY([ReligiousCommunityId])
REFERENCES [dbo].[ReligiousCommunity] ([Id])
GO
ALTER TABLE [dbo].[ReligiousCommunityBase] CHECK CONSTRAINT [FK_ReligiousCommunityBase_ReligiousCommunity]
GO
ALTER TABLE [dbo].[ReligiousCommunityBase]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunityBase_Vocation] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[ReligiousCommunityBase] CHECK CONSTRAINT [FK_ReligiousCommunityBase_Vocation]
GO
ALTER TABLE [dbo].[ReligiousCommunityManagementTerm]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunityManagementTerm_ReligiousCommunity] FOREIGN KEY([ReligiousCommunityId])
REFERENCES [dbo].[ReligiousCommunity] ([Id])
GO
ALTER TABLE [dbo].[ReligiousCommunityManagementTerm] CHECK CONSTRAINT [FK_ReligiousCommunityManagementTerm_ReligiousCommunity]
GO
ALTER TABLE [dbo].[ReligiousCommunityManagementTerm]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunityManagementTerm_ReligiousCommunityBase] FOREIGN KEY([ReligiousCommunityBaseId])
REFERENCES [dbo].[ReligiousCommunityBase] ([Id])
GO
ALTER TABLE [dbo].[ReligiousCommunityManagementTerm] CHECK CONSTRAINT [FK_ReligiousCommunityManagementTerm_ReligiousCommunityBase]
GO
ALTER TABLE [dbo].[ReligiousCommunityManagementTerm]  WITH CHECK ADD  CONSTRAINT [FK_ReligiousCommunityManagementTerm_Vocation] FOREIGN KEY([VocationId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[ReligiousCommunityManagementTerm] CHECK CONSTRAINT [FK_ReligiousCommunityManagementTerm_Vocation]
GO
ALTER TABLE [dbo].[Sacrament]  WITH CHECK ADD  CONSTRAINT [FK_Sacrament_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[Sacrament] CHECK CONSTRAINT [FK_Sacrament_Parishioner]
GO
ALTER TABLE [dbo].[Sacrament]  WITH CHECK ADD  CONSTRAINT [FK_Sacrament_SacramentGroup] FOREIGN KEY([SacramentGroupId])
REFERENCES [dbo].[SacramentGroup] ([Id])
GO
ALTER TABLE [dbo].[Sacrament] CHECK CONSTRAINT [FK_Sacrament_SacramentGroup]
GO
ALTER TABLE [dbo].[SacramentGroup]  WITH CHECK ADD  CONSTRAINT [FK_SacramentGroup_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[SacramentGroup] CHECK CONSTRAINT [FK_SacramentGroup_Parish]
GO
ALTER TABLE [dbo].[Society]  WITH CHECK ADD  CONSTRAINT [FK_Society_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[Society] CHECK CONSTRAINT [FK_Society_Parish]
GO
ALTER TABLE [dbo].[Society]  WITH CHECK ADD  CONSTRAINT [FK_Society_Parishioner] FOREIGN KEY([ManagedBy])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[Society] CHECK CONSTRAINT [FK_Society_Parishioner]
GO
ALTER TABLE [dbo].[SocietyMember]  WITH CHECK ADD  CONSTRAINT [FK_SocietyMember_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[SocietyMember] CHECK CONSTRAINT [FK_SocietyMember_Parishioner]
GO
ALTER TABLE [dbo].[SocietyMember]  WITH CHECK ADD  CONSTRAINT [FK_SocietyMember_Society] FOREIGN KEY([SocietyId])
REFERENCES [dbo].[Society] ([Id])
GO
ALTER TABLE [dbo].[SocietyMember] CHECK CONSTRAINT [FK_SocietyMember_Society]
GO
ALTER TABLE [dbo].[Vicariate]  WITH CHECK ADD  CONSTRAINT [FK_Vicariate_Diocese] FOREIGN KEY([DioceseId])
REFERENCES [dbo].[Diocese] ([Id])
GO
ALTER TABLE [dbo].[Vicariate] CHECK CONSTRAINT [FK_Vicariate_Diocese]
GO
ALTER TABLE [dbo].[Vicariate]  WITH CHECK ADD  CONSTRAINT [FK_Vicariate_Parish] FOREIGN KEY([ParishId])
REFERENCES [dbo].[Parish] ([Id])
GO
ALTER TABLE [dbo].[Vicariate] CHECK CONSTRAINT [FK_Vicariate_Parish]
GO
ALTER TABLE [dbo].[Vocation]  WITH CHECK ADD  CONSTRAINT [FK_Vocation_Parishioner] FOREIGN KEY([ParishionerId])
REFERENCES [dbo].[Parishioner] ([Id])
GO
ALTER TABLE [dbo].[Vocation] CHECK CONSTRAINT [FK_Vocation_Parishioner]
GO
ALTER TABLE [dbo].[VocationDeaconRequisitionSession]  WITH CHECK ADD  CONSTRAINT [FK_VocationDeaconRequisitionSession_DeaconRequisitionSession] FOREIGN KEY([DeaconRequisitionSessionId])
REFERENCES [dbo].[DeaconRequisitionSession] ([Id])
GO
ALTER TABLE [dbo].[VocationDeaconRequisitionSession] CHECK CONSTRAINT [FK_VocationDeaconRequisitionSession_DeaconRequisitionSession]
GO
ALTER TABLE [dbo].[VocationDeaconRequisitionSession]  WITH CHECK ADD  CONSTRAINT [FK_VocationDeaconRequisitionSession_Vocation] FOREIGN KEY([VocationId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[VocationDeaconRequisitionSession] CHECK CONSTRAINT [FK_VocationDeaconRequisitionSession_Vocation]
GO
ALTER TABLE [dbo].[VocationExchangeReligiousCommunityBase]  WITH CHECK ADD  CONSTRAINT [FK_VocationExchangeReligiousCommunityBase_ReligiousCommunityBase] FOREIGN KEY([OldReligiousCommunityBaseId])
REFERENCES [dbo].[ReligiousCommunityBase] ([Id])
GO
ALTER TABLE [dbo].[VocationExchangeReligiousCommunityBase] CHECK CONSTRAINT [FK_VocationExchangeReligiousCommunityBase_ReligiousCommunityBase]
GO
ALTER TABLE [dbo].[VocationExchangeReligiousCommunityBase]  WITH CHECK ADD  CONSTRAINT [FK_VocationExchangeReligiousCommunityBase_ReligiousCommunityBase1] FOREIGN KEY([NewReligiousCommunityBaseId])
REFERENCES [dbo].[ReligiousCommunityBase] ([Id])
GO
ALTER TABLE [dbo].[VocationExchangeReligiousCommunityBase] CHECK CONSTRAINT [FK_VocationExchangeReligiousCommunityBase_ReligiousCommunityBase1]
GO
ALTER TABLE [dbo].[VocationExchangeReligiousCommunityBase]  WITH CHECK ADD  CONSTRAINT [FK_VocationExchangeReligiousCommunityBase_Vocation] FOREIGN KEY([VocationId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[VocationExchangeReligiousCommunityBase] CHECK CONSTRAINT [FK_VocationExchangeReligiousCommunityBase_Vocation]
GO
ALTER TABLE [dbo].[VocationSeminaryYear]  WITH CHECK ADD  CONSTRAINT [FK_VocationSeminaryYear_SeminaryYear1] FOREIGN KEY([SeminaryYearId])
REFERENCES [dbo].[SeminaryYear] ([Id])
GO
ALTER TABLE [dbo].[VocationSeminaryYear] CHECK CONSTRAINT [FK_VocationSeminaryYear_SeminaryYear1]
GO
ALTER TABLE [dbo].[VocationSeminaryYear]  WITH CHECK ADD  CONSTRAINT [FK_VocationSeminaryYear_Vocation1] FOREIGN KEY([VocationId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[VocationSeminaryYear] CHECK CONSTRAINT [FK_VocationSeminaryYear_Vocation1]
GO
USE [master]
GO
ALTER DATABASE [QLGP] SET  READ_WRITE 
GO

CREATE TABLE [dbo].[HoiDongLinhMuc] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (100) NOT NULL,
    [Description] NVARCHAR (255) NULL,
    [Note]        NVARCHAR (500) NULL,
    CONSTRAINT [PK__HoiDongL__3214EC0793558564] PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[HDLMMember] (
    [PriestID] INT NOT NULL,
    [HdlmID]   INT NOT NULL,
    [Role]     INT NOT NULL,
    CONSTRAINT [PK_HDLMMember] PRIMARY KEY CLUSTERED ([PriestID] ASC, [HdlmID] ASC),
    CONSTRAINT [FK_HDLMMember_Priest] FOREIGN KEY ([PriestID]) REFERENCES [dbo].[Priest] ([Id]),
    CONSTRAINT [FK_HDLMMember_HoiDongLinhMuc] FOREIGN KEY ([HdlmID]) REFERENCES [dbo].[HoiDongLinhMuc] ([Id])
);

