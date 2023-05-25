INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/VocationFilter/Index', N'Thông tin giáo dân', 1)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (64, N'/VocationFilter/Index', N'Thông tin giáo dân', 0, N'fa-users', 0, 1200, 1, 1, N'/VocationFilter/Index')
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/VocationFilter/Index', 1, 1)

INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/MenuManagement/Index', N'Quản lý chức năng', 1)
INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (65, N'/MenuManagement/Index', N'Quản lý chức năng', 0, N'fa-bars', 4, 402, 1, 1, N'/MenuManagement/Index')
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/MenuManagement/Index', 1, 1)

ALTER TABLE [dbo].[Vocation]
ADD [SeminaryId] int NULL, [SeminaryType] int NULL