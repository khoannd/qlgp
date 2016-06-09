using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class DioceseData
    {
        private readonly PMSDataContext _db;
        public DioceseData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public Diocese GetDiocesesByDioceseId(int dioceseId)
        {
            const string query = "SELECT * FROM Diocese WHERE Id = {0}";
            return _db.ExecuteQuery<Diocese>(query, dioceseId).SingleOrDefault();
        }
        public Diocese GetDefaultDiocese()
        {
            const string query = "SELECT * FROM Diocese WHERE IsDefault = 1";
            return _db.ExecuteQuery<Diocese>(query).SingleOrDefault();
        }
        public List<Diocese> GetAllDioceses()
        {
            const string query = "SELECT * FROM Diocese ";
            return _db.ExecuteQuery<Diocese>(query).ToList();
        }

        public string GetImageUrlByDioceseId(int dioceseId)
        {
            const string query = "SELECT ImageUrl FROM Diocese WHERE Id = {0}";
            return _db.ExecuteQuery<string>(query, dioceseId).SingleOrDefault();
        }

        public int UpdateDiocese(Diocese diocese)
        {
            try
            {
                var item = _db.Dioceses.SingleOrDefault(d => d.Id == diocese.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = diocese.Name;
                item.Church = diocese.Church;
                item.Address = diocese.Address;
                item.Bishop = diocese.Bishop;
                item.Website = diocese.Website;
                item.Phone = diocese.Phone;
                item.Email = diocese.Email;
                if (!string.IsNullOrEmpty(diocese.ImageUrl))
                {
                    item.ImageUrl = diocese.ImageUrl;
                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                
                return -1;
            }
        }

        public int CheckUniqueDiocese(string name, int id)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT Name FROM Diocese WHERE LOWER(RTRIM(LTRIM((Name)))) = {0} AND Id != {1}";
                string unique = _db.ExecuteQuery<string>(query, name, id).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {
                
                return  -1;
            }
        }
    }
}
