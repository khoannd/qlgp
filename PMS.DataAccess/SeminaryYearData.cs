using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class SeminaryYearData
    {
        private readonly PMSDataContext _db;

        public SeminaryYearData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<SeminaryYear> GetAll()
        {
            return _db.SeminaryYears.ToList();
        }

        public SeminaryYear Get(int id)
        {
            return _db.SeminaryYears.SingleOrDefault(s => s.Id == id);
        }

        public int Add(SeminaryYear seminaryYear)
        {
            try
            {
                _db.SeminaryYears.InsertOnSubmit(seminaryYear);
                _db.SubmitChanges();
                return seminaryYear.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Update(SeminaryYear seminaryYear)
        {
            try
            {
                var exist = _db.SeminaryYears.SingleOrDefault(s => s.Id == seminaryYear.Id);

                if (exist == null)
                {
                    return 0;
                }

                exist.SeminaryName = seminaryYear.SeminaryName;
                exist.SeminaryYearCode = seminaryYear.SeminaryYearCode;
                exist.StartAt = seminaryYear.StartAt;
                exist.EndAt = seminaryYear.EndAt;

                _db.SubmitChanges();

                return exist.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Delete(int id)
        {
            try
            {
                SeminaryYear seminaryYear = _db.SeminaryYears.SingleOrDefault(p => p.Id == id);

                if (seminaryYear == null)
                {
                    return 0;
                }

                if (seminaryYear.VocationSeminaryYears.Any()) //is there any seminarian associate with this seminary year course
                {
                    return -2;
                }

                _db.SeminaryYears.DeleteOnSubmit(seminaryYear);
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
