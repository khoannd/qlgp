using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class DioceseBusiness
    {
        private readonly DioceseData _dioceseData;

        public DioceseBusiness(string connection)
        {
            _dioceseData = new DioceseData(connection);
        }

        public Diocese GetDiocesesByDioceseId(int dioceseId)
        {
            return _dioceseData.GetDiocesesByDioceseId(dioceseId);
        }

        public Diocese GetDefaultDiocese()
        {
            return _dioceseData.GetDefaultDiocese();
        }

        public List<Diocese> GetAllDioceses()
        {
            return _dioceseData.GetAllDioceses();
        }

        public int AddDiocese(Diocese diocese)
        {
            return _dioceseData.AddDiocese(diocese);
        }

        public int UpdateDiocese(Diocese diocese)
        {
            return _dioceseData.UpdateDiocese(diocese);
        }

        public int CheckUniqueDiocese(string name, string code, int id)
        {
            return _dioceseData.CheckUniqueDiocese(name, code, id);
        }

        public string GetImageUrlByDioceseId(int dioceseId)
        {
            return _dioceseData.GetImageUrlByDioceseId(dioceseId);
        }

        public IEnumerable<IConvertible[]> GetOrderedDioceseByParamsAndPaging(string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            var parishes = _dioceseData.GetAllDioceses();
            IEnumerable<Diocese> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = parishes.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = parishes;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Code) : filteredListItems.OrderByDescending(p => p.Code);
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Address) : filteredListItems.OrderByDescending(p => p.Address);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Website) : filteredListItems.OrderByDescending(p => p.Website);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Email) : filteredListItems.OrderByDescending(p => p.Email);
            }
            else if (sortColumnIndex == 8)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Church) : filteredListItems.OrderByDescending(p => p.Church);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Id,
                           c.Code,
                           c.Name,
                           c.Address,
                           c.Website,
                           c.Phone,
                           c.Email ,
                           c.Church,
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
    }
}
