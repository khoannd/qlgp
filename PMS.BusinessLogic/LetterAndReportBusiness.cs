using PMS.DataAccess.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Utilities;
using PMS.DataAccess;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess;

namespace PMS.BusinessLogic
{
    public class LetterAndReportBusiness
    {
        private readonly LetterAndReportData _letterAndReportData;

        public LetterAndReportBusiness(string connection)
        {
            _letterAndReportData = new LetterAndReportData(connection);
        }
		public List<LetterAndReport> GetAllLetterAndReport()
		{
            return _letterAndReportData.GetAllLetterAndReport().ToList();
        }
		public string  getTemplate(int id)
        {
            return _letterAndReportData.getTemplate(id);
        }

        public List<ValueSet> GetLoai()
        {
            return _letterAndReportData.GetLoai().OrderBy(p => p.Definition).ToList();
        }

        //
        public IEnumerable<IConvertible[]> GetLetterAndReportByParamsAndPaging(string searchValue, int sortColumnIndex
                                                                                    , string sortDirection, int displayStart, int displayLength
                                                                                    , out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            var letterAndReports = _letterAndReportData.GetLoadAllLetterAndReport();
            IEnumerable<LetterAndReportViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                filteredListItems = letterAndReports.Where(c => (c.Ten.ToLower().Contains(searchValue.ToLower())));
            }
            else
            {
                filteredListItems = letterAndReports;
            }
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Ten) : filteredListItems.OrderByDescending(p => p.Ten);
            }
            else
            {
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Id,
                           c.Ten,
                           c.TenLoai,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }



        public int CheckValidTen(string ten)
        {
            return _letterAndReportData.CheckValidTen(ten);
        }

        public int AddLetterAndReport(LetterAndReport letterandreport)
        {
            return _letterAndReportData.AddLetterAndReport(letterandreport);
        }
        public LetterAndReport GetLetterAndReportId(int id)
        {
            return _letterAndReportData.GetLetterAndReportId(id);
        }

        public int UpdateLetterAndReport(LetterAndReport letterandreport)
        {
            return _letterAndReportData.UpdateLetterAndReport(letterandreport);
        }


        public int DeleteLetterAndReport(int id)
        {
            return _letterAndReportData.DeleteLetterAndReport(id);
        }


        //
    }
}
