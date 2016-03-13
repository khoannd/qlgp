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
    public class FamilyBusiness
    {
        private readonly FamilyData _familyData;

        public FamilyBusiness(string connection)
        {
            _familyData = new FamilyData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedFamiliesByParamsAndPaging(int parishId, int communityId, int parishDivisionId,
                           bool isCounted, int status, string searchValue, int changeParishFamily, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<Family> families;

            if (parishDivisionId != 0)
            {
                families = _familyData.GetFamiliesByParishDivisionId(parishDivisionId, isCounted, status);
            }
            else
            {
                if (communityId != 0)
                {
                    families = _familyData.GetFamiliesByCommunityId(communityId, isCounted, status);

                }
                else
                {
                    families = _familyData.GetFamiliesByParishId(parishId, isCounted, status);
                }
            }

            IEnumerable<Family> filteredListItems = families;

            if (changeParishFamily == 1)
            {
                filteredListItems =
                    filteredListItems.Where(
                        c => ((c.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish
                              || c.FamilyMigrationRequests.Any(p => p.Community.ParishId == parishId)) && c.Status != (int)FamilyStatusEnum.Deleted));
            }

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = filteredListItems.Where(c => (c.Code.Trim().ToLower().Contains(searchValue) ||
                                                      (string.Concat(c.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", c.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name).Trim().ToLower().Contains(searchValue))
                                                      || c.Name.Trim().ToLower().Contains(searchValue)));
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
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name))) :
                    filteredListItems.OrderByDescending(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name)));
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.FamilyMembers.Count(f => f.Status == (int)FamilyMemberStatusEnum.Main)) : filteredListItems.OrderByDescending(p => p.FamilyMembers.Count(f => f.Status == (int)FamilyMemberStatusEnum.Main));
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
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

            IEnumerable<Family> displayedList;

            if (displayLength != -1)
            {
                displayedList = list.Skip(displayStart).Take(displayLength);
            }
            else
            {
                displayedList = list;
            }

            IEnumerable<IConvertible[]> result;
            Parishioner member;

            if (status != (int)FamilyStatusEnum.Saved)
            {
                result = from c in displayedList
                         select new IConvertible[]
                           {
                               c.Id,
                               c.Id,
                               c.Code,
                               c.Name,
                               string.Concat((member = c.FamilyMembers.First(fm => fm.IsHouseholder).Parishioner).ChristianName,
                                   " ", member.Name),
                               c.FamilyMembers.Count(f => (f.Status == (int) FamilyMemberStatusEnum.Main
                                   && f.Parishioner.Status != (int) ParishionerStatusEnum.Deleted) ),
                               c.Phone,
                               (c.Community.ParentId != null) ? c.Community.Name : "",
                               (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                               c.Id
                           };
            }
            else
            {
                int outside = 0;
                int approved = 0;
                FamilyMigrationRequest request;

                result = from c in displayedList
                         select new IConvertible[]
                           {
                               (request = c.FamilyMigrationRequests.FirstOrDefault(pmr => pmr.Community.ParishId == parishId)) != null ?
                               (approved = (c.Community.ParishId == parishId) ? -1 : -2) : 0,
                               c.Id,
                               c.Code,
                               c.Name,
                               string.Concat((member = c.FamilyMembers.First(fm => fm.IsHouseholder).Parishioner).ChristianName,
                                   " ", member.Name),
                               c.FamilyMembers.Count(f => (f.Status == (int) FamilyMemberStatusEnum.Main
                                   && f.Parishioner.Status != (int) ParishionerStatusEnum.Deleted)),
                               c.Phone,
                                (request == null || approved == -1) ? ((c.Community.ParentId != null) ? c.Community.Name : "")
                               : ((request.Community.ParentId != null) ? request.Community.Name : ""),
                               (request == null || approved == -1) ? ((c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name)
                               : ((request.Community.ParentId != null) ? request.Community.Community1.Name : request.Community.Name),
                               c.Id
                           };
            }

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public Family GetFamilyByParishionerId(int parishionerId, out bool isHouseholder, out int status, out int result)
        {
            return _familyData.GetFamilyByParishionerId(parishionerId, out isHouseholder, out status, out result);
        }

        public int ChangeFamilyStatus(int id, int status, string username, bool isForced)
        {
            return _familyData.ChangeFamilyStatus(id, status, username, isForced);
        }

        public List<FamilyMember> GetFamilyMembersByFamilyId(int familyId)
        {
            return _familyData.GetFamilyMembersByFamilyId(familyId).OrderByDescending(fm => fm.IsHouseholder).ThenByDescending(fm => fm.Status).ThenBy(fm => fm.Position).ToList();
        }

        public int AddFamilyMember(int familyId, int parishionerId)
        {
            return _familyData.AddFamilyMember(familyId, parishionerId);
        }

        public int DeleteFamilyMember(int id)
        {
            return _familyData.DeleteFamilyMember(id);
        }

        public int AddFamily(Family family)
        {
            return _familyData.AddFamily(family);
        }

        public int UpdateFamily(Family family)
        {
            return _familyData.UpdateFamily(family);
        }

        public string LoadFamilyCode(int parishId, string prefix, int characterNumber)
        {
            return _familyData.LoadFamilyCode(parishId, prefix, characterNumber);
        }

        public int CheckFamilyCode(string code, int parishId)
        {
            return _familyData.CheckFamilyCode(code, parishId);
        }

        public Family GetFamilyById(int id)
        {
            return _familyData.GetFamilyById(id);
        }

        public int ChangeFamilyPosition(int memberId, int familyId, int position)
        {
            return _familyData.ChangeFamilyPosition(memberId, familyId, position);
        }

        public Parishioner SuggestMoreMember(int memberId, int parishId)
        {
            return _familyData.SuggestMorMember(memberId, parishId);
        }

    }
}
