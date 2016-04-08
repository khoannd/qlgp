using PMS.DataAccess.Models;
using PMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class SeminaryYearBusiness
    {
        private readonly SeminaryYearData _seminaryYearData;

        public SeminaryYearBusiness(string connection)
        {
            _seminaryYearData = new SeminaryYearData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedSeminaryYearsByParamsAndPaging(string searchValue, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<SeminaryYear> seminaryYears;

            seminaryYears = _seminaryYearData.GetAll();

            IEnumerable<SeminaryYear> filteredListItems = seminaryYears;

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = filteredListItems.Where(c => (c.SeminaryName.Trim().ToLower().Contains(searchValue)));
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.SeminaryYearCode) : filteredListItems.OrderByDescending(p => p.SeminaryYearCode);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.SeminaryName) : filteredListItems.OrderByDescending(p => p.SeminaryName);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.StartAt) : filteredListItems.OrderByDescending(p => p.StartAt);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.EndAt) : filteredListItems.OrderByDescending(p => p.EndAt);
            }
            else
            {
                filteredListItems = filteredListItems.OrderByDescending(p => p.Id);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;

            IEnumerable<SeminaryYear> displayedList;

            if (displayLength != -1)
            {
                displayedList = list.Skip(displayStart).Take(displayLength);
            }
            else
            {
                displayedList = list;
            }

            IEnumerable<IConvertible[]> result;
            result = from c in displayedList
                     select new IConvertible[]
                           {
                               c.Id,
                               c.Id,
                               c.SeminaryYearCode,
                               c.SeminaryName,
                               c.StartAt.Year,
                               c.EndAt.Year,
                               c.Id
                           };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public SeminaryYear Get(int id)
        {
            return _seminaryYearData.Get(id);
        }

        public IEnumerable<SeminaryYear> GetAll()
        {
            return _seminaryYearData.GetAll();
        }

        public int Add(SeminaryYear seminaryYear)
        {
            return _seminaryYearData.Add(seminaryYear);
        }

        public int Update (SeminaryYear seminaryYear)
        {
            return _seminaryYearData.Update(seminaryYear);
        }


        public int Delete(int id)
        {
            return _seminaryYearData.Delete(id);
        }
    }
}
