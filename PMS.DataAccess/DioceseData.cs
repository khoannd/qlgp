using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

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

        public int AddDiocese(Diocese diocese)
        {
            try
            {
                _db.Dioceses.InsertOnSubmit(diocese);
                _db.SubmitChanges();
                return diocese.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
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
                item.Code = diocese.Code.Trim();
                item.Name = diocese.Name.Trim();
                item.Church = diocese?.Church?.Trim();
                item.Address = diocese?.Address?.Trim();
                item.Bishop = diocese?.Bishop?.Trim();
                item.Website = diocese?.Website?.Trim();
                item.Phone = diocese?.Phone?.Trim();
                item.Email = diocese?.Email?.Trim();
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

        public int CheckUniqueDiocese(string name, string code, int id)
        {
            try
            {
                const string query = "SELECT Name FROM Diocese WHERE ([Name] = {0} OR [Code] = {1}) AND Id != {2}";
                string unique = _db.ExecuteQuery<string>(query, name, code, id).SingleOrDefault();
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
        public int DeleteDiocese(int id)
        {
            try
            {
                Diocese diocese = GetDiocesesByDioceseId(id);
                const string query = "select Id, ( select top 1 Id from Parish where DioceseId = {0}) as HasParish, ( select top 1 Id from Priest where DioceseId = {0}) as HasPriest, ( select top 1 Id from Vicariate where DioceseId = {0}) as HasVicariate from Diocese where Id = {0}; ";
                DioceseDeleteViewModel result = _db.ExecuteQuery<DioceseDeleteViewModel>(query, id, id, id).SingleOrDefault();
                if (result != null)
                {
                    if (result.HasVicariate.HasValue && result.HasVicariate > 0)
                    {
                        return -1;
                    }
                    else if (result.HasPriest.HasValue && result.HasPriest > 0)
                    {
                        return -1;
                    }
                    else if (result.HasParish.HasValue && result.HasParish > 0)
                    {
                        return -1;
                    }
                    // deletable
                    _db.Dioceses.DeleteOnSubmit(diocese);
                    _db.SubmitChanges();
                    return 1;
                }
                else
                {
                    return 0;
                }
                return 1;
            }
            catch (Exception)
            {

                return -1;
            }
        }

    }
}
