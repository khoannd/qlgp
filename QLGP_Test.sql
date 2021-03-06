
/****** Object:  Table [dbo].[Account]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[BanHanhGiao]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanHanhGiao](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[ParishId] [int] NOT NULL,
 CONSTRAINT [PK_BanHanhGiao] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BanHanhGiaoMember]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanHanhGiaoMember](
	[BanHanhGiaoId] [int] NOT NULL,
	[ParishionerId] [int] NOT NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_BanHanhGiaoMember] PRIMARY KEY CLUSTERED 
(
	[BanHanhGiaoId] ASC,
	[ParishionerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChristianSuggestion]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Class]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ClassGroup]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ClassMember]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Community]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Configuration]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ConstructionPermit]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[DeaconRequisitionComment]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[ParishId] [int] NULL,
	[VocationDeaconRequisitionId] [int] NOT NULL,
 CONSTRAINT [PK_DeaconRequisitionComment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeaconRequisitionSession]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Diocese]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_Diocese_IsDefault]  DEFAULT ((0)),
	[Code] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Diocese] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Donation]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[DonationRank]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[DonationSession]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DonationSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DonationDate] [char](8) NOT NULL,
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
/****** Object:  Table [dbo].[Family]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[CommunityId] [int] NULL,
	[ParishId] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_Family] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FamilyMember]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[FamilyMigrationRequest]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FamilyMigrationRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FamilyId] [int] NOT NULL,
	[ToParishId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[FromCommunityId] [int] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_FamilyMigrationRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeneralStatus]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[GiayMoi]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GiayMoi](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](100) NOT NULL,
	[Loai] [int] NOT NULL,
	[Mau] [ntext] NULL,
	[NgayMoi] [char](10) NULL,
	[NgaySuKien] [char](10) NULL,
	[DiaDiem] [nvarchar](255) NULL,
	[NguoiGoi] [nvarchar](100) NULL,
	[ThoiGian] [char](10) NULL,
	[MauId] [int] NULL,
 CONSTRAINT [PK__GiayMoi__3214EC07F6D8C6F6] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HDLMMember]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HDLMMember](
	[PriestID] [int] NOT NULL,
	[HdlmID] [int] NOT NULL,
	[Role] [int] NOT NULL,
 CONSTRAINT [PK_HDLMMember] PRIMARY KEY CLUSTERED 
(
	[PriestID] ASC,
	[HdlmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoiDongLinhMuc]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoiDongLinhMuc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Note] [nvarchar](500) NULL,
 CONSTRAINT [PK_HoiDongLinhMuc] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachMoi]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachMoi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[ChucDanh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](250) NULL,
	[SoDienThoai] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[GhiChu] [nvarchar](50) NULL,
	[GiayMoiId] [int] NOT NULL,
 CONSTRAINT [PK_KhachMoi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LeaveVocationRequisition]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[LetterAndReport]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LetterAndReport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[Loai] [int] NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[Mau] [ntext] NULL,
 CONSTRAINT [PK_LetterAndReport] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Matrimony]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu](
	[Id] [int] NOT NULL,
	[ScreenId] [varchar](255) NULL,
	[Text] [nvarchar](255) NULL,
	[NewWindow] [bit] NOT NULL CONSTRAINT [DF_Menu_NewWindow]  DEFAULT ((0)),
	[IconClass] [varchar](100) NULL,
	[ParentId] [int] NOT NULL CONSTRAINT [DF_Menu_ParentId]  DEFAULT ((0)),
	[Position] [int] NOT NULL CONSTRAINT [DF_Menu_Position]  DEFAULT ((0)),
	[Visible] [bit] NOT NULL CONSTRAINT [DF_Menu_Visible]  DEFAULT ((1)),
	[MenuType] [int] NULL CONSTRAINT [DF_Menu_MenuType]  DEFAULT ((1)),
	[Link] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Message]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Parish]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[Patron] [nvarchar](255) NULL,
	[PatronDate] [nvarchar](50) NULL,
	[ChauLuot] [nvarchar](100) NULL,
	[Category] [int] NOT NULL DEFAULT ((2)),
	[DioceseId] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_Parish] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Parishioner]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[CommunityId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](100) NULL,
	[LastUpdatedBy] [varchar](100) NULL,
	[Title] [nvarchar](20) NULL,
	[PatronDate] [varchar](4) NULL,
	[ParishId] [int] NULL DEFAULT ((0)),
	[IDNo] [nvarchar](20) NULL,
	[IDDate] [nvarchar](8) NULL,
	[IDPlace] [nvarchar](20) NULL,
 CONSTRAINT [PK_Parishioner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ParishionerMigrationRequest]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParishionerMigrationRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParishionerId] [int] NOT NULL,
	[ToParishId] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[FromCommunityId] [int] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_ParishionerMigrationRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ParishManager]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[ParishName] [nvarchar](255) NULL,
	[ReportType] [nvarchar](20) NULL,
 CONSTRAINT [PK_ParishManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlaceSuggestion]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Priest]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ReligiousCommunity]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ReligiousCommunityBase]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ReligiousCommunityManagementTerm]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ForDiocese] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RolePermission]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RolePermission](
	[ScreenId] [varchar](255) NOT NULL,
	[RoleId] [int] NOT NULL,
	[Permission] [int] NOT NULL CONSTRAINT [DF_RolePermission_Permission]  DEFAULT ((1)),
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[ScreenId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sacrament]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[SacramentGroup]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ScreenAction]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScreenAction](
	[Id] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Enabled] [bit] NOT NULL CONSTRAINT [DF_ScreenAction_Enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_ScreenAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeminaryYear]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Society]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[SocietyMember]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ThuPhanUu]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuPhanUu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaGiaoDan] [int] NOT NULL,
	[NgayMat] [datetime] NOT NULL,
	[ChucVu] [nvarchar](25) NOT NULL,
	[MauThu] [int] NULL,
 CONSTRAINT [PK_ThuPhanUu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThuPhanUu_NguoiNhan]    Script Date: 12/20/2016 11:23:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuPhanUu_NguoiNhan](
	[ThuPhanUuId] [int] NOT NULL,
	[NguoiNhanId] [int] NOT NULL,
	[DaIn] [bit] NULL,
 CONSTRAINT [PK_ThuPhanUu_NguoiNhan] PRIMARY KEY CLUSTERED 
(
	[ThuPhanUuId] ASC,
	[NguoiNhanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThuyenChuyenLinhMuc]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[VaiTro]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[ValueSet]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Vicariate]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[Vocation]    Script Date: 12/20/2016 11:23:28 AM ******/
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
	[IsRetired] [bit] NOT NULL DEFAULT ((0)),
	[TypeCode] [varchar](50) NULL,
	[ServedId] [int] NULL,
	[ServedType] [int] NULL,
	[Place1] [nvarchar](100) NULL,
	[Place2] [nvarchar](100) NULL,
	[Place3] [nvarchar](100) NULL,
	[Place4] [nvarchar](100) NULL,
	[Place5] [nvarchar](100) NULL,
	[Place6] [nvarchar](100) NULL,
	[Place7] [nvarchar](100) NULL,
	[Place8] [nvarchar](100) NULL,
	[Place9] [nvarchar](100) NULL,
	[Giver1] [nvarchar](100) NULL,
	[Giver2] [nvarchar](100) NULL,
	[Giver3] [nvarchar](100) NULL,
	[Giver4] [nvarchar](100) NULL,
	[Giver5] [nvarchar](100) NULL,
	[Giver6] [nvarchar](100) NULL,
	[Giver7] [nvarchar](100) NULL,
	[Giver8] [nvarchar](100) NULL,
	[Giver9] [nvarchar](100) NULL,
	[ServedRole] [int] NULL,
	[ServedStartDate] [nvarchar](8) NULL,
	[Diocesan] [bit] NOT NULL DEFAULT ((1)),
 CONSTRAINT [PK_Vocation] PRIMARY KEY CLUSTERED 
