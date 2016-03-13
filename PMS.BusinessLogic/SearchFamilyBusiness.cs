using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class SearchFamilyBusiness
    {
        private readonly FamilyData _familyData;

        public SearchFamilyBusiness(string connection)
        {
            _familyData = new FamilyData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedFamiliesByParamsAndPaging(int dioceseId, int vicariateId,
            int parishId, int communityId, int parishDivisionId, string code, string parishionerName, string fatherName, string motherName,
            bool notIncludeRecord, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Family> families;
            const bool isCounted = true;
            int status = (int)FamilyStatusEnum.AvailableAndSaved;
            if (notIncludeRecord)
            {
                status = (int)FamilyStatusEnum.Available;
            }

            if (parishDivisionId != 0)
            {
                families = _familyData.SearchFamiliesByParishDivisionId(parishDivisionId, isCounted, status, code, parishionerName, fatherName, motherName);
            }
            else
            {
                if (communityId != 0)
                {
                    families = _familyData.SearchFamiliesByCommunityId(communityId, isCounted, status, code, parishionerName, fatherName, motherName);

                }
                else
                {
                    if (parishId != 0)
                    {
                        families = _familyData.SearchFamiliesByParishId(parishId, isCounted, status, code, parishionerName, fatherName, motherName);
                    }
                    else
                    {
                        if (vicariateId != 0)
                        {
                            families = _familyData.SearchFamiliesByVicariateId(vicariateId, isCounted, status, code, parishionerName, fatherName, motherName);
                        }
                        else
                        {
                            families = _familyData.SearchFamiliesByDioceseId(dioceseId, isCounted, status, code, parishionerName, fatherName, motherName);
                        }
                    }
                }
            }

            IEnumerable<Family> filteredListItems;
                     
            filteredListItems = families;            

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Code) : filteredListItems.OrderByDescending(p => p.Code);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name))) :
                    filteredListItems.OrderByDescending(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name)));
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.FamilyMembers.Count) : filteredListItems.OrderByDescending(p => p.FamilyMembers.Count);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Community.Name) : filteredListItems.OrderByDescending(p => p.Community.Name);
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


            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,   
                           c.Id,
                           c.Code,
                           c.Name,
                           string.Concat(c.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", c.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name),
                           c.FamilyMembers.Count(f => (f.Status == (int) FamilyMemberStatusEnum.Main
                                   && f.Parishioner.Status != (int) ParishionerStatusEnum.Deleted) ),
                           c.Phone,                     
                           (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                           c.Community.Parish.Name,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }
    }
}
