﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class PriestBusiness
    {
        private readonly PriestData _priestData;

        public PriestBusiness(string connection)
        {
            _priestData = new PriestData(connection);
        }

        public List<string> GetPriestNamesByName(int dioceseId, string name)
        {
            return _priestData.GetPriestNamesByName(dioceseId, name).ToList();
        }

        public List<string> GetPriestByName(int dioceseId, string name)
        {
            return _priestData.GetPriestNamesByName(dioceseId, name).ToList();
        }

        public Priest GetPriestByPriestId(int id)
        {
            return _priestData.GetPriestByPriestId(id);
        }

        public int AddPriest(Priest priest)
        {
            return _priestData.AddPriest(priest);
        }

        public int UpdatePriest(Priest priest)
        {
            return _priestData.UpdatePriest(priest);
        }

        public int DeletePriest(int id)
        {
            return _priestData.DeletePriest(id);
        }        
        public IEnumerable<IConvertible[]> GetOrderedPriestsByParamsAndPaging(int dioceseId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Priest> priests;
           
            priests = _priestData.GetPriestByDioceseId(dioceseId);

            IEnumerable<Priest> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = priests.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = priests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
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
                           c.Id,
                           c.ChristianName,
                           c.Name,
                           converter.ConvertStringToDate(c.BirthDate),
                           c.Phone,
                           c.Id                           
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
        public IEnumerable<IConvertible[]> GetOrderedPriestsByParamsAndPagingForTCLM(int tclmId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Priest> priests;

            priests = _priestData.GetPriestForTCLM(tclmId);

            IEnumerable<Priest> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = priests.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = priests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
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
                           c.Id,
                           c.ChristianName,
                           c.Name,
                           converter.ConvertStringToDate(c.BirthDate),
                           c.Phone,
                           c.Id                           
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
    }
}