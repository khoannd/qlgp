using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class CommunityData
    {
        private PMSDataContext _db;

        public CommunityData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Community> GetCommunitiesByParishId(int parishId)
        {
            const string query = "SELECT * FROM Community WHERE ParishId = {0} AND ParentId IS NULL";
            return _db.ExecuteQuery<Community>(query, parishId);
        }

        public Community GetCommunitiesById(int id)
        {
            const string query = "SELECT * FROM Community WHERE Id = {0}";
            return _db.ExecuteQuery<Community>(query, id).SingleOrDefault();
        }

        public int GetDefaultCommunityIdByParishId(int parishId)
        {
            try
            {
                var item = _db.Communities.SingleOrDefault(c => c.ParishId == parishId && c.IsDefault);

                if (item == null)
                {
                    return -1;
                }
                return item.Id;
            }
            catch (Exception e)
            {
                return -2;
            }
        }

        public IEnumerable<Community> GetParishDivisionsByCommunityId(int communityId)
        {
            const string query = "SELECT * FROM Community WHERE ParentId = {0}";
            return _db.ExecuteQuery<Community>(query, communityId);
        }

        public IEnumerable<Community> GetParishDivisionsByParishId(int parishId)
        {
            const string query = "SELECT * FROM Community WHERE ParishId = {0} AND ParentId IS NOT NULL";
            return _db.ExecuteQuery<Community>(query, parishId);
        }

        public IEnumerable<Community> GetParishDivisionsByVicariateId(int vicariateId)
        {
            const string query = "SELECT C.* " +
                        "FROM Community AS C LEFT JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) ON C.ParishId = P.Id " +
                        "WHERE V.Id = {0} AND C.ParentId IS NOT NULL";
            return _db.ExecuteQuery<Community>(query, vicariateId);
        }

        public IEnumerable<Community> GetParishDivisionsByDioceseId(int dioceseId)
        {
            const string query = "SELECT C.* " +
                               "FROM Community AS C LEFT JOIN (Parish AS P INNER JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) " +
                               "ON P.VicariateId = V.Id) ON C.ParishId = P.Id " +
                               "WHERE D.Id = {0} AND C.ParentId IS NOT NULL";
            return _db.ExecuteQuery<Community>(query, dioceseId);
        }

        public IEnumerable<Community> GetNotDefaultCommunitiesByParishId(int parishId)
        {
            const string query = "SELECT * FROM Community WHERE ParishId = {0} AND IsDefault = {1} AND ParentId IS NULL";
            return _db.ExecuteQuery<Community>(query, parishId, false);
        }

        public IEnumerable<Community> GetNotDefaultCommunitiesByVicariateId(int vicariateId)
        {
            const string query = "SELECT C.* " +
                                 "FROM Community AS C LEFT JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) ON C.ParishId = P.Id " +
                                 "WHERE V.Id = {0} AND C.IsDefault = {1} AND ParentId IS NULL";
            return _db.ExecuteQuery<Community>(query, vicariateId, false);
        }

        public IEnumerable<Community> GetNotDefaultCommunitiesByDioceseId(int dioceseId)
        {
            const string query = "SELECT C.* " +
                                 "FROM Community AS C LEFT JOIN (Parish AS P INNER JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) " +
                                 "ON P.VicariateId = V.Id) ON C.ParishId = P.Id " +
                                 "WHERE D.Id = {0} AND C.IsDefault = {1} AND ParentId IS NULL";
            return _db.ExecuteQuery<Community>(query, dioceseId, false);
        }

        public int AddCommunity(Community community)
        {
            try
            {
                _db.Communities.InsertOnSubmit(community);
                _db.SubmitChanges();
                return community.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateCommunity(Community community)
        {
            try
            {
                var item = _db.Communities.SingleOrDefault(c => c.Id == community.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = community.Name;
                item.ParentId = community.ParentId;

                _db.SubmitChanges();
                return community.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateDivision(Community community)
        {
            try
            {
                var item = _db.Communities.SingleOrDefault(c => c.Id == community.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = community.Name;

                _db.SubmitChanges();
                return community.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }


        public int DeleteCommunity(int id)
        {
            try
            {
                Community community = _db.Communities.SingleOrDefault(c => c.Id == id);

                if (community == null)
                {
                    return 0;
                }

                _db.Communities.DeleteOnSubmit(community);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int CheckUniqueCommunity(string name, int communityId, int parishId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT C.Name " +
                                     "FROM Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                     "WHERE LOWER(RTRIM(LTRIM((C.Name)))) = {0} AND C.Id != {1} AND P.Id = {2}";
                string unique = _db.ExecuteQuery<string>(query, name, communityId, parishId).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
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

        public int CheckUniqueDivision(string name, int communityId, int parentId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT C.Name " +
                                     "FROM Community AS C " +
                                     "WHERE LOWER(RTRIM(LTRIM((C.Name)))) = {0} AND C.Id != {1} AND C.ParentId = {2}";
                string unique = _db.ExecuteQuery<string>(query, name, communityId, parentId).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
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
    }


}
