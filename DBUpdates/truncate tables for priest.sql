DELETE FROM Donation;
DBCC CHECKIDENT ('Donation',RESEED, 0);
GO
DELETE FROM DonationRank;
DBCC CHECKIDENT ('DonationRank',RESEED, 0);
GO
DELETE FROM DonationSession;
DBCC CHECKIDENT ('DonationSession',RESEED, 0);
GO
DELETE FROM FamilyMember;
DBCC CHECKIDENT ('FamilyMember',RESEED, 0);
GO
DELETE FROM FamilyMigrationRequest;
DBCC CHECKIDENT ('FamilyMigrationRequest',RESEED, 0);
GO
DELETE FROM ParishionerMigrationRequest;
DBCC CHECKIDENT ('ParishionerMigrationRequest',RESEED, 0);
GO
DELETE FROM ParishManager;
DBCC CHECKIDENT ('ParishManager',RESEED, 0);
GO
DELETE FROM ThuyenChuyenLinhMuc;
DBCC CHECKIDENT ('ThuyenChuyenLinhMuc',RESEED, 0);
GO
UPDATE Parish SET PriestId = null;
DELETE FROM Priest;
DBCC CHECKIDENT ('Priest',RESEED, 0);
GO
DELETE FROM Sacrament;
DBCC CHECKIDENT ('Sacrament',RESEED, 0);
GO
DELETE FROM Vocation;
GO
DELETE FROM VocationDeaconRequisitionSession;
DBCC CHECKIDENT ('VocationDeaconRequisitionSession',RESEED, 0);
GO
DELETE FROM VocationExchangeReligiousCommunityBase;
DBCC CHECKIDENT ('VocationExchangeReligiousCommunityBase',RESEED, 0);
GO
DELETE FROM VocationSeminaryYear;
DBCC CHECKIDENT ('VocationSeminaryYear',RESEED, 0);
GO
DELETE FROM Parishioner;
DBCC CHECKIDENT ('Parishioner',RESEED, 0);
GO