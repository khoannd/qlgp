using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class SearchBusiness
    {
        private readonly ParishionerData _parishionerData;
        public SearchBusiness(string connection)
        {
            _parishionerData = new ParishionerData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedParishionersByParamsAndPaging(int dioceseId, int vicariateId,
            int parishId, int communityId, int parishDivisionId, string code, string parishionerName, string fatherName, string motherName,
            bool notIncludeRecord, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Parishioner> parishioners;
            const bool isCounted = true;
            int status = (int)ParishionerStatusEnum.AvailableAndSaved;
            if (notIncludeRecord)
            {
                status = (int)ParishionerStatusEnum.Available;
            }
            const int gender = -1;

            if (parishDivisionId != 0)
            {
                parishioners = _parishionerData.GetParishionersByParishDivisionId(parishDivisionId, isCounted, status,
                    gender);
            }
            else
            {
                if (communityId != 0)
                {
                    parishioners = _parishionerData.GetParishionersByCommunityId(communityId, isCounted, status, gender);

                }
                else
                {
                    if (parishId != 0)
                    {
                        parishioners = _parishionerData.GetParishionersByParishId(parishId, isCounted, status, gender);
                    }
                    else
                    {
                        if (vicariateId != 0)
                        {
                            parishioners = _parishionerData.GetParishionersByVicariateId(vicariateId, isCounted, status, gender);
                        }
                        else
                        {
                            parishioners = _parishionerData.GetParishionersByDioceseId(dioceseId, isCounted, status, gender);
                        }
                    }
                }
            }

            IEnumerable<Parishioner> filteredListItems;

            //Search
            if (!(string.IsNullOrEmpty(parishionerName) && string.IsNullOrEmpty(code)
                && string.IsNullOrEmpty(fatherName) && string.IsNullOrEmpty(motherName)))
            {           
                parishionerName = parishionerName.Trim().ToLower();
                code = code.Trim().ToLower();
                fatherName = fatherName.Trim().ToLower();
                motherName = motherName.Trim().ToLower();
                filteredListItems = parishioners.Where(c => ((string.Concat(c.ChristianName, " ", c.Name).Trim().ToLower().Contains(parishionerName)) &&
                                                       (c.Code.Trim().ToLower().Contains(code)) &&
                                                        (string.IsNullOrEmpty(fatherName) || (!string.IsNullOrEmpty(c.FatherName) && c.FatherName.Trim().ToLower().Contains(fatherName)) ) &&
                                                       (string.IsNullOrEmpty(motherName) || (!string.IsNullOrEmpty(c.MotherName) && c.MotherName.Trim().ToLower().Contains(motherName)))));
            }
            else
            {
                filteredListItems = parishioners;
            }

            //Sort
            if (sortColumnIndex == 1)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Code) : filteredListItems.OrderByDescending(p => p.Code);
            }
            else if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Gender) : filteredListItems.OrderByDescending(p => p.Gender);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.FatherName) : filteredListItems.OrderByDescending(p => p.FatherName);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.MotherName) : filteredListItems.OrderByDescending(p => p.MotherName);
            }
            else if (sortColumnIndex == 8)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Community.Parish.Name) : filteredListItems.OrderByDescending(p => p.Community.Parish.Name);
            }
            else
            {
                filteredListItems = filteredListItems.OrderByDescending(p => p.Id);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);

            var conveter = new DateConverter();

            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,    
                           c.Id,
                           c.Code,
                           c.ChristianName,
                           c.Name,
                           c.Gender == 0 ? "Nữ" : "Nam",
                           conveter.ConvertStringToDate(c.BirthDate),                        
                           c.FatherName,
                           c.MotherName,
                           c.Community.Parish.Name,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }
    }
}
