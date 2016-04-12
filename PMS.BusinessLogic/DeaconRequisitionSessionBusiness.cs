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
    public class DeaconRequisitionSessionBusiness
    {
        private readonly DeaconRequisitionSessionData _deaconRequisitionSessionData;

        public DeaconRequisitionSessionBusiness(string connection)
        {
            _deaconRequisitionSessionData = new DeaconRequisitionSessionData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedDeaconRequisitionSessionsByParamsAndPaging(string searchValue, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<DeaconRequisitionSession> sessions;

            sessions = _deaconRequisitionSessionData.GetAll();

            IEnumerable<DeaconRequisitionSession> filteredListItems = sessions;

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = filteredListItems.Where(c => (c.SessionCode.Trim().ToLower().Contains(searchValue) || c.SessionName.Trim().ToLower().Contains(searchValue)
                    || c.Year.Year.ToString().Contains(searchValue) || (c.SessionName.Trim().ToLower() + " " + c.Year.Year.ToString()).Contains(searchValue)));
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Year).ThenBy(p => p.SessionName) : filteredListItems.OrderByDescending(p => p.Year).ThenByDescending(p => p.SessionName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.SessionCode) : filteredListItems.OrderByDescending(p => p.SessionCode);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.DeadlineForPriest) : filteredListItems.OrderByDescending(p => p.DeadlineForPriest);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.DeadlineForParish)
                    : filteredListItems.OrderByDescending(p => p.DeadlineForParish);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Status) : filteredListItems.OrderByDescending(p => p.Status);
            }
            else
            {
                filteredListItems = filteredListItems.OrderByDescending(p => p.Year);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;

            IEnumerable<DeaconRequisitionSession> displayedList;

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
                               c.Id,
                               c.Id,
                               c.SessionName + " " + c.Year.ToString("yyyy"),
                               c.SessionCode,                               
                               converter.ConvertStringToDate(c.DeadlineForPriest.ToString("yyyyMMdd")),
                               converter.ConvertStringToDate(c.DeadlineForParish.Value.ToString("yyyyMMdd")),
                               c.Status,
                               c.Id
                           };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public DeaconRequisitionSession Get(int id)
        {
            return _deaconRequisitionSessionData.Get(id);
        }

        public int Add(DeaconRequisitionSession deaconRequisitionSession)
        {
            return _deaconRequisitionSessionData.Add(deaconRequisitionSession);
        }

        public int Update(DeaconRequisitionSession deaconRequisitionSession)
        {
            return _deaconRequisitionSessionData.Update(deaconRequisitionSession);
        }

        public int Delete(int id)
        {
            return _deaconRequisitionSessionData.Delete(id);
        }
    }
}
