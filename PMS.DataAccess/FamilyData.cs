using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.DataAccess
{
    public class FamilyData
    {
        private readonly PMSDataContext _db;
        public FamilyData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Family> GetFamiliesByParishDivisionId(int parishDivisionId, bool? isCounted, int status)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F " +
                               "WHERE F.CommunityId = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    //Lay them nguoi da chuyen di
                    query += " UNION " +
                                 " SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId " +
                                 "WHERE FMR.FromCommunityId = {0} AND F.IsCounted = {1}";
                    //---------------------------

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        //Lay them nguoi da chuyen di
                        query += " UNION " +
                                     " SELECT F.* " +
                                     "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                     "ON F.Id = FMR.FamilyId " +
                                     "WHERE FMR.FromCommunityId = {0} AND F.IsCounted = {1}";
                        //---------------------------
                    }

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, isCounted, status);
                }

            }
            else
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F " +
                               "WHERE F.CommunityId = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";

                    //Lay them nguoi da chuyen di
                    query += " UNION " +
                                 " SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId " +
                                 "WHERE FMR.FromCommunityId = {0} ";
                    //---------------------------

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {1} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        //Lay them nguoi da chuyen di
                        query += " UNION " +
                                 " SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId " +
                                 "WHERE FMR.FromCommunityId = {0} ";
                        //---------------------------
                    }

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, status);
                }

            }
        }

        public IEnumerable<Family> GetFamiliesByCommunityId(int communityId, bool? isCounted, int status)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F INNER JOIN Community AS C " +
                               "ON F.CommunityId = C.Id " +
                               "WHERE (F.CommunityId = {0} OR C.ParentId = {0}) AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE (FMR.FromCommunityId = {0} OR C.ParentId = {0}) AND F.IsCounted = {1}";

                    return _db.ExecuteQuery<Family>(query, communityId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE (FMR.FromCommunityId = {0} OR C.ParentId = {0}) AND F.IsCounted = {1}";
                    }

                    return _db.ExecuteQuery<Family>(query, communityId, isCounted, status);
                }

            }
            else
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F INNER JOIN Community AS C " +
                               "ON F.CommunityId = C.Id " +
                               "WHERE (F.CommunityId = {0} OR C.ParentId = {0}) ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE (FMR.FromCommunityId = {0} OR C.ParentId = {0}) ";

                    return _db.ExecuteQuery<Family>(query, communityId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {1} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE (FMR.FromCommunityId = {0} OR C.ParentId = {0}) ";
                    }

                    return _db.ExecuteQuery<Family>(query, communityId, status);
                }

            }

        }

        public IEnumerable<Family> GetFamiliesByParishId(int parishId, bool? isCounted, int status)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) " +
                               "ON F.CommunityId = C.Id " +
                               "WHERE P.Id = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND F.IsCounted = {1} ";

                    return _db.ExecuteQuery<Family>(query, parishId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND F.IsCounted = {1} ";
                    }

                    return _db.ExecuteQuery<Family>(query, parishId, isCounted, status);
                }

            }
            else
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) " +
                               "ON F.CommunityId = C.Id " +
                               "WHERE P.Id = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} ";

                    return _db.ExecuteQuery<Family>(query, parishId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {1} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} ";
                    }

                    return _db.ExecuteQuery<Family>(query, parishId, status);
                }

            }

        }

        public IEnumerable<Family> GetFamiliesByVicariateId(int vicariateId, bool? isCounted, int status)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) " +
                               "ON C.ParishId = P.Id) ON F.CommunityId = C.Id " +
                               "WHERE V.Id = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND F.IsCounted = {1}";

                    return _db.ExecuteQuery<Family>(query, vicariateId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND F.IsCounted = {1}";
                    }

                    return _db.ExecuteQuery<Family>(query, vicariateId, isCounted, status);
                }

            }
            else
            {
                string query = "SELECT F.* " +
                               "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) " +
                               "ON C.ParishId = P.Id) ON F.CommunityId = C.Id " +
                               "WHERE V.Id = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} ";

                    return _db.ExecuteQuery<Family>(query, vicariateId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {1} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} ";
                    }

                    return _db.ExecuteQuery<Family>(query, vicariateId, status);
                }

            }

        }

        public IEnumerable<Family> GetFamiliesByDioceseId(int dioceseId, bool? isCounted, int status)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT F.* " +
                           "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN " +
                           "(Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id) " +
                           "ON C.ParishId = P.Id) ON F.CommunityId = C.Id " +
                           "WHERE D.Id = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND F.IsCounted = {1}";

                    return _db.ExecuteQuery<Family>(query, dioceseId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND F.IsCounted = {1}";
                    }

                    return _db.ExecuteQuery<Family>(query, dioceseId, isCounted, status);
                }

            }
            else
            {
                string query = "SELECT F.* " +
                           "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN " +
                           "(Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id) " +
                           "ON C.ParishId = P.Id) ON F.CommunityId = C.Id " +
                           "WHERE D.Id = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";

                    query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} ";

                    return _db.ExecuteQuery<Family>(query, dioceseId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved);
                }
                else
                {
                    query += "AND F.Status = {1} ";

                    if (status == (int)FamilyStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT F.* " +
                                 "FROM Family AS F INNER JOIN FamilyMigrationRequest AS FMR " +
                                 "ON F.Id = FMR.FamilyId INNER JOIN Community AS C " +
                                 "ON FMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} ";
                    }

                    return _db.ExecuteQuery<Family>(query, dioceseId, status);
                }

            }

        }

        public Family GetFamilyByParishionerId(int parishionerId, out bool isHouseholder, out int status, out int result)
        {
            try
            {
                //Chi check luu tru ko check xoa
                const string query = "SELECT F.* " +
                                         "FROM Family AS F INNER JOIN FamilyMember AS Fm " +
                                         "ON F.Id = Fm.FamilyId " +
                                         "WHERE Fm.ParishionerId = {0} AND Fm.Status = 1 AND F.Status != -1";

                var family = _db.ExecuteQuery<Family>(query, parishionerId).SingleOrDefault();

                if (family == null)
                {
                    isHouseholder = false;
                    result = 0;
                    status = -1;
                    return null;
                }

                //Voi gia dinh hien tai thi co phai la chu ho hay khong ?
                const string query2 = "SELECT Fm.* " +
                                      "FROM FamilyMember AS Fm " +
                                      "WHERE Fm.ParishionerId = {0} AND Fm.FamilyId = {1}";

                var member = _db.ExecuteQuery<FamilyMember>(query2, parishionerId, family.Id).SingleOrDefault();

                isHouseholder = false;
                status = -1;

                if (member != null)
                {
                    isHouseholder = member.IsHouseholder;
                    status = member.Status;
                }

                result = 1;
                return family;
            }
            catch (Exception e)
            {
                isHouseholder = false;
                result = -1;
                status = -1;
                return null;
            }

        }

        public int ChangeFamilyStatus(int id, int status, string username, bool isForced)
        {
            try
            {
                var family = _db.Families.SingleOrDefault(p => p.Id == id);

                if (family == null)
                {
                    return 0;
                }

                //Neu khong bi bat buoc thay doi trang thai thi kiem tra
                if (!isForced)
                {
                    //Xoa di
                    if (status == (int)FamilyStatusEnum.Deleted)
                    {

                        //Xem coi co yeu cau chuyen xu nao ko
                        var request =
                                family.FamilyMigrationRequests.SingleOrDefault(
                                    pmr => (pmr.FromCommunityId == family.CommunityId && pmr.ToParishId.HasValue &&
                                        pmr.Status == (int)MigrationRequestStatusEnum.Waiting));

                        if (request != null)
                        {
                            return -5;
                        }

                        //Neu so luong thanh vien hien tai = 0
                        if (family.FamilyMembers.Count(f => (f.Status == (int)FamilyMemberStatusEnum.Main
                                   && f.Parishioner.Status != (int)ParishionerStatusEnum.Deleted)) != 0)
                        {
                            return -3;
                        }

                    }

                }

                if (!isForced)
                {
                    //Phuc hoi
                    if (status == (int)FamilyStatusEnum.Available)
                    {

                        //Kiem tra xem coi co dang yeu cau chuyen xu khong ?
                        var request =
                            family.FamilyMigrationRequests.SingleOrDefault(
                                pmr => (pmr.FromCommunityId == family.CommunityId &&
                                    pmr.Status != (int)MigrationRequestStatusEnum.Approved));

                        if (request != null)
                        {
                            if (request.Status != (int)MigrationRequestStatusEnum.Reject && request.ToParishId.HasValue)
                            {
                                return -4;
                            }

                            //Neu nhu yeu cau chuyen xu nay bi tu choi roi
                            //Thuc hien xoa di cai request truoc khi doi status

                            //Tim ra nhung thang dang la main cua gia dinh nay
                            //Co truong hop no them vao gia dinh thi chua biet nen khong the cho phep o day != null duoc

                            var members =
                                family.FamilyMembers.Where(fm => fm.Status == (int)FamilyMemberStatusEnum.Main);

                            foreach (var familyMember in members)
                            {
                                var parishionerRequest =
                                    _db.ParishionerMigrationRequests.SingleOrDefault(
                                        pm => (pm.ParishionerId == familyMember.ParishionerId
                                              && pm.FromCommunityId == family.CommunityId &&
                                              (pm.Status == (int)MigrationRequestStatusEnum.Reject || (!pm.ToParishId.HasValue))));

                                if (parishionerRequest == null)
                                {
                                    continue;
                                }

                                _db.ParishionerMigrationRequests.DeleteOnSubmit(parishionerRequest);
                            }

                            family.DomicilePlace = "";
                            family.DomicileStatus = (int)DomicileStatusEnum.InParish;
                            _db.FamilyMigrationRequests.DeleteOnSubmit(request);
                        }

                    }

                }

                //Neu la xoa thi cho tat ca thanh vien trong gia dinh la sub het
                if (status == (int)FamilyStatusEnum.Deleted)
                {
                    //Lay ra nhung thanh vien la main va ko bi xoa
                    var members = family.FamilyMembers.Where(fm => (fm.Status == (int)FamilyMemberStatusEnum.Main
                                                                    && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted));

                    var request =
                                family.FamilyMigrationRequests.SingleOrDefault(
                                    pmr => (pmr.FromCommunityId == family.CommunityId &&
                                        pmr.Status == (int)MigrationRequestStatusEnum.Waiting));
                    if (request != null)
                    {
                        _db.FamilyMigrationRequests.DeleteOnSubmit(request);
                    }

                    foreach (var member in members)
                    {
                        member.Status = (int)FamilyMemberStatusEnum.Sub;
                    }

                }

                family.Status = status;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int AddFamily(Family family)
        {
            try
            {
                _db.Families.InsertOnSubmit(family);
                _db.SubmitChanges();
                return family.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateFamily(Family family)
        {
            try
            {
                var item = _db.Families.SingleOrDefault(f => f.Id == family.Id);

                if (item == null)
                {
                    return 0;
                }

                //Lay ra nhung thanh vien trong gia dinh va chuyen luon ho cua nhung thanh vien nay cho giong gia dinh
                var members = _db.FamilyMembers.Where(fm => (fm.FamilyId == family.Id && fm.Status == (int)FamilyMemberStatusEnum.Main
                                                        && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted));

                foreach (var member in members)
                {
                    var mem = member.Parishioner;

                    mem.CommunityId = family.CommunityId;

                    if (!string.IsNullOrEmpty(family.Phone))
                    {
                        mem.Phone = family.Phone;
                    }

                    if (!string.IsNullOrEmpty(family.Address))
                    {
                        mem.Address = family.Address;
                    }
                }

                item.Name = family.Name;
                item.CommunityId = family.CommunityId;
                item.Address = family.Address;
                item.Note = family.Note;
                item.Phone = family.Phone;
                item.IsCounted = family.IsCounted;
                item.DomicileStatus = family.DomicileStatus;
                item.DomicilePlace = family.DomicilePlace;

                //Status ??
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public Family GetFamilyById(int familyId)
        {
            try
            {
                return _db.Families.SingleOrDefault(f => f.Id == familyId);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public IEnumerable<FamilyMember> GetFamilyMembersByFamilyId(int familyId)
        {
            try
            {
                return _db.FamilyMembers.Where(fm => (fm.FamilyId == familyId && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted));
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public int AddFamilyMember(int familyId, int parishionerId)
        {
            try
            {
                var member = new FamilyMember();
                //Coi coi co chua thi update lai status thoi
                var familyMember =
                    _db.FamilyMembers.SingleOrDefault(
                        fm => (fm.ParishionerId == parishionerId && fm.FamilyId == familyId));

                if (familyMember != null)
                {
                    //Neu la main thi thoi khoi
                    if (familyMember.Status == (int)FamilyMemberStatusEnum.Main)
                    {
                        return familyMember.Id;
                    }

                    familyMember.Status = (int)FamilyMemberStatusEnum.Main;
                }
                else
                {
                    //Check so luong thanh vien
                    int members = _db.FamilyMembers.Count(fm => (fm.FamilyId == familyId && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted));


                    if (members == 0)
                    {
                        member = new FamilyMember()
                        {
                            FamilyId = familyId,
                            ParishionerId = parishionerId,
                            Position = (int)FamilyEnum.Chuho,
                            IsHouseholder = true,
                            Status = (int)FamilyMemberStatusEnum.Main
                        };
                    }
                    else
                    {
                        //Add vao family member
                        member = new FamilyMember()
                        {
                            FamilyId = familyId,
                            ParishionerId = parishionerId,
                            Position = (int)FamilyEnum.Con,
                            IsHouseholder = false,
                            Status = (int)FamilyMemberStatusEnum.Main
                        };
                    }

                    _db.FamilyMembers.InsertOnSubmit(member);
                }

                //Kiem tra gia dinh hien tai va chuyen thanh sub
                var current =
                    _db.FamilyMembers.SingleOrDefault(
                        fm => fm.ParishionerId == parishionerId && fm.Status == (int)FamilyMemberStatusEnum.Main);

                if (current != null)
                {
                    current.Status = (int)FamilyMemberStatusEnum.Sub;
                }

                //Thay doi lai giao ho cho giao dan do giong nhu giao ho cua gia dinh (nen suy nghi)
                var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == parishionerId);
                var family = _db.Families.SingleOrDefault(f => f.Id == familyId);

                if (parishioner == null || family == null)
                {
                    return 0;
                }


                //Lay ra giao ho default cua giao xu hien tai
                var defaultCommunity =
                    _db.Communities.FirstOrDefault(c => (c.ParishId == family.Community.ParishId && c.IsDefault));

                if (defaultCommunity == null)
                {
                    return 0;
                }

                if ((parishioner.CommunityId == defaultCommunity.Id) && (family.CommunityId != defaultCommunity.Id))
                {
                    parishioner.IsCounted = true;
                }

                int oldValue = parishioner.CommunityId;

                parishioner.CommunityId = family.CommunityId;

                //Trang thai la chuyen den xu khac
                if (parishioner.DomicileStatus == (int) DomicileStatusEnum.TransferredToAnotherParish)
                {
                    var request =
                        _db.ParishionerMigrationRequests.FirstOrDefault(pmr => (pmr.FromCommunityId == oldValue &&
                                                                                pmr.ParishionerId == parishioner.Id));
                    if (request != null)
                    {
                        request.FromCommunityId = family.CommunityId;
                        
                    }
                    member.Status = (int)FamilyMemberStatusEnum.Sub;
                }

                //Neu qua doi thi thanh sub
                if (parishioner.IsDead)
                {
                    member.Status = (int) FamilyMemberStatusEnum.Sub;
                }

                //Cap nhat them dia chi va so dien thoai
                if (!string.IsNullOrEmpty(family.Phone))
                {
                    parishioner.Phone = family.Phone;
                }

                if (!string.IsNullOrEmpty(family.Address))
                {
                    parishioner.Address = family.Address;
                }

                _db.SubmitChanges();
                if (familyMember != null)
                {
                    return familyMember.Id;
                }
                else
                {
                    return member.Id;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public Parishioner SuggestMorMember(int memberId, int parishId)
        {
            var member = _db.FamilyMembers.FirstOrDefault(fm => fm.Id == memberId);

            if (member == null)
            {
                return null;
            }

            var parishioner = member.Parishioner;

            Parishioner target = null;

            //Lay ra hon phoi
            if (parishioner.Gender == 1)
            {
                var matrimony =
                    _db.Matrimonies.FirstOrDefault(
                        m =>
                            (m.HusbandId == parishioner.Id && (!m.Parishioner1.IsDead) &&
                             (m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted) &&
                             (m.Status != (int)MatrimonyStatusEnum.Removed)));

                if (matrimony != null)
                {
                    target = matrimony.Parishioner1;
                }
            }
            else
            {
                var matrimony =
                    _db.Matrimonies.FirstOrDefault(
                        m =>
                            (m.WifeId == parishioner.Id && (!m.Parishioner.IsDead) &&
                             (m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted) &&
                             (m.Status != (int)MatrimonyStatusEnum.Removed)));

                if (matrimony != null)
                {
                    target = matrimony.Parishioner;
                }
            }

            if (target == null)
            {
                return null;
            }

            //Kiem tra xem co trong xu khong và coi coi cho chuyen xu chua
            if (target.Community.ParishId != parishId || target.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish)
            {
                return null;
            }

            //Kiem tra chu ho
            var isHouseHolder =
                _db.FamilyMembers.Any(
                    fm => (fm.ParishionerId == target.Id && fm.Status == (int)FamilyMemberStatusEnum.Main
                           && fm.Position == (int)FamilyEnum.Chuho));

            if (isHouseHolder)
            {
                return null;
            }

            //Kiem tra xem coi nguoi nay co thuoc gia dinh nay chua
            var alreadyStayed =
                target.FamilyMembers.Any(
                    fm => (fm.FamilyId == member.FamilyId && fm.Status == (int)FamilyMemberStatusEnum.Main));

            if (alreadyStayed)
            {
                return null;
            }

            return target;
        }

        public int DeleteFamilyMember(int id)
        {
            try
            {
                var member = _db.FamilyMembers.SingleOrDefault(fm => fm.Id == id);

                if (member == null)
                {
                    return 0;
                }

                //Kiem tra coi giao dan nay co phai la chu ho hay khong
                if (member.IsHouseholder)
                {
                    return -2;
                }

                _db.FamilyMembers.DeleteOnSubmit(member);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Code lay duoc cua nhung nguoi da bi xoa
        public string LoadFamilyCode(int parishId, string prefix, int characterNumber)
        {
            try
            {
                const string query = "SELECT MAX(Code) " +
                                      "FROM Family AS F LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON F.CommunityId = C.Id " +
                                      "WHERE P.Id = {0} AND F.Code LIKE {1} AND F.Status != {2}";

                string underline = "";

                for (int i = 0; i < characterNumber; i++)
                {
                    underline += "_";
                }

                string suffixParam = prefix + underline;

                string code = _db.ExecuteQuery<string>(query, parishId, suffixParam, (int)FamilyStatusEnum.Deleted).SingleOrDefault();

                var converter = new CodeConverter();
                string s = code;
                int result = 0;
                int count = 0;

                while (true)
                {
                    result = 0;
                    s = converter.GenerateCode(s, prefix, characterNumber);
                    result = CheckFamilyCode(s, parishId);
                    //Neu ko trung
                    if (result == 1)
                    {
                        break;
                    }
                    //Neu bi exception thi dem 3 lan roi cho out
                    if (result == -1)
                    {
                        count++;
                        if (count > 3)
                        {
                            return "";
                        }
                    }

                }
                return s;
            }
            catch (Exception e)
            {
                return "";
            }
        }

        //Check code
        public int CheckFamilyCode(string code, int parishId)
        {
            try
            {
                const string query = "SELECT Pa.Code " +
                                     "FROM Family AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) " +
                                     "ON Pa.CommunityId = C.Id " +
                                     "WHERE P.Id = {0} AND Pa.Code = {1} AND Pa.Status != {2}";
                string result = _db.ExecuteQuery<string>(query, parishId, code, (int)FamilyStatusEnum.Deleted).SingleOrDefault();

                if (string.IsNullOrEmpty(result))
                {
                    return 1;
                }

                return 0;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Quan tam here
        public int ChangeFamilyPosition(int memberId, int familyId, int position)
        {
            try
            {
                var member =
                        _db.FamilyMembers.SingleOrDefault(fm => fm.Id == memberId);

                if (member == null)
                {
                    return 0;
                }

                if (position == (int)FamilyEnum.Chuho)
                {
                    //Kiem tra coi nguoi do phai sub khong ?
                    if (member.Status == (int)FamilyMemberStatusEnum.Sub)
                    {
                        return -2;
                    }

                    //Kiem tra them chu ho cu va vk ck lien quan
                    //Lay chu ho cu ra truoc
                    var oldHouseholder =
                        _db.FamilyMembers.SingleOrDefault(fm => (fm.FamilyId == familyId && fm.IsHouseholder));

                    if (oldHouseholder == null)
                    {
                        return 0;
                    }

                    int memberGender = member.Parishioner.Gender;
                    int houseHolderGender = oldHouseholder.Parishioner.Gender;

                    //Neu 2 chu ho cung gioi tinh thi nguoi vk ck lien quan co the khong sao
                    if (memberGender != houseHolderGender)
                    {
                        FamilyMember matrimonyMember;
                        //Tim nguoi vk hoac ck
                        if (houseHolderGender == 0)
                        { //Neu la nu thi kiem ck
                            matrimonyMember =
                                _db.FamilyMembers.SingleOrDefault(
                                    fm => (fm.FamilyId == familyId && fm.Position == (int)FamilyEnum.Chong));
                        }
                        else
                        {
                            matrimonyMember =
                                 _db.FamilyMembers.SingleOrDefault(
                                     fm => (fm.FamilyId == familyId && fm.Position == (int)FamilyEnum.Vo));
                        }
                        // Neu nguoi nay ton tai thi cap nhat nguoi nay thanh chua xac dinh
                        if (matrimonyMember != null)
                        {
                            matrimonyMember.Position = (int)FamilyEnum.Undefined;
                        }

                    }

                    //Cap nhat cho chu ho moi vao cu
                    member.Position = (int)FamilyEnum.Chuho;
                    member.IsHouseholder = true;

                    oldHouseholder.Position = (int)FamilyEnum.Undefined;
                    oldHouseholder.IsHouseholder = false;
                }
                else if (position == (int)FamilyEnum.Vo)
                {
                    //Kiem tra coi chu ho la ai
                    var wife = _db.FamilyMembers.FirstOrDefault(fm => (fm.FamilyId == familyId && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted &&
                                                              fm.Status == (int)FamilyMemberStatusEnum.Main
                                                              && fm.Position == (int)FamilyEnum.Vo));

                    if (wife != null)
                    {
                        if (wife.ParishionerId != member.ParishionerId)
                        {
                            return -4;
                        }
                    }

                    member.Position = position;
                }
                else if (position == (int)FamilyEnum.Chong)
                {
                    //Kiem tra coi chu ho la ai
                    var husband = _db.FamilyMembers.FirstOrDefault(fm => (fm.FamilyId == familyId && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted &&
                                                              fm.Status == (int)FamilyMemberStatusEnum.Main
                                                              && fm.Position == (int)FamilyEnum.Chong));

                    if (husband != null)
                    {
                        if (husband.ParishionerId != member.ParishionerId)
                        {
                            return -5;
                        }
                    }

                    member.Position = position;
                }
                else
                {
                    //Kiem tra coi nguoi do co gioi tinh la gi ?
                    int memberGender = member.Parishioner.Gender;

                    if (memberGender == 0)
                    {
                        if (position == (int)FamilyEnum.Chong || position == (int)FamilyEnum.Cha ||
                            position == (int)FamilyEnum.Ong ||
                            position == (int)FamilyEnum.Anh || position == (int)FamilyEnum.Re ||
                            position == (int)FamilyEnum.Chu ||
                            position == (int)FamilyEnum.Chu || position == (int)FamilyEnum.Cau ||
                            position == (int)FamilyEnum.Duong)
                        {
                            return -3;
                        }

                    }
                    else
                    {
                        if (position == (int)FamilyEnum.Vo || position == (int)FamilyEnum.Me ||
                            position == (int)FamilyEnum.Ba ||
                            position == (int)FamilyEnum.Chi || position == (int)FamilyEnum.Dau ||
                            position == (int)FamilyEnum.Co ||
                            position == (int)FamilyEnum.Di || position == (int)FamilyEnum.Mo ||
                            position == (int)FamilyEnum.Thim)
                        {
                            return -3;
                        }
                    }

                    //Lam binh thuong
                    member.Position = position;
                }

                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }

        }


        // Search Family By Parishioner ---------------------------------------------------------------------------------
        public IEnumerable<Family> SearchFamiliesByParishDivisionId(int parishDivisionId, bool? isCounted, int status,
          string code, string parishionerName, string fatherName, string motherName)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN Parishioner AS Pa ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE Pa.CommunityId = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query +=
                        " AND Pa.Code LIKE {4} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {5} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {6}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {7}) ";

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";
                    return _db.ExecuteQuery<Family>(query, parishDivisionId, isCounted, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
            else
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN Parishioner AS Pa ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE Pa.CommunityId = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";
                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {1} ";
                    query +=
                        " AND Pa.Code LIKE {2} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {3} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {4}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {5}) ";

                    return _db.ExecuteQuery<Family>(query, parishDivisionId, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
        }

        public IEnumerable<Family> SearchFamiliesByCommunityId(int communityId, bool? isCounted, int status,
            string code, string parishionerName, string fatherName, string motherName)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN Community AS C ON " +
                               "Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE (Pa.CommunityId = {0} OR C.ParentId = {0}) AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query +=
                        " AND Pa.Code LIKE {4} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {5} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {6}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {7}) ";

                    return _db.ExecuteQuery<Family>(query, communityId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";
                    return _db.ExecuteQuery<Family>(query, communityId, isCounted, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
            else
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN Community AS C ON " +
                               "Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE (Pa.CommunityId = {0} OR C.ParentId = {0}) ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";
                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";

                    return _db.ExecuteQuery<Family>(query, communityId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {1} ";
                    query +=
                        " AND Pa.Code LIKE {2} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {3} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {4}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {5}) ";

                    return _db.ExecuteQuery<Family>(query, communityId, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
        }

        public IEnumerable<Family> SearchFamiliesByParishId(int parishId, bool? isCounted, int status,
            string code, string parishionerName, string fatherName, string motherName)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN Community AS C ON " +
                               "Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE C.ParishId = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query +=
                        " AND Pa.Code LIKE {4} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {5} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {6}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {7}) ";

                    return _db.ExecuteQuery<Family>(query, parishId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";
                    return _db.ExecuteQuery<Family>(query, parishId, isCounted, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
            else
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN Community AS C ON " +
                               "Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE C.ParishId = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";
                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";

                    return _db.ExecuteQuery<Family>(query, parishId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {1} ";
                    query +=
                        " AND Pa.Code LIKE {2} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {3} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {4}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {5}) ";

                    return _db.ExecuteQuery<Family>(query, parishId, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
        }

        public IEnumerable<Family> SearchFamiliesByVicariateId(int vicariateId, bool? isCounted, int status,
            string code, string parishionerName, string fatherName, string motherName)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                               "Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE P.VicariateId = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query +=
                        " AND Pa.Code LIKE {4} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {5} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {6}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {7}) ";

                    return _db.ExecuteQuery<Family>(query, vicariateId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";
                    return _db.ExecuteQuery<Family>(query, vicariateId, isCounted, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
            else
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                               "Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE P.VicariateId = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";
                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";

                    return _db.ExecuteQuery<Family>(query, vicariateId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {1} ";
                    query +=
                        " AND Pa.Code LIKE {2} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {3} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {4}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {5}) ";

                    return _db.ExecuteQuery<Family>(query, vicariateId, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
        }

        public IEnumerable<Family> SearchFamiliesByDioceseId(int dioceseId, bool? isCounted, int status,
            string code, string parishionerName, string fatherName, string motherName)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                               "(Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id ) " +
                               "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE V.DioceseId = {0} AND F.IsCounted = {1} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {2} OR F.Status = {3}) ";

                    query +=
                        " AND Pa.Code LIKE {4} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {5} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {6}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {7}) ";

                    return _db.ExecuteQuery<Family>(query, dioceseId, isCounted,
                        (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {2} ";

                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";
                    return _db.ExecuteQuery<Family>(query, dioceseId, isCounted, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
            else
            {
                string query = "SELECT DISTINCT F.* " +
                               "FROM Family AS F LEFT JOIN (FamilyMember AS FM INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                               "(Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id ) " +
                               "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id) ON FM.ParishionerId = Pa.Id) " +
                               "ON F.Id = FM.FamilyId " +
                               "WHERE V.DioceseId = {0} ";

                if (status == (int)FamilyStatusEnum.AvailableAndSaved)
                {
                    query += "AND (F.Status = {1} OR F.Status = {2}) ";
                    query +=
                        " AND Pa.Code LIKE {3} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {4} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {5}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {6}) ";

                    return _db.ExecuteQuery<Family>(query, dioceseId, (int)FamilyStatusEnum.Available, (int)FamilyStatusEnum.Saved, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }
                else
                {
                    query += "AND F.Status = {1} ";
                    query +=
                        " AND Pa.Code LIKE {2} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {3} AND (Pa.FatherName IS NULL OR Pa.FatherName LIKE {4}) " +
                        " AND (Pa.MotherName IS NULL OR Pa.MotherName LIKE {5}) ";

                    return _db.ExecuteQuery<Family>(query, dioceseId, status, "%" + code + "%", "%" +
                        parishionerName + "%", "%" + fatherName + "%", "%" + motherName + "%");
                }

            }
        }


    }
}
