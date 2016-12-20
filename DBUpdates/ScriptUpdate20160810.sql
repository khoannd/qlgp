/* 2016/08/10 START */
/* ALTER TABLE Parishioner */
ALTER TABLE Parishioner
ADD Title nvarchar(20) NULL,
PatronDate varchar(4) NULL,
ParishId INT NULL DEFAULT 0
GO

ALTER TABLE Parishioner
ADD IDNo nvarchar(20) NULL,
IDDate nvarchar(8) NULL,
IDPlace nvarchar(200) NULL
GO

UPDATE Parishioner SET BirthDate = REPLACE(BirthDate, '.', '')
GO

ALTER TABLE Parishioner
ALTER COLUMN CommunityId INT NULL;
GO

ALTER TABLE Family
ADD ParishId INT NULL DEFAULT 0
GO

ALTER TABLE Family
ALTER COLUMN CommunityId INT NULL;
GO

ALTER TABLE ParishionerMigrationRequest
ALTER COLUMN FromCommunityId INT NULL;
GO

ALTER TABLE FamilyMigrationRequest
ALTER COLUMN FromCommunityId INT NULL;
GO

/* ALTER TABLE Vocation */
ALTER TABLE Vocation
ADD IsRetired BIT DEFAULT 0 NOT NULL,
TypeCode varchar(50) NULL
,ServedId INT NULL
,ServedType INT NULL,
Place1 nvarchar(100) NULL,
Place2 nvarchar(100) NULL,
Place3 nvarchar(100) NULL,
Place4 nvarchar(100) NULL,
Place5 nvarchar(100) NULL,
Place6 nvarchar(100) NULL,
Place7 nvarchar(100) NULL,
Place8 nvarchar(100) NULL,
Place9 nvarchar(100) NULL,
Giver1 nvarchar(100) NULL,
Giver2 nvarchar(100) NULL,
Giver3 nvarchar(100) NULL,
Giver4 nvarchar(100) NULL,
Giver5 nvarchar(100) NULL,
Giver6 nvarchar(100) NULL,
Giver7 nvarchar(100) NULL,
Giver8 nvarchar(100) NULL,
Giver9 nvarchar(100) NULL,
ServedRole int NULL,
ServedStartDate nvarchar(8)

GO

/* ALTER TABLE Vocation */
ALTER TABLE Vocation
ADD Diocesan BIT DEFAULT 1 NOT NULL
GO

ALTER TABLE Priest DROP CONSTRAINT [DF__Priest__Diocesan__693CA210]
GO
ALTER TABLE Priest DROP COLUMN [Diocesan]
GO

/* ALTER TABLE Parish */
ALTER TABLE Parish
ADD Category INT DEFAULT 2 NOT NULL, -- Parish Type
DioceseId INT NOT NULL DEFAULT 0
GO

/* ALTER TABLE Parish */
ALTER TABLE ParishManager
ADD ParishName nvarchar(255) NULL
GO

ALTER TABLE ParishManager
ADD ReportType nvarchar(20) NULL -- REF TO ValueSet.Code
GO

UPDATE Parish SET DioceseId = (SELECT DioceseId FROM Vicariate WHERE Parish.VicariateId=Vicariate.Id);
GO

INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('1', N'Tòa giám mục', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('2', N'Thà thờ giáo xứ', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('3', N'Giáo họ biệt lập', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('4', N'Nhà dòng', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('5', N'Đại chủng viện', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('6', N'Trung tâm hành hương', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('7', N'Nhà hưu Giáo phận ', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('8', N'Hải ngoại', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('9', N'Nhà dự tu', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('10', N'Trường học', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('11', N'Cộng đoàn - Tu hội', NULL, 'PARISHTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('-1', N'Khác', NULL, 'PARISHTYPE');

GO
-- INSERT TCLMTYPE
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TCLM01', N'BN - Thuyên Chuyển Chánh xứ', N'04 BN - TChuyen chanhxu.docx', 'TCLMTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TCLM02', N'BN Phó đi Chánh xứ', N'03 BN Pho di chanhxu.docx', 'TCLMTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TCLM03', N'BN Phó đi Phó', N'02 BN Pho di Pho.docx', 'TCLMTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TCLM04', N'BN Tân LM đi Phó', N'01 BN Tan LM di Pho.docx', 'TCLMTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TCLM05', N'BN nghỉ hưu', N'06 BN thay cha nghi huu.docx', 'TCLMTYPE');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TCLM06', N'BN cha dòng', N'09 BN cha dong.docx', 'TCLMTYPE');

GO

INSERT INTO VaiTro (Name) VALUES (N'Truyền giáo');
INSERT INTO VaiTro (Name) VALUES (N'Du Học');
INSERT INTO VaiTro (Name) VALUES (N'Bề trên');
INSERT INTO VaiTro (Name) VALUES (N'Cộng đoàn');
INSERT INTO VaiTro (Name) VALUES (N'Đặc trách');
INSERT INTO VaiTro (Name) VALUES (N'Giám đốc');
INSERT INTO VaiTro (Name) VALUES (N'Hiệu trưởng');
INSERT INTO VaiTro (Name) VALUES (N'Linh phụ');
INSERT INTO VaiTro (Name) VALUES (N'Phó Hiệu trưởng');
INSERT INTO VaiTro (Name) VALUES (N'Phụ trách');
INSERT INTO VaiTro (Name) VALUES (N'Quản nhiệm');
INSERT INTO VaiTro (Name) VALUES (N'Tổng Đại diện');
INSERT INTO VaiTro (Name) VALUES (N'Viện Phụ');
INSERT INTO VaiTro (Name) VALUES (N'Nghỉ hưu');
INSERT INTO VaiTro (Name) VALUES (N'Về nhà riêng');

SET IDENTITY_INSERT VaiTro ON
INSERT INTO VaiTro (Id, Name) VALUES (-1, N'Khác');
SET IDENTITY_INSERT VaiTro OFF
GO

INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('D.GH', N'Dòng Giáo Hoàng', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('D.GH.H', N'Dòng Giáo Hoàng - Nghỉ hưu', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('D.GH-MV', N'Dòng Giáo Hoàng - Mục vụ', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('D.GP', N'Dòng Giáo Phận', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('D.GP.H', N'Dòng Giáo Phận - Nghỉ hưu', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('D.GP-MV', N'Dòng Giáo Phận - Mục vụ', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TH.GH', N'Tu Hội Giáo Hoàng', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TH.GH-MV', N'Tu Hội Giáo Hoàng - Mục vụ', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TH.GP', N'Tu Hội Giáo Phận', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TH.GP.H', N'Tu Hội Giáo Phận - Nghỉ hưu', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('TH.GP-MV', N'Tu Hội Giáo Phận - Mục vụ', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP', N'Linh Mục Triều', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.ĐCV', N'Linh Mục Triều - Đại Chủng Viện', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.Ng', N'Linh Mục Triều - Ngoài GP', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.TGM', N'Linh Mục Triều - Tòa GM', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.NH', N'Linh Mục ở Nhà Hưu Dưỡng', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.H', N'Linh Mục Nghỉ Hưu ở Nhà Riêng - Trong GP', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.H.Ng', N'Linh Mục Nghỉ Hưu ở Nhà Riêng - Ngoài GP', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.HN.Dh', N'Linh Mục Hải Ngoại - Du Học', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.HN.Mv', N'Linh Mục Hải Ngoại - Mục Vụ', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('GP.K', N'Linh Mục Triều - Nghỉ Tạm', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('Ng.GP.ĐCV', N'Linh Mục GP Khác - Làm ở ĐCV', NULL, 'SEMINARYTAG');
INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('Ng.GP.H', N'Linh Mục GP Khác - Nghỉ Hưu Tại GP', NULL, 'SEMINARYTAG');
GO

INSERT INTO Diocese(Name, ImageUrl, IsDefault, Code) VALUES(N'Hải Ngoại', '', 0, 'HAINGOAI');
GO

INSERT INTO Vicariate(Name, DioceseId, ParishId) VALUES(N'Sài Gòn', 2, NULL);
INSERT INTO Vicariate(Name, DioceseId, ParishId) VALUES(N'Hải Ngoại', 3, NULL);
GO
SET IDENTITY_INSERT Vicariate ON
INSERT INTO Vicariate(Id, Name, DioceseId) VALUES (0, N'Không chỉ định', 1);
SET IDENTITY_INSERT Vicariate OFF
GO
UPDATE Vicariate SET Name=RTRIM(LTRIM(Name));
GO

/* -- FOR XL ONLY
UPDATE Parishioner SET ParishId=1 WHERE [Code] LIKE 'LM%'
GO
UPDATE Parish SET Category = 1, Name=N'Tòa Giám mục Xuân Lộc' WHERE Id=1; -- TGM
UPDATE Parish SET Category = 5, Name=N'Đại Chủng viện Xuân Lộc' WHERE Id=2; -- DCV
GO

UPDATE Vicariate  SET name = REPLACE(name, N'Hoà', N'Hòa') WHERE name like N'%hoà %' or name like N'%hoà';
GO

INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Anh', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Canada', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Cao Thái', 13, 2, 2);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Dòng Đồng Công', 13, 4, 2, N'521 Tỉnh lộ 43, P. Tam Phú, Thủ Đức. Tp. HCM');
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Hoa Kỳ', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Hong Kong', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Nhà dự tu Gò Vấp', 13, 9, 2);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Nhà dự tu Thánh Tịnh', 13, 9, 2);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Nhà Dự tu Tống Viết Bường', 13, 9, 2);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Sài Gòn', 13, -1, 2);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Pháp', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Phi Luật Tân', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Rôma', 14, -1, 3);
INSERT INTO Parish(Name, VicariateId, Category, DioceseId) VALUES (N'Nhà hưu Giáo phận', 0, 7, 1);
GO

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Tông Đồ Nhỏ')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Tông Đồ Nhỏ', 3, 11, 1, N'Gia Tân 2, Thống Nhất, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Đức Huy')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Đức Huy', 3, 2, 1, N'Gia Tân 1, Thống Nhất, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Fatima')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Fatima', 3, 2, 1, N'Gia Kiệm, Thống Nhất , Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thanh Sơn')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thanh Sơn', 3, 2, 1, N'Quang Trung, Thống Nhất, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Anh')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Anh', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Canada')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Canada', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Hoa Kỳ')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Hoa Kỳ', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Hong Kong')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Hong Kong', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Pháp')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Pháp', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Phi Luật Tân')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Phi Luật Tân', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Rôma')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Rôma', 14, -1, 3, N' ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Hải Dương')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Hải Dương', 4, 2, 1, N'469Kp.6, P.Hố Nai, Biên Hòa, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thánh Tâm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thánh Tâm', 4, 2, 1, N'Tân Biên, Biên Hòa, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Đền Martin')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Đền Martin', 4, 6, 1, N'Tân Biên, Biên Hòa, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Ngũ Phúc')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Ngũ Phúc', 5, 2, 1, N'Xã Hố Nai 3, Trảng Bom, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Trường nghề Hòa Bình')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Trường nghề Hòa Bình', 5, 10, 1, N'Hố Nai 3, Trảng Bom, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Hiền Đức')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Hiền Đức', 6, 2, 1, N'Phước Thái, Long Thành, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Long Đức')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Long Đức', 6, 2, 1, N'Xã An Phước, Long Thành, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Tân Cang')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Tân Cang', 6, 2, 1, N'Xã Phước Tân, Biên Hòa, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thành Đức')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thành Đức', 6, 2, 1, N'Xã Suối Trầu, Long Thành, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thiên Bình')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thiên Bình', 6, 2, 1, N'Xã Tam Phước, Tp. Biên Hòa, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Bùi Đệ')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Bùi Đệ', 7, 2, 1, N'Xã Bắc Sơn, Trảng Bom, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Vĩnh Phước')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Vĩnh Phước', 8, 2, 1, N'Xã Vĩnh Thanh, Nhơn Trạch, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Bình Lâm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Bình Lâm', 9, 2, 1, N'20/1 Đồng Xoài, Túc Trưng, Định Quán, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Mai Lâm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Mai Lâm', 9, 2, 1, N'Xã Phú Lâm, Tân Phú , Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Tiên Lâm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Tiên Lâm', 9, 2, 1, N'Ấp 3, Xã Núi Tượng, Tân Phú, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Tu hội Bác Ái - Phú Dòng')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Tu hội Bác Ái - Phú Dòng', 11, 11, 1, N'xã Phú Cường, Định Quán, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Chúa Cứu Thế- Phú Dòng')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Chúa Cứu Thế- Phú Dòng', 11, 2, 1, N'Ấp Phú Dòng, Xã Phú Cường, Định Quán, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Đức Thắng')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Đức Thắng', 11, 2, 1, N'20/1 Đồng Xoài, Túc Trưng, Định Quán, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Túc Trưng')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Túc Trưng', 11, 2, 1, N'xã Phú Cường, Định Quán, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Hồng Ân')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Hồng Ân', 12, 2, 1, N'Ấp 4, Sông Ray, Cẩm Mỹ, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Tân Ngãi')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Tân Ngãi', 12, 2, 1, N'Xã Xuân Tâm, Xuân Lộc, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thái Xuân')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thái Xuân', 12, 2, 1, N'Xuân Định, Xuân Lộc, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thánh Gia')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thánh Gia', 12, 2, 1, N'Ấp Bình Tân, Xã Xuân Phú, Xuân Lộc, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thừa Ân')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thừa Ân', 12, 2, 1, N'Ấp 4, Xã Thừa Đức, Cẩm Mỹ, Đồng Nai') END


IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Thánh Linh')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Thánh Linh', 6, 3, 1, N'Ấp 2, Xã Bàu Cạn, Long Thành, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Hiếu Liêm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Hiếu Liêm', 7, 3, 1, N'Hiếu Liêm, Vĩnh Cửu, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Giang Lâm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Giang Lâm', 9, 3, 1, N'Xã Phú Thanh, Tân Phú, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Tà Lài')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Tà Lài', 9, 3, 1, N'xã Phú Lập, Tân Phú , Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Phanxicô')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Phanxicô', 10, 3, 1, N'P. Long Bình, Biên Hoà, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Chà Rang')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Chà Rang', 12, 3, 1, N'Ấp Chà Rang, Xã Suối Cao, Xuân Lộc, Đồng Nai ') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Trảng Táo')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Trảng Táo', 12, 3, 1, N'Ấp Trảng Táo, Xã Xuân Thành, Xuân Lộc, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Xuân Tôn')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Xuân Tôn', 12, 3, 1, N'Xã Xuân Bắc, Xuân Lộc, Đồng Nai') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Nhà Vãng lai Phát Diệm')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Nhà Vãng lai Phát Diệm', 13, -1, 2, N'Nhà Vãng Lai Phát Diệm, 102 Chiến Thắng, P. 9, Phú Nhuận, Tp. HCM') END

IF NOT EXISTS (SELECT 1 FROM Parish WHERE Name = N'Cây Gáo')
BEGIN INSERT INTO Parish(Name, VicariateId, Category, DioceseId, Address) VALUES (N'Cây Gáo', 3, 2, 1, N'Thanh Bình, Trảng Bom, Đồng Nai') END

GO

UPDATE Parish  SET name = REPLACE(name, N'Hoà', N'Hòa') WHERE name like N'%hoà %' or name like N'%hoà';
UPDATE Parish SET name=N'Chính Tòa' where name = N'Xuân Lộc';
UPDATE Parish SET name=N'Đan Kar' where name = N'Đankar';
UPDATE Parish SET name=N'Na Goa' where name = N'Nagoa';
UPDATE Parish SET name=N'Martinô' where name = N'Martino';
UPDATE Parish SET name=N'Đức Mẹ HCG' where name = N'Đức Mẹ HCG.';
UPDATE Parish SET name=N'Tòa Giám mục Xuân Lộc' where name = N'Toà Giám mục Xuân Lộc';
GO
UPDATE parishioner  SET name = REPLACE(name, N'Hoà', N'Hòa') WHERE name like N'%hoà %' or name like N'%hoà';
UPDATE priest  SET name = REPLACE(name, N'Hoà', N'Hòa') WHERE name like N'%hoà %' or name like N'%hoà';
GO
*/
/* 2016/08/10 END */
