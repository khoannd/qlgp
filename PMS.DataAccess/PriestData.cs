using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Utilities;

namespace PMS.DataAccess
{
    public class PriestData
    {
        private readonly PMSDataContext _db;

        public PriestData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<PriestViewModel> GetPriestByDioceseId(int dioceseId)
        {
            const string query = "SELECT * FROM Priest " +
                                 "WHERE DioceseId = {0} " +
                                 "ORDER By Id DESC";
            return _db.ExecuteQuery<PriestViewModel>(query, dioceseId);
        }

        public IEnumerable<Priest> GetPriestForTCLM(int tclmId)
        {
            const string query = @" select Priest.*
                                    from Priest
                                    where Priest.Id not in (
						                                    select ParishManager.PriestId 
						                                    from ParishManager 
						                                    where ParishManager.PriestId is not null 
						                                    and ParishManager.IdThuyenChuyenLinhMuc = {0}
					                                    )";
            return _db.ExecuteQuery<Priest>(query, tclmId);
        }

        public Priest GetPriestByPriestId(int id)
        {
            const string query = "SELECT * FROM Priest WHERE Id = {0}";
            return _db.ExecuteQuery<Priest>(query, id).SingleOrDefault();
        }

        public int AddPriest(Priest priest)
        {
            try
            {
                _db.Priests.InsertOnSubmit(priest);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int UpdatePriest(Priest priest)
        {
            try
            {
                var item = _db.Priests.SingleOrDefault(d => d.Id == priest.Id);
                if (item == null)
                {
                    return 0;
                }
                item.ChristianName = priest.ChristianName;
                item.Name = priest.Name;
                item.BirthDate = priest.BirthDate;
                item.Phone = priest.Phone;

                _db.SubmitChanges();
                return priest.Id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int DeletePriest(int id)
        {
            try
            {
                Priest priest = _db.Priests.SingleOrDefault(p => p.Id == id);

                if (priest == null)
                {
                    return 0;
                }

                _db.Priests.DeleteOnSubmit(priest);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public IEnumerable<string> GetPriestNamesByName(int dioceseId, string name)
        {
            const string query = "SELECT (P.ChristianName + ' ' + P.Name) AS Name " +
                                 "FROM Priest AS P " +
                                 "WHERE P.DioceseId = {0} AND (P.ChristianName + ' ' + P.Name) LIKE {1} " +
                                 "ORDER BY P.ChristianName, P.Name";

            name = name.Trim();
            return _db.ExecuteQuery<string>(query, dioceseId, "%" + name + "%");
        }

        public IEnumerable<Priest> GetAllPriests()
        {
            string query = "SELECT * FROM Priest ORDER BY ChristianName";
            return _db.ExecuteQuery<Priest>(query, 0);
        }

        public IEnumerable<Priest> GetPriestForHDLM()
        {
            const string query = @" select * 
                                    from Priest as pr 
                                    where pr.Id not in (
						                                    select PriestID from HDLMMember
					                                    )";
            return _db.ExecuteQuery<Priest>(query);
        }

        public PriestViewModel GetPriestAndParishionerInfoByPriestId(int id)
        {
            const string query = "SELECT p.*, pa.Code, pa.ImageUrl " +
                "FROM Priest p " +
                "INNER JOIN Parishioner pa " +
                "ON p.ParishionerId = pa.Id " +
                "WHERE p.Id = {0}";
            return _db.ExecuteQuery<PriestViewModel>(query, id).SingleOrDefault();
        }
        public IEnumerable<PriestViewModel> getParishionerByDioceseId(int dioceseId)
        {
            const string query = "SELECT p.*, pa.Code, pa.ImageUrl " +
                "FROM Priest p " +
                "INNER JOIN Parishioner pa " +
                "ON p.ParishionerId = pa.Id " +
                "WHERE DioceseId = {0} " +
                "ORDER By Id DESC";
            return _db.ExecuteQuery<PriestViewModel>(query, dioceseId);
        }
    }
}
