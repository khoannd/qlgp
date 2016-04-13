using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class ParishData
    {
        private readonly PMSDataContext _db;

        public ParishData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Parish> GetParishesByDioceseId(int dioceseId)
        {
            const string query = "SELECT P.* FROM Parish AS P " +
                                 "LEFT JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id " +                               
                                 "WHERE D.Id = {0}";
            return _db.ExecuteQuery<Parish>(query, dioceseId);

        }

        public IEnumerable<Parish> GetParishesByDioceseIdNotMine(int dioceseId, int parishId)
        {
            const string query = "SELECT P.* FROM Parish AS P " +
                                 "LEFT JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND P.Id != {1} ";
            return _db.ExecuteQuery<Parish>(query, dioceseId, parishId);
        } 

        public IEnumerable<Parish> GetParishesByVicariateId(int vicariateId)
        {
            const string query = "SELECT * FROM Parish " +
                                 "WHERE VicariateId = {0}";
            return _db.ExecuteQuery<Parish>(query, vicariateId);
        }

        public IEnumerable<Parish> GetParishesByVicariateIdNotMine(int vicariateId, int parishId)
        {
            const string query = "SELECT * FROM Parish " +
                                 "WHERE VicariateId = {0} AND Id != {1} ";
            return _db.ExecuteQuery<Parish>(query, vicariateId, parishId);
        } 

        public Parish GetParishesByParishId(int id)
        {
            const string query = "SELECT * FROM Parish  WHERE Id = {0}";
            return _db.ExecuteQuery<Parish>(query, id).SingleOrDefault();
        }

        public IEnumerable<Parish> GetAllParish()
        {
            string query = "SELECT * FROM Parish ORDER BY Name";
            return _db.ExecuteQuery<Parish>(query, 0);
        }

        public string GetImageUrlByParishId(int parishId)
        {
            const string query = "SELECT ImageUrl FROM Parish WHERE Id = {0}";
            return _db.ExecuteQuery<string>(query, parishId).SingleOrDefault();
        }

        public int AddParish(Parish parish)
        {
            try
            {
                _db.Parishes.InsertOnSubmit(parish);
                _db.SubmitChanges();
                return parish.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int UpdateParish(Parish parish)
        {
            try
            {
                var item = _db.Parishes.SingleOrDefault(d => d.Id == parish.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = parish.Name;
                item.Address = parish.Address;
                item.Ward = parish.Ward;
                item.District = parish.District;
                item.Province = parish.Province;
                item.Priest = parish.Priest;
                item.PriestId = parish.PriestId;
                item.Website = parish.Website;
                item.Phone = parish.Phone;
                item.Email = parish.Email;
                item.VicariateId = parish.VicariateId;
                if (!string.IsNullOrEmpty(parish.ImageUrl))
                {
                    item.ImageUrl = parish.ImageUrl;
                }
                
                _db.SubmitChanges();
                return parish.Id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int UpdateParishManager(Parish parish)
        {
            try
            {
                var item = _db.Parishes.SingleOrDefault(d => d.Id == parish.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = parish.Name;
                item.Address = parish.Address;
                item.Ward = parish.Ward;
                item.District = parish.District;
                item.Province = parish.Province;
                item.Priest = parish.Priest;                
                item.Website = parish.Website;
                item.Phone = parish.Phone;
                item.Email = parish.Email;
                if (!string.IsNullOrEmpty(parish.ImageUrl))
                {
                    item.ImageUrl = parish.ImageUrl;
                }
               
                _db.SubmitChanges();
                return parish.Id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int DeleteParish(int id)
        {
            try
            {
                Parish parish = _db.Parishes.SingleOrDefault(p => p.Id == id);
                
                if (parish == null)
                {
                    return 0;
                }
                Configuration configuration = _db.Configurations.SingleOrDefault(c => c.ParishId == id);
                Community community = _db.Communities.SingleOrDefault(co => co.ParishId == id && co.IsDefault);

                
                if (configuration == null)
                {
                    return 0;
                }
                if (community == null)
                {
                    return 0;
                }
                _db.Configurations.DeleteOnSubmit(configuration);
                _db.Communities.DeleteOnSubmit(community);

                _db.Parishes.DeleteOnSubmit(parish);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int CheckUniqueParish(string name, int parishId, int dioceseId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT P.Name " +
                                     "FROM Parish AS P LEFT JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id " +
                                     "WHERE LOWER(RTRIM(LTRIM((P.Name)))) = {0} AND P.Id != {1} AND D.Id = {2}";
                string unique = _db.ExecuteQuery<string>(query, name, parishId, dioceseId).SingleOrDefault();
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

        public IEnumerable<string> GetParishNamesByName(string name, int parishId)
        {
            if (string.IsNullOrEmpty(name))
            {
                const string query1 = "SELECT Name FROM Parish " +
                                      "WHERE Id != {0} " +
                                      "ORDER BY Name";
                return _db.ExecuteQuery<string>(query1, parishId);
            }

            name = name.Trim();

            const string query2 = "SELECT Name FROM Parish " +
                                 "WHERE Name LIKE {0} AND Id != {1} " +
                                 "ORDER BY Name";

            return _db.ExecuteQuery<string>(query2, "%" + name + "%", parishId);
        }

        public IEnumerable<Parish> SearchParishByKeyword(string keyword, int start, int length)
        {
            keyword = keyword.Trim().ToLower();
            var query = _db.Parishes.Where(p => p.Name.ToLower().Contains(keyword) || p.Email.ToLower().Contains(keyword) || p.Phone.ToLower().Contains(keyword) || p.Website.ToLower().Contains(keyword)
                || p.Address.ToLower().Contains(keyword) || p.Ward.ToLower().Contains(keyword) || p.District.ToLower().Contains(keyword) || p.Province.ToLower().Contains(keyword)).OrderBy(p => p.Name);

            if (length <= 0)
            {
                return query.ToList();
            }
            else
            {
                return query.Skip(start).Take(length);
            }
                
        }
    }
}
