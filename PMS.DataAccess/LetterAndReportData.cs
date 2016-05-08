using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class LetterAndReportData
    {
        private readonly PMSDataContext _db;
        private const string _loai = "MBC";

        public LetterAndReportData(String connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<LetterAndReportViewModel> GetLoadAllLetterAndReport()
        {
            const string query = "SELECT a.*, b.Definition " +
                                 "AS TenLoai " +
                                 "FROM LetterAndReport a LEFT JOIN ValueSet b ON a.Loai=b.Code " +
                                 "WHERE b.Category='MBC'";
            return _db.ExecuteQuery<LetterAndReportViewModel>(query);
        }

        public IEnumerable<ValueSet> GetLoai()
        {
            const string query = "select * from ValueSet where Category = {0}" ;
            return _db.ExecuteQuery<ValueSet>(query, _loai);

        }
        public int CheckValidTen(string ten)
        {
            try
            {
                var item = _db.LetterAndReports.SingleOrDefault(a => a.Ten.Equals(ten));

                if (item == null)
                {
                    return 1;
                }

                return 0;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int AddLetterAndReport(LetterAndReport letterandreport)
        {
            try
            {
                _db.LetterAndReports.InsertOnSubmit(letterandreport);
                _db.SubmitChanges();
                return letterandreport.Id;
            }
            catch (Exception e)
            {
                return 0;
            }
        }

        public LetterAndReport GetLetterAndReportId(int id)
        {
            const string query = "SELECT * FROM LetterAndReport WHERE Id = {0}";
            return _db.ExecuteQuery<LetterAndReport>(query, id).SingleOrDefault();
        }

        public int UpdateLetterAndReport(LetterAndReport letterandreport)
        {
            try
            {
                var item = _db.LetterAndReports.SingleOrDefault(d => d.Id == letterandreport.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Id = letterandreport.Id;
                item.Ten = letterandreport.Ten;
                item.Loai = letterandreport.Loai;
                item.MoTa = letterandreport.MoTa;
                item.Mau = letterandreport.Mau;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int DeleteLetterAndReport(int id)
        {
            try
            {
                LetterAndReport letterandreport = _db.LetterAndReports.SingleOrDefault(p => p.Id == id);

                if (letterandreport == null)
                {
                    return 0;
                }

                _db.LetterAndReports.DeleteOnSubmit(letterandreport);
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
