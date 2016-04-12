-- post update SQL script
-- write comment foreach SQL block
-- comment exaple: 2016-04-10 VuongMV add script to create table ValueSet

-- comment: 2016-04-12 PhuongND add script to create tables SeminaryYear, VocationSeminaryYear, DeaconRequisitionSession, VocationDeaconRequisitionSession, DeaconRequisitionComment, LeaveVocationRequisition, ReligiousCommunity, ReligiousCommunityBase, ReligiousCommunityManagementTerm, VocationExchangeReligiousCommunityBase
/****** Object:  Table [dbo].[DeaconRequisitionComment]    Script Date: 12/04/2016 6:08:58 CH ******/
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
ALTER TABLE [dbo].[LeaveVocationRequisition]  WITH CHECK ADD  CONSTRAINT [FK_LeaveVocationRequisition_Vocation] FOREIGN KEY([VocationId])
REFERENCES [dbo].[Vocation] ([ParishionerId])
GO
ALTER TABLE [dbo].[LeaveVocationRequisition] CHECK CONSTRAINT [FK_LeaveVocationRequisition_Vocation]
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
