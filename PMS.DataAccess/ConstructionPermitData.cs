using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class ConstructionPermitData
    {
        private readonly PMSDataContext _db;
        public ConstructionPermitData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public IEnumerable<ConstructionPermitViewModel> getAllConstructionPermit()
        {
            const string query = "SELECT c.Id, t.Definition AS TypeName, p.Name AS ParishName , c.Description, c.FilePath, s.Definition AS StatusName, c.Note " +
                "FROM ConstructionPermit c " +
                "INNER JOIN ValueSet t " +
                "ON c.PermitType = t.Code AND t.Category LIKE 'PermitType' " +
                "INNER JOIN ValueSet s " +
                "ON c.PermitStatus = s.Code AND s.Category LIKE 'PermitStatus' " +
                "INNER JOIN Parish p " +
                "ON c.ParishId = p.Id " +
                "ORDER BY c.Id DESC";
            return _db.ExecuteQuery<ConstructionPermitViewModel>(query, 0);
        }

        public int createConstructionPermit(ConstructionPermit constructionPermit)
        {
            try
            {
                _db.ConstructionPermits.InsertOnSubmit(constructionPermit);
                _db.SubmitChanges();
                return constructionPermit.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public ConstructionPermit GetConstructionPermitById(int id)
        {
            const string query = "SELECT * FROM ConstructionPermit WHERE Id = {0}";
            return _db.ExecuteQuery<ConstructionPermit>(query, id).SingleOrDefault();
        }

        public int UpdateConstructionPermit(ConstructionPermit constructionPermit)
        {
            try
            {
                var item = _db.ConstructionPermits.SingleOrDefault(d => d.Id == constructionPermit.Id);
                if (item == null)
                {
                    return 0;
                }
                item.PermitType = constructionPermit.PermitType;
                item.ParishId = constructionPermit.ParishId;
                item.Description = constructionPermit.Description;
                item.FilePath = constructionPermit.FilePath;
                item.PermitStatus = constructionPermit.PermitStatus;
                item.Note = constructionPermit.Note;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int DeleteConstructionPermit(int id)
        {
            try
            {
                ConstructionPermit constructionPermit = _db.ConstructionPermits.SingleOrDefault(p => p.Id == id);
                if (constructionPermit == null)
                {
                    return 0;
                }

                _db.ConstructionPermits.DeleteOnSubmit(constructionPermit);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public IEnumerable<ConstructionPermitViewModel> GetConstructionPermitByPermitType(int permitType)
        {
            const string query = "SELECT c.Id, t.Definition AS TypeName, p.Name AS ParishName , c.Description, c.FilePath, s.Definition AS StatusName, c.Note " +
                "FROM ConstructionPermit c " +
                "INNER JOIN ValueSet t " +
                "ON c.PermitType = t.Code AND t.Category LIKE 'PermitType' " +
                "INNER JOIN ValueSet s " +
                "ON c.PermitStatus = s.Code AND s.Category LIKE 'PermitStatus' " +
                "INNER JOIN Parish p " +
                "ON c.ParishId = p.Id " +
                "WHERE c.PermitType = {0} " +
                "ORDER BY c.Id DESC";
            return _db.ExecuteQuery<ConstructionPermitViewModel>(query, permitType);
        }

        public IEnumerable<ConstructionPermitViewModel> GetConstructionPermitByPermitStatus(int permitStatus)
        {
            const string query = "SELECT c.Id, t.Definition AS TypeName, p.Name AS ParishName , c.Description, c.FilePath, s.Definition AS StatusName, c.Note " +
                "FROM ConstructionPermit c " +
                "INNER JOIN ValueSet t " +
                "ON c.PermitType = t.Code AND t.Category LIKE 'PermitType' " +
                "INNER JOIN ValueSet s " +
                "ON c.PermitStatus = s.Code AND s.Category LIKE 'PermitStatus' " +
                "INNER JOIN Parish p " +
                "ON c.ParishId = p.Id " +
                "WHERE c.PermitStatus = {0} " +
                "ORDER BY c.Id DESC";
            return _db.ExecuteQuery<ConstructionPermitViewModel>(query, permitStatus);
        }

        public IEnumerable<ConstructionPermitViewModel> GetConstructionPermitByPermitTypeAndPermitStatus(int permitType, int permitStatus)
        {
            const string query = "SELECT c.Id, t.Definition AS TypeName, p.Name AS ParishName , c.Description, c.FilePath, s.Definition AS StatusName, c.Note " +
                "FROM ConstructionPermit c " +
                "INNER JOIN ValueSet t " +
                "ON c.PermitType = t.Code AND t.Category LIKE 'PermitType' " +
                "INNER JOIN ValueSet s " +
                "ON c.PermitStatus = s.Code AND s.Category LIKE 'PermitStatus' " +
                "INNER JOIN Parish p " +
                "ON c.ParishId = p.Id " +
                "WHERE c.PermitType= {0} AND c.PermitStatus= {1} " +
                "ORDER BY c.Id DESC";
            return _db.ExecuteQuery<ConstructionPermitViewModel>(query, permitType, permitStatus);
        }

        public int UpdateFilePath(int Id, string filePath)
        {
            try
            {
                var item = _db.ConstructionPermits.SingleOrDefault(d => d.Id == Id);
                if (item == null)
                {
                    return 0;
                }
                item.FilePath = filePath;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }
    }
}
