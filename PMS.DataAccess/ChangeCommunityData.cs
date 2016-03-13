using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class ChangeCommunityData
    {
        private readonly PMSDataContext _db;

        public ChangeCommunityData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Community> GetCommunitiesByParishId(int parishId)
        {
            const string query = "SELECT * FROM Community WHERE ParishId = {0} AND ParentId IS NULL";
            return _db.ExecuteQuery<Community>(query, parishId);
        }
        public IEnumerable<Community> GetParishDivisionsByParishId(int parishId)
        {
            const string query = "SELECT * FROM Community WHERE ParishId = {0} AND ParentId IS NOT NULL";
            return _db.ExecuteQuery<Community>(query, parishId);
        }
        public IEnumerable<Parishioner> GetParishionersByCommunityId(int communityId, bool? isCounted)
        {
            const string query = "SELECT pa.* FROM Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id " +
                                 "WHERE (CommunityId = {0} OR ParentId = {1}) AND IsCounted = {2} AND pa.Status = {3} ";
            return _db.ExecuteQuery<Parishioner>(query, communityId, communityId, isCounted, (int)ParishionerStatusEnum.Available);
        }
        public IEnumerable<Parishioner> GetParishionersByParishId(int parishId, bool? isCounted)
        {
            const string query = "SELECT pa.* FROM Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id " +
                                 "WHERE co.ParishId = {0} AND pa.IsCounted = {1} AND pa.Status = {2} ";
            return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, (int)ParishionerStatusEnum.Available);
        }

        public int ChangeParishionersCommunity(string[] parishioners, int communityTargetId)
        {
            try
            {
                foreach (var item in parishioners)
                {
                    int id = Int32.Parse(item);
                    var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == id);
                    if (parishioner == null)
                    {
                        return 0;
                    }
                    else
                    {
                        if (parishioner.CommunityId == communityTargetId)
                        {
                        }
                        else
                        {
                            if (parishioner.CommunityId == communityTargetId)
                            {
                            }
                            else
                            {
                                var familyMemberStatus = parishioner.FamilyMembers.FirstOrDefault(p => p.Status == (int)FamilyMemberStatusEnum.Main);
                                if (familyMemberStatus != null)
                                {
                                    familyMemberStatus.Status = (int) FamilyMemberStatusEnum.Sub;
                                    parishioner.CommunityId = communityTargetId;
                                }
                            }
                        }
                    }
                }
                _db.SubmitChanges();
                return 1;
            }
            catch(Exception e)
            {
                return -1;
            }
        }

        //Phần gia đình
        public IEnumerable<Family> GetFamiliesByCommunityId(int communityId, bool? isCounted)
        {
            const string query = "SELECT fa.* FROM Family AS fa INNER JOIN Community AS co ON fa.CommunityId = co.Id " +
                                 "WHERE (co.Id = {0} OR co.ParentId = {1}) AND fa.IsCounted = {2} AND fa.Status = {3} ";
            return _db.ExecuteQuery<Family>(query, communityId, communityId, isCounted, (int)FamilyStatusEnum.Available);
        }
        public IEnumerable<Family> GetFamiliesByParishId(int parishId, bool? isCounted)
        {
            const string query = "SELECT fa.* FROM Family AS fa INNER JOIN Community AS co ON fa.CommunityId = co.Id " +
                                 "WHERE co.ParishId = {0} AND fa.IsCounted = {1} AND fa.Status = {2} ";
            return _db.ExecuteQuery<Family>(query, parishId, isCounted, (int)FamilyStatusEnum.Available);
        }

        public IEnumerable<FamilyMember> GetHouseHolderNameByFamilyId(int familyId)
        {
            const string query = "SELECT * FROM FamilyMember WHERE FamilyId = {0} AND Position = {1} ";
            return _db.ExecuteQuery<FamilyMember>(query, familyId, (int)FamilyEnum.Chuho);
        }

        public int ChangeFamiliesCommunity(string[] families, int communityTargetId)
        {
            try
            {
                foreach (var item in families)
                {
                    int id = Int32.Parse(item);
                    var family = _db.Families.SingleOrDefault(p => p.Id == id);
                    if (family == null)
                    {
                        return 0;
                    }
                    else
                    {
                        family.CommunityId = communityTargetId;
                        foreach (var fm in family.FamilyMembers.Where(c => c.Status == (int)FamilyMemberStatusEnum.Main))
                        {
                            fm.Parishioner.CommunityId = communityTargetId;
                        }
                    }
                }
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
