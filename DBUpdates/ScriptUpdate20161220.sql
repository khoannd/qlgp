/* 2016/12/20 START */
IF NOT EXISTS (SELECT 1 FROM ValueSet WHERE Category = 'CONFIG' AND Code = 'VERSION')
BEGIN 
	INSERT INTO ValueSet (Code, Definition, Note, Category) VALUES ('VERSION', N'2.0.0.0', NULL, 'CONFIG');
END
ELSE
BEGIN
	UPDATE ValueSet SET Definition = '2.0.0.0' WHERE Category = 'CONFIG' AND Code = 'VERSION'
END
GO

UPDATE Parishioner
SET ParishId = (SELECT C.ParishId FROM Community c WHERE c.Id = Parishioner.CommunityId AND Parishioner.CommunityId IS NOT NULL)
WHERE Parishioner.CommunityId IS NOT NULL
GO

/* -- review data

delete from priest where parishionerid in (select id from parishioner where code like 'MGD%')
go
select * from priest where parishionerid in (select id from parishioner where gender=1)
go
SELECT * from parish where priestid in (select id from priest where parishionerid in (select id from parishioner where code like 'MGD%'))
go
update parishioner set gender = 1 where id in (select parishionerid from priest)
go
delete from priest where parishionerid in (select parishionerid from familymember)

*/
/* 2016/12/20 END */