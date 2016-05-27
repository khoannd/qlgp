using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class VicariateData
    {
        private readonly PMSDataContext _db;

        public VicariateData(String connection)
        {
            _db = new PMSDataContext(connection);   
        }

        //Suggest giáo xứ đại diện cho giáo hạt
        public IEnumerable<Parish> GetParishesForVicariate(int dioceseId, int vicariateId)
        {
            const string query = "SELECT p.* FROM Parish AS p " +
                                 "INNER JOIN Vicariate AS v ON p.VicariateId = v.Id " +
                                 "WHERE v.DioceseId = {0} AND p.VicariateId = {1} " +
                                 "ORDER BY p.Name ";
            return _db.ExecuteQuery<Parish>(query, dioceseId, vicariateId);

        }
        public IEnumerable<Vicariate> GetVicariateByDioceseId(int dioceseId)
        {
            const string query = "SELECT * FROM Vicariate WHERE DioceseId = {0} ";
            return _db.ExecuteQuery<Vicariate>(query, dioceseId);
        }

        public Vicariate GetVicariateByVicariateId(int id)
        {
            const string query = "SELECT * FROM Vicariate WHERE Id = {0}";
            return _db.ExecuteQuery<Vicariate>(query, id).SingleOrDefault();
        }

        //Thêm xóa sửa giáo hạt
        public int AddVicariate(Vicariate vicariate)
        {
            try
            {
                _db.Vicariates.InsertOnSubmit(vicariate);
                _db.SubmitChanges();
                return vicariate.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Update giáo hạt

        //Load giáo xứ = autocomplete
        //public IEnumerable<string> LoadParishByName(string name)
        //{
        //    if (string.IsNullOrEmpty(name))
        //    {
        //        const string query1 = "SELECT Name FROM Parish ORDER BY Name ";
        //        return _db.ExecuteQuery<string>(query1);
        //    }
        //    name = name.Trim();
        //    const  string query2 = "SELECT Name FROM Parish " +
        //                           "WHERE Name LIKE {0} " +
        //                           "ORDER BY Name";

        //    return _db.ExecuteQuery<string>(query2, "%" + name + "%");

        //}
        public int UpdateVicariate(Vicariate vicariate)
        {
            try
            {
                var item = _db.Vicariates.SingleOrDefault(d => d.Id == vicariate.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = vicariate.Name;
                item.ParishId = vicariate.ParishId;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        
        public int DeleteVicariate(int id)
        {
            try
            {
                Vicariate vicariate = _db.Vicariates.SingleOrDefault(p => p.Id == id);

                if (vicariate == null)
                {
                    return 0;
                }

                _db.Vicariates.DeleteOnSubmit(vicariate);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }


        //Validate giáo hạt
        public int CheckUniqueParish(string name, int vicariateId, int dioceseId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT v.Name " +
                                     "FROM Vicariate AS v INNER JOIN Diocese AS d ON v.DioceseId = d.Id " +
                                     "WHERE LOWER(RTRIM(LTRIM((v.Name)))) = {0} AND v.Id != {1} AND d.Id = {2} ";
                string unique = _db.ExecuteQuery<string>(query, name, vicariateId, dioceseId).SingleOrDefault();
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

        public IEnumerable<Vicariate> getAllVicariate()
        {
            string query = "SELECT * FROM Vicariate ORDER BY Name";
            return _db.ExecuteQuery<Vicariate>(query, 0);
        }
    }
}
