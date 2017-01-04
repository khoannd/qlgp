INSERT [dbo].[Menu] ([Id], [ScreenId], [Text], [NewWindow], [IconClass], [ParentId], [Position], [Visible], [MenuType], [Link]) VALUES (1, N'/VocationFilter/Index', N'Thông tin giáo dân', 0, N'fa-users', 0, 1200, 1, 1, N'/VocationFilter/Index')
INSERT [dbo].[ScreenAction] ([Id], [Name], [Enabled]) VALUES (N'/VocationFilter/Index', N'Thông tin giáo dân', 1)
INSERT [dbo].[RolePermission] ([ScreenId], [RoleId], [Permission]) VALUES (N'/VocationFilter/Index', 1, 1)

ALTER TABLE [dbo].[Vocation]
ADD [SeminaryId] int NULL, [SeminaryType] int NULL