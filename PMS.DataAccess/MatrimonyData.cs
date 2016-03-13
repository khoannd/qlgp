using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class MatrimonyData
    {
        private readonly PMSDataContext _db;

        public MatrimonyData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public int CountMatrimonyCoupleBySacramentGroupId(int sacramentGroupId)
        {
            const string query = "SELECT Count(SacramentGroupId) FROM Matrimony " +
                                 "WHERE SacramentGroupId = {0}";
            return _db.ExecuteQuery<int>(query, sacramentGroupId).SingleOrDefault();
        }
        public IEnumerable<Matrimony> GetMatrimoniesByParishionerId(int parishionerId)
        {
            const string query = "SELECT M.* " +
                                 "FROM Matrimony AS M " +
                                 "WHERE M.HusbandId = {0} OR M.WifeId = {0}";
            return _db.ExecuteQuery<Matrimony>(query, parishionerId);
        }

        public IEnumerable<Matrimony> GetMatrimoniesByParishDivisionId(int parishDivisionId)
        {
            const string query1 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN Parishioner AS Pa ON M.HusbandId = Pa.Id " +
                                 "WHERE Pa.CommunityId = {0} ";
            const string query2 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN Parishioner AS Pa ON M.HusbandId = Pa.Id " +
                                 "WHERE Pa.CommunityId = {0} ";
            const string query = query1 + " UNION " + query2;
            return _db.ExecuteQuery<Matrimony>(query, parishDivisionId);
        }

        public IEnumerable<Matrimony> GetMatrimoniesByCommunityId(int communityId)
        {
            const string query1 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN Community AS C " +
                                 "ON Pa.CommunityId = C.Id) ON M.HusbandId = Pa.Id " +
                                 "WHERE Pa.CommunityId = {0} OR C.ParentId = {0}";
            const string query2 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN Community AS C " +
                                 "ON Pa.CommunityId = C.Id) ON M.WifeId = Pa.Id " +
                                 "WHERE Pa.CommunityId = {0} OR C.ParentId = {0}";
            const string query = query1 + " UNION " + query2;
            return _db.ExecuteQuery<Matrimony>(query, communityId);
        }
        public IEnumerable<Matrimony> GetMatrimoniesByParishId(int parishId)
        {
            const string query1 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) " +
                                 "ON Pa.CommunityId = C.Id) ON M.HusbandId = Pa.Id " +
                                 "WHERE P.Id = {0} ";
            const string query2 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) " +
                                 "ON Pa.CommunityId = C.Id) ON M.WifeId = Pa.Id " +
                                 "WHERE P.Id = {0} ";
            const string query = query1 + " UNION " + query2;
            return _db.ExecuteQuery<Matrimony>(query, parishId);
        }
        public IEnumerable<Matrimony> GetMatrimoniesByVicariateId(int vicariateId)
        {
            const string query1 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                                 "(Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id ) ON C.ParishId = P.Id) " +
                                 "ON Pa.CommunityId = C.Id) ON M.HusbandId = Pa.Id " +
                                 "WHERE V.Id = {0} ";
            const string query2 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                                 "(Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id ) ON C.ParishId = P.Id) " +
                                 "ON Pa.CommunityId = C.Id) ON M.WifeId = Pa.Id " +
                                 "WHERE V.Id = {0} ";
            const string query = query1 + " UNION " + query2;
            return _db.ExecuteQuery<Matrimony>(query, vicariateId);
        }

        public IEnumerable<Matrimony> GetMatrimoniesByDioceseId(int dioceseId)
        {
            const string query1 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                                 "(Parish AS P INNER JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id ) " +
                                 "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id) ON M.HusbandId = Pa.Id " +
                                 "WHERE D.Id = {0} ";
            const string query2 = "SELECT M.* " +
                                 "FROM Matrimony AS M INNER JOIN (Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN " +
                                 "(Parish AS P INNER JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id ) " +
                                 "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id) ON M.WifeId = Pa.Id " +
                                 "WHERE D.Id = {0} ";
            const string query = query1 + " UNION " + query2;
            return _db.ExecuteQuery<Matrimony>(query, dioceseId);
        }
        public int AddMatrimony(Matrimony matrimony, string username)
        {
            try
            {
                _db.Matrimonies.InsertOnSubmit(matrimony);

                var husband = _db.Parishioners.SingleOrDefault(p => p.Id == matrimony.HusbandId);
                if (husband == null)
                {
                    return 0;
                }
                var wife = _db.Parishioners.SingleOrDefault(p => p.Id == matrimony.WifeId);
                if (wife == null)
                {
                    return 0;
                }

                //Cap nhat trang thai hon phoi
                husband.LastUpdatedBy = username;
                wife.LastUpdatedBy = username;
                husband.IsMarried = true;
                wife.IsMarried = true;

                //Cu them hon phoi la ko duoc don than
                husband.IsSingle = false;
                wife.IsSingle = false;

                //Xet da hoi tuc cho thong tin on goi
                var husVocation = _db.Vocations.SingleOrDefault(v => v.ParishionerId == husband.Id);
                if (husVocation != null)
                {
                    husVocation.IsLeft = true;
                }
                var wifVocation = _db.Vocations.SingleOrDefault(v => v.ParishionerId == wife.Id);
                if (wifVocation != null)
                {
                    wifVocation.IsLeft = true;
                }

                //Neu gui cho nguoi ngoai xu thi tao message can them parishId va accountId (neu co)


                //-------------

                _db.SubmitChanges();
                return matrimony.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateMatrimony(Matrimony matrimony, string username)
        {
            try
            {

                var item = _db.Matrimonies.SingleOrDefault(m => m.Id == matrimony.Id);

                if (item == null)
                {
                    return 0;
                }

                var husband = _db.Parishioners.SingleOrDefault(p => p.Id == matrimony.HusbandId);

                if (husband == null)
                {
                    return 0;
                }
                var wife = _db.Parishioners.SingleOrDefault(p => p.Id == matrimony.WifeId);

                if (wife == null)
                {
                    return 0;
                }


                if (matrimony.Status != (int) MatrimonyStatusEnum.Removed)
                {
                    //Neu nguoi vo hoac nguoi chong chet thi khong sao
                    if (!(husband.IsDead || wife.IsDead))
                    {
                        //Neu trang thai cu khac Removed thi thoi ke no
                        if (item.Status == (int) MatrimonyStatusEnum.Removed)
                        {
                            //Kiem tra coi thang cu la gi
                            var matri =
                                _db.Matrimonies.FirstOrDefault(m => (m.HusbandId == husband.Id && (!m.Parishioner1.IsDead) &&
                                         (m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted) &&
                                         (m.Status != (int)MatrimonyStatusEnum.Removed)));

                            var matri2 =
                                _db.Matrimonies.FirstOrDefault(m => (m.WifeId == wife.Id && (!m.Parishioner.IsDead) &&
                                         (m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted) &&
                                         (m.Status != (int)MatrimonyStatusEnum.Removed)));

                            if (matri != null || matri2 != null)
                            {
                                return -4;
                            }

                        }
                       
                    }

                }
                
                //Neu thong tin nguoi chong duoc thay doi thanh nguoi moi thi nguoi cu phai thay doi lai
                if (item.HusbandId != matrimony.HusbandId)
                {
                    var oldHusband = _db.Parishioners.SingleOrDefault(p => p.Id == item.HusbandId);

                    if (oldHusband == null)
                    {
                        return 0;
                    }

                    var husbandMatrimonies = _db.Matrimonies.Where(m => m.HusbandId == oldHusband.Id).ToList();

                    if (husbandMatrimonies.Count == 1)
                    {
                        oldHusband.IsMarried = false;
                        oldHusband.IsSingle = true;
                    }

                    oldHusband.LastUpdatedBy = username;

                }

                if (item.WifeId != matrimony.WifeId)
                {
                    var oldWife = _db.Parishioners.SingleOrDefault(p => p.Id == item.WifeId);

                    if (oldWife == null)
                    {
                        return 0;
                    }

                    var wifeMatrimonies = _db.Matrimonies.Where(m => m.WifeId == oldWife.Id).ToList();

                    if (wifeMatrimonies.Count == 1)
                    {
                        oldWife.IsMarried = false;
                        oldWife.IsSingle = true;
                    }

                    oldWife.LastUpdatedBy = username;
                }

                //Xet da hoi tuc cho thong tin on goi
                var husVocation = _db.Vocations.SingleOrDefault(v => v.ParishionerId == husband.Id);
                if (husVocation != null)
                {
                    husVocation.IsLeft = true;
                }
                var wifVocation = _db.Vocations.SingleOrDefault(v => v.ParishionerId == wife.Id);
                if (wifVocation != null)
                {
                    wifVocation.IsLeft = true;
                }
                //-------------

                husband.LastUpdatedBy = username;
                wife.LastUpdatedBy = username;

                item.HusbandId = matrimony.HusbandId;
                item.WifeId = matrimony.WifeId;
                item.Name = matrimony.Name;
                item.Number = matrimony.Number;
                item.Date = matrimony.Date;
                item.Place = matrimony.Place;
                item.Priest = matrimony.Priest;
                item.FirstWitness = matrimony.FirstWitness;
                item.SecondWitness = matrimony.SecondWitness;
                item.Status = matrimony.Status;
                item.Note = matrimony.Note;

                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteMatrimony(int id, string username)
        {
            try
            {
                var item = _db.Matrimonies.SingleOrDefault(m => m.Id == id);

                if (item == null)
                {
                    return 0;
                }

                var husband = _db.Parishioners.SingleOrDefault(p => p.Id == item.HusbandId);
                if (husband == null)
                {
                    return 0;
                }
                var wife = _db.Parishioners.SingleOrDefault(p => p.Id == item.WifeId);
                if (wife == null)
                {
                    return 0;
                }

                //Check matrimony
                var husbandMatrimonies = _db.Matrimonies.Where(m => m.HusbandId == husband.Id).ToList();
                var wifeMatrimonies = _db.Matrimonies.Where(m => m.WifeId == wife.Id).ToList();

                husband.LastUpdatedBy = username;
                wife.LastUpdatedBy = username;

                if (husbandMatrimonies.Count == 1)
                {
                    husband.IsMarried = false;
                    husband.IsSingle = true;
                }

                if (wifeMatrimonies.Count == 1)
                {
                    wife.IsMarried = false;
                    wife.IsSingle = true;
                }

                _db.Matrimonies.DeleteOnSubmit(item);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public Matrimony GetMatrimonyById(int id)
        {
            try
            {
                return _db.Matrimonies.SingleOrDefault(m => m.Id == id);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public IEnumerable<Matrimony> GetMatrimonyBySacramentGroupId(int sacramentGroupId)
        {
            const string query = "SELECT M.* FROM Matrimony AS M " +
                                 "WHERE M.SacramentGroupId = {0}";
            return _db.ExecuteQuery<Matrimony>(query, sacramentGroupId);
        }

        public int CheckExistedMatrimony(int parishionerId1, int parishionerId2)
        {
            try
            {
                const string query = "SELECT M.* " +
                                     "FROM Matrimony AS M " +
                                     "WHERE (M.HusbandId = {0} AND M.WifeId = {1}) OR (M.HusbandId = {1} AND M.WifeId = {0})";

                bool hasMatrimony = _db.ExecuteQuery<Matrimony>(query, parishionerId1, parishionerId2).Any();

                if (hasMatrimony)
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

        public int UpdateEditableNumber(Matrimony matrimony)
        {
            try
            {
                var item = _db.Matrimonies.SingleOrDefault(d => d.Id == matrimony.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Number = matrimony.Number;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int UpdateEditableFirstWitness(Matrimony matrimony)
        {
            try
            {
                var item = _db.Matrimonies.SingleOrDefault(d => d.Id == matrimony.Id);
                if (item == null)
                {
                    return 0;
                }
                item.FirstWitness = matrimony.FirstWitness;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int UpdateEditableSecondWitness(Matrimony matrimony)
        {
            try
            {
                var item = _db.Matrimonies.SingleOrDefault(d => d.Id == matrimony.Id);
                if (item == null)
                {
                    return 0;
                }
                item.SecondWitness = matrimony.SecondWitness;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int AddSacramentGroupIdForMatrimony(int id, int sacramentGroupId)
        {
            try
            {
                var item = _db.Matrimonies.SingleOrDefault(d => d.Id == id);
                if (item == null)
                {
                    return 0;
                }
                item.SacramentGroupId = sacramentGroupId;
                _db.SubmitChanges();
                return item.Id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int RemoveMatrimonyFromSacramentGroup(int id)
        {
            try
            {
                Matrimony matrimony = _db.Matrimonies.SingleOrDefault(m => m.Id == id);

                if (matrimony == null)
                {
                    return 0;
                }
                matrimony.SacramentGroupId = null;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }    
    }
}
