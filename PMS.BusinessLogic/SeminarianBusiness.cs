using PMS.DataAccess.Models;
using PMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class SeminarianBusiness
    {
        private readonly SeminarianData _seminarianData;

        public SeminarianBusiness(string connection)
        {
            _seminarianData = new SeminarianData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedSeminariansByParamsAndPaging(string searchValue, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<Vocation> seminarians;

            seminarians = _seminarianData.GetAll();

            IEnumerable<Vocation> filteredListItems = seminarians;

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = filteredListItems.Where(c => (c.Parishioner.Name.Trim().ToLower().Contains(searchValue) || c.Parishioner.ChristianName.Trim().ToLower().Contains(searchValue)
                    || c.Phone.Contains(searchValue) || c.Parishioner.Phone.Contains(searchValue) || c.Parishioner.MobilePhone.Contains(searchValue)
                    || c.Email.Contains(searchValue)));
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.ChristianName) : filteredListItems.OrderByDescending(p => p.Parishioner.ChristianName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Name) : filteredListItems.OrderByDescending(p => p.Parishioner.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.BirthDate) : filteredListItems.OrderByDescending(p => p.Parishioner.BirthDate);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.VocationSeminaryYears.OrderByDescending(v => v.SeminaryYear.StartAt).FirstOrDefault())
                    : filteredListItems.OrderByDescending(p => p.VocationSeminaryYears.OrderByDescending(v => v.SeminaryYear.StartAt).FirstOrDefault());
            }
            else
            {
                filteredListItems = filteredListItems.OrderByDescending(p => p.Date2);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;

            IEnumerable<Vocation> displayedList;

            if (displayLength != -1)
            {
                displayedList = list.Skip(displayStart).Take(displayLength);
            }
            else
            {
                displayedList = list;
            }

            var converter = new DateConverter();

            IEnumerable<IConvertible[]> result;
            result = from c in displayedList
                     select new IConvertible[]
                           {
                               c.ParishionerId,
                               c.ParishionerId,
                               c.Parishioner.ChristianName,
                               c.Parishioner.Name,                               
                               converter.ConvertStringToDate(c.Parishioner.BirthDate),
                               c.VocationSeminaryYears.OrderByDescending(v => v.SeminaryYear.StartAt).Select(s => s.SeminaryYear.StartAt.ToString("yyyy") + "-" + s.SeminaryYear.EndAt.ToString("yyyy") + " " + s.SeminaryYear.SeminaryName).FirstOrDefault(),
                               !string.IsNullOrEmpty(c.Phone) ? c.Phone : !string.IsNullOrEmpty(c.Parishioner.Phone) ? c.Parishioner.Phone : c.Parishioner.MobilePhone,
                               c.ParishionerId
                           };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public Vocation Get(int id)
        {
            return _seminarianData.Get(id);
        }

        public int Add(Vocation seminarian)
        {
            return _seminarianData.Add(seminarian);
        }

        public int Update(Vocation seminarian)
        {
            return _seminarianData.Update(seminarian);
        }


        public int Delete(int id)
        {
            return _seminarianData.Delete(id);
        }
    }
}
