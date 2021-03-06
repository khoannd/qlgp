-- post update SQL script
-- write comment foreach SQL block
-- comment exaple: 2016-04-10 VuongMV add table ValueSet

-- 2016-06-08 KhoanND add tables RolePermission, Menu
-- This table allow a role accesses menu/screen,  contains actions which have SessionFilterExpired
CREATE TABLE [RolePermission](
	[ScreenId] [varchar](255) NOT NULL,
	[RoleId] [int] NOT NULL,
	[Permission] [int] NOT NULL CONSTRAINT [DF_RolePermission_Permission]  DEFAULT ((1)),
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[ScreenId] ASC,
	[RoleId] ASC,
	[Permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
-- Define menu for diocese (MenuType=1) or parish (MenuType=2), associate with table RolePermission to display menu for each role
CREATE TABLE [Menu](
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

-- 2016-06-19 KhoanND modify table Role, Diocese
GO

ALTER TABLE [Role]
ADD ForDiocese BIT NOT NULL DEFAULT 0;
GO
UPDATE Diocese SET Code=N'HCM' Where ID=2
GO
ALTER TABLE Diocese
ALTER COLUMN Code nvarchar(10) NOT NULL
-- 2016-06-20 KhoanND add table ScreenAction - List all screens and actions in system which need to check permission for specific role, this table allows user manages permission on screen
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
-- 2016-06-22 KhoanND INSERT DATA FOR MENU, SCREEN, PERMISSION

INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/Account/AccountManagement', N'Tài khoản', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/Family', N'Duyệt yêu cầu chuyển xứ cho gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/Parishioner', N'Duyệt yêu cầu chuyển xứ cho giáo dân', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/ViewFamilyRequest', N'Xem yêu cầu chuyển xứ cho gia đình', 1)
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/ApproveRequest/ViewParishionerRequest', N'Xem yêu cầu chuyển xứ cho giáo dân', 1)
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
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/BanHanhGiao/Index', N'Ban hành giáo', 1)
GO

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
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (60, N'/BanHanhGiao/Index', N'Ban hành giáo', 0, N'fa-user', 20, 1005, 1, 1, N'/BanHanhGiao/Index')
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
UPDATE Role SET ForDiocese=1 WHERE Id=1
INSERT [dbo].[Role] ([Id], [Name], [ForDiocese]) VALUES (5, N'Nhập liệu Giáo phận', 1)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
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
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/SearchFamily/Family', 5, 1)
GO
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
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'Statistic', 5, 1)
GO
-- 2016/07/01 Khoan add tables: BanHanhGiao, BanHanhGiaoMember
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
-- 2016/07/01 Khoan insert data into ValueSet table for BanHanGiaoMember.RoleId
SET IDENTITY_INSERT [dbo].[ValueSet] ON
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (28, N'1', N'Chủ tịch', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (29, N'2', N'Phó chủ tịch', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (30, N'3', N'Thư ký', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (31, N'4', N'Thủ quỹ', NULL, N'BHG_Role')
INSERT [dbo].[ValueSet] ([Id], [Code], [Definition], [Note], [Category]) VALUES (32, N'5', N'Thành viên', NULL, N'BHG_Role')
SET IDENTITY_INSERT [dbo].[ValueSet] OFF
GO
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (60, N'/BanHanhGiao/Index', N'Ban hành giáo', 0, N'fa-user', 20, 1005, 1, 1, N'/BanHanhGiao/Index')
-- GO
-- INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/BanHanhGiao/Index', N'Ban hành giáo', 1)
GO
Update Community SET Name=N'Mặc định' WHERE IsDefault=1;


