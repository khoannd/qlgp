using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class ParishBusiness
    {
        private readonly ParishData _parishData;

        public ParishBusiness(string connection)
        {
            _parishData = new ParishData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedParishesByParamsAndPaging(int dioceseId, int vicariateId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Parish> parishes;
            if (vicariateId == 0)
            {
                parishes = _parishData.GetParishesByDioceseId(dioceseId);
            }
            else
            {
                parishes = _parishData.GetParishesByVicariateId(vicariateId);
            }

            IEnumerable<Parish> filteredListItems;
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
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Address) : filteredListItems.OrderByDescending(p => p.Address);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Priest) : filteredListItems.OrderByDescending(p => p.Priest);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Website) : filteredListItems.OrderByDescending(p => p.Website);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Email) : filteredListItems.OrderByDescending(p => p.Email);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
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
                           c.Name,
                           c.Address,
                           c.Priest,
                           c.Website,
                           c.Email ,
                           c.Phone,
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int CheckUniqueParish(string name, int parishId, int dioceseId)
        {
            return _parishData.CheckUniqueParish(name, parishId, dioceseId);
        }

        public int AddParish(Parish parish)
        {
            return _parishData.AddParish(parish);
        }

        public int UpdateParish(Parish parish)
        {
            return _parishData.UpdateParish(parish);
        }

        public int UpdateParishManager(Parish parish)
        {
            return _parishData.UpdateParishManager(parish);
        }

        public int DeleteParish(int id)
        {
            return _parishData.DeleteParish(id);
        }

        public Parish GetParishesByParishId(int id)
        {
            return _parishData.GetParishesByParishId(id);
        }

        public IEnumerable<Parish> GetAllParish()
        {
            return _parishData.GetAllParish();
        }

        public List<Parish> GetParishesByVicariateId(int vicariateId)
        {
            return _parishData.GetParishesByVicariateId(vicariateId).OrderBy(p => p.Name).ToList();
        }

        public List<Parish> GetParishesByDioceseId(int dioceseId)
        {
            return _parishData.GetParishesByDioceseId(dioceseId).OrderBy(p => p.Name).ToList();
        }

        public List<Parish> GetParishesByDioceseIdNotMine(int dioceseId, int parishId)
        {
            return _parishData.GetParishesByDioceseIdNotMine(dioceseId, parishId).OrderBy(p => p.Name).ToList();
        }

        public List<Parish> GetParishesByVicariateIdNotMine(int vicariateId, int parishId)
        {
            return _parishData.GetParishesByVicariateIdNotMine(vicariateId, parishId).OrderBy(p => p.Name).ToList();
        }
        public string GetImageUrlByParishId(int parishId)
        {
            return _parishData.GetImageUrlByParishId(parishId);
        }

        public List<string> GetParishNamesByName(string name, int parishId)
        {
            return _parishData.GetParishNamesByName(name, parishId).ToList();
        }


    }
}
