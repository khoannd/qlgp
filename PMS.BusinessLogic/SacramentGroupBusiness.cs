using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class SacramentGroupBusiness
    {
        private readonly SacramentGroupData _sacramentGroupData;
        private readonly SacramentData _sacramentData;
        private readonly MatrimonyData _matrimonyData;

        public SacramentGroupBusiness(string connection)
        {
            _sacramentData = new SacramentData(connection);
            _sacramentGroupData = new SacramentGroupData(connection);
            _matrimonyData = new MatrimonyData(connection);
        }

        public SacramentGroup GetSacramentGroupsById(int id)
        {
            return _sacramentGroupData.GetSacramentGroupsById(id).SingleOrDefault();
        }

        public IEnumerable<IConvertible[]> GetOrderedSacramentGroupByParamsAndPaging(int type, int parishId,
            string searchValue, int sortColumnIndex, string sortDirection,
            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<SacramentGroup> sacramentGroups;

            sacramentGroups = _sacramentGroupData.GetSacramentGroupByType(type, parishId);

            IEnumerable<SacramentGroup> filteredListItems;

            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = sacramentGroups.Where(c => (c.Description.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = sacramentGroups;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Date) : filteredListItems.OrderByDescending(p => p.Date);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Description) : filteredListItems.OrderByDescending(p => p.Description);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Giver) : filteredListItems.OrderByDescending(p => p.Giver);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ReceivedPlace) : filteredListItems.OrderByDescending(p => p.ReceivedPlace);
            }
            else if (sortColumnIndex == 6)
            {
                //filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.NumOfPeople) : filteredListItems.OrderByDescending(p => p.NumOfPeople);
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
                           converter.ConvertStringToDate(c.Date),
                           c.Description,
                           c.Giver,
                           c.ReceivedPlace,
                            type == 4 ? (_matrimonyData.CountMatrimonyCoupleBySacramentGroupId(c.Id)) : (_sacramentData.CountNumberofOeopleOfSacramentGroupId(c.Id)),
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int AddSaracmentGroup(SacramentGroup sacramentGroup)
        {
            return _sacramentGroupData.AddSaracmentGroup(sacramentGroup);
        }

        public int UpdateSacramentGroup(SacramentGroup sacramentGroup)
        {
            return _sacramentGroupData.UpdateSacramentGroup(sacramentGroup);
        }

        public int DeleteSacramentGroup(int id)
        {
            return _sacramentGroupData.DeleteSacramentGroup(id);
        }
        public int CheckExistedSacramentGroup(string date, int type, int parishId, int sacramentGroupId)
        {
            return _sacramentData.CheckExistedSacramentGroup(date, type, parishId, sacramentGroupId);
        }
    }
}