(
	[ParishionerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VocationDeaconRequisitionSession]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[VocationExchangeReligiousCommunityBase]    Script Date: 12/20/2016 11:23:28 AM ******/
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
/****** Object:  Table [dbo].[VocationSeminaryYear]    Script Date: 12/20/2016 11:23:28 AM ******/
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

INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (2, N'admin', N'e10adc3949ba59abbe56e057f20f883e', N'Administrator', CAST(N'2014-10-02 00:00:00.000' AS DateTime), 1, 1, 1, 1)
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
INSERT [dbo].[Account] ([Id], [Username], [Password], [Name], [CreatedDate], [Status], [RoleId], [DioceseId], [ParishId]) VALUES (15, N'nhaplieu', N'e10adc3949ba59abbe56e057f20f883e', N'Nhập Liệu Viên', CAST(N'2016-06-21 17:35:13.570' AS DateTime), 1, 5, 1, 2)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[BanHanhGiao] ON 

INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (1, N'Khoan', NULL, NULL, 2)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (2, N'BHG1', NULL, NULL, 2)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (3, N'BHG3', NULL, NULL, 2)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (4, N'BHG4', CAST(N'2016-02-06 00:00:00.000' AS DateTime), CAST(N'2016-08-07 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (5, N'BHG5', NULL, NULL, 3)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (6, N'BHG6', NULL, NULL, 1)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (8, N'BHG7', CAST(N'2016-07-07 00:00:00.000' AS DateTime), CAST(N'2017-08-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (11, N'BHG8', NULL, NULL, 1)
INSERT [dbo].[BanHanhGiao] ([Id], [Name], [FromDate], [ToDate], [ParishId]) VALUES (12, N'BHG9', CAST(N'2016-01-07 00:00:00.000' AS DateTime), CAST(N'2018-07-07 00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[BanHanhGiao] OFF
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (0, 195, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (0, 205, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (0, 1811, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (1, 808, 1)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 150, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 166, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 172, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 173, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 221, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 222, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 223, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 808, 1)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 809, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (4, 1809, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (6, 1811, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (8, 808, NULL)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (11, 810, 5)
INSERT [dbo].[BanHanhGiaoMember] ([BanHanhGiaoId], [ParishionerId], [RoleId]) VALUES (12, 205, 5)
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

INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (1, N'Chưa rõ', 1, NULL, 1)
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
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (27, N'Chưa rõ', 1, NULL, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (28, N'Gia Phong', 0, NULL, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (29, N'Phong Gia', 0, 28, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (30, N'Phong Lưu', 0, 28, 12)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (31, N'Chưa rõ', 1, NULL, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (32, N'Quang Phú', 0, NULL, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (33, N'Tân Phong', 0, NULL, 1)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (34, N'Tài Phong', 0, NULL, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (35, N'Quang Tây', 0, 32, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (36, N'Quang Đông', 0, 32, 13)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (37, N'Gia Định 1', 0, 11, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (38, N'Gia Định 2', 0, 11, 9)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (39, N'Chưa rõ', 1, NULL, 14)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (40, N'Chưa rõ', 1, NULL, 15)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (41, N'Chưa rõ', 1, NULL, 16)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (42, N'Chưa rõ', 1, NULL, 17)
INSERT [dbo].[Community] ([Id], [Name], [IsDefault], [ParentId], [ParishId]) VALUES (43, N'Ngoài xứ', 1, NULL, 18)
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
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (14, 0, 1, N'', 1, 1, N'', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (15, 0, 1, N'', 1, 1, N'', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (16, 0, 1, N'', 1, 1, N'', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (17, 0, 1, N'', 1, 1, N'', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Configuration] ([ParishId], [MultipleParishionerAdding], [ParishionerCodeGeneration], [ParishionerPrefix], [ParishionerCharacterNumber], [FamilyCodeGeneration], [FamilyPrefix], [FamilyCharacterNumber], [BaptismTemplate], [HolyCommunionTemplate], [ConfirmationTemplate], [MatrimonyTemplate], [SacramentTemplate]) VALUES (18, 0, 1, N'', 1, 1, N'', 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ConstructionPermit] ON 

INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (41, 3, 2, NULL, N'UploadFiles/ĐƠN ĐỀ NGHỊ CẤP GIẤY PHÉP XÂY DỰNG NHÀ Ở.docx', 2, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (42, 1, 9, NULL, N'UploadFiles/ĐƠN ĐỀ NGHỊ CẤP GIẤY PHÉP XÂY DỰNG TẠM.doc', 3, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (43, 2, 8, NULL, N'UploadFiles/ĐƠN XIN CẤP GIẤY PHÉP XÂY DỰNG.docx', 3, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (44, 1, 9, N'Xin xây dựng nhà thờ', N'UploadFiles/Message-20160310-025753.pdf', 2, NULL)
INSERT [dbo].[ConstructionPermit] ([Id], [PermitType], [ParishId], [Description], [FilePath], [PermitStatus], [Note]) VALUES (45, 2, 2, NULL, N'UploadFiles/newyear-1.jpg', 2, NULL)
SET IDENTITY_INSERT [dbo].[ConstructionPermit] OFF
SET IDENTITY_INSERT [dbo].[Diocese] ON 

INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church], [IsDefault], [Code]) VALUES (1, N'/Content/assets/avatars/giaophan.jpg', N'Hồ Chí Minh', N'12/4 Xô Viết Nghệ Tĩnh', N'www.toathanh.com.vn', N'0909 090 909', N'tuanhmsilver#abc@gmail.com', NULL, N'Toa nha Chanh xu', 1, N'HCM       ')
INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church], [IsDefault], [Code]) VALUES (2, N'/Content/assets/avatars/giaophan.jpg', N'Đà Lạt', N'aa', NULL, NULL, NULL, NULL, NULL, 0, N'DL        ')
INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church], [IsDefault], [Code]) VALUES (3, N'/Images/Dioceses/062672af-31ad-4412-a39a-e01145deba24.jpg', N'Nha Trang', N'TP THNha Trang', N'www.gpnhatrang.org', N'0989 888 7890', N'gpnhatrang@gmail.com', NULL, N'Giao xu chinh toa', 0, N'NT        ')
INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church], [IsDefault], [Code]) VALUES (4, N'/Images/Dioceses/2a3d2754-0c06-487f-8fa5-a1acaa629bcb.jpg', N'Phú Cường', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'PC')
INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church], [IsDefault], [Code]) VALUES (5, N'', N'Hải Ngoại', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'HAINGOAI')
INSERT [dbo].[Diocese] ([Id], [ImageUrl], [Name], [Address], [Website], [Phone], [Email], [Bishop], [Church], [IsDefault], [Code]) VALUES (6, N'', N'Hải Ngoại', NULL, NULL, NULL, NULL, NULL, NULL, 0, N'HAINGOAI')
SET IDENTITY_INSERT [dbo].[Diocese] OFF
SET IDENTITY_INSERT [dbo].[Donation] ON 

INSERT [dbo].[Donation] ([Id], [ParishionerID], [DonationLevel], [CertificateID]) VALUES (1, 152, NULL, NULL)
INSERT [dbo].[Donation] ([Id], [ParishionerID], [DonationLevel], [CertificateID]) VALUES (2, 803, NULL, NULL)
INSERT [dbo].[Donation] ([Id], [ParishionerID], [DonationLevel], [CertificateID]) VALUES (3, 152, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Donation] OFF
SET IDENTITY_INSERT [dbo].[DonationSession] ON 

INSERT [dbo].[DonationSession] ([Id], [DonationDate], [ReceiptID], [Note], [DonationID], [Currency], [InputValue], [FinalValue], [ExchangeRate], [ReceiptDate]) VALUES (1, N'20160529', NULL, NULL, 1, N'VND', 3000000, 3000000, 1, N'        ')
INSERT [dbo].[DonationSession] ([Id], [DonationDate], [ReceiptID], [Note], [DonationID], [Currency], [InputValue], [FinalValue], [ExchangeRate], [ReceiptDate]) VALUES (2, N'20160529', NULL, NULL, 2, N'VND', 3000000, 3000000, 1, N'        ')
INSERT [dbo].[DonationSession] ([Id], [DonationDate], [ReceiptID], [Note], [DonationID], [Currency], [InputValue], [FinalValue], [ExchangeRate], [ReceiptDate]) VALUES (3, N'20160609', NULL, NULL, 3, N'VND', 3000000, 3000000, 1, N'        ')
SET IDENTITY_INSERT [dbo].[DonationSession] OFF
SET IDENTITY_INSERT [dbo].[Family] ON 

INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (3, N'MGĐTN01', N'Tuấn - Quân', N'0932044068', N'66/16 Tây H?', N'Nothing to do here', 0, NULL, 1, -1, 5, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (7, N'GĐTN01', N'Khôi - Tuấn', N'0932 044 023', N'66/16 ?p Ninh Bình Xã Ninh Thu?n', N'test ghi chú các b?n', 0, NULL, 0, 1, 8, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (10, N'GĐTN02', N'Khôi - Quân', N'0844 688 8741', N'128 Chung cu Lô A Lý Thu?ng Ki?t', N'ttttttt', 0, NULL, 1, -1, 9, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (11, N'GĐTN03', N'Mẫn - Thành', N'0838 463 2154', N'66/16 Xô Vi?t Ngh? Tinh', N'asdfasdfasdf', 0, NULL, 0, 1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (12, N'GĐTN04', N'Khôi - Mẫn Mẫn', N'0846 987 7796', N'test', N'asdasasdasdasd', 0, NULL, 1, -1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (17, N'GĐTN05', N'Khôi - Trung', N'0838 403 154', N'sdfsdfdsf65448', N'sdfsdfsdfasdfasdf', 0, NULL, 1, -1, 9, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (18, N'GĐTN06', N'Trung - Mai', NULL, N'test d?a ch? nhà', N'dfgdfgslkgjgjks;dfklg', 0, NULL, 1, -1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (19, N'GĐTN07', N'Phong - Phương', N'0838 403 248', N'66/16 XVNT', N'test ghi chu', 0, NULL, 1, -1, 8, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (20, N'GĐTN08', N'Lê - Mận', N'0838 403 624', N'123 Xô Vi?t Ngh? Tinh', N'test', 0, NULL, 1, -1, 8, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (21, N'GĐTN09', N'Mẫn - Vy', N'0838 402 4444', N'123 Lô A Quang Trung', N'test ghi chú', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (22, N'GĐTN10', N'Phong - Lê', N'0832 184 8787', N'123 XVNT Phong K?', N'sdafasdfasdfasdfasdf', 0, NULL, 1, 0, 9, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (23, N'GĐTN11', N'Mẫn - Lưu', N'0838 403 624', N'123123 AAAAa', N'test', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (24, N'GĐTN12', N'Phong - Lưu', N'0843 154 8787', N'sadfasdfasdfa', N'asdfasdfasdfasdf', 0, NULL, 1, 1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (25, N'GĐTN13', N'Mẫn - Lưu', N'0838 403 2454', N'66/16 Xô Vi?t Ngh? Tinh', N'sdfasfasdfasdfasdf', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (26, N'GĐTN14', N'Lê - Thanh', N'0834 848 487', N'qwerqwerqwerqwer', N'asdfasfasfafsdf', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (27, N'GĐTN15', N'Khôi - Mẫn', N'0838 465 215', N'66/16 Xô Vi?t Ngh? Tinh', N'test ghi chú nè', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (28, N'GĐTN16', N'Mẫn - Đạt', N'0838 403 2454', N'24234234', N'sadfasdfasdf', 0, NULL, 1, -1, 8, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (35, N'GĐTN17', N'Hậu - Vân', N'0832 165 484', N'66/16 Xô Vi?t Ngh? Tinh', N'asdasdasdadadadad', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (36, N'GĐTN18', N'Khanh - Đức', N'0932 232 323', N'66/16 Xô Vi?t Ngh? Tinh P.21 QBT', N'test ghi chú', 0, NULL, 1, 0, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (37, N'GĐTN19', N'Phong - Kim', N'0838 403 624', N'qwerqwrqwerqwer', N'test', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (38, N'GĐTN20', N'Khang - Phụng', N'0838 403 624', N'66/16 Hoàng Qu?c Vi?t', N'test ghi chú', 0, NULL, 1, 1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (39, N'GĐTN21', N'Phong - Vân', N'0838 403 624', N'66/15 Xô Vi?t Ngh? Tinh', N'093204423', 0, NULL, 1, -1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (40, N'GĐTN22', N'Phong - Lữ', N'0838 403 624', N'66/16 Xô Vi?t Ngh? Tinh', NULL, 0, NULL, 1, -1, 16, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (41, N'GĐTN23', N'Trung - Quốc', N'8038 403 624', N'123/A Lãng Ðông', NULL, 0, NULL, 1, 1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (42, N'GĐTN24', N'Lưu - Mẫn', N'0838 403 624', N'66/16 CMT8', N'ghi chú thông tin', 0, NULL, 1, 1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (43, N'GĐTN25', N'Lượng - Khối', N'0838 403 624', N'66/16 Xô Vi?t Ngh? Tinh', N'test ghi chú tuấn', 0, NULL, 1, 0, 19, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (44, N'GĐTN26', N'Văn - Quốc', N'0129 312 313', NULL, NULL, 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (45, N'GĐTN27', N'Phong - Lê', N'0932 040 423', N'66/16 Xô Vi?t Ngh? Tinh', N'test ghi chú', 0, NULL, 1, 1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (46, N'GĐTN28', N'Mẫn - Phương', N'0838 403 624', N'66/16 Ngô Tất Tố', N'Test thử ghi chú nha em', 0, NULL, 1, 1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (47, N'GĐTN29', N'Linh - Lực', N'0831 222 4444', N'123 Quang Trung Phường 10 Gò Vấp', N'test edit thông tin gia đình', 2, N'alo 123', 1, -1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (48, N'GĐTN30', N'Phong - Lưu', N'0838 403 624', N'123 Trần Quốc Lượng P 19. Q BT', N'asdfasdfasdfasdf', 0, NULL, 1, -1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (51, N'GĐTN31', N'Mẫn - Trung', N'0838 403 624', N'66/16 Lâm Phong', N'nhà này có nhiều hơn 1 người', 0, NULL, 1, 1, 15, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (52, N'GĐTN32', N'Phong - Ngữ', N'0846 321 5487', N'321 Trần Quốc Toản', N'test ghi chú về đây', 0, N'', 1, 1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (53, N'GĐTN33', N'Phương - Linh', N'0123 456 7897', N'123 BCDEF', N'test ghi chú abc def', 1, N'Thị Nghè', 1, 1, 14, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (54, N'GĐTN34', N'Tỉnh - Dung', N'0932 044 023', N'123/8 Hàm Nghi P.21 Q Phú Nhuận', N'Gia đình có 2 người đã bị chuyển xứ', 0, NULL, 1, -1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (55, N'GĐTN35', N'Phong - Lâm', N'0932 044 0423', NULL, NULL, 1, N'Thị Nghè', 1, 1, 11, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (56, N'GĐTN32', N'Vàng - Bạc', N'0932 204 4087', N'66/16 Xô Viết Nghệ Tĩnh', N'test ghi chú', 0, NULL, 1, 1, 15, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (57, N'GĐTN33', N'Kha - Lân', N'9032 404 4484', NULL, NULL, 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (58, N'GĐTN33', N'Linh - Phú', NULL, NULL, NULL, 0, NULL, 1, -1, 16, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (63, N'GĐTN33', N'Tấn - Mai', NULL, NULL, NULL, 0, NULL, 1, 0, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (64, N'GĐTN34', N'Minh - Phong', N'0932 044 023', N'123 Tô Hiến Thành', N'test ghi chú', 0, NULL, 0, 1, 9, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (65, N'GĐTN35', N'Cát - Vàng', NULL, NULL, NULL, 0, NULL, 1, 1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (66, N'GĐTN36', N'Linh - Vương', NULL, NULL, N'test ghi chú', 0, NULL, 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (67, N'GĐTN37', N'Phong - Lưu', N'0932 044 023', N'66/16 Xô Viết Nghệ Tĩnh', NULL, 0, N'thị nghè', 1, 1, 26, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (68, N'GĐTN38', N'Tân - Bình', N'0932 040 423', N'66/16 Xô Viết Nghệ Tĩnh', N'ABCDEF', 2, N'abcdef', 1, -1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (69, N'GĐTN38', N'Khôi - Tuấn', NULL, NULL, NULL, 0, N'', 1, 1, 11, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (70, N'GĐTN39', N'Phong - Lưu', N'0932 023 023', N'66/16 Xô Viết Nghệ Tĩnh', NULL, 0, N'', 1, 1, 11, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (71, N'GĐTN38', N'Khôi - Phụng', NULL, NULL, NULL, 0, NULL, 1, -1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (72, N'GĐTN39', N'Khôi - Phụng', NULL, NULL, NULL, 0, NULL, 1, -1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (73, N'GĐTN40', N'Khôi - Phụng', NULL, NULL, NULL, 0, NULL, 1, 1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (74, N'GĐTN41', N'Phong - Vân', N'0838 403 624', N'66/12A XVNT P.21 Quận Bình Thạnh', NULL, 0, NULL, 1, 1, 10, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (75, N'GĐTN42', N'Vân - Lan', NULL, NULL, NULL, 0, NULL, 1, 1, 26, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (76, N'GĐTN43', N'Thiên - Thu', NULL, NULL, NULL, 1, N'Thị Nghè', 1, 1, 13, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (77, N'GĐTN43', N'Nhã - Thanh', N'0838 422 3311', N'123 CMT8', NULL, 0, NULL, 1, 1, 7, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (78, N'GĐTN44', N'Khôi - Thu', NULL, NULL, NULL, 0, NULL, 1, 1, 17, NULL)
INSERT [dbo].[Family] ([Id], [Code], [Name], [Phone], [Address], [Note], [DomicileStatus], [DomicilePlace], [IsCounted], [Status], [CommunityId], [ParishId]) VALUES (79, N'GĐTN45', N'Hồng - Hương', NULL, NULL, NULL, 0, NULL, 1, 1, 9, NULL)
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
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (62, 55, 60, 1, 0, 1)
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
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (98, 69, 53, 1, 0, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (99, 70, 165, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (100, 70, 193, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (101, 70, 189, 4, 0, 0)
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
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (148, 73, 222, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (149, 73, 54, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (150, 78, 93, 4, 0, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (151, 78, 214, 4, 1, 0)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (152, 79, 1814, 1, 1, 1)
INSERT [dbo].[FamilyMember] ([Id], [FamilyId], [ParishionerId], [Position], [Status], [IsHouseholder]) VALUES (153, 79, 1813, 3, 1, 0)
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
SET IDENTITY_INSERT [dbo].[GiayMoi] ON 

INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (34, N'Giấy mời tham dự đại hội Giới trẻ', 12, N'<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]-->

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; TÒA
GIÁM MỤC XUÂN LỘC <span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">CỘNG
HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt" align="center"><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp; </span>2 Hùng Vương </span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Xu</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">â</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">n
B</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;
mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">ì</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
<span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Độc Lập </span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
T</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ự</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Do </span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> H</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ạ</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh
Ph</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ú</span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">c</span></b></p>

<p class="MsoNormal" style="margin-left:-7.1pt;text-align:justify;tab-stops:center 63.8pt 349.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp; </span>Long
Khánh </span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> </span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">Đồ</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ng Nai</span></b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> </span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> </span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:
10.0pt;mso-bidi-font-size:11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Số
: </span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">362</span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">-</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">2013</span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">/TGM<span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b></p>

<p class="MsoNormal" style="text-align:right" align="right"><span style="font-size:
7.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><i style="mso-bidi-font-style:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Long Khánh, </span></i><i style="mso-bidi-font-style:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">[NgayHienTai]</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></i>

</p><p class="MsoNormal"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="text-align:center" align="center"><b style="mso-bidi-font-weight:
normal"><span style="font-size:18.0pt;mso-bidi-font-size:22.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">GIẤY XÁC NHẬN</span></b></p>

<p class="MsoNormal" style="margin-top:3.0pt;text-align:center" align="center"><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"><br></span></span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"><span style="mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span></span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></p>

<p class="MsoNormal" style="text-align:center" align="center"><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="text-align:center" align="center"><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:2.0cm;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Tôi,
</span><b style="mso-bidi-font-weight:normal"><span style="font-size:13.5pt;
mso-bidi-font-size:12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">[TenNguoiGoi]</span></b><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, Tổng Đại diện Giáo phận <br>
Xuân Lộc,</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xác
nhận </span><b style="mso-bidi-font-weight:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">,</span></b><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> giáo xứ <b style="mso-bidi-font-weight:normal">Xxxx Xxxx <span style="mso-spacerun:yes">&nbsp;</span></b>nằm trong địa bàn (địa chỉ phường xã)</span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được thành
lập từ năm yyyy</span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được cơ
quan có thẩm quyền chính thức công nhận năm yyyy, có diện tích đất đai là ###########
m<sup>2</sup> gồm thửa đất số ### tờ bản đồ số ###; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>tờ bản đồ số </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span>và thuộc về Tòa Giám mục Xuân Lộc.</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Kính
đề nghị Ủy ban Nhân dân tỉnh Đồng Nai, Sở Tài nguyên và Môi trường xem xét giải
quyết và cấp giấy chứng nhận quyền sử dụng đất cho </span><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><b style="mso-bidi-font-weight:normal">Xxxx Xxxx <span style="mso-spacerun:yes">&nbsp;</span></b></span><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><b> </b></span><b style="mso-bidi-font-weight:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes"></span></span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes"></span></span></b><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:78.0pt;margin-bottom:.0001pt;text-align:justify"><span style="font-size:1.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:42.55pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xin
chân thành cám ơn Quý Ban và trân trọng kính chào.</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="tab-stops:center 319.2pt" align="center"><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:
1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.5pt;mso-bidi-font-size:
12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Linh mục </span></b><font size="3"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Vinhsơn
Đặng Văn Tú</span></b></font></p><div align="center">

<b style="mso-bidi-font-weight:normal"><span style="font-size:13.5pt;
mso-bidi-font-size:12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-fareast-font-family:
&quot;Times New Roman&quot;;mso-bidi-font-family:&quot;Times New Roman&quot;;mso-ansi-language:
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Tổng Đại diện Giáo phận Xuân Lộc </span></b></div>

                                    ', N'09/04/2016', N'28/04/2016', N'75 Huỳnh Thúc Kháng, Phường Bến Thành, Quận 1, Tp. Hồ Chí Minh', N'Giuse Nguyen Van A', N'10:15am   ', 15)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (35, N'Khánh thành nhà thờ', 9, N'Cộng hòa xã hội chủ nghĩa việt nam', N'10/04/2016', N'11/05/2016', N'2/20 Bình Giã, Phường 13, Quận Tân Bình, Thành Phố Hồ Chí Minh', N'Giuse Nguyen Van A', N'7:00pm    ', 12)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (165, N'Ngũ Thử team', 2, N'Cộng hòa xã hội chủ nghĩa việt nam', N'25/04/2016', N'21/04/2016', N'Công Viên Phần Mềm Quang Trung Tô Kỹ', N'Giuse Nguyen Van A', N'2:30pm    ', 12)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (168, N'Giấy mời test', 1, N'<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]-->

<div><p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; &nbsp;</span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt">&nbsp;&nbsp;&nbsp;&nbsp; <b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">TÒA GIÁM MỤC XUÂN LỘC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">CỘNG
HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; 210 Hùng Vương </span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Xu</span></b><b><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">â</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">n
B</span></b><b><span style="font-size:11.0pt;
mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">ì</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Độc Lập </span></b><b><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
T</span></b><b><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ự</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Do </span></b><b><span style="font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> H</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ạ</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh
Ph</span></b><b><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ú</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">c<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-left:-7.1pt;text-align:justify;tab-stops:center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; Long
Khánh </span></b><b><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> </span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">Đồ</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ng Nai</span></b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">µ</span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><b><span style="font-size:
10.0pt;mso-bidi-font-size:11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;Số
: </span></b><!--[if supportFields]><b style=''mso-bidi-font-weight:normal''><span
style=''font-size:10.0pt;mso-bidi-font-size:11.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD No <span style=''mso-element:field-separator''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">362</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">-</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span>
MERGEFIELD Nam_ <span style=''mso-element:field-separator''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">2013</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">/TGM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></b></p>

<p class="MsoNormal" align="right" style="text-align:right"><span style="font-size:
7.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="right" style="text-align:right"><i><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Long Khánh, [NgayHienTai]</span></i></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal" align="center" style="text-align:center"><b><span style="font-size:18.0pt;mso-bidi-font-size:22.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">GIẤY XÁC NHẬN<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-top:3.0pt;text-align:center"><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" align="center" style="text-align:center"><b>&nbsp;</b></p>

<p class="MsoNormal" align="center" style="text-align:center"><b>&nbsp;</b></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:2.0cm;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Tôi, </span><span style="font-family: ''UTM Times'', serif; font-size: 18px; line-height: 27px;"><b>[TenDucGiamMuc]</b></span><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, Tổng Đại diện Giáo phận <br>
Xuân Lộc,<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xác
nhận </span><!--[if supportFields]><b style=''mso-bidi-font-weight:normal''><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_ho </span></b><![endif]--><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">,</span></b><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> giáo xứ <b>Xxxx Xxxx &nbsp;</b>nằm trong địa bàn (địa chỉ phường xã)</span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span> MERGEFIELD Diachi <span
style=''mso-element:field-separator''></span></span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được thành
lập từ năm yyyy</span><!--[if supportFields]><span style=''font-size:14.0pt;
mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span> MERGEFIELD Thành_lập </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được cơ
quan có thẩm quyền chính thức công nhận năm yyyy, có diện tích đất đai là ###########
m<sup>2</sup> gồm thửa đất số ### tờ bản đồ số ###; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_2 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__2 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_3 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__3 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_4 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__4 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_5 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__5 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_6 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__6 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_7 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__7 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_8 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__8 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_9 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__9 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;và thuộc về Tòa Giám mục Xuân Lộc.<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Kính
đề nghị Ủy ban Nhân dân tỉnh Đồng Nai, Sở Tài nguyên và Môi trường xem xét giải
quyết và cấp giấy chứng nhận quyền sử dụng đất cho </span><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_ho </span></b><![endif]--><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_xu <span style=''mso-element:
field-separator''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Thánh Giuse</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:78.0pt;margin-bottom:.0001pt;text-align:justify"><span style="font-size:1.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:42.55pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xin
chân thành cám ơn Quý Ban và trân trọng kính chào.<o:p></o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="text-align: right;"><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-size:13.5pt;mso-bidi-font-size:
12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Linh mục [TenNguoiGoi]</span></b></p>

<p class="MsoNormal" style="text-align: right;"><b><span style="font-size:13.5pt;mso-bidi-font-size:12.5pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tổng
Đại diện Giáo phận Xuân Lộc <o:p></o:p></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p></div>

                                    ', N'07/05/2016', N'18/05/2016', N'Công viên quan trung quận 12', N'Giuse Nguyen Van A', N'11:15pm   ', 15)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (172, N'Giấy nhận xét', 11, N'<p class="MsoNormal" style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
margin-left:-14.2pt;margin-bottom:.0001pt;text-align:justify;text-indent:-7.1pt;
line-height:normal;tab-stops:center 2.0cm 349.8pt"><b><span style="mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp;TÒA
GIÁM MỤC XUÂN LỘC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p></o:p></span></b></p><p class="MsoNormal" style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
margin-left:-21.3pt;margin-bottom:.0001pt;text-align:justify;text-indent:-7.1pt;
line-height:normal;tab-stops:center 2.0cm 349.8pt"><b><span style="mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp; 210
Hùng Vương – Xuân Bình</span></b><b><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:
&quot;Times New Roman&quot;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></b></p><p class="MsoNormal" style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
margin-left:-7.1pt;margin-bottom:.0001pt;text-align:justify;text-indent:-7.1pt;
line-height:normal;tab-stops:center 2.0cm 349.8pt"><b><span style="mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp; Long
Khánh – Đồng Nai</span></b><span style="mso-bidi-font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:7.1pt;margin-bottom:.0001pt;text-indent:-7.1pt;line-height:normal;
tab-stops:center 2.0cm 349.8pt"><b><span style="mso-bidi-font-size:12.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp; Số :
174-2009/TGM<o:p></o:p></span></b></p><p class="MsoNormal" style="margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
margin-left:-21.3pt;margin-bottom:.0001pt;text-align:justify;text-indent:-7.1pt;
line-height:normal;tab-stops:center 49.65pt 2.0cm right 467.8pt"><span style="mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-family:Wingdings;mso-ascii-font-family:&quot;Times New Roman&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;;
mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span><span style="mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">
</span><span style="font-family:Wingdings;mso-ascii-font-family:&quot;Times New Roman&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;;
mso-char-type:symbol;mso-symbol-font-family:Wingdings">{</span><span style="mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">
</span><span style="font-family:Wingdings;mso-ascii-font-family:&quot;Times New Roman&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-hansi-font-family:&quot;Times New Roman&quot;;
mso-char-type:symbol;mso-symbol-font-family:Wingdings"></span><span style="mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><i><span style="font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p></o:p></span></i></p><p class="MsoNormal" align="right" style="margin-top:6.0pt;margin-right:0cm;
margin-bottom:0cm;margin-left:0cm;margin-bottom:.0001pt;text-align:right;
line-height:normal"><i><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:
&quot;Times New Roman&quot;">Xuân Lộc, [NgayHienTai]</span></i></p><p class="MsoNormal" align="right" style="margin-top:6.0pt;margin-right:0cm;
margin-bottom:0cm;margin-left:0cm;margin-bottom:.0001pt;text-align:right;
line-height:normal"><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:0cm;margin-bottom:.0001pt;line-height:normal"><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:
&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:0cm;margin-bottom:.0001pt;line-height:normal"><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:
&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:36.0pt;margin-bottom:.0001pt;text-indent:36.0pt;line-height:normal"><i><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">Cha
thân mến,<o:p></o:p></span></i></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:36.0pt;margin-bottom:.0001pt;text-indent:36.0pt;line-height:normal"><i><span style="font-size:1.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></i></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:36.0pt;margin-bottom:.0001pt;text-align:justify;text-indent:36.0pt;
line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">Theo
Giáo luật khoản 1031 và 1032, trước khi được phong chức linh mục, các chủng
sinh cần có một thời gian thích hợp để thực hành chức phó tế; và phải có khoảng
cách ít là sáu tháng giữa chức phó tế và chức linh mục.<o:p></o:p></span></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:36.0pt;margin-bottom:.0001pt;text-align:justify;text-indent:36.0pt;
line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">Nay
tôi gửi đến Cha DANH SÁCH ỨNG VIÊN PHÓ TẾ của giáo phận Xuân Lộc kỳ này, cùng
với một bản mẫu nhận xét về các ứng viên. Xin Cha vui lòng cho tôi biết nhận
xét của Cha về các thầy, đặc biệt những thầy có liên hệ, và xin Cha gửi bản trả
lời về Văn phòng Tòa Giám mục <b><i>trước ngày [NgaySuKien].</i></b><o:p></o:p></span></p><p class="MsoNormal" style="margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:36.0pt;margin-bottom:.0001pt;text-align:justify;text-indent:36.0pt;
line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">Chân
thành cám ơn Cha và xin Cha thêm lời cầu nguyện cho tôi.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal;tab-stops:center 12.0cm"><b><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;letter-spacing:.1pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-size:13.0pt;font-family:
Wingdings;mso-ascii-font-family:&quot;Times New Roman&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;;
mso-hansi-font-family:&quot;Times New Roman&quot;;letter-spacing:.1pt;mso-char-type:symbol;
mso-symbol-font-family:Wingdings">U</span></b><b><span style="font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:
&quot;Times New Roman&quot;;letter-spacing:.1pt">&nbsp;[TenDucGiamMuc]<o:p></o:p></span></b></p><p class="MsoNormal" style="margin-bottom:0cm;margin-bottom:.0001pt;text-align:
justify;line-height:normal;tab-stops:center 12.0cm"><b><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;;mso-fareast-font-family:&quot;Times New Roman&quot;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;Giám
mục Giáo phận Xuân Lộc<o:p></o:p></span></b></p><p class="MsoNormal" align="center" style="margin-bottom:0cm;margin-bottom:.0001pt;
text-align:center;line-height:normal;page-break-before:always"><br></p>

                                    ', N'03/06/2016', N'30/06/2016', NULL, N'Giuse Đinh Văn Mẫn', NULL, 16)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (173, N'Moi cong viec', 2, N'<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"></o:shapedefaults>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"></o:idmap>
 </o:shapelayout></xml><![endif]-->

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:right" align="right"><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Xuân Lộc, ngày </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">28</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> tháng </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">1</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> năm </span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">2010</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></i></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-size:1.0pt;mso-bidi-font-size:12.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="margin-left:1.0cm;text-align:center" align="center"><b style="mso-bidi-font-weight:normal"><span style="font-size:19.0pt;mso-bidi-font-size:
18.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">THƯ PHÂN ƯU</span></b></p>

<p class="MsoNormal"><span style="mso-ignore:vglayout">

</span></p><table align="left" cellpadding="0" cellspacing="0" height="39" width="219">
 <tbody><tr>
  <td height="13" width="219"><br></td>
 </tr>
 <tr>
  <td><br></td>
  <td><br></td></tr></tbody></table><p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
134.25pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:9.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<br style="mso-ignore:vglayout" clear="ALL">

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:106.35pt;margin-bottom:.0001pt;text-align:justify;text-indent:
49.6pt;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">K</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ính gửi : XXX XXXX Xxxxxx Xxxxx Xxxxxx </span></b></p>

<p class="MsoNormal" style="margin-top:2.0pt;text-align:justify;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="mso-spacerun:yes">&nbsp;&nbsp; </span>Xxxxx Xxxxx Xxxxx XXXX</span></b></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:5.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> thân mến,</span></i></p>

<p class="MsoNormal" style="margin-left:29.75pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:7.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Chúng tôi xin gởi đến </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến những lời phân ưu chân thành nhất. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.75pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Sự ra đi của </span><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Xxxx Xxxxx Xxxxx XXXXX</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"> </span></b><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:
.2pt">để lại nhiều thương nhớ cho mọi người, nhất là cho </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến. Tuy nhiên, trong niềm tin vào Đức Kitô Khổ
nạn và Phục sinh, chúng ta tin rằng </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> đang trên đường tiến về quê trời vinh phúc.</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">Chúng tôi xin hiệp với </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">, với Tang quyến và cộng đoàn phụng vụ trong Thánh lễ an
táng, cầu nguyện cho </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:-.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"> được sớm về hưởng nhan thánh Chúa. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Chúng
ta tin rằng, một khi về bên Chúa, </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> sẽ bầu cử
cho chúng ta một cách hiệu quả trước tòa Chúa.</span></p>

<p class="MsoNormal" style="text-align:justify"><span style="font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Thân
ái chào </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> và chân
thành phân ưu với </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
<b style="mso-bidi-font-weight:normal">XXXXXX XXXXXX XXXXXX</b></span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục giáo phận Xuân Lộc</span></b></p>

<p class="MsoNormal" style="margin-top:3.0pt;text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:4.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> XXXXX XXXX XXXXX XXXXX</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục Phụ tá</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>



                                    ', NULL, NULL, NULL, N'Nguyen Manh Hung', NULL, 14)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (174, N'Moi cong viec', 2, N'<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"></o:shapedefaults>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"></o:idmap>
 </o:shapelayout></xml><![endif]-->

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:right" align="right"><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Xuân Lộc, ngày </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">28</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> tháng </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">1</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> năm </span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">2010</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></i></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-size:1.0pt;mso-bidi-font-size:12.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="margin-left:1.0cm;text-align:center" align="center"><b style="mso-bidi-font-weight:normal"><span style="font-size:19.0pt;mso-bidi-font-size:
18.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">THƯ PHÂN ƯU</span></b></p>

<p class="MsoNormal"><span style="mso-ignore:vglayout">

</span></p><table align="left" cellpadding="0" cellspacing="0" height="39" width="219">
 <tbody><tr>
  <td height="13" width="219"><br></td>
 </tr>
 <tr>
  <td><br></td>
  <td><br></td></tr></tbody></table><p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
134.25pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:9.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<br style="mso-ignore:vglayout" clear="ALL">

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:106.35pt;margin-bottom:.0001pt;text-align:justify;text-indent:
49.6pt;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">K</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ính gửi : XXX XXXX Xxxxxx Xxxxx Xxxxxx </span></b></p>

<p class="MsoNormal" style="margin-top:2.0pt;text-align:justify;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="mso-spacerun:yes">&nbsp;&nbsp; </span>Xxxxx Xxxxx Xxxxx XXXX</span></b></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:5.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> thân mến,</span></i></p>

<p class="MsoNormal" style="margin-left:29.75pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:7.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Chúng tôi xin gởi đến </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến những lời phân ưu chân thành nhất. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.75pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Sự ra đi của </span><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Xxxx Xxxxx Xxxxx XXXXX</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"> </span></b><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:
.2pt">để lại nhiều thương nhớ cho mọi người, nhất là cho </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến. Tuy nhiên, trong niềm tin vào Đức Kitô Khổ
nạn và Phục sinh, chúng ta tin rằng </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> đang trên đường tiến về quê trời vinh phúc.</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">Chúng tôi xin hiệp với </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">, với Tang quyến và cộng đoàn phụng vụ trong Thánh lễ an
táng, cầu nguyện cho </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:-.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"> được sớm về hưởng nhan thánh Chúa. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Chúng
ta tin rằng, một khi về bên Chúa, </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> sẽ bầu cử
cho chúng ta một cách hiệu quả trước tòa Chúa.</span></p>

<p class="MsoNormal" style="text-align:justify"><span style="font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Thân
ái chào </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> và chân
thành phân ưu với </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
<b style="mso-bidi-font-weight:normal">XXXXXX XXXXXX XXXXXX</b></span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục giáo phận Xuân Lộc</span></b></p>

<p class="MsoNormal" style="margin-top:3.0pt;text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:4.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> XXXXX XXXX XXXXX XXXXX</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục Phụ tá</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>



                                    ', N'09/07/2016', N'16/07/2016', NULL, N'Tran Van Ngoc', NULL, 14)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (175, N'Moi cong viec', 2, N'<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"></o:shapedefaults>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"></o:idmap>
 </o:shapelayout></xml><![endif]-->

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:right" align="right"><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Xuân Lộc, ngày </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">28</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> tháng </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">1</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> năm </span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">2010</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></i></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-size:1.0pt;mso-bidi-font-size:12.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="margin-left:1.0cm;text-align:center" align="center"><b style="mso-bidi-font-weight:normal"><span style="font-size:19.0pt;mso-bidi-font-size:
18.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">THƯ PHÂN ƯU</span></b></p>

<p class="MsoNormal"><span style="mso-ignore:vglayout">

</span></p><table align="left" cellpadding="0" cellspacing="0" height="39" width="219">
 <tbody><tr>
  <td height="13" width="219"><br></td>
 </tr>
 <tr>
  <td><br></td>
  <td><br></td></tr></tbody></table><p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
134.25pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:9.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<br style="mso-ignore:vglayout" clear="ALL">

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:106.35pt;margin-bottom:.0001pt;text-align:justify;text-indent:
49.6pt;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">K</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ính gửi : XXX XXXX Xxxxxx Xxxxx Xxxxxx </span></b></p>

<p class="MsoNormal" style="margin-top:2.0pt;text-align:justify;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="mso-spacerun:yes">&nbsp;&nbsp; </span>Xxxxx Xxxxx Xxxxx XXXX</span></b></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:5.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> thân mến,</span></i></p>

<p class="MsoNormal" style="margin-left:29.75pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:7.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Chúng tôi xin gởi đến </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến những lời phân ưu chân thành nhất. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.75pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Sự ra đi của </span><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Xxxx Xxxxx Xxxxx XXXXX</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"> </span></b><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:
.2pt">để lại nhiều thương nhớ cho mọi người, nhất là cho </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến. Tuy nhiên, trong niềm tin vào Đức Kitô Khổ
nạn và Phục sinh, chúng ta tin rằng </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> đang trên đường tiến về quê trời vinh phúc.</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">Chúng tôi xin hiệp với </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">, với Tang quyến và cộng đoàn phụng vụ trong Thánh lễ an
táng, cầu nguyện cho </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:-.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"> được sớm về hưởng nhan thánh Chúa. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Chúng
ta tin rằng, một khi về bên Chúa, </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> sẽ bầu cử
cho chúng ta một cách hiệu quả trước tòa Chúa.</span></p>

<p class="MsoNormal" style="text-align:justify"><span style="font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Thân
ái chào </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> và chân
thành phân ưu với </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
<b style="mso-bidi-font-weight:normal">XXXXXX XXXXXX XXXXXX</b></span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục giáo phận Xuân Lộc</span></b></p>

<p class="MsoNormal" style="margin-top:3.0pt;text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:4.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> XXXXX XXXX XXXXX XXXXX</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục Phụ tá</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>



                                    ', N'09/07/2016', N'16/07/2016', NULL, N'Tran Van Ngoc', NULL, 14)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (176, N'Moi Du Tiec Chuc Mung', 2, N'Cộng hòa xã hội chủ nghĩa việt nam', NULL, NULL, NULL, N'Nguyen Van Ngoc', NULL, 12)
INSERT [dbo].[GiayMoi] ([Id], [Ten], [Loai], [Mau], [NgayMoi], [NgaySuKien], [DiaDiem], [NguoiGoi], [ThoiGian], [MauId]) VALUES (177, N'Xac nhan dat', 12, N'<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]-->

<div><p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; &nbsp;</span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt">&nbsp;&nbsp;&nbsp;&nbsp; <b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">TÒA GIÁM MỤC XUÂN LỘC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">CỘNG
HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; 210 Hùng Vương </span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Xu</span></b><b><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">â</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">n
B</span></b><b><span style="font-size:11.0pt;
mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">ì</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Độc Lập </span></b><b><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
T</span></b><b><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ự</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Do </span></b><b><span style="font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> H</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ạ</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh
Ph</span></b><b><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ú</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">c<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-left:-7.1pt;text-align:justify;tab-stops:center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; Long
Khánh </span></b><b><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> </span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">Đồ</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ng Nai</span></b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">µ</span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><b><span style="font-size:
10.0pt;mso-bidi-font-size:11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;Số
: </span></b><!--[if supportFields]><b style=''mso-bidi-font-weight:normal''><span
style=''font-size:10.0pt;mso-bidi-font-size:11.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD No <span style=''mso-element:field-separator''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">362</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">-</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span>
MERGEFIELD Nam_ <span style=''mso-element:field-separator''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">2013</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">/TGM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></b></p>

<p class="MsoNormal" align="right" style="text-align:right"><span style="font-size:
7.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="right" style="text-align:right"><i><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Long Khánh, [NgayHienTai]</span></i></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal" align="center" style="text-align:center"><b><span style="font-size:18.0pt;mso-bidi-font-size:22.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">GIẤY XÁC NHẬN<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-top:3.0pt;text-align:center"><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" align="center" style="text-align:center"><b>&nbsp;</b></p>

<p class="MsoNormal" align="center" style="text-align:center"><b>&nbsp;</b></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:2.0cm;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Tôi, </span><span style="font-family: ''UTM Times'', serif; font-size: 18px; line-height: 27px;"><b>[TenDucGiamMuc]</b></span><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, Tổng Đại diện Giáo phận <br>
Xuân Lộc,<o:p></o:p></span></p><p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:2.0cm;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Moi [TenKhachMoi]</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xác
nhận </span><!--[if supportFields]><b style=''mso-bidi-font-weight:normal''><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_ho </span></b><![endif]--><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">,</span></b><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> giáo xứ <b>Xxxx Xxxx &nbsp;</b>nằm trong địa bàn (địa chỉ phường xã)</span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span> MERGEFIELD Diachi <span
style=''mso-element:field-separator''></span></span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được thành
lập từ năm yyyy</span><!--[if supportFields]><span style=''font-size:14.0pt;
mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span> MERGEFIELD Thành_lập </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được cơ
quan có thẩm quyền chính thức công nhận năm yyyy, có diện tích đất đai là ###########
m<sup>2</sup> gồm thửa đất số ### tờ bản đồ số ###; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_2 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__2 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_3 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__3 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_4 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__4 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_5 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__5 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_6 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__6 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_7 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__7 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_8 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__8 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_9 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__9 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;và thuộc về Tòa Giám mục Xuân Lộc.<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Kính
đề nghị Ủy ban Nhân dân tỉnh Đồng Nai, Sở Tài nguyên và Môi trường xem xét giải
quyết và cấp giấy chứng nhận quyền sử dụng đất cho </span><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_ho </span></b><![endif]--><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_xu <span style=''mso-element:
field-separator''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Thánh Giuse</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:78.0pt;margin-bottom:.0001pt;text-align:justify"><span style="font-size:1.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:42.55pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xin
chân thành cám ơn Quý Ban và trân trọng kính chào.<o:p></o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;[NgayHienTai]</o:p></span></p>

<p class="MsoNormal" style="text-align: right;"><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-size:13.5pt;mso-bidi-font-size:
12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Linh mục [TenNguoiGoi]</span></b></p>

<p class="MsoNormal" style="text-align: right;"><b><span style="font-size:13.5pt;mso-bidi-font-size:12.5pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tổng
Đại diện Giáo phận Xuân Lộc <o:p></o:p></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p></div>

                                    ', NULL, NULL, NULL, N'NGuyen VAn a', NULL, 15)
SET IDENTITY_INSERT [dbo].[GiayMoi] OFF
INSERT [dbo].[HDLMMember] ([PriestID], [HdlmID], [Role]) VALUES (585, 4, 0)
INSERT [dbo].[HDLMMember] ([PriestID], [HdlmID], [Role]) VALUES (587, 4, 0)
INSERT [dbo].[HDLMMember] ([PriestID], [HdlmID], [Role]) VALUES (589, 4, 1)
SET IDENTITY_INSERT [dbo].[HoiDongLinhMuc] ON 

INSERT [dbo].[HoiDongLinhMuc] ([Id], [Name], [Description], [Note]) VALUES (4, N'Hội Đồng XYZ', NULL, NULL)
SET IDENTITY_INSERT [dbo].[HoiDongLinhMuc] OFF
SET IDENTITY_INSERT [dbo].[KhachMoi] ON 

INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (112, N'Đỗ Trần Quang Phúc', N'Nghệ Sĩ', N'trên mây 1', N'113', N'email@email.com', N'ghi chú 123', 165)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (115, N'Nam ', N'xe ôm', N'ổ chuột', N'0999ccx', N'email', N'Cao to đen hôi', 165)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (119, N'Phạm bảo toàn', NULL, NULL, NULL, NULL, NULL, 34)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (120, N'Huỳnh Minh Đức', NULL, NULL, NULL, NULL, NULL, 34)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (121, N'Nguyễn Văn An', NULL, NULL, NULL, NULL, NULL, 35)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (122, N'Matthêu Nguyễn Văn An', N'Cha', N'123 Ví dụ', N'0999999999', N'vidu@gmail.com', NULL, 168)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (126, N'Nguyen Huu Huan', NULL, NULL, NULL, NULL, NULL, 172)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (127, N'Nguyen Manh Quoc', NULL, NULL, NULL, NULL, NULL, 173)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (128, N'Gia Minh', NULL, NULL, NULL, NULL, NULL, 173)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (129, N'Hoang Viet', NULL, NULL, NULL, NULL, NULL, 173)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (130, N'Tran Hoang', NULL, NULL, NULL, NULL, NULL, 174)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (131, N'Nguyen Minh', NULL, NULL, NULL, NULL, NULL, 175)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (132, N'Hoang Long', NULL, NULL, NULL, NULL, NULL, 175)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (133, N'Hoang Hoa Hung', NULL, NULL, NULL, NULL, NULL, 176)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (134, N'Nguyen Van Minh', NULL, NULL, NULL, NULL, NULL, 176)
INSERT [dbo].[KhachMoi] ([id], [HoTen], [ChucDanh], [DiaChi], [SoDienThoai], [Email], [GhiChu], [GiayMoiId]) VALUES (135, N'Nguyen Van B', NULL, NULL, NULL, NULL, NULL, 177)
SET IDENTITY_INSERT [dbo].[KhachMoi] OFF
SET IDENTITY_INSERT [dbo].[LetterAndReport] ON 

INSERT [dbo].[LetterAndReport] ([Id], [Ten], [Loai], [MoTa], [Mau]) VALUES (12, N'Giay Moi', 1, NULL, N'Cộng hòa xã hội chủ nghĩa việt nam')
INSERT [dbo].[LetterAndReport] ([Id], [Ten], [Loai], [MoTa], [Mau]) VALUES (13, N'Bao Cao', 2, NULL, NULL)
INSERT [dbo].[LetterAndReport] ([Id], [Ten], [Loai], [MoTa], [Mau]) VALUES (14, N'Thư phân ưu', 8, N'Thư phân ưu', N'<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"></o:shapedefaults>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"></o:idmap>
 </o:shapelayout></xml><![endif]-->

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:right" align="right"><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Xuân Lộc, ngày </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">28</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> tháng </span></i><i style="mso-bidi-font-style:
normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">1</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> năm </span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">2010</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></i></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-size:1.0pt;mso-bidi-font-size:12.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="margin-left:1.0cm;text-align:center" align="center"><b style="mso-bidi-font-weight:normal"><span style="font-size:19.0pt;mso-bidi-font-size:
18.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">THƯ PHÂN ƯU</span></b></p>

<p class="MsoNormal"><span style="mso-ignore:vglayout">

</span></p><table align="left" cellpadding="0" cellspacing="0" height="39" width="219">
 <tbody><tr>
  <td height="13" width="219"><br></td>
 </tr>
 <tr>
  <td><br></td>
  <td><br></td></tr></tbody></table><p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
134.25pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:9.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<br style="mso-ignore:vglayout" clear="ALL">

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:106.35pt;margin-bottom:.0001pt;text-align:justify;text-indent:
49.6pt;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">K</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ính gửi : XXX XXXX Xxxxxx Xxxxx Xxxxxx </span></b></p>

<p class="MsoNormal" style="margin-top:2.0pt;text-align:justify;tab-stops:205.55pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-spacerun:yes">&nbsp;</span><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="mso-spacerun:yes">&nbsp;&nbsp; </span>Xxxxx Xxxxx Xxxxx XXXX</span></b></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:54.45pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:5.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:12.0pt;margin-right:0cm;margin-bottom:
0cm;margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span></i><i style="mso-bidi-font-style:normal"><span style="font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> thân mến,</span></i></p>

<p class="MsoNormal" style="margin-left:29.75pt;text-align:justify;text-indent:
31.45pt"><i style="mso-bidi-font-style:normal"><span style="font-size:7.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></i></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Chúng tôi xin gởi đến </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến những lời phân ưu chân thành nhất. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.75pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Sự ra đi của </span><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt">Xxxx Xxxxx Xxxxx XXXXX</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"> </span></b><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:
.2pt">để lại nhiều thương nhớ cho mọi người, nhất là cho </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> và Tang quyến. Tuy nhiên, trong niềm tin vào Đức Kitô Khổ
nạn và Phục sinh, chúng ta tin rằng </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:.2pt"> đang trên đường tiến về quê trời vinh phúc.</span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">Chúng tôi xin hiệp với </span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt">, với Tang quyến và cộng đoàn phụng vụ trong Thánh lễ an
táng, cầu nguyện cho </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;letter-spacing:-.2pt"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;
letter-spacing:-.2pt"> được sớm về hưởng nhan thánh Chúa. </span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:29.7pt;margin-bottom:.0001pt;text-align:justify;text-indent:31.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Chúng
ta tin rằng, một khi về bên Chúa, </span><span style="font-size:14.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Ông cố</span></span><span style="font-size:
14.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> sẽ bầu cử
cho chúng ta một cách hiệu quả trước tòa Chúa.</span></p>

<p class="MsoNormal" style="text-align:justify"><span style="font-size:13.0pt;
mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Thân
ái chào </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> và chân
thành phân ưu với </span><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-no-proof:yes">Cha</span></span><span style="font-size:
13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><span style="font-size:12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
<b style="mso-bidi-font-weight:normal">XXXXXX XXXXXX XXXXXX</b></span></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục giáo phận Xuân Lộc</span></b></p>

<p class="MsoNormal" style="margin-top:3.0pt;text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-size:4.0pt;mso-bidi-font-size:
12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></b><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;MS Mincho&quot;;
mso-bidi-font-family:&quot;MS Mincho&quot;">✞</span></b><b style="mso-bidi-font-weight:
normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> XXXXX XXXX XXXXX XXXXX</span></b></p>

<p class="MsoNormal" style="text-align:justify;tab-stops:center 325.8pt"><b style="mso-bidi-font-weight:normal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><span style="mso-tab-count:1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>Giám
mục Phụ tá</span></b><b style="mso-bidi-font-weight:normal"><span style="font-size:13.0pt;mso-bidi-font-size:12.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></p>



                                    ')
INSERT [dbo].[LetterAndReport] ([Id], [Ten], [Loai], [MoTa], [Mau]) VALUES (15, N'Xác nhận đất đai', 12, NULL, N'<!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:TargetScreenSize>800x600</o:TargetScreenSize>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves></w:TrackMoves>
  <w:TrackFormatting></w:TrackFormatting>
  <w:PunctuationKerning></w:PunctuationKerning>
  <w:ValidateAgainstSchemas></w:ValidateAgainstSchemas>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF></w:DoNotPromoteQF>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>JA</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables></w:BreakWrappedTables>
   <w:SnapToGridInCell></w:SnapToGridInCell>
   <w:WrapTextWithPunct></w:WrapTextWithPunct>
   <w:UseAsianBreakRules></w:UseAsianBreakRules>
   <w:DontGrowAutofit></w:DontGrowAutofit>
   <w:SplitPgBreakAndParaMark></w:SplitPgBreakAndParaMark>
   <w:EnableOpenTypeKerning></w:EnableOpenTypeKerning>
   <w:DontFlipMirrorIndents></w:DontFlipMirrorIndents>
   <w:OverrideTableStyleHps></w:OverrideTableStyleHps>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"></m:mathFont>
   <m:brkBin m:val="before"></m:brkBin>
   <m:brkBinSub m:val="&#45;-"></m:brkBinSub>
   <m:smallFrac m:val="off"></m:smallFrac>
   <m:dispDef></m:dispDef>
   <m:lMargin m:val="0"></m:lMargin>
   <m:rMargin m:val="0"></m:rMargin>
   <m:defJc m:val="centerGroup"></m:defJc>
   <m:wrapIndent m:val="1440"></m:wrapIndent>
   <m:intLim m:val="subSup"></m:intLim>
   <m:naryLim m:val="undOvr"></m:naryLim>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="true"
  DefSemiHidden="true" DefQFormat="false" DefPriority="99"
  LatentStyleCount="267">
  <w:LsdException Locked="false" Priority="0" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Normal"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="heading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 7"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 8"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" Name="toc 9"></w:LsdException>
  <w:LsdException Locked="false" Priority="35" QFormat="true" Name="caption"></w:LsdException>
  <w:LsdException Locked="false" Priority="10" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="0" Name="Default Paragraph Font"></w:LsdException>
  <w:LsdException Locked="false" Priority="11" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtitle"></w:LsdException>
  <w:LsdException Locked="false" Priority="22" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Strong"></w:LsdException>
  <w:LsdException Locked="false" Priority="20" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="59" SemiHidden="false"
   UnhideWhenUsed="false" Name="Table Grid"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Placeholder Text"></w:LsdException>
  <w:LsdException Locked="false" Priority="1" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="No Spacing"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" UnhideWhenUsed="false" Name="Revision"></w:LsdException>
  <w:LsdException Locked="false" Priority="34" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="List Paragraph"></w:LsdException>
  <w:LsdException Locked="false" Priority="29" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="30" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Quote"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 1"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 2"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 3"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 4"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 5"></w:LsdException>
  <w:LsdException Locked="false" Priority="60" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="61" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="62" SemiHidden="false"
   UnhideWhenUsed="false" Name="Light Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="63" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="64" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Shading 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="65" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="66" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium List 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="67" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 1 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="68" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 2 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="69" SemiHidden="false"
   UnhideWhenUsed="false" Name="Medium Grid 3 Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="70" SemiHidden="false"
   UnhideWhenUsed="false" Name="Dark List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="71" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Shading Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="72" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful List Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="73" SemiHidden="false"
   UnhideWhenUsed="false" Name="Colorful Grid Accent 6"></w:LsdException>
  <w:LsdException Locked="false" Priority="19" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="21" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Emphasis"></w:LsdException>
  <w:LsdException Locked="false" Priority="31" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Subtle Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="32" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Intense Reference"></w:LsdException>
  <w:LsdException Locked="false" Priority="33" SemiHidden="false"
   UnhideWhenUsed="false" QFormat="true" Name="Book Title"></w:LsdException>
  <w:LsdException Locked="false" Priority="37" Name="Bibliography"></w:LsdException>
  <w:LsdException Locked="false" Priority="39" QFormat="true" Name="TOC Heading"></w:LsdException>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
	mso-para-margin:0cm;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman","serif";}
</style>
<![endif]-->

<div><p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; &nbsp;</span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt">&nbsp;&nbsp;&nbsp;&nbsp; <b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">TÒA GIÁM MỤC XUÂN LỘC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">CỘNG
HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; 210 Hùng Vương </span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Xu</span></b><b><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">â</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">n
B</span></b><b><span style="font-size:11.0pt;
mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:
&quot;UTM Times&quot;">ì</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Độc Lập </span></b><b><span style="font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
T</span></b><b><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ự</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
Do </span></b><b><span style="font-family:
&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> H</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ạ</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">nh
Ph</span></b><b><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">ú</span></b><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">c<o:p></o:p></span></b></p>

<p class="MsoNormal" style="margin-left:-7.1pt;text-align:justify;tab-stops:center 63.8pt 349.8pt"><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; Long
Khánh </span></b><b><span style="font-size:
11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;">–</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> </span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;;mso-bidi-font-family:&quot;UTM Times&quot;">Đồ</span></b><b><span style="font-size:11.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">ng Nai</span></b><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">µ</span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:11.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings"></span><span style="font-size:11.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" style="margin-left:-21.3pt;text-align:justify;tab-stops:
center 63.8pt"><b><span style="font-size:
10.0pt;mso-bidi-font-size:11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;Số
: </span></b><!--[if supportFields]><b style=''mso-bidi-font-weight:normal''><span
style=''font-size:10.0pt;mso-bidi-font-size:11.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD No <span style=''mso-element:field-separator''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">362</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">-</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span>
MERGEFIELD Nam_ <span style=''mso-element:field-separator''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">2013</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:10.0pt;mso-bidi-font-size:
11.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">/TGM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></span></b></p>

<p class="MsoNormal" align="right" style="text-align:right"><span style="font-size:
7.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" align="right" style="text-align:right"><i><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Long Khánh, [NgayHienTai]</span></i></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal"><b>&nbsp;</b></p>

<p class="MsoNormal" align="center" style="text-align:center"><b><span style="font-size:18.0pt;mso-bidi-font-size:22.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">GIẤY XÁC NHẬN<o:p></o:p></span></b></p>

<p class="MsoNormal" align="center" style="margin-top:3.0pt;text-align:center"><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:&quot;UTM Times&quot;;
mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">
</span><span style="font-size:9.0pt;font-family:Wingdings;mso-ascii-font-family:
&quot;UTM Times&quot;;mso-hansi-font-family:&quot;UTM Times&quot;;mso-char-type:symbol;mso-symbol-font-family:
Wingdings">{</span><span style="font-size:9.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p></o:p></span></p>

<p class="MsoNormal" align="center" style="text-align:center"><b>&nbsp;</b></p>

<p class="MsoNormal" align="center" style="text-align:center"><b>&nbsp;</b></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:2.0cm;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Tôi, </span><span style="font-family: ''UTM Times'', serif; font-size: 18px; line-height: 27px;"><b>[TenDucGiamMuc]</b></span><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;
font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, Tổng Đại diện Giáo phận <br>
Xuân Lộc,<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xác
nhận </span><!--[if supportFields]><b style=''mso-bidi-font-weight:normal''><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_ho </span></b><![endif]--><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">,</span></b><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"> giáo xứ <b>Xxxx Xxxx &nbsp;</b>nằm trong địa bàn (địa chỉ phường xã)</span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span> MERGEFIELD Diachi <span
style=''mso-element:field-separator''></span></span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được thành
lập từ năm yyyy</span><!--[if supportFields]><span style=''font-size:14.0pt;
mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span> MERGEFIELD Thành_lập </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">, được cơ
quan có thẩm quyền chính thức công nhận năm yyyy, có diện tích đất đai là ###########
m<sup>2</sup> gồm thửa đất số ### tờ bản đồ số ###; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_2 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__2 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_3 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__3 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_4 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__4 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_5 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__5 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_6 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__6 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_7 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__7 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_8 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__8 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">; thửa </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Thua_9 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;tờ bản đồ số </span><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD BDo__9 </span><![endif]--><!--[if supportFields]><span
style=''font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:"UTM Times","serif"''><span
style=''mso-element:field-end''></span></span><![endif]--><span style="font-size:
14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;và thuộc về Tòa Giám mục Xuân Lộc.<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:35.45pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Kính
đề nghị Ủy ban Nhân dân tỉnh Đồng Nai, Sở Tài nguyên và Môi trường xem xét giải
quyết và cấp giấy chứng nhận quyền sử dụng đất cho </span><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_ho </span></b><![endif]--><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-begin''></span><span
style=''mso-spacerun:yes''> </span>MERGEFIELD Giao_xu <span style=''mso-element:
field-separator''></span></span></b><![endif]--><b><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">Thánh Giuse</span></b><!--[if supportFields]><b
style=''mso-bidi-font-weight:normal''><span style=''font-size:14.0pt;mso-bidi-font-size:
13.0pt;font-family:"UTM Times","serif"''><span style=''mso-element:field-end''></span></span></b><![endif]--><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">.<o:p></o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:78.0pt;margin-bottom:.0001pt;text-align:justify"><span style="font-size:1.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal" style="margin-top:9.0pt;margin-right:0cm;margin-bottom:0cm;
margin-left:42.55pt;margin-bottom:.0001pt;text-align:justify;text-indent:42.55pt"><span style="font-size:14.0pt;mso-bidi-font-size:13.0pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Xin
chân thành cám ơn Quý Ban và trân trọng kính chào.<o:p></o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:
&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;[NgayHienTai]</o:p></span></p>

<p class="MsoNormal" style="text-align: right;"><b><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span style="font-size:13.5pt;mso-bidi-font-size:
12.5pt;font-family:&quot;UTM Times&quot;,&quot;serif&quot;">Linh mục [TenNguoiGoi]</span></b></p>

<p class="MsoNormal" style="text-align: right;"><b><span style="font-size:13.5pt;mso-bidi-font-size:12.5pt;font-family:
&quot;UTM Times&quot;,&quot;serif&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tổng
Đại diện Giáo phận Xuân Lộc <o:p></o:p></span></b></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>

<p class="MsoNormal"><span style="font-family:&quot;UTM Times&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p></div>

                                    ')
INSERT [dbo].[LetterAndReport] ([Id], [Ten], [Loai], [MoTa], [Mau]) VALUES (16, N'Xin nhận xét Phó Tế', 11, NULL, N'<p class="MsoNormal" style="margin: 0cm 0cm 0.0001pt -14.2pt; text-align: justify; text-indent: -7.1pt; line-height: normal;"><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif;">&nbsp; TÒA GIÁM MỤC XUÂN LỘC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;"><o:p></o:p></span></span></p><p class="MsoNormal" style="margin: 0cm 0cm 0.0001pt -21.3pt; text-align: justify; text-indent: -7.1pt; line-height: normal;"><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif;">&nbsp;&nbsp; 210 Hùng Vương – Xuân Bình</span></span><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></span></p><p class="MsoNormal" style="margin: 0cm 0cm 0.0001pt -7.1pt; text-align: justify; text-indent: -7.1pt; line-height: normal;"><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif;">&nbsp;&nbsp; Long Khánh – Đồng Nai</span></span><span style="font-family: ''Times New Roman'', serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt 7.1pt; text-indent: -7.1pt; line-height: normal;"><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif;">&nbsp; Số : 174-2009/TGM<o:p></o:p></span></span></p><p class="MsoNormal" style="margin: 0cm 0cm 0.0001pt -21.3pt; text-align: justify; text-indent: -7.1pt; line-height: normal;"><span style="font-family: ''Times New Roman'', serif;">&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-family: Wingdings;"></span><span style="font-family: ''Times New Roman'', serif;">&nbsp;</span><span style="font-family: Wingdings;">{</span><span style="font-family: ''Times New Roman'', serif;">&nbsp;</span><span style="font-family: Wingdings;"></span><span style="font-family: ''Times New Roman'', serif;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><i><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;"><o:p></o:p></span></i></p><p class="MsoNormal" align="right" style="margin: 6pt 0cm 0.0001pt; text-align: right; line-height: normal;"><i><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;">Xuân Lộc, [NgayHienTai]</span></i></p><p class="MsoNormal" align="right" style="margin: 6pt 0cm 0.0001pt; text-align: right; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt 36pt; text-indent: 36pt; line-height: normal;"><i><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;">Cha thân mến,<o:p></o:p></span></i></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt 36pt; text-indent: 36pt; line-height: normal;"><i><span style="font-family: ''Times New Roman'', serif; font-size: 1pt;"><o:p>&nbsp;</o:p></span></i></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt 36pt; text-align: justify; text-indent: 36pt; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;">Theo Giáo luật khoản 1031 và 1032, trước khi được phong chức linh mục, các chủng sinh cần có một thời gian thích hợp để thực hành chức phó tế; và phải có khoảng cách ít là sáu tháng giữa chức phó tế và chức linh mục.<o:p></o:p></span></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt 36pt; text-align: justify; text-indent: 36pt; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;">Nay tôi gửi đến Cha DANH SÁCH ỨNG VIÊN PHÓ TẾ của giáo phận Xuân Lộc kỳ này, cùng với một bản mẫu nhận xét về các ứng viên. Xin Cha vui lòng cho tôi biết nhận xét của Cha về các thầy, đặc biệt những thầy có liên hệ, và xin Cha gửi bản trả lời về Văn phòng Tòa Giám mục&nbsp;<span style="font-weight: 700;"><i>trước ngày [NgaySuKien].</i></span><o:p></o:p></span></p><p class="MsoNormal" style="margin: 6pt 0cm 0.0001pt 36pt; text-align: justify; text-indent: 36pt; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;">Chân thành cám ơn Cha và xin Cha thêm lời cầu nguyện cho tôi.<o:p></o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt; letter-spacing: 0.1pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span style="font-weight: 700;"><span style="font-family: Wingdings; font-size: 13pt; letter-spacing: 0.1pt;">U</span></span><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif; font-size: 13pt; letter-spacing: 0.1pt;">&nbsp;[TenDucGiamMuc]<o:p></o:p></span></span></p><p class="MsoNormal" style="margin-bottom: 0.0001pt; text-align: justify; line-height: normal;"><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;Giám mục Giáo phận Xuân Lộc<o:p></o:p></span></span></p><div><span style="font-weight: 700;"><span style="font-family: ''Times New Roman'', serif; font-size: 14pt;"><br></span></span></div>

                                    ')
SET IDENTITY_INSERT [dbo].[LetterAndReport] OFF
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
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (1, N'/Diocese/Index', N'Trang chủ', 0, N'fa-home', 0, 100, 1, 1, N'/Diocese/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (2, N'Diocese', N'Giáo phận', 0, N'fa-sitemap', 0, 200, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (3, N'/Parish/Index', N'Danh sách Giáo xứ', 0, N'fa-bank', 2, 203, 1, 1, N'/Parish/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (4, N'/Account/AccountManagement', N'Tài khoản', 0, N'fa-user', 0, 400, 1, 1, N'/Account/AccountManagement')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (5, N'Priest', N'Linh mục', 0, N'fa-arrows', 0, 500, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (6, N'/Priest/Index', N'Danh sách Linh mục', 0, N'fa-caret-right', 5, 501, 1, 1, N'/Priest/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (7, N'/HoiDongLinhMuc/Index', N'Hội đồng Linh Mục', 0, N'fa-gavel', 5, 502, 1, 1, N'/HoiDongLinhMuc/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (8, N'Seminary', N'Chủng viện', 0, N'fa-book', 0, 600, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (9, N'/Seminary/Index', N'Danh sách khóa học', 0, N'fa-caret-right', 8, 601, 1, 1, N'/Seminary/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (10, N'/Seminarian/Index', N'Danh sách chủng sinh', 0, N'fa-caret-right', 8, 602, 1, 1, N'/Seminarian/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (11, N'/DeaconRequisition/Index', N'Danh sách đợt xin chức phó tế', 0, N'fa-caret-right', 8, 603, 1, 1, N'/DeaconRequisition/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (12, N'/Seminary/ParishSupportRequisitionSession', N'Danh sách đợt xin giúp xứ', 0, NULL, 8, 604, 1, 1, N'/Seminary/ParishSupportRequisitionSession')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (13, N'/Parishioner/Index', N'Giáo dân', 0, N'fa-users', 0, 700, 1, 1, N'/Parishioner/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (14, N'Search', N'Tìm kiếm', 0, N'fa-search-plus', 0, 800, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (15, N'/Search/Parishioner', N'Tìm kiếm giáo dân', 0, N'fa-caret-right', 14, 801, 1, 1, N'/Search/Parishioner')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (16, N'/SearchFamily/Family', N'Tìm kiếm gia đình của giáo dân', 0, NULL, 14, 802, 1, 1, N'/SearchFamily/Family')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (17, N'Statistic', N'Thống kê', 0, N'fa-bar-chart-o', 0, 900, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (18, N'/Statistic/Index', N'Thống kê chung', 0, NULL, 17, 901, 1, 1, N'/Statistic/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (19, N'/Chart/Index', N'Biểu đồ', 0, NULL, 17, 902, 1, 1, N'/Chart/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (20, N'OfficeDepartment', N'Ban Văn Phòng', 0, N'fa-building', 0, 1000, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (21, N'/LetterAndReport/Index', N'Mẫu giấy tờ', 0, N'fa-envelope', 20, 1001, 1, 1, N'/LetterAndReport/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (22, N'/GiayMoi/GiayMoi', N'Giấy mời / thông báo', 0, N'fa-paper-plane', 20, 1002, 1, 1, N'/GiayMoi/GiayMoi')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (23, N'/ConstructionPermit/Index', N'Đơn xin xây dựng', 0, N'fa-building', 20, 1003, 1, 1, N'/ConstructionPermit/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (24, N'/ThuPhanUu/Index', N'Thư phân ưu', 0, N'fa-gavel', 20, 1004, 1, 1, N'/ThuPhanUu/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (25, N'ParishionerDepartment', N'Ban giáo dân', 0, N'fa-users', 0, 1100, 1, 1, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (26, N'/Donation/Index', N'Quản lý quyên góp', 0, NULL, 25, 1101, 1, 1, N'/Donation/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (27, N'/ParishHome/Index', N'Trang chủ', 0, N'fa-home', 0, 2000, 1, 2, N'/ParishHome/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (28, N'Parish', N'Thông tin giáo xứ', 0, N'fa-university', 0, 2100, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (29, N'/Community/Index', N'Danh sách giáo họ', 0, NULL, 28, 2101, 1, 2, N'/Community/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (30, N'/Society/Index', N'Danh sách hội đoàn', 0, NULL, 28, 2102, 1, 2, N'/Society/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (31, N'/Configuration/Index', N'Cấu hình giáo xứ', 0, NULL, 28, 2103, 1, 2, N'/Configuration/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (32, N'ParishionerFamily', N'Giáo dân &amp; Gia đình', 0, N'fa-users', 0, 2200, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (33, N'/Parishioner/Index', N'Danh sách giáo dân', 0, NULL, 32, 2201, 1, 2, N'/Parishioner/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (34, N'/Family/Index', N'Danh sách gia đình', 0, NULL, 32, 2202, 1, 2, N'/Family/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (35, N'Archive', N'Hồ sơ lưu trữ', 0, N'fa-archive', 0, 2300, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (36, N'/Parishioner/SaveStorage', N'Hồ sơ lưu trữ giáo dân', 0, NULL, 35, 2301, 1, 2, N'/Parishioner/SaveStorage')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (37, N'/Family/SaveStorage', N'Hồ sơ lưu trữ gia đình', 0, NULL, 35, 2302, 1, 2, N'/Family/SaveStorage')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (38, N'Sacrament', N'Sổ bí tích', 0, N'fa-bars', 0, 2400, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (39, N'/Sacrament/Index?type=1', N'Sổ Rửa tội', 0, NULL, 38, 2401, 1, 2, N'/Sacrament/Index?type=1')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (40, N'/Sacrament/Index?type=2', N'Sổ XTRL lần đầu', 0, NULL, 38, 2402, 1, 2, N'/Sacrament/Index?type=2')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (41, N'/Sacrament/Index?type=3', N'Sổ Thêm sức', 0, NULL, 38, 2403, 1, 2, N'/Sacrament/Index?type=3')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (42, N'/Sacrament/Index?type=4', N'Sổ Hôn phối', 0, NULL, 38, 2404, 1, 2, N'/Sacrament/Index?type=4')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (43, N'DoctineCourse', N'Quản lý giáo lý', 0, N'fa-graduation-cap', 0, 2500, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (44, N'/DoctrineCourse/Index', N'Danh sách khối giáo lý', 0, NULL, 43, 2501, 1, 2, N'/DoctrineCourse/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (45, N'/DoctrineCourse/ManageClass', N'Danh sách lớp giáo lý', 0, NULL, 43, 2502, 1, 2, N'/DoctrineCourse/ManageClass')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (46, N'Search', N'Tìm kiếm', 0, N'fa-search-plus', 0, 2600, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (47, N'/Search/Parishioner', N'Tìm kiếm giáo dân', 0, NULL, 46, 2601, 1, 2, N'/Search/Parishioner')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (48, N'/SearchFamily/Family', N'Tìm kiếm gia đình của giáo dân', 0, NULL, 46, 2602, 1, 2, N'/SearchFamily/Family')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (49, NULL, N'Công cụ dữ liệu', 0, NULL, 0, 2700, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (50, N'/ChangeCommunity/Parishioner', N'Chuyển họ cho giáo dân', 0, NULL, 49, 2701, 1, 2, N'/ChangeCommunity/Parishioner')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (51, N'/ChangeCommunity/Family', N'Chuyển họ cho gia đình', 0, NULL, 49, 2702, 1, 2, N'/ChangeCommunity/Family')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (52, N'/ChangeParish/Parishioner', N'Chuyển xứ cho giáo dân', 0, NULL, 49, 2703, 1, 2, N'/ChangeParish/Parishioner')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (53, N'/ChangeParish/Family', N'Chuyển xứ cho gia đình', 0, NULL, 49, 2704, 1, 2, N'/ChangeParish/Family')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (54, N'/DataChecking/Parishioner', N'Kiểm tra dữ liệu giáo dân', 0, NULL, 49, 2705, 1, 2, N'/DataChecking/Parishioner')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (56, N'Statistic', N'Thống kê', 0, N'fa-bar-chart-o', 0, 2800, 1, 2, NULL)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (57, N'/Statistic/Index', N'Thống kê chung', 0, NULL, 56, 2801, 1, 2, N'/Statistic/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (58, N'/Chart/Index', N'Biểu đồ', 0, NULL, 56, 2802, 1, 2, N'/Chart/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (55, N'/SacramentCreation/Index', N'Tạo đợt bí tích tự động', 0, NULL, 49, 2706, 1, 2, N'/SacramentCreation/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (56, N'/Vicariate/Index', N'Danh sách Giáo hạt', 0, N'fa-bank', 2, 202, 1, 1, N'/Vicariate/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (57, N'/Diocese/List', N'Danh sách Giáo phận', 0, NULL, 2, 201, 1, 1, N'/Diocese/List')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (58, N'/ThuyenChuyenLinhMuc/Index', N'Thuyên chuyển Linh Mục', 0, N'fa-gavel', 5, 503, 1, 1, N'/ThuyenChuyenLinhMuc/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (59, N'/RolePermission/Index', N'Phân quyền', 0, N'fa-user', 4, 401, 1, 1, N'/RolePermission/Index')
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (60, N'/BanHanhGiao/Index', N'Ban hành giáo', 0, N'fa-gavel', 20, 1005, 1, 1, N'/BanHanhGiao/Index')
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

INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (1, N'Tòa Giám mục Xuân Lộc', N'Đường Đất Đông', N'www.gxthinghe.com', N'0935 484 8777', N'gxthinghe@gmail.com', N'/Images/Parishes/9ae8b05d-f25b-4582-b156-0faf22627f08.jpg', N'Giuse Đỗ Trọng Cát', 1, NULL, N'Xã Ví Dụ', N'Huyện Giả Sử', N'Tỉnh Giả Định', N'a', N'b', N'd', 1, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (2, N'Đại Chủng viện Xuân Lộc', N'32 Xô Viết Nghệ Tĩnh', N'www.abc.com', N'6546548', N'gxabc@gmail.com', N'abc', N'Antôn Đỗ Văn Thanh', 1, NULL, N'Phường 25', N'Quận Bình Thạnh', N'TP Hồ Chí Minh', NULL, NULL, NULL, 5, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (3, N'Tân Bình', N'abc', N'www.abc.com', N'0932 045 656', N'khoihm93@gmail.com', NULL, N'Đaminh Huỳnh Trọng Long', 1, 1, N'Thu Duc', NULL, N'HCM', NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (5, N'Tân Định', N'asdfasdfasdf', N'www.abc.com', N'0936 426 5484', N'khoihm@gmail.com', NULL, N'Đaminh Huỳnh Trọng Long', 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (6, N'Bình Tân', N'sdfsdfasdf', N'www.apapa.com', N'1231 231 2312', N'khoihm@gmail.com', NULL, NULL, 2, NULL, N'', N'', N'', NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (7, N'Thủ Đức', N'Tô Ngọc Vân', N'www.123123.com', N'1234 234 2342', N'asdsdfsdf@yahoo.com', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (8, N'Phú Nhuận', N'Nguyễn Kiệm', N'www.1234902348.com', N'2342 342 3423', N'khoihm93@gmail.com', NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (9, N'Bình Lợi', N'65 An Dương Vương', N'www.gxbinhloi.com', N'0965 465 4848', N'gxbinhloi@gmail.com', NULL, N'Gioakim Huỳnh Phúc Mẫn', 4, NULL, N'', N'', N'', NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (10, N'Thuận An', N'Thu Duc', N'www.123123.com', N'2903 409 2384', N'khoihm@gmail.com', NULL, NULL, 4, NULL, NULL, NULL, NULL, N'a', N's', N'd', 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (12, N'Tân Phong', N'66/16 Xô Viết Nghệ Tĩnh', N'www.tanbinh.com', N'0838 402 634', N'tanbinh@gmail.com', N'/Images/Parishes/7499919f-9642-430f-a639-d276e2843a8b.jpg', N'Phêrô Trương Tấn Trọng', 6, NULL, NULL, NULL, NULL, N'r', N't', N't', 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (13, N'Quang Tây', N'126 Tô Ký', N'www.quangtay.com', N'0843 434 343', N'quangtay@gmail.com', N'/Images/Parishes/1a639e4e-21ef-4531-a26f-1a603a091f02.jpg', N'Antôn Nguyễn Văn Trung', 7, NULL, N'', N'', N'', NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (14, N'Tân Hội', NULL, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (15, N'Phan Rang', NULL, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (16, N'Tấn Tài', NULL, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (17, N'Thanh Khang', N'123 Tam Ha', NULL, NULL, NULL, N'/Images/Parishes/518214cd-2915-47b6-b6d8-79d603872ddd.jpg', N'Giuse Nguyễn Trọng Cát', 4, NULL, N'Linh Dong', N'Thu Duc', N'HCM', NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (18, N'Phú Quý', NULL, NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 4)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (21, N'Cao Thái', NULL, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (22, N'Dòng Đồng Công', N'521 Tỉnh lộ 43, P. Tam Phú, Thủ Đức. Tp. HCM', NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (25, N'Nhà dự tu Gò Vấp', NULL, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (26, N'Nhà dự tu Thánh Tịnh', NULL, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (27, N'Nhà Dự tu Tống Viết Bường', NULL, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (28, N'Sài Gòn', NULL, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -1, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (32, N'Nhà hưu Giáo phận', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (44, N'Hải Dương', N'469Kp.6, P.Hố Nai, Biên Hòa, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (45, N'Thánh Tâm', N'Tân Biên, Biên Hòa, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (46, N'Đền Martin', N'Tân Biên, Biên Hòa, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (47, N'Ngũ Phúc', N'Xã Hố Nai 3, Trảng Bom, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (48, N'Trường nghề Hòa Bình', N'Hố Nai 3, Trảng Bom, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (49, N'Hiền Đức', N'Phước Thái, Long Thành, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (50, N'Long Đức', N'Xã An Phước, Long Thành, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (51, N'Tân Cang', N'Xã Phước Tân, Biên Hòa, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (52, N'Thành Đức', N'Xã Suối Trầu, Long Thành, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (53, N'Thiên Bình', N'Xã Tam Phước, Tp. Biên Hòa, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (54, N'Bùi Đệ', N'Xã Bắc Sơn, Trảng Bom, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (55, N'Vĩnh Phước', N'Xã Vĩnh Thanh, Nhơn Trạch, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (56, N'Bình Lâm', N'20/1 Đồng Xoài, Túc Trưng, Định Quán, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (57, N'Mai Lâm', N'Xã Phú Lâm, Tân Phú , Đồng Nai', NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (58, N'Tiên Lâm', N'Ấp 3, Xã Núi Tượng, Tân Phú, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (59, N'Tu hội Bác Ái - Phú Dòng', N'xã Phú Cường, Định Quán, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, 4)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (60, N'Chúa Cứu Thế- Phú Dòng', N'Ấp Phú Dòng, Xã Phú Cường, Định Quán, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 4)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (61, N'Đức Thắng', N'20/1 Đồng Xoài, Túc Trưng, Định Quán, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 4)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (62, N'Túc Trưng', N'xã Phú Cường, Định Quán, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 4)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (63, N'Hồng Ân', N'Ấp 4, Sông Ray, Cẩm Mỹ, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (64, N'Tân Ngãi', N'Xã Xuân Tâm, Xuân Lộc, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (65, N'Thái Xuân', N'Xuân Định, Xuân Lộc, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (66, N'Thánh Gia', N'Ấp Bình Tân, Xã Xuân Phú, Xuân Lộc, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (67, N'Thừa Ân', N'Ấp 4, Xã Thừa Đức, Cẩm Mỹ, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (68, N'Thánh Linh', N'Ấp 2, Xã Bàu Cạn, Long Thành, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (69, N'Hiếu Liêm', N'Hiếu Liêm, Vĩnh Cửu, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 1)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (70, N'Giang Lâm', N'Xã Phú Thanh, Tân Phú, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (71, N'Tà Lài', N'xã Phú Lập, Tân Phú , Đồng Nai', NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 3)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (72, N'Phanxicô', N'P. Long Bình, Biên Hoà, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (73, N'Chà Rang', N'Ấp Chà Rang, Xã Suối Cao, Xuân Lộc, Đồng Nai ', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (74, N'Trảng Táo', N'Ấp Trảng Táo, Xã Xuân Thành, Xuân Lộc, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (75, N'Xuân Tôn', N'Xã Xuân Bắc, Xuân Lộc, Đồng Nai', NULL, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, 2)
INSERT [dbo].[Parish] ([Id], [Name], [Address], [Website], [Phone], [Email], [ImageUrl], [Priest], [VicariateId], [PriestId], [Ward], [District], [Province], [Patron], [PatronDate], [ChauLuot], [Category], [DioceseId]) VALUES (76, N'Nhà Vãng lai Phát Diệm', N'Nhà Vãng Lai Phát Diệm, 102 Chiến Thắng, P. 9, Phú Nhuận, Tp. HCM', NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -1, 3)
SET IDENTITY_INSERT [dbo].[Parish] OFF
SET IDENTITY_INSERT [dbo].[Parishioner] ON 

INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (3, N'LM10001', NULL, N'Đaminh', N'Huỳnh Trọng Long', 1, N'19800702', N'HCM', N'Huỳnh Văn Hải', N'Nguyễn Thị Thanh Phi', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'1900-01-23 00:00:00.000' AS DateTime), NULL, N'admin', NULL, N'', 1, NULL, N'', NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (5, N'MGD002', NULL, N'Giuse', N'Huỳnh Phong Vân', 0, N'19821202', N'Đồng Nai', N'Huỳnh Văn A', N'Nguyễn Thị B', 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'1900-01-23 00:00:00.000' AS DateTime), NULL, N'admin', NULL, N'', 1, NULL, N'', NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (6, N'MGD003', N'63600328075725.jpg', N'Phêrô', N'Trương Tấn Trọng', 0, N'19810901', N'Hồ Chí Minh', N'Huỳnh Văn Hải', N'Nguyễn Thị Thanh Phi', 1, 1, 0, N'', N'Cấp II', 0, N'Học sinh', N'66/16 Xô Viết Nghệ Tĩnh', N'0838 403 624', NULL, N'minhthu@gmail.com', NULL, 0, 0, N'        ', 1, 0, 9, CAST(N'2014-10-10 00:46:48.027' AS DateTime), NULL, N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (7, N'LM00004', N'63600328007118.jpg', N'Antôn', N'Nguyễn Văn Trung', 1, N'19791204', N'Hồ Chí Minh', N'Huỳnh Văn Thành', N'Nguyễn Thị Ngọc', 1, 1, 0, N'', N'Đại học', 0, N'Nhân viên', N'66/16 Xô Viết Nghệ Tĩnh', N'0838 403 624', N'09091231234', N'vanhai@gmail.com', NULL, 0, 0, N'        ', 0, 0, 3, CAST(N'2014-10-10 00:49:17.060' AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (8, N'MGD005', NULL, N'Phaolô', N'Lê Minh Quang', 1, N'20011224', N'Đồng Nai', N'Lê Văn A', N'Nguyễn Thị C', 1, 1, 0, N'', N'Đại học', 1, N'Sinh viên', N'66/15 Lô 2A', N'0836 487 984', N'0932 168 478', N'leminhquang@gmail.com', N'Test ghi chú', 1, 0, N'        ', 0, 1, 3, CAST(N'2014-10-10 01:06:20.140' AS DateTime), NULL, N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (12, N'MGD006', NULL, N'Phanxicô', N'Nguyễn Thị Ngọc Linh', 0, N'19980000', N'Hồ Chí Minh', N'Nguyễn Thanh Long', N'Hồ Ngọc Phương', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 16, CAST(N'2014-10-11 09:32:31.960' AS DateTime), NULL, N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (13, N'MGD004', NULL, N'Phêrô Tự', N'Huỳnh Ánh Lâm', 1, N'20141015', N'Hồ Chí Minh', N'Giuse Huỳnh Văn Hải', N'Gioakim Huỳnh Minh Thư', 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-13 13:23:20.500' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (14, N'MGD003', NULL, N'Giuse', N'Huỳnh Quang Khải', 1, N'20141001', N'Tây Ninh', N'Đaminh Huỳnh Minh Khôi', N'Antôn Huỳnh Ánh Linh', 0, 1, 0, NULL, N'Cấp II', 0, N'Buôn bán', NULL, N'0839 464 8621', N'0932 040 423', NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-13 13:36:24.397' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (15, N'MGD005', NULL, N'Giuse', N'Huỳnh Anh Tuấn', 1, N'20141008', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', N'Antôn Huỳnh Ánh Linh', 1, 1, 0, NULL, N'Cấp III', 0, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-13 16:39:45.027' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (16, N'MGD006', NULL, N'Giuse', N'Huỳnh Minh Khôi', 1, N'20141016', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', N'Antôn Huỳnh Ánh Linh', 1, 0, 2, N'deffff', N'Cấp II', 0, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh', NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 33, CAST(N'2014-10-13 16:41:05.763' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (20, N'MGD007', NULL, N'Gioakim', N'Huỳnh Minh Hồng', 0, N'20140510', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 2, CAST(N'2014-10-14 09:01:25.830' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (21, N'MGD008', NULL, N'Giuse', N'Huỳnh Minh Tuấn', 1, N'20141200', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, N'0932 040 423', N'0838 403 624', N'khoihm@gmail.com', NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-14 09:21:56.880' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (22, N'MGD009', NULL, N'Giuse', N'Huỳnh Ngọc Phượng', 0, N'20140101', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, N'khoihm@gmail.com', NULL, 0, 0, N'        ', 1, 0, 2, CAST(N'2014-10-14 09:38:58.277' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (23, N'MGD010', NULL, N'Gioakim', N'Huỳnh Tú Trinh', 0, N'20141200', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 8, CAST(N'2014-10-14 09:41:20.810' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (25, N'MGD012', NULL, N'Gioakim', N'Huỳnh Lâm Phong', 1, N'20141008', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-10-14 09:43:30.167' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (27, N'MGD013', NULL, N'Phaolô', N'Lương Quốc Trung', 1, N'19930308', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 8, CAST(N'2014-10-14 10:56:39.027' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (28, N'MGD014', NULL, N'Gioakim', N'Lương Bằng Quang', 1, N'19960000', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-14 10:57:15.443' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (29, N'MGD015', NULL, N'Rosa', N'Lương Mộng Hảo', 0, N'        ', NULL, N'Giuse Huỳnh Minh Tuấn', N'Giuse Huỳnh Ngọc Phượng', 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-14 10:58:28.827' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (31, N'MGD016', NULL, N'Mattheu', N'Lương Trọng Cát', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-14 11:06:25.250' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (32, N'MGD017', NULL, N'Mattheu', N'Gia Cát Trọng', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-14 11:11:38.010' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (33, N'MGD018', NULL, N'Phêrô', N'Huỳnh Ngọc Long', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-19 15:49:27.850' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (36, N'1', NULL, N'Rosa', N'Nguyễn Thị Thanh Hằng', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-19 15:55:54.053' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (37, N'2', NULL, N'Gioakim', N'Nguyễn Thị Thanh Phương', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2014-10-19 15:56:22.313' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (38, N'3', NULL, N'Phaolô', N'Huỳnh Thanh Tuấn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2014-10-19 15:59:21.533' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (39, N'4', NULL, N'Giuse', N'Huỳnh Lam Ngọc', 0, N'20141009', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-19 16:46:44.627' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (40, N'5', NULL, N'Giuse', N'Huỳnh Thanh Hải', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-19 17:19:46.293' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (41, N'6', NULL, N'Đaminh', N'Võ Văn Phú', 1, N'        ', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-19 17:20:15.003' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (48, N'7', NULL, N'Giuse', N'Huỳnh Ngọc Long', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-19 17:39:49.690' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (49, N'8', NULL, N'Antôn', N'Phan Đăng Cường', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-19 17:40:20.960' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (50, N'9', NULL, N'Rosa', N'Lê Thị Hà', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-19 17:40:45.473' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (51, N'10', NULL, N'Rosa', N'Đỗ Thị Hường', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-19 17:41:05.100' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (52, N'11', NULL, N'Giuse', N'Huỳnh Ngọc Quang', 1, N'19911020', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-19 17:46:50.693' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (53, N'GXTN1', NULL, NULL, N'Huỳnh Minh Khôi', 1, N'20141022', NULL, N'Phêrô Huỳnh Ngọc Long', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, N'', N'Cấp II', 0, N'Nhân viên', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 13, CAST(N'2014-10-20 09:58:17.947' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (54, N'GXTN2', NULL, N'Têrêsa', N'Huỳnh Ngọc Lâm', 0, N'19961108', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-10-20 10:14:10.280' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (55, N'GXTN3', NULL, N'Phanxicô', N'Phan Xích Lân', 1, N'19501200', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-20 10:14:47.600' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (56, N'GXTN4', NULL, N'Giuse', N'Huỳnh Thanh Lân', 1, N'19931223', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-20 10:42:54.453' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (57, N'GXTN5', NULL, NULL, N'Phan Ngọc Long', 1, N'20141022', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-20 12:49:14.830' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (58, N'GXTN6', NULL, N'Mattheu', N'Ngọc Hân', 0, N'19931200', NULL, N'Phanxicô Huỳnh Ngọc Lâm', N'Gioakim Huỳnh Minh Hồng', 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-20 14:14:38.390' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (59, N'GXTN7', NULL, NULL, N'Huỳnh Công Đức', 1, N'19930000', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-10-21 08:50:47.327' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (60, N'GXTN8', NULL, NULL, N'Huỳnh Minh Phong', 1, N'20140800', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 13, CAST(N'2014-10-21 09:59:51.923' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (61, N'GXTN9', NULL, N'Mattheu', N'Huỳnh Văn Lượng', 1, N'20141006', N'Tiền Giang', N'Đaminh Huỳnh Minh Khôi', N'Giuse Huỳnh Ngọc Phượng', 1, 1, 0, NULL, N'Trung học', 0, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', N'0965 248 484', N'khoihm93@gmail.com', N'Ghi chu', 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-23 10:09:17.993' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (62, N'GXTN10', NULL, N'Phêrô', N'Gia Cát Biển', 1, N'20141022', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Giuse Huỳnh Ngọc Phượng', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-23 10:11:32.667' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (63, N'GXTN11', NULL, N'Gioakim', N'Huỳnh Thị Hồng Lê', 0, N'19701100', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-10-23 12:30:10.207' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (64, N'GXTN12', NULL, N'Phêrô Tự', N'Bùi Thị Thu', 1, N'19981000', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-23 12:32:04.740' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (65, N'GXTN13', NULL, N'Phêrô Tự', N'Bùi Thị Đông', 0, N'19910700', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-23 12:32:29.450' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (66, N'GXTN14', NULL, N'Phêrô Tự', N'Lưu Lượng', 1, N'19951019', N'Tiền Giang', N'Giuse Huỳnh Minh Tuấn', N'Gioakim Huỳnh Minh Thư', 1, 1, 0, NULL, N'Trung học', 1, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh Phường 21', N'0838 403 624', N'0932 044 023', N'khoihm93@gmail.com', N'ABC', 1, 0, N'        ', 0, 1, 3, CAST(N'2014-10-24 09:21:00.500' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (67, N'GXTN15', NULL, N'Mattheu', N'Phan Văn Tự', 1, N'19980800', N'Đồng Nai', N'Giuse Huỳnh Minh Tuấn', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, NULL, N'Cấp III', 0, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh', NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 2, CAST(N'2014-10-24 09:24:33.983' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (68, N'GXTN16', NULL, N'Giuse', N'Huỳnh Phong Lưu', 1, N'19960000', N'Đồng Nai', N'Giuse Huỳnh Minh Tuấn', N'Gioakim Huỳnh Minh Hồng', 1, 1, 0, N'', N'Cấp II', 0, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 400 423', N'0835 465 4654', N'khoihm93@gmail.com', N'asdfasdfasdfasdfasd', 1, 0, N'        ', 0, 1, 5, CAST(N'2014-10-24 09:26:31.547' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (69, N'GXTN17', NULL, N'Giuse', N'Huỳnh Lộc Lộc', 1, N'19941018', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Gioakim Huỳnh Minh Hồng', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-25 12:36:28.783' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (70, N'GXTN18', NULL, N'Phaolô', N'Huỳnh Ngọc Phú', 1, N'19951110', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-25 14:55:15.540' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (71, N'GXTN19', NULL, N'Mattheu', N'Huỳnh Minh Kha', 1, N'19941200', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Gioakim Huỳnh Minh Thư', 1, 1, 0, N'', N'Cấp III', 0, N'Nhân viên', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 040 423', N'0843 546 484', N'khoihm93@gmail.com', N'KhoihM', 0, 0, N'        ', 0, 1, 15, CAST(N'2014-10-26 08:36:19.720' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (72, N'GXTN20', NULL, N'Giuse', N'a', 1, N'20141014', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-26 09:42:07.750' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (73, N'GXTN21', NULL, N'Mattheu', N'Huỳnh Văn Thánh', 1, N'19911000', N'Tây Ninh', N'Giuse Huỳnh Văn Hải', N'Gioakim Nguyễn Thị Thanh Phương', 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 13, CAST(N'2014-10-26 09:42:55.957' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (74, N'GXTN22', NULL, N'Gioakim', N'Huỳnh Gia Cát Tấn', 1, N'20140928', N'Đồng Nai', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-26 09:51:56.090' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (75, N'GXTN23', NULL, N'Gioakim', N'Phan Ngọc Long', 1, N'19981000', N'Tiền Giang', N'Đaminh Huỳnh Minh Khôi', NULL, 1, 1, 0, NULL, N'Trên Đại học', 1, N'Công nhân', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-26 09:57:27.853' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (76, N'GXTN24', NULL, N'Phêrô Tự', N'Phan Ngọc Lâm Tuấn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', N'Cấp III', 1, N'Nông dân', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-26 09:58:47.370' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (77, N'GXTN25', NULL, N'Giuse', N'Huỳnh Lâm Phan', 1, N'19981220', N'Tiền Giang', NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141116', 0, 1, 7, CAST(N'2014-10-26 10:09:49.843' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (78, N'GXTN26', NULL, N'Giuse', N'Huỳnh Cảm Tử', 1, N'20140928', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, N'66/16 Lâm Phong', N'0838 403 624', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-10-26 15:28:10.070' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (79, N'GXTN27', NULL, N'Mattheu', N'Huỳnh Cảm Biến Thịnh', 1, N'20141006', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-26 15:28:39.510' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (80, N'GXTN28', NULL, N'Antôn', N'Phan Ngọc Hành', 0, N'20141006', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141009', 0, 1, 5, CAST(N'2014-10-26 15:29:14.427' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (81, N'GXTN29', NULL, N'Phêrô Tự', N'Huỳnh Quốc Phương', 1, N'19930302', N'Tiền Giang', N'Giuse Huỳnh Văn Hải', N'Phanxicô Nguyễn Thị Ngọc Linh', 0, 1, 1, N'Lâm Đồng', N'Cao đẳng', 1, N'Thiết kế đồ họa', N'66/1A Lô B', N'0838 403 624', N'0932 040 423', N'phuong@yahoo.com', N'Test thử ghi chú
ABC', 1, 0, N'        ', 0, 1, 5, CAST(N'2014-10-26 17:30:39.387' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (82, N'GXTN30', NULL, N'Gioakim', N'Huỳnh Minh Lương', 1, N'19931224', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, N'        ', 1, 1, 26, CAST(N'2014-10-26 17:50:41.073' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (83, N'GXTN31', NULL, N'Phanxicô', N'Nguyễn Thị Khánh Ngọc', 0, N'19930308', N'Hồ Chí Minh', N'Giuse Huỳnh Thanh Lân', N'Giuse Huỳnh Lam Ngọc', 1, 1, 1, N'Gia Lai', N'Trung học', 1, N'Buôn bán', N'12A Nguyễn Huệ', N'0838 403 624', N'0932 040 423', N'khoihm93@gmail.com', N'Test thử chức năng load edit
Test xuống hàng', 0, 0, N'        ', 1, 0, 3, CAST(N'2014-10-26 23:27:01.990' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (84, N'GXTN32', NULL, N'Đaminh', N'Huỳnh Tấn Tài', 1, N'19940623', N'Tiền Giang', N'Giuse Huỳnh Tấn Tài', N'Rosa Nguyễn Thị Thanh Hằng', 1, 1, 0, N'', N'Đại học', 1, N'Công nhân', N'123 Ngô Tất Tố', N'0838 403 6555', N'0923 040 432', N'taitai@gmail.com', N'Test edit giáo dân
Test thử xuống hàng', 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-27 14:42:14.627' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (85, N'GXTN33', NULL, N'Mattheu', N'Huỳnh Nhơn Lộc', 1, N'19931223', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-10-27 17:31:37.193' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (86, N'GXTN34', NULL, N'Phaolô', N'Ngô Văn Thành', 1, N'19930502', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-27 17:33:35.113' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (87, N'GXTN35', NULL, N'Phêrô Tự', N'Tạ Vĩnh Nhân', 1, N'19930504', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-27 17:34:04.090' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (88, N'GXTN36', NULL, N'Gioakim', N'Huỳnh Văn Kháng', 1, N'20141007', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-27 17:36:39.087' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (89, N'GXTN37', NULL, N'Phanxicô', N'Huỳnh Văn Thanh', 0, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141112', 1, 0, 17, CAST(N'2014-10-27 17:37:30.123' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (90, N'GXTN38', NULL, N'Giuse', N'Lê Văn Vàng', 1, N'20140928', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-27 17:44:12.820' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (91, N'GXTN39', NULL, N'Giuse', N'Văn Phong Thành', 1, N'20141005', N'Tiền Giang', N'Phaolô Lê Minh Quang', N'Rosa Lương Mộng Hảo', 1, 1, 0, N'', N'Cấp I', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:20:28.897' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (92, N'GXTN40', NULL, N'Phanxicô', N'Phan Xích Văn', 1, N'19930303', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-28 08:22:03.063' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (93, N'GXTN41', NULL, N'Mattheu', N'Huỳnh Ngọc Hà', 0, N'20140811', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-10-28 08:24:05.587' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (94, N'GXTN42', NULL, N'Rosa', N'Huỳnh Thái Lân', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 8, CAST(N'2014-10-28 08:24:26.053' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (95, N'GXTN43', NULL, N'Đaminh', N'Huỳnh Vân Vân', 0, N'19950300', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-28 08:24:57.430' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (96, N'GXTN44', NULL, N'Giuse', N'Phan Văn Ngọc', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 5, CAST(N'2014-10-28 08:26:21.637' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (97, N'GXTN45', NULL, N'Phanxicô', N'Huỳnh Ngọc Vân', 0, N'20061112', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'        ', 1, 0, 10, CAST(N'2014-10-28 08:28:44.303' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (98, N'GXTN46', NULL, N'Phanxicô', N'Huỳnh Ngọc Phương', 0, N'20141006', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-28 08:29:44.473' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (99, N'GXTN47', NULL, N'Phanxicô', N'Huỳnh Văn Linh', 0, N'        ', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 14, CAST(N'2014-10-28 08:31:06.207' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (100, N'GXTN48', NULL, N'Rosa', N'Huỳnh Phúc Linh', 0, N'20141014', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 14, CAST(N'2014-10-28 08:31:54.893' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (101, N'GXTN49', NULL, N'Rosa', N'Thái Văn Linh', 0, N'        ', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 38, CAST(N'2014-10-28 08:33:03.943' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (102, N'GXTN50', NULL, N'Giuse', N'Huỳnh Phúc Thương', 0, N'20141103', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-10-28 08:34:36.233' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (103, N'GXTN51', NULL, N'Đaminh', N'Huỳnh Tấn Cát', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141125', 1, 0, 10, CAST(N'2014-10-28 08:36:48.403' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (104, N'GXTN52', NULL, N'Phanxicô', N'Huỳnh Long Ngọc', 0, N'        ', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 14, CAST(N'2014-10-28 08:38:22.700' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (105, N'GXTN53', NULL, N'Phaolô', N'Nguyễn Văn Buồn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:39:44.387' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (106, N'GXTN54', NULL, N'Mattheu', N'Huỳnh Phan Văn', 1, N'19931222', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-10-28 08:41:51.133' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (107, N'GXTN55', NULL, N'Mattheu', N'Huỳnh Văn Phạm', 1, N'20031200', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-10-28 08:44:08.927' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (108, N'GXTN56', NULL, N'Phaolô', N'Võ Hoàng Thịnh', 1, N'        ', NULL, N'Mattheu Huỳnh Nhơn Lộc', N'Giuse Huỳnh Văn Thanh', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:49:04.277' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (109, N'GXTN57', NULL, N'Phêrô Tự', N'Phạm Hoàng Thủ', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 3, CAST(N'2014-10-28 08:50:27.217' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (110, N'GXTN58', NULL, N'Giuse', N'Phan Trung Anh', 0, N'20121000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 19, CAST(N'2014-10-28 13:16:46.503' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (111, N'GXTN59', NULL, N'Gioakim', N'Huỳnh Minh Tuấn', 1, N'20141014', N'Tiền Giang', N'Phaolô Nguyễn Văn Buồn', N'Đaminh Huỳnh Vân Vân', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 3, CAST(N'2014-10-30 08:43:31.687' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (112, N'GXTN60', NULL, N'Phanxicô', N'Nguyễn Phong Lưu', 1, N'20141013', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-10-30 08:43:58.790' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (113, N'GXTN61', NULL, N'Mattheu', N'Nguyễn Thị Ngọc Linh', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 5, CAST(N'2014-10-30 08:53:35.140' AS DateTime), N'manager', N'staff', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (114, N'GXTN62', NULL, N'Mattheu', N'Nguyễn Thanh', 1, N'20141016', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-30 15:40:27.697' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (115, N'GXTN63', NULL, N'Phaolô', N'Huỳnh Tuấn', 1, N'20141005', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-30 15:52:58.000' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (116, N'GXTN64', NULL, N'Giuse', N'Huỳnh Mẫn Mẫn', 0, N'20141014', NULL, NULL, NULL, 1, 1, 0, N'', N'Cấp II', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-10-30 15:57:57.860' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (117, N'GXTN65', NULL, N'Antôn', N'Nguyễn Thành Thái', 1, N'20141006', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 17, CAST(N'2014-10-30 17:16:20.020' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (118, N'GXTN66', NULL, N'Rosa', N'Nguyễn Thị Trinh', 0, N'19950602', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 8, CAST(N'2014-10-30 17:17:01.950' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (119, N'GXTN67', NULL, N'Phanxicô', N'Huỳnh Vân Lữ', 1, N'20141006', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Giuse Huỳnh Lam Ngọc', 1, 0, 0, N'', N'Cao đẳng', 1, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', NULL, NULL, NULL, NULL, 0, 1, N'20141117', 1, 0, 10, CAST(N'2014-10-31 08:09:08.057' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (120, N'GXTN68', NULL, N'Phêrô', N'Nguyễn Phong Thịnh', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-10-31 08:11:50.033' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (121, N'GXTN69', NULL, N'Phanxicô', N'Phan Minh Trung', 1, N'19930800', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 8, CAST(N'2014-10-31 10:28:58.143' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (122, N'GXTN70', NULL, N'Mattheu', N'Huỳnh Minh Kha', 0, N'20141014', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-10-31 12:44:37.887' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (123, N'GXTN71', NULL, N'Mattheu', N'Nguyễn Thành Công', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, N'6532 154 8787', NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-01 11:41:54.360' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (124, N'GXTN72', NULL, N'Phêrô Tự', N'Phan Văn Hưng', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, N'0932 405 4878', NULL, NULL, 0, 1, N'20141110', 1, 0, 10, CAST(N'2014-11-02 10:24:05.690' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (125, N'GXTN73', NULL, N'Giuse', N'Huỳnh Văn Minh', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-02 10:46:38.043' AS DateTime), N'manager', N'staff', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (126, N'GXTN74', NULL, N'Phanxicô', N'Huỳnh Ảnh Thủ', 1, N'        ', NULL, NULL, NULL, 1, 0, 2, N'an thưa', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-02 21:54:11.267' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (127, N'GXTN75', NULL, N'Mattheu', N'Huỳnh Văn Phượng', 0, N'20141026', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 13, CAST(N'2014-11-02 22:15:42.953' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (128, N'GXTN76', NULL, N'Phanxicô', N'Phan Văn Phong', 0, N'        ', NULL, NULL, NULL, 1, 0, 2, N'unknow', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-02 22:16:34.960' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (129, N'GXTN77', NULL, N'Gioakim', N'Huỳnh Lâm Quang', 0, N'20140908', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 14, CAST(N'2014-11-02 22:17:01.503' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (130, N'GXTN78', NULL, N'Phaolô', N'Lâm Phượng', 0, N'20140707', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 14, CAST(N'2014-11-02 22:17:49.857' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (131, N'GXTN79', NULL, N'Mattheu', N'Huỳnh Phượng Linh', 0, N'20140407', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 11, CAST(N'2014-11-02 22:19:25.947' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (132, N'GXTN80', NULL, N'Phêrô Tự', N'Hà Lãng', 1, N'20141027', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 37, CAST(N'2014-11-02 22:25:10.793' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (133, N'GXTN77', NULL, N'Phêrô', N'Ngô Gia Thành', 1, N'19981000', N'Tây Ninh', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, NULL, N'Cấp III', 0, N'Nhân viên', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 8, CAST(N'2014-11-07 09:37:58.793' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (134, N'GXTN78', NULL, N'Antôn', N'Thái Phú Trạch', 1, N'20140928', N'Tây Ninh', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 2, N'test', N'Cấp III', 0, N'Nội trợ', N'66/16 Xố Viết Nghệ Tĩnh', N'0838 403 624', N'0932 040 423', N'thaiphutrach@gmail.com', N'Test', 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-07 09:54:17.837' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (135, N'GXTN79', NULL, N'Mattheu', N'Huỳnh Văn Sáng', 1, N'20141026', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Minh Thư', 1, 1, 2, N'abc', N'Cấp III', 0, N'Nhân viên', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-11-09 11:07:48.023' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (136, N'GXTN80', NULL, N'Gioakim', N'Huỳnh Phúc Mẫn', 1, N'20141119', NULL, N'Antôn Phan Đăng Cường', NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141102', 0, 1, 10, CAST(N'2014-11-09 11:51:00.823' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (137, N'GXTN81', NULL, N'Mattheu', N'Lã Quốc Phong', 1, N'20141026', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-11 04:43:47.560' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (138, N'GXTN82', NULL, N'Phêrô Tự', N'Liên Thanh Phương', 1, N'20141027', N'Tiền Giang', N'Gioakim Huỳnh Gia Cát Tấn', N'Giuse Huỳnh Ngọc Phượng', 0, 0, 0, N'', N'Cấp III', 0, N'Nhân viên', NULL, N'0838 463 2154', N'0932 044 0874', N'khoihm93@gmail.com', NULL, 0, 1, N'20141103', 0, 1, 1, CAST(N'2014-11-12 12:24:16.277' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (139, N'GXTN83', NULL, N'Phanxicô', N'Quách Tỉnh', 1, N'19500000', N'Tiền Giang', NULL, NULL, 1, 1, 0, NULL, N'Trên Đại học', 1, N'Nghề tự do', N'66/16 XVNT', NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 16, CAST(N'2014-11-12 13:39:15.933' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (140, N'GXTN84', NULL, N'Gioakim', N'Phương Văn Gia', 1, N'20141103', N'Tiền Giang', NULL, NULL, 0, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-11-12 13:55:53.397' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (141, N'GXTN85', NULL, N'Mattheu', N'Huỳnh Ngọc Nữ', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-12 16:29:34.800' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (142, N'GXTN86', NULL, N'Giuse', N'Huỳnh Văn Phụng', 0, N'20141026', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-11-16 09:59:35.460' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (143, N'GXTN87', NULL, N'Phêrô Tự', N'Phan Văn Bạc', 1, N'19930302', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Giuse Huỳnh Ngọc Phượng', 1, 1, 0, NULL, N'Trung học', 0, N'Buôn bán', NULL, N'0838 403 624', N'0932 404 023', N'khoihm93@gmail.com', N'test ghi chu', 0, 0, N'        ', 0, 1, 15, CAST(N'2014-11-19 09:16:05.057' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (144, N'GXTN88', NULL, N'Phaolô', N'Phan Văn Kim', 0, N'19930228', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-11-19 09:16:26.597' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (145, N'GXTN89', NULL, N'Gioakim', N'Phan Văn Đồng', 0, N'19900000', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141109', 0, 1, 10, CAST(N'2014-11-19 09:16:54.377' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (146, N'GXTN90', NULL, N'Phanxicô', N'Đỗ Ngọc Hường', 1, N'19950800', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-19 14:33:48.203' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (147, N'GXTN91', NULL, N'Giuse', N'Đỗ Huỳnh Long', 1, N'19980000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 9, CAST(N'2014-11-19 14:36:47.347' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (148, N'GXTN92', NULL, N'Phanxicô', N'Phong Lưu Hồ', 1, N'20140525', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-19 14:38:46.173' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (149, N'GXTN93', NULL, N'Phêrô', N'Lưu Phước Hải', 1, N'19971021', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 8, CAST(N'2014-11-19 14:45:22.503' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (150, N'GXTN94', NULL, N'Phanxicô', N'Trương Linh Phụng', 0, N'19930518', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', N'Đại học', 0, N'Buôn bán', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-19 14:48:20.873' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (151, N'GXTN95', NULL, N'Mattheu', N'Đỗ Thị Trấn', 1, N'19981015', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 10, CAST(N'2014-11-19 14:50:55.400' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (152, N'GXTN96', NULL, N'Giuse', N'Đỗ Minh Luân', 1, N'20140831', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20160405', 0, 1, 10, CAST(N'2014-11-19 14:51:47.733' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (153, N'GXTN97', NULL, N'Mattheu', N'Huỳnh Lam Phúc', 1, N'20140930', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 26, CAST(N'2014-11-19 14:54:35.777' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (154, N'GXTN98', NULL, N'Phaolô', N'Đỗ Ngọc Thùy', 0, N'20141027', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2014-11-19 14:56:31.013' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (155, N'GXTN99', NULL, N'Mattheu', N'Đỗ Minh Lộc', 1, N'20121124', N'Tây Ninh', N'Antôn Nguyễn Thành Thái', NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-20 12:22:07.623' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (156, N'GXTN100', NULL, N'Phanxicô', N'Đỗ Thành Đạt', 1, N'19981202', N'Tiền Giang', N'Giuse Đỗ Minh Luân', N'Giuse Huỳnh Lam Ngọc', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 1, 10, CAST(N'2014-11-20 12:32:54.357' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (157, N'GXTN101', NULL, N'Mattheu', N'Huỳnh Minh Khôi', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 12:46:39.767' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (158, N'GXTN102', NULL, N'Mattheu', N'Huỳnh Quốc Phong', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-20 12:48:24.460' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (159, N'GXTN103', NULL, N'Mattheu', N'Đỗ Văn Thừa', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'123 CMT8', N'0838 422 3311', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-11-20 12:49:36.470' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (160, N'GXTN104', NULL, N'Gioakim', N'Đỗ Hữu Tài', 1, N'20031000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-20 13:00:36.390' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (161, N'GXTN105', NULL, N'Mattheu', N'Phan Thái Liên', 0, N'19950302', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-11-20 13:47:00.510' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (162, N'GXTN106', NULL, N'Mattheu', N'Huỳnh Trọng Phú', 0, N'        ', NULL, N'Đaminh Phan Văn Long', N'Giuse Huỳnh Ngọc Phượng', 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141111', 1, 0, 10, CAST(N'2014-11-20 13:50:47.163' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (163, N'GXTN107', NULL, N'Antôn', N'Đỗ Gia Lâm', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 13:51:39.333' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (164, N'GXTN108', NULL, N'Đaminh', N'Huỳnh Phong Phú', 1, N'19931000', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 14:26:46.460' AS DateTime), N'manager', N'manager2', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (165, N'GXTN109', NULL, N'Mattheu', N'Huỳnh Tấn Trung', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 11, CAST(N'2014-11-20 14:27:20.497' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (166, N'GXTN110', NULL, N'Đaminh', N'Phan Văn Long', 1, N'19981110', N'Tiền Giang', N'Gioakim Huỳnh Gia Cát Tấn', N'Giuse Huỳnh Lam Ngọc', 1, 1, 0, N'', N'Cấp III', 0, N'Buôn bán', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-20 14:27:48.857' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (167, N'GXTN111', NULL, N'Mattheu', N'Huỳnh Ngọc Hải', 0, N'20121031', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-27 08:11:00.697' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (168, N'GXTN112', NULL, N'Phanxicô', N'Huỳnh Văn Đổi', 0, N'20141027', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141212', 1, 0, 8, CAST(N'2014-11-27 08:11:37.157' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (169, N'GXTN113', NULL, N'Mattheu', N'Đỗ Hồng Ngọc', 0, N'19950302', N'Tiền Giang', N'Antôn Phan Đăng Cường', N'Gioakim Huỳnh Tú Trinh', 1, 1, 0, N'', N'Cao đẳng', 0, N'Buôn bán', N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', N'0932 044 023', N'hongngoc@gmail.com', N'test ghi chú', 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-27 08:13:27.367' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (170, N'GXTN114', NULL, N'Mattheu', N'Đỗ Hoàng Kim', 1, N'19951002', NULL, NULL, NULL, 1, 1, 0, N'', N'Cao đẳng', 1, N'Buôn bán', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-11-27 10:10:27.140' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (171, N'GXTN115', NULL, N'Mattheu', N'Huỳnh Văn Cát', 1, N'20141102', NULL, NULL, NULL, 1, -1, 2, N'abc', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2014-11-27 10:14:27.560' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (172, N'GXTN116', NULL, N'Phaolô', N'Hoàng Kim Tuấn', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 19, CAST(N'2014-11-27 10:15:08.673' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (173, N'GXTN117', NULL, N'Phêrô Tự', N'Đỗ Thị Lai', 0, N'20040902', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 10:15:47.753' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (174, N'GXTN118', NULL, N'Phêrô', N'Đỗ Thành Lân', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 10:23:14.490' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (175, N'GXTN119', NULL, N'Antôn', N'Mai Văn Linh', 1, N'20141026', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 10:40:53.563' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (176, N'GXTN120', NULL, N'Antôn', N'Huỳnh Phúc Vân', 1, N'20051202', N'Tiền Giang', NULL, NULL, 1, 1, 0, N'', N'Trung học', 1, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-11-27 11:04:56.387' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (177, N'GXTN121', NULL, N'Phêrô', N'Lai Văn Thành', 1, N'20091127', NULL, NULL, NULL, 1, 1, 1, N'Tân Định', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-27 11:05:39.267' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (178, N'GXTN122', NULL, N'Antôn', N'Lê Minh Tuấn', 1, N'19950902', N'Tiền Giang', N'Antôn Nguyễn Thành Thái', N'Phêrô Tự Bùi Thị Đông', 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-27 15:38:49.243' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (179, N'GXTN123', NULL, N'Phêrô', N'Huỳnh Minh Quân', 0, N'20011210', N'Hồ Chí Minh', NULL, NULL, 1, 0, 2, N'Tân Phong', N'Trung học', 1, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-11-27 15:39:34.977' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (180, N'GXTN124', NULL, N'Mattheu', N'Huỳnh Lưu Thương', 1, N'19961210', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', NULL, NULL, NULL, 0, 1, N'20141212', 1, 0, 10, CAST(N'2014-11-27 18:03:32.083' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (181, N'GXTN125', NULL, N'Phanxicô', N'Huỳnh Hữu Lộc', 1, N'20141026', NULL, NULL, NULL, 1, -1, 2, N'thị nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-11-27 23:44:25.830' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (182, N'GXTN126', NULL, N'Giuse', N'Huỳnh Minh Khôi', 1, N'19950502', NULL, NULL, NULL, 1, 0, 2, N'abc', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 17, CAST(N'2014-11-27 23:46:43.987' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (187, N'GXTN127', NULL, N'Anrê', N'Huỳnh Long Nhật', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-28 09:32:12.720' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (188, N'GXTN128', NULL, N'Phêrô Tự', N'Huỳnh Minh Khôi', 1, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', N'Cấp III', 1, N'Nhân viên', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 044 023', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 26, CAST(N'2014-11-28 10:02:07.287' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (189, N'GXTN129', NULL, N'Đaminh', N'Huỳnh Văn Phú', 1, N'19931020', N'Tây Ninh', N'Gioakim Đỗ Hữu Tài', N'Rosa Lê Thị Hà', 1, 1, 0, N'', N'Cấp I', 0, N'Buôn bán', NULL, N'0838 403 624', N'0932 040 423', N'phuvan@gmail.com', N'ghi chú chung', 0, 0, N'        ', 0, 1, 37, CAST(N'2014-11-28 10:22:09.867' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (190, N'GXTP1', NULL, N'Antôn', N'Huỳnh Ngọc Quân', 1, N'19931200', N'Tây Ninh', N'Giuse Huỳnh Ngọc Long', N'Đaminh Huỳnh Văn Phúc', 1, 1, 0, NULL, N'Đại học', 0, N'Nội trợ', N'66/16 Xô Viết Nghệ Tĩnh', N'0838 403 625', N'0932 040 423', N'quan@gmail.com', N'ghi chú thông tin', 0, 0, N'        ', 1, 0, 29, CAST(N'2014-11-28 16:26:10.233' AS DateTime), N'managertanphong', N'managertanphong', NULL, NULL, 12, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (191, N'GXTP2', NULL, N'Antôn', N'Huỳnh Phúc Linh', 0, N'20091020', N'Tiền Giang', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 30, CAST(N'2014-11-28 16:27:49.820' AS DateTime), N'managertanphong', N'managertanphong', NULL, NULL, 12, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (192, N'GXTP3', NULL, N'Anrê', N'Huỳnh Quốc Phú', 1, N'19930200', N'Tây Ninh', NULL, NULL, 1, 1, 0, NULL, N'Cấp III', 1, N'Nội trợ', NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 30, CAST(N'2014-11-28 16:33:37.760' AS DateTime), N'managertanphong', N'managertanphong', NULL, NULL, 12, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (193, N'GXTN130', NULL, N'Catarina', N'Huỳnh Minh Lưu', 1, N'20141027', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 37, CAST(N'2014-11-28 17:17:31.550' AS DateTime), N'manager', N'admin', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (194, N'GXTN129', NULL, N'Clara', N'Đỗ Thành Hải', 0, N'        ', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-30 12:56:25.690' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (195, N'GXTN130', NULL, N'Vincentê', N'Lâm Phong Giả', 1, N'19921020', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-30 13:24:50.840' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (196, N'GXTN131', NULL, N'Vincentê', N'Vendetta', 1, N'19901130', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 16, CAST(N'2014-11-30 15:53:13.500' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (197, N'GXTN132', NULL, N'Têrêsa', N'Hạ Uyên', 0, N'19901114', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-11-30 15:53:52.543' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (198, N'GXTN133', NULL, N'Phêrô', N'Trần Phi', 1, N'19901113', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 8, CAST(N'2014-11-30 15:57:09.740' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (199, N'GXTN134', NULL, N'Simon', N'Pumpa', 0, N'19901127', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-11-30 15:57:23.707' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (200, N'GXTN135', NULL, N'Clara', N'Cleric', 1, N'19961105', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 7, CAST(N'2014-11-30 16:10:40.000' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (201, N'GXTN136', NULL, N'Catarina', N'Ngô Quang Phụng', 0, N'19951121', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 15, CAST(N'2014-11-30 16:10:56.947' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (202, N'GXTN137', NULL, N'Antôn', N'Huỳnh Thánh Tôn', 1, N'19901002', NULL, NULL, NULL, 1, 1, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 13, CAST(N'2014-11-30 16:23:35.067' AS DateTime), N'manager', N'manager', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (203, N'GXTN137', NULL, N'Tôma', N'Nguyễn Quang Đại', 1, N'        ', NULL, NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'19901110', 1, 0, 7, CAST(N'2014-12-01 15:44:50.960' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (204, N'GXTN138', NULL, N'Antôn', N'Nguyễn Thành Công', 0, N'        ', NULL, NULL, NULL, 1, -1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-12-01 19:47:27.813' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (205, N'GXTN139', NULL, N'Giuse', N'Huỳnh Quốc Phong', 1, N'19651012', N'Đà Lạt', NULL, NULL, 1, 1, 0, N'', N'Trên Đại học', 0, N'Nhân viên', N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', N'0932 040 423', N'phong@gmail.com', NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-05 06:24:40.867' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (206, N'GXTN140', NULL, N'Rosa', N'Nguyễn Ngọc Vân', 0, N'        ', N'Tây Ninh', NULL, NULL, 1, 0, 0, N'', N'Đại học', 0, N'Nội trợ', N'66/A XVNT P.21 Quận Bình Thạnh TP HCM', N'0838 403 624', N'0932 288 7654', NULL, NULL, 0, 1, N'19920302', 1, 0, 10, CAST(N'2014-12-05 06:30:07.890' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (207, N'GXTN141', NULL, N'Maria', N'Lê Minh Thu', 0, N'19971101', N'Hải Phòng', NULL, NULL, 1, 1, 1, N'Thị Nghè', N'Cấp III', 0, N'Học sinh', N'102/2A Ngô Tất Tố P.19 Quận Bình Thạnh TP HCM', N'0838 462 167', N'0938 391 602', N'minhthu@gmail.com', NULL, 0, 0, N'        ', 1, 0, 13, CAST(N'2014-12-05 07:01:54.237' AS DateTime), N'manager', N'manager2', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (208, N'GXTN142', NULL, N'Clara', N'Đỗ Ngọc Lan', 0, N'19901210', N'Hồ Chí Minh', NULL, NULL, 1, 0, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'19901210', 1, 0, 26, CAST(N'2014-12-05 08:20:17.787' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (209, N'GXTN143', NULL, N'Vincentê', N'Huỳnh Quốc Thiên', 1, N'19930302', NULL, N'Giuse Huỳnh Quốc Phong', N'Rosa Nguyễn Ngọc Vân', 1, 0, 1, N'Thị Nghè', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'20141210', 1, 0, 13, CAST(N'2014-12-05 13:11:25.363' AS DateTime), N'manager', N'manager2', NULL, NULL, 9, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (210, N'GXTN143', NULL, N'Têrêsa', N'Nguyễn Thị Ngọc Linh', 0, N'        ', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, N'19901109', 1, 0, 10, CAST(N'2014-12-11 21:42:18.853' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (211, N'GXTN144', NULL, N'Henricô', N'Huỳnh Quốc Quang', 1, N'19931012', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-13 16:45:18.330' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (212, N'GXTN145', NULL, N'Catarina', N'Nguyễn Ngọc Phương Linh', 0, N'20031115', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 1, CAST(N'2014-12-14 07:36:08.633' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (213, N'GXTN146', NULL, N'Antôn', N'Trần Âu Mỹ', 1, N'19901112', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 10, CAST(N'2014-12-14 07:38:03.567' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (214, N'GXTN147', NULL, N'Simon', N'Huỳnh Phúc Quân', 1, N'19900302', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-12-14 08:08:22.603' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (215, N'GXTN148', NULL, N'Antôn', N'Đỗ Thành Tài', 1, N'20101115', N'Tây Ninh', NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-12-14 08:20:20.660' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (216, N'GXTN149', NULL, N'Gioakim', N'Phan Quang Trị', 1, N'19901010', NULL, NULL, NULL, 1, 0, 0, NULL, NULL, 0, NULL, N'66/12A XVNT P.21 Quận Bình Thạnh', N'0838 403 624', NULL, NULL, NULL, 0, 1, N'20141201', 0, 1, 10, CAST(N'2014-12-14 09:06:45.463' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (217, N'GXTN150', NULL, N'Đaminh', N'Quốc Mạnh Tùng', 1, N'19901010', NULL, NULL, NULL, 1, 0, 2, N'Bình Lợi', N'Cấp III', 0, N'Buôn bán', N'66/16 Xô Viết Nghệ Tĩnh', N'0932 204 4087', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-12-14 09:35:23.790' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (218, N'GXTN151', NULL, N'Anrê', N'Phan Quang Tú', 1, N'19891112', NULL, NULL, NULL, 1, 0, 2, N'Tân Bình', NULL, 0, NULL, N'66/16 Lâm Phong', N'0838 403 624', NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 15, CAST(N'2014-12-14 09:36:32.993' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (219, N'GXTN152', NULL, N'Đaminh', N'Phạm Hữu Lộc', 1, N'20141201', N'Nha Trang', N'Antôn Nguyễn Thành Thái', N'Giuse Huỳnh Ngọc Phượng', 1, 0, 0, N'', N'Cao đẳng', 0, N'Nghề tự do', N'123 CMT8', N'0838 422 3311', NULL, NULL, NULL, 0, 1, N'        ', 0, 1, 7, CAST(N'2014-12-14 18:12:06.930' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (220, N'GXTN153', NULL, N'Clara', N'Lại Quốc Khôi', 1, N'19930302', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-12-14 20:22:50.763' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (221, N'GXTN154', NULL, N'Gioakim', N'Phan Thị Thu', 0, N'19891012', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 17, CAST(N'2014-12-14 20:23:14.530' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (222, N'GXTN155', NULL, N'Anrê', N'Đỗ Thị Lai', 1, N'19901101', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, N'123 CMT8', N'0838 422 3311', NULL, NULL, NULL, 0, 0, N'        ', 1, 0, 16, CAST(N'2014-12-14 20:27:23.800' AS DateTime), N'manager', N'admin', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (223, N'GXTN156', NULL, NULL, N'Lưu Thị Linh', 0, N'19901012', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 10, CAST(N'2014-12-14 22:51:05.153' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (224, N'GXTN157', NULL, NULL, N'Lưu Lung Linh', 0, N'        ', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2014-12-14 22:55:47.813' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (226, N'GXTN158', NULL, N'Catarina', N'Nguyễn Đức Minh', 1, N'19801111', N'Dong Dong', NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 7, CAST(N'2016-05-21 11:57:35.117' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (803, N'GXTN159', NULL, N'Anrê', N'Nguyễn Văn Đông', 1, N'19981010', N'Tân Cường', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 4, CAST(N'2016-05-29 20:34:20.927' AS DateTime), N'admin', N'admin', NULL, NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (804, N'LM00001', N'63600328001806.jpg', N'Anrê', N'Nguyễn Văn Hồng', 1, N'19840101', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-05-31 21:20:53.270' AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (805, N'LM00006', N'63600327996991.jpg', N'Anrê', N'Nguyen Van An', 1, N'19870101', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-05-31 21:26:52.740' AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (806, N'LM00005', N'63600327991554.jpg', N'Gioakim', N'Tran Van Chin', 1, N'19670101', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-05-31 21:31:51.277' AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (807, N'LM00007', N'63600327996991.jpg', N'Antôn', N'Nguyen Van Sau', 1, N'19760101', NULL, NULL, NULL, 0, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1, 1, CAST(N'2016-05-31 21:47:33.887' AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (808, N'LM00008', N'63600336683565.jpg', N'Giuse', N'Nguyen Van Bay', 1, N'19670101', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-05-31 22:03:05.423' AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (809, N'LM00009', N'63600336676952.jpg', N'Antôn', N'Thái Văn Công', 1, N'19860101', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-05-31 22:05:16.517' AS DateTime), NULL, N'admin', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (810, N'LM00010', N'63600336689095.jpg', N'Đaminh', N'Tran Van Kinh', 1, N'19560101', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-06-01 00:11:06.310' AS DateTime), NULL, N'admin', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1808, N'GXTN159', NULL, N'Anrê', N'Nguyen Van Linh', 1, N'19901111', N'Dong Dong', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2016-06-09 22:27:04.583' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1809, N'LM00011', N'63603703455109.jpg', N'Antôn', N'Trần Van Bốn', 1, N'19080110', NULL, NULL, NULL, 0, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 1, CAST(N'2016-06-21 11:14:05.090' AS DateTime), NULL, N'admin', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1810, N'GXTN160', NULL, N'Anna', N'Trương Thị Mây', 0, N'20000101', N'Phan Rang', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 40, CAST(N'2016-06-21 17:24:41.223' AS DateTime), N'admin', N'admin', NULL, NULL, 15, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1811, N'GXTN160', NULL, N'Phero', N'Nguyễn Văn Minh', 1, N'19660701', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2016-07-09 11:03:12.330' AS DateTime), N'admin', N'admin', NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1812, N'GXTN161', NULL, N'Matthêu', N'Nguyễn Văn Mạnh', 1, N'19881111', NULL, NULL, NULL, 1, 1, 0, N'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2016-07-09 12:31:06.953' AS DateTime), NULL, N'manager', N'Anh', N'', 1, NULL, N'', NULL)
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1813, N'GXTN162', NULL, N'Maria', N'Trần Thị Hương', 0, N'19901111', N'Sài Gòn', NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2016-12-20 11:18:37.227' AS DateTime), N'manager', N'manager', NULL, NULL, 1, N'212102938', N'20091112', N'Hồ Chí Minh')
INSERT [dbo].[Parishioner] ([Id], [Code], [ImageUrl], [ChristianName], [Name], [Gender], [BirthDate], [BirthPlace], [FatherName], [MotherName], [IsCounted], [Status], [DomicileStatus], [DomicilePlace], [Education], [IsStudying], [Career], [Address], [Phone], [MobilePhone], [Email], [Note], [IsCatechumen], [IsDead], [DeadDate], [IsMarried], [IsSingle], [CommunityId], [CreatedDate], [CreatedBy], [LastUpdatedBy], [Title], [PatronDate], [ParishId], [IDNo], [IDDate], [IDPlace]) VALUES (1814, N'GXTN163', NULL, N'Đaminh', N'Nguyễn Văn Hồng', 1, N'19871209', NULL, NULL, NULL, 1, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, N'        ', 0, 1, 9, CAST(N'2016-12-20 11:20:03.247' AS DateTime), N'manager', N'manager', NULL, NULL, 1, NULL, N'', NULL)
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
SET IDENTITY_INSERT [dbo].[ParishManager] ON 

INSERT [dbo].[ParishManager] ([Id], [ParishId], [PriestId], [StartDate], [EndDate], [Position], [PositionName], [IdThuyenChuyenLinhMuc], [TakenDate], [StatusId], [Code], [ParishName], [ReportType]) VALUES (1, 5, 1, N'20160509', N'20160630', 1, N'', 1, CAST(N'2016-07-09 16:33:35.580' AS DateTime), 3, NULL, NULL, NULL)
INSERT [dbo].[ParishManager] ([Id], [ParishId], [PriestId], [StartDate], [EndDate], [Position], [PositionName], [IdThuyenChuyenLinhMuc], [TakenDate], [StatusId], [Code], [ParishName], [ReportType]) VALUES (5, 9, 583, N'20160701', N'', 1, N'', 3, NULL, 2, NULL, NULL, NULL)
INSERT [dbo].[ParishManager] ([Id], [ParishId], [PriestId], [StartDate], [EndDate], [Position], [PositionName], [IdThuyenChuyenLinhMuc], [TakenDate], [StatusId], [Code], [ParishName], [ReportType]) VALUES (6, 5, 589, N'20160701', N'', 1, N'', 3, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[ParishManager] ([Id], [ParishId], [PriestId], [StartDate], [EndDate], [Position], [PositionName], [IdThuyenChuyenLinhMuc], [TakenDate], [StatusId], [Code], [ParishName], [ReportType]) VALUES (7, 13, 585, N'20160701', N'', 1, N'', 3, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[ParishManager] ([Id], [ParishId], [PriestId], [StartDate], [EndDate], [Position], [PositionName], [IdThuyenChuyenLinhMuc], [TakenDate], [StatusId], [Code], [ParishName], [ReportType]) VALUES (8, 5, 1, N'20160630', N'20160509', 1, N'', 2, CAST(N'2016-07-09 16:20:40.020' AS DateTime), 3, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ParishManager] OFF
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

INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (1, N'Đaminh', N'Huỳnh Trọng Long', N'19800702  ', 1, NULL, 3)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (5, N'Antôn', N'Nguyễn Văn Trung', N'19791204  ', 1, N'09091231234', 7)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (583, N'Anrê', N'Nguyễn Văn Hồng', N'19840101  ', 1, NULL, 804)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (584, N'Anrê', N'Nguyen Van An', N'19870101  ', 1, NULL, 805)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (585, N'Gioakim', N'Tran Van Chin', N'19670101  ', 1, NULL, 806)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (587, N'Giuse', N'Nguyen Van Bay', N'19670101  ', 1, NULL, 808)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (588, N'Antôn', N'Thái Văn Công', N'19860101  ', 1, NULL, 809)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (589, N'Đaminh', N'Tran Van Kinh', N'19560101  ', 1, NULL, 810)
INSERT [dbo].[Priest] ([Id], [ChristianName], [Name], [BirthDate], [DioceseId], [Phone], [ParishionerId]) VALUES (1587, N'Antôn', N'Trần Van Bốn', N'19080110  ', 1, NULL, 1809)
SET IDENTITY_INSERT [dbo].[Priest] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [ForDiocese]) VALUES (1, N'Quản trị viên Giáo Phận', 1)
INSERT [dbo].[Role] ([Id], [Name], [ForDiocese]) VALUES (2, N'Quản lý Giáo xứ', 0)
INSERT [dbo].[Role] ([Id], [Name], [ForDiocese]) VALUES (3, N'Nhập liệu Giáo xứ', 0)
INSERT [dbo].[Role] ([Id], [Name], [ForDiocese]) VALUES (4, N'Giáo lý viên', 0)
INSERT [dbo].[Role] ([Id], [Name], [ForDiocese]) VALUES (5, N'Nhập liệu Giáo phận', 1)
SET IDENTITY_INSERT [dbo].[Role] OFF
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Account/AccountManagement', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Family', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Family', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Family', 3, 0)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Family', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Parishioner', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Parishioner', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Parishioner', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Parishioner', 4, 0)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/Parishioner', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewFamilyRequest', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewFamilyRequest', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewFamilyRequest', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewFamilyRequest', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewParishionerRequest', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewParishionerRequest', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewParishionerRequest', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ApproveRequest/ViewParishionerRequest', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/BanHanhGiao/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeCommunity/Family', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeCommunity/Family', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeCommunity/Parishioner', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeCommunity/Parishioner', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeParish/Family', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeParish/Family', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeParish/Parishioner', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ChangeParish/Parishioner', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Chart/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Chart/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Chart/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Chart/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Community/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Community/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Configuration/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Configuration/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Configuration/PreviewTemplate', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Configuration/PreviewTemplate', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Configuration/PreviewTemplate', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Configuration/PreviewTemplate', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ConstructionPermit/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ConstructionPermit/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DataChecking/Parishioner', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DataChecking/Parishioner', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DeaconRequisition/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DeaconRequisition/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DeaconRequisitionComment/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DeaconRequisitionComment/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Diocese/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Diocese/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Diocese/List', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Diocese/List', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DoctrineCourse/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DoctrineCourse/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DoctrineCourse/ManageClass', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/DoctrineCourse/ManageClass', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Donation/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Donation/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Family/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Family/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Family/SaveStorage', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Family/SaveStorage', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/GiayMoi/GiayMoi', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/GiayMoi/GiayMoi', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/HoiDongLinhMuc/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/HoiDongLinhMuc/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/LetterAndReport/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/LetterAndReport/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Message/CreateMessage', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Message/CreateMessage', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Message/CreateMessage', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Message/CreateMessage', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parish/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parish/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ParishHome/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ParishHome/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/PrintPage', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/PrintPage', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/PrintPage', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/PrintPage', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/SaveStorage', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Parishioner/SaveStorage', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Priest/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Priest/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Priest/PrintPage', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Priest/PrintPage', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Sacrament/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Sacrament/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SacramentCreation/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SacramentCreation/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Search/Parishioner', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Search/Parishioner', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Search/Parishioner', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Search/Parishioner', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SearchFamily/Family', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SearchFamily/Family', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SearchFamily/Family', 3, 1)
GO
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SearchFamily/Family', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Seminarian/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Seminarian/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Seminary/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Seminary/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Seminary/ParishSupportRequisitionSession', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Seminary/ParishSupportRequisitionSession', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Society/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Society/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Statistic/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Statistic/Index', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Statistic/Index', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Statistic/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ThuPhanUu/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ThuPhanUu/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ThuyenChuyenLinhMuc/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/ThuyenChuyenLinhMuc/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Vicariate/Index', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/Vicariate/Index', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Archive', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Archive', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Archive', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Archive', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Diocese', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Diocese', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'DoctineCourse', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'DoctineCourse', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'DoctineCourse', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'DoctineCourse', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'OfficeDepartment', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'OfficeDepartment', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Parish', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Parish', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Parish', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Parish', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'ParishionerDepartment', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'ParishionerDepartment', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'ParishionerFamily', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'ParishionerFamily', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'ParishionerFamily', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'ParishionerFamily', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Priest', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Priest', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Sacrament', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Sacrament', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Sacrament', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Sacrament', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Search', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Search', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Search', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Search', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Seminary', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Seminary', 5, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Statistic', 1, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Statistic', 2, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Statistic', 3, 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Statistic', 5, 0)
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
INSERT [dbo].[Sacrament] ([Id], [SacramentGroupId], [ParishionerId], [Number], [Type], [Patron], [Note], [Date], [Giver], [ReceivedPlace]) VALUES (70, NULL, 189, N'0932131321231', 1, N'Đaminh Huỳnh Trọng Luân', NULL, N'20041210', N'Giuse Huỳnh Phong Vân', N'Tây Ninh')
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
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Account/AccountManagement', N'Tài khoản', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/Family', N'Duyệt yêu cầu chuyển xứ cho gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/Parishioner', N'Duyệt yêu cầu chuyển xứ cho giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/ViewFamilyRequest', N'Xem yêu cầu chuyển xứ cho gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/ViewParishionerRequest', N'Xem yêu cầu chuyển xứ cho giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/BanHanhGiao/Index', N'Ban hành giáo', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ChangeCommunity/Family', N'Chuyển họ cho gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ChangeCommunity/Parishioner', N'Chuyển họ cho giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ChangeParish/Family', N'Chuyển xứ cho gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ChangeParish/Parishioner', N'Chuyển xứ cho giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Chart/Index', N'Biểu đồ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Community/Index', N'Danh sách giáo họ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Configuration/Index', N'Cấu hình giáo xứ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Configuration/PreviewTemplate', N'Cấu hình mẫu báo cáo của giáo xứ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ConstructionPermit/Index', N'Đơn xin xây dựng', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/DataChecking/Parishioner', N'Kiểm tra dữ liệu giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/DeaconRequisition/Index', N'Danh sách đợt xin chức phó tế', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/DeaconRequisitionComment/Index', N'Nhận xét phó tế', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Diocese/Index', N'Trang chủ giáo phận', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Diocese/List', N'Danh sách Giáo phận', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/DoctrineCourse/Index', N'Danh sách khối giáo lý', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/DoctrineCourse/ManageClass', N'Danh sách lớp giáo lý', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Donation/Index', N'Quản lý quyên góp', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Family/Index', N'Danh sách gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Family/SaveStorage', N'Hồ sơ lưu trữ gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/GiayMoi/GiayMoi', N'Giấy mời / thông báo', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/HoiDongLinhMuc/Index', N'Hội đồng Linh Mục', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/LetterAndReport/Index', N'Mẫu giấy tờ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Message/CreateMessage', N'Tạo tin nhắn', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Parish/Index', N'Danh sách Giáo xứ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ParishHome/Index', N'Trang chủ giáo xứ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Parishioner/Index', N'Danh sách giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Parishioner/PrintPage', N'In thông tin giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Parishioner/SaveStorage', N'Hồ sơ lưu trữ giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Priest/Index', N'Danh sách Linh mục', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Priest/PrintPage', N'In thẻ Linh Mục', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/RolePermission/Index', N'Phân quyền', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Sacrament/Index', N'Danh sách bí tích', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/SacramentCreation/Index', N'Tạo đợt bí tích tự động', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Search/Parishioner', N'Tìm kiếm giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/SearchFamily/Family', N'Tìm kiếm gia đình của giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Seminarian/Index', N'Danh sách chủng sinh', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Seminary/Index', N'Danh sách khóa học', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Seminary/ParishSupportRequisitionSession', N'Danh sách đợt xin giúp xứ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Society/Index', N'Danh sách hội đoàn', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Statistic/Index', N'Thống kê chung', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ThuPhanUu/Index', N'Thư phân ưu', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ThuyenChuyenLinhMuc/Index', N'Thuyên chuyển Linh Mục', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Vicariate/Index', N'Danh sách Giáo hạt', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Archive', N'Hồ sơ lưu trữ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Diocese', N'Giáo phận', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'DoctineCourse', N'Quản lý giáo lý', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'OfficeDepartment', N'Ban Văn Phòng', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Parish', N'Thông tin giáo xứ', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'ParishionerDepartment', N'Ban giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'ParishionerFamily', N'Giáo dân &amp; Gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Priest', N'Linh mục', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Sacrament', N'Sổ bí tích', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Search', N'Tìm kiếm', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Seminary', N'Chủng viện', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'Statistic', N'Thống kê', 1)
SET IDENTITY_INSERT [dbo].[SeminaryYear] ON 

INSERT [dbo].[SeminaryYear] ([Id], [StartAt], [EndAt], [SeminaryName], [SeminaryYearCode]) VALUES (2, CAST(N'2015-02-01 00:00:00.000' AS DateTime), CAST(N'2020-02-01 00:00:00.000' AS DateTime), N'Đại chủng viện thánh Giuse Xuân Lộc', N'X')
INSERT [dbo].[SeminaryYear] ([Id], [StartAt], [EndAt], [SeminaryName], [SeminaryYearCode]) VALUES (3, CAST(N'2014-02-01 00:00:00.000' AS DateTime), CAST(N'2019-02-01 00:00:00.000' AS DateTime), N'Đại chủng viện thánh Giuse Xuân Lộc', N'IX')
INSERT [dbo].[SeminaryYear] ([Id], [StartAt], [EndAt], [SeminaryName], [SeminaryYearCode]) VALUES (4, CAST(N'2015-02-01 00:00:00.000' AS DateTime), CAST(N'2020-02-01 00:00:00.000' AS DateTime), N'Đại chủng viên thánh Giuse Sài Gòn', N'XX')
SET IDENTITY_INSERT [dbo].[SeminaryYear] OFF
SET IDENTITY_INSERT [dbo].[ThuPhanUu] ON 

INSERT [dbo].[ThuPhanUu] ([Id], [MaGiaoDan], [NgayMat], [ChucVu], [MauThu]) VALUES (1, 152, CAST(N'2016-04-05 00:00:00.000' AS DateTime), N'Ông cố', NULL)
SET IDENTITY_INSERT [dbo].[ThuPhanUu] OFF
INSERT [dbo].[ThuPhanUu_NguoiNhan] ([ThuPhanUuId], [NguoiNhanId], [DaIn]) VALUES (1, 808, NULL)
INSERT [dbo].[ThuPhanUu_NguoiNhan] ([ThuPhanUuId], [NguoiNhanId], [DaIn]) VALUES (1, 809, NULL)
SET IDENTITY_INSERT [dbo].[ThuyenChuyenLinhMuc] ON 

INSERT [dbo].[ThuyenChuyenLinhMuc] ([Id], [NgayQuyetDinh], [NgayHieuLuc], [NguoiQuyetDinh], [MoTa]) VALUES (1, N'20160510', N'20160509', N'Antôn Nguyễn Văn Trung', N'Đợt thuyên chuyển ngày 10 tháng 05 năm 2016')
INSERT [dbo].[ThuyenChuyenLinhMuc] ([Id], [NgayQuyetDinh], [NgayHieuLuc], [NguoiQuyetDinh], [MoTa]) VALUES (2, N'20160530', N'20160630', N'Anrê Nguyễn Ngọc Dũng', N'Đợt thuyên chuyển ngày 30 tháng 05 năm 2016')
INSERT [dbo].[ThuyenChuyenLinhMuc] ([Id], [NgayQuyetDinh], [NgayHieuLuc], [NguoiQuyetDinh], [MoTa]) VALUES (3, N'20160602', N'20160701', N'Anrê Nguyen Van An', N'Đợt thuyên chuyển ngày 02 tháng 06 năm 2016')
SET IDENTITY_INSERT [dbo].[ThuyenChuyenLinhMuc] OFF
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (-1, N'Khác')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (1, N'Chánh xứ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (2, N'Phó xứ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (3, N'Truyền giáo')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (4, N'Du Học')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (5, N'Bề trên')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (6, N'Cộng đoàn')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (7, N'Đặc trách')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (8, N'Giám đốc')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (9, N'Hiệu trưởng')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (10, N'Linh phụ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (11, N'Phó Hiệu trưởng')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (12, N'Phụ trách')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (13, N'Quản nhiệm')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (14, N'Tổng Đại diện')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (15, N'Viện Phụ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (16, N'Nghỉ hưu')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (17, N'Về nhà riêng')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (18, N'Truyền giáo')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (19, N'Du Học')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (20, N'Bề trên')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (21, N'Cộng đoàn')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (22, N'Đặc trách')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (23, N'Giám đốc')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (24, N'Hiệu trưởng')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (25, N'Linh phụ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (26, N'Phó Hiệu trưởng')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (27, N'Phụ trách')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (28, N'Quản nhiệm')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (29, N'Tổng Đại diện')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (30, N'Viện Phụ')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (31, N'Nghỉ hưu')
INSERT [dbo].[VaiTro] ([Id], [Name]) VALUES (32, N'Về nhà riêng')
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
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (11, N'1', N'Dự đại hội', NULL, N'GiayMoi')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (12, N'2', N'Khánh thành nhà thờ', NULL, N'GiayMoi')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (13, N'3', N'Báo cáo tài chính', NULL, N'Báo cáo')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (14, N'1', N'Chứng nhận', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (15, N'2', N'Chúc mừng', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (16, N'3', N'Hồ sơ', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (17, N'4', N'Giới thiệu', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (18, N'5', N'Thành lập Giáo xứ', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (19, N'6', N'Thư phân ưu', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (20, N'7', N'Thẻ Linh Mục - Tu sĩ', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (21, N'8', N'Thư mời', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (22, N'9', N'Thông báo', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (23, N'10', N'Thuyên chuyển - bổ nhiệm', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (24, N'11', N'Tiến chức', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (25, N'12', N'Xác nhận đất đai', NULL, N'MBC')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (26, N'1', N'USD', NULL, N'Currency')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (27, N'2', N'VND', NULL, N'Currency')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (28, N'1', N'Chủ tịch', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (29, N'2', N'Phó chủ tịch', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (30, N'3', N'Thư ký', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (31, N'4', N'Thủ quỹ', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (32, N'5', N'Thành viên', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (33, N'1', N'Tòa giám mục', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (34, N'2', N'Thà thờ giáo xứ', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (35, N'3', N'Giáo họ biệt lập', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (36, N'4', N'Nhà dòng', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (37, N'5', N'Đại chủng viện', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (38, N'6', N'Trung tâm hành hương', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (39, N'7', N'Nhà hưu Giáo phận ', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (40, N'8', N'Hải ngoại', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (41, N'9', N'Nhà dự tu', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (42, N'10', N'Trường học', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (43, N'11', N'Cộng đoàn - Tu hội', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (44, N'-1', N'Khác', NULL, N'PARISHTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (45, N'D.GH', N'Dòng Giáo Hoàng', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (46, N'D.GH.H', N'Dòng Giáo Hoàng - Nghỉ hưu', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (47, N'D.GH-MV', N'Dòng Giáo Hoàng - Mục vụ', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (48, N'D.GP', N'Dòng Giáo Phận', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (49, N'D.GP.H', N'Dòng Giáo Phận - Nghỉ hưu', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (50, N'D.GP-MV', N'Dòng Giáo Phận - Mục vụ', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (51, N'TH.GH', N'Tu Hội Giáo Hoàng', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (52, N'TH.GH-MV', N'Tu Hội Giáo Hoàng - Mục vụ', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (53, N'TH.GP', N'Tu Hội Giáo Phận', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (54, N'TH.GP.H', N'Tu Hội Giáo Phận - Nghỉ hưu', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (55, N'TH.GP-MV', N'Tu Hội Giáo Phận - Mục vụ', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (56, N'GP', N'Linh Mục Triều', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (57, N'GP.ÐCV', N'Linh Mục Triều - Đại Chủng Viện', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (58, N'GP.Ng', N'Linh Mục Triều - Ngoài GP', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (59, N'GP.TGM', N'Linh Mục Triều - Tòa GM', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (60, N'GP.NH', N'Linh Mục ở Nhà Hưu Dưỡng', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (61, N'GP.H', N'Linh Mục Nghỉ Hưu ở Nhà Riêng - Trong GP', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (62, N'GP.H.Ng', N'Linh Mục Nghỉ Hưu ở Nhà Riêng - Ngoài GP', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (63, N'GP.HN.Dh', N'Linh Mục Hải Ngoại - Du Học', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (64, N'GP.HN.Mv', N'Linh Mục Hải Ngoại - Mục Vụ', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (65, N'GP.K', N'Linh Mục Triều - Nghỉ Tạm', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (66, N'Ng.GP.ÐCV', N'Linh Mục GP Khác - Làm ở ĐCV', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (67, N'Ng.GP.H', N'Linh Mục GP Khác - Nghỉ Hưu Tại GP', NULL, N'SEMINARYTAG')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (80, N'TCLM01', N'BN - Thuyên Chuyển Chánh xứ', N'04 BN - TChuyen chanhxu.docx', N'TCLMTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (81, N'TCLM02', N'BN Phó đi Chánh xứ', N'03 BN Pho di chanhxu.docx', N'TCLMTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (82, N'TCLM03', N'BN Phó đi Phó', N'02 BN Pho di Pho.docx', N'TCLMTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (83, N'TCLM04', N'BN Tân LM đi Phó', N'01 BN Tan LM di Pho.docx', N'TCLMTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (84, N'TCLM05', N'BN nghỉ hưu', N'06 BN thay cha nghi huu.docx', N'TCLMTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (85, N'TCLM06', N'BN cha dòng', N'09 BN cha dong.docx', N'TCLMTYPE')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (109, N'VERSION', N'2.0.0.0', NULL, N'CONFIG')
SET IDENTITY_INSERT [dbo].[ValueSet] OFF
SET IDENTITY_INSERT [dbo].[Vicariate] ON 

INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (0, N'Không chỉ định', 1, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (1, N'Bình Thạnh', 1, 2)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (2, N'Tân Bình', 1, 6)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (4, N'Bình Tân', 1, 9)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (5, N'Thủ Đức', 1, 10)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (6, N'Tân Thuận', 1, 12)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (7, N'Quang Trung', 1, 13)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (8, N'Bình Thạnh', 3, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (9, N'Phan Rang', 3, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (10, N'Đà Lạt', 2, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (11, N'Phú Công', 4, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (12, N'Sài Gòn', 2, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (13, N'Hải Ngoại', 3, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (14, N'Sài Gòn', 2, NULL)
INSERT [dbo].[Vicariate] ([Id], [Name], [DioceseId], [ParishId]) VALUES (15, N'Hải Ngoại', 3, NULL)
SET IDENTITY_INSERT [dbo].[Vicariate] OFF
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (117, N'20141121', N'        ', N'20141113', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 4, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (120, N'20140908', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (122, N'20141112', N'        ', N'20141110', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (123, N'20141112', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (124, N'20141113', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (125, N'20141113', N'        ', N'20141120', N'20141111', N'20141126', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (197, N'20141202', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (208, N'20121200', N'20130400', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (209, N'20141203', N'20141205', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (211, N'20141201', N'20141209', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 0, NULL, NULL, N'', N'', N'', 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (804, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (805, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (806, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (807, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (808, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (809, N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 4, NULL, NULL, N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (810, N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 4, NULL, NULL, N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Vocation] ([ParishionerId], [Date1], [Date2], [Date3], [Date4], [Date5], [Date6], [Date7], [Date8], [Date9], [Seminary], [SeminaryAddress], [Position], [ServedPlace], [ServedAddress], [Phone], [Email], [Note], [IsLeft], [IsRetired], [TypeCode], [ServedId], [ServedType], [Place1], [Place2], [Place3], [Place4], [Place5], [Place6], [Place7], [Place8], [Place9], [Giver1], [Giver2], [Giver3], [Giver4], [Giver5], [Giver6], [Giver7], [Giver8], [Giver9], [ServedRole], [ServedStartDate], [Diocesan]) VALUES (1809, N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', N'        ', NULL, NULL, 4, NULL, NULL, N'', N'', N'', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
/****** Object:  Index [CK_ValueSet]    Script Date: 12/20/2016 11:23:28 AM ******/
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
ALTER TABLE [dbo].[GiayMoi]  WITH CHECK ADD  CONSTRAINT [FK_GiayMoi_LetterAndReport] FOREIGN KEY([MauId])
REFERENCES [dbo].[LetterAndReport] ([Id])
GO
ALTER TABLE [dbo].[GiayMoi] CHECK CONSTRAINT [FK_GiayMoi_LetterAndReport]
GO
ALTER TABLE [dbo].[HDLMMember]  WITH CHECK ADD  CONSTRAINT [FK_HDLMMember_Priest] FOREIGN KEY([PriestID])
REFERENCES [dbo].[Priest] ([Id])
GO
ALTER TABLE [dbo].[HDLMMember] CHECK CONSTRAINT [FK_HDLMMember_Priest]
GO
ALTER TABLE [dbo].[KhachMoi]  WITH CHECK ADD  CONSTRAINT [FK_KhachMoi_GiayMoi] FOREIGN KEY([GiayMoiId])
REFERENCES [dbo].[GiayMoi] ([Id])
GO
ALTER TABLE [dbo].[KhachMoi] CHECK CONSTRAINT [FK_KhachMoi_GiayMoi]
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
