using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class ChangeCommunityBusiness
    {
        private readonly ChangeCommunityData _changeCommunityData;
        public ChangeCommunityBusiness(string connection)
        {
            _changeCommunityData = new ChangeCommunityData(connection);
        }

        public List<Community> GetCommunitiesByParishId(int parishId)
        {
            return _changeCommunityData.GetCommunitiesByParishId(parishId).OrderByDescending(c => c.IsDefault).ThenBy(c => c.Name).ToList();
        }
        public List<Community> GetParishDivisionsByParishId(int parishId)
        {
            return _changeCommunityData.GetParishDivisionsByParishId(parishId).OrderBy(c => c.ParentId).ThenBy(c => c.Name).ToList();
        }

        //Load Parishioner ra dataTable
        public IEnumerable<IConvertible[]> GetOrderedParishionersByParamsAndPaging(int parishId, int communityId, bool isCounted, string searchValue, int sortColumnIndex, string sortDirection,
                                                                                    int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<Parishioner> parishioners;
            if (communityId == 0)
            {
                parishioners = _changeCommunityData.GetParishionersByParishId(parishId, isCounted);
            }
            else
            {
                parishioners = _changeCommunityData.GetParishionersByCommunityId(communityId, isCounted);
            }

            IEnumerable<Parishioner> filteredListItems;
            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = parishioners.Where(c => (c.Code.Trim().ToLower().Contains(searchValue) ||
                                                      (string.Concat(c.ChristianName, " ", c.Name).Trim().ToLower().Contains(searchValue))));
            }
            else
            {
                filteredListItems = parishioners;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Code) : filteredListItems.OrderByDescending(p => p.Code);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Gender) : filteredListItems.OrderByDescending(p => p.Gender);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Community.Name) : filteredListItems.OrderByDescending(p => p.Community.Name);
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
                           (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                           (c.Community.ParentId != null) ? c.Community.Name : "",
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int ChangeParishionersCommunity(string[] parishioners, int communityTargetId)
        {
            return _changeCommunityData.ChangeParishionersCommunity(parishioners, communityTargetId);
        }
        //---------------------------------------------------------------------------
        //Phần gia đình
        public string GetHouseHolderName(int familyId)
        {
            string name = "";
            var houseHolder = _changeCommunityData.GetHouseHolderNameByFamilyId(familyId);
            foreach (var item in houseHolder)
            {
                name = item.Parishioner.ChristianName + " " + item.Parishioner.Name;
            }
            return name;
        }
        //Load family ra dataTable
        public IEnumerable<IConvertible[]> GetOrderedFamiliesByParamsAndPaging(int parishId, int communityId, bool isCounted, string searchValue, int sortColumnIndex, string sortDirection,
                                                                                    int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<Family> families;
            if (communityId == 0)
            {
                families = _changeCommunityData.GetFamiliesByParishId(parishId, isCounted);
            }
            else
            {
                families = _changeCommunityData.GetFamiliesByCommunityId(communityId, isCounted);
            }

            IEnumerable<Family> filteredListItems;
            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = families.Where(c => (c.Code.Trim().ToLower().Contains(searchValue) ||
                                                      (string.Concat(c.Code, " ", c.Name).Trim().ToLower().Contains(searchValue))));
            }
            else
            {
                filteredListItems = families;
            }

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
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name))) : filteredListItems.OrderByDescending(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name)));
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.FamilyMembers.Count(q => q.FamilyId == p.Id)) : filteredListItems.OrderByDescending(p => p.FamilyMembers.Count(q => q.FamilyId == p.Id));
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Community.Name) : filteredListItems.OrderByDescending(p => p.Community.Name);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = filteredListItems.OrderByDescending(p => p.Id);
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
                           c.Name,
                           GetHouseHolderName(c.Id),
                           c.FamilyMembers.Count(f => (f.Status == (int) FamilyMemberStatusEnum.Main
                                   && f.Parishioner.Status != (int) ParishionerStatusEnum.Deleted) ),
                           (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                           (c.Community.ParentId != null) ? c.Community.Name : "",
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
        public int ChangeFamiliesCommunity(string[] families, int communityTargetId)
        {
            return _changeCommunityData.ChangeFamiliesCommunity(families, communityTargetId);
        }
    }
}
