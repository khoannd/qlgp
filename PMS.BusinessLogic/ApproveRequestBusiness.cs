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
    public class ApproveRequestBusiness
    {
        private readonly ApproveRequestData _approveRequestData;

        public ApproveRequestBusiness(string connection)
        {
            _approveRequestData = new ApproveRequestData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedMigrationRequestByParamsAndPaging(int id, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data

            IEnumerable<ParishionerMigrationRequest> parishionerMigrationRequests = _approveRequestData.GetParishionerMigrationRequestByParishId(id);

            IEnumerable<ParishionerMigrationRequest> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = parishionerMigrationRequests.Where(c => (c.Parishioner.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = parishionerMigrationRequests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.ChristianName) : filteredListItems.OrderByDescending(p => p.Parishioner.ChristianName);
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Name) : filteredListItems.OrderByDescending(p => p.Parishioner.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Gender) : filteredListItems.OrderByDescending(p => p.Parishioner.Gender);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.BirthDate) : filteredListItems.OrderByDescending(p => p.Parishioner.BirthDate);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Community.Parish.Name) : filteredListItems.OrderByDescending(p => p.Parishioner.Community.Parish.Name);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.ParishionerId,
                           c.Id,
                           c.Parishioner.ChristianName,
                           c.Parishioner.Name,
                           c.Parishioner.Gender == 0 ? "Nữ" : "Nam",
                           converter.ConvertStringToDate(c.Parishioner.BirthDate),
                           c.Parishioner.Community.Parish.Name,
                           c.CreatedDate.ToString("dd/MM/yyyy"),
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        //public int CountParishionerMigrationRequestByParishId(int id)
        //{
        //    return _approveRequestData.CountParishionerMigrationRequestByParishId(id);
        //}

        public int ApproveParishionerMigrationRequest(int communityId, int[] ids, int accountId)
        {
            return _approveRequestData.ApproveParishionerMigrationRequest(communityId, ids, accountId);
        }

        public int DenyParishionerMigrationRequest(int id)
        {
            return _approveRequestData.DenyParishionerMigrationRequest(id);
        }

        public IEnumerable<IConvertible[]> GetOrderedMigrationRequestSendingByParamsAndPaging(int id, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data

            IEnumerable<ParishionerMigrationRequest> parishionerMigrationRequests = _approveRequestData.GetParishionerMigrationRequestSendingByParishId(id);

            IEnumerable<ParishionerMigrationRequest> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = parishionerMigrationRequests.Where(c => (c.Parishioner.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = parishionerMigrationRequests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.ChristianName) : filteredListItems.OrderByDescending(p => p.Parishioner.ChristianName);
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Name) : filteredListItems.OrderByDescending(p => p.Parishioner.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Gender) : filteredListItems.OrderByDescending(p => p.Parishioner.Gender);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.BirthDate) : filteredListItems.OrderByDescending(p => p.Parishioner.BirthDate);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parish.Name) : filteredListItems.OrderByDescending(p => p.Parish.Name);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.ParishionerId,
                           c.Id,
                           c.Parishioner.ChristianName,
                           c.Parishioner.Name,
                           c.Parishioner.Gender == 0 ? "Nữ" : "Nam",
                           converter.ConvertStringToDate(c.Parishioner.BirthDate),
                           c.Parish.Name,
                           c.CreatedDate.ToString("dd/MM/yyyy"),
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        //public int CountParishionerMigrationSendingRequestByParishId(int id)
        //{
        //    return _approveRequestData.CountParishionerMigrationSendingRequestByParishId(id);
        //}

        public int CancelParishionerMigrationRequestSending(int id)
        {
            return _approveRequestData.CancelParishionerMigrationRequestSending(id);
        }

        //-----------------------------------------------------------------------------------------------
        //Family Business
        //public int CountFamilyMigrationRequestByParishId(int id)
        //{
        //    return _approveRequestData.CountFamilyMigrationRequestByParishId(id);
        //}

        //public int CountFamilyMigrationSendingRequestByParishId(int id)
        //{
        //    return _approveRequestData.CountFamilyMigrationSendingRequestByParishId(id);
        //}

        public int ApproveFamilyMigrationRequest(int communityId, string[] ids, int accountId)
        {
            return _approveRequestData.ApproveFamilyMigrationRequest(communityId, ids, accountId);
        }

        public int DenyFamilyMigrationRequest(int id)
        {
            return _approveRequestData.DenyFamilyMigrationRequest(id);
        }

        public int CancelFamilyMigrationRequestSending(int id)
        {
            return _approveRequestData.CancelFamilyMigrationRequestSending(id);
        }

        public IEnumerable<IConvertible[]> GetOrderedFamilyMigrationRequestByParamsAndPaging(int id, string searchValue, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data

            IEnumerable<FamilyMigrationRequest> familyMigrationRequests = _approveRequestData.GetFamilyMigrationRequestByParishId(id);

            IEnumerable<FamilyMigrationRequest> filteredListItems;

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = familyMigrationRequests.Where(c => (c.Family.Name.Trim().ToLower().Contains(searchValue) ||
                                                      (string.Concat(c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ",
                                                      c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name).Trim().ToLower().Contains(searchValue))));
            }
            else
            {
                filteredListItems = familyMigrationRequests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.Name) : filteredListItems.OrderByDescending(p => p.Family.Name);
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (string.Concat(p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name))) :
                    filteredListItems.OrderByDescending(p => (string.Concat(p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name)));
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.FamilyMembers.Count) : filteredListItems.OrderByDescending(p => p.Family.FamilyMembers.Count);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.Phone) : filteredListItems.OrderByDescending(p => p.Family.Phone);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.Community.Parish.Name) : filteredListItems.OrderByDescending(p => p.Family.Community.Parish.Name);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.FamilyId,
                           c.Id,
                           c.Family.Name,
                           string.Concat(c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name),
                           c.Family.FamilyMembers.Count(f => f.Status == (int) FamilyMemberStatusEnum.Main && f.Parishioner.Status != (int)ParishionerStatusEnum.Deleted),
                           c.Family.Phone,
                           c.Family.Community.Parish.Name,
                           c.CreatedDate.ToString("dd/MM/yyyy"),
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public IEnumerable<IConvertible[]> GetOrderedFamilyMigrationSendingRequestByParamsAndPaging(int id, string searchValue, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data

            IEnumerable<FamilyMigrationRequest> familyMigrationRequests = _approveRequestData.GetFamilyrMigrationRequestSendingByParishId(id);

            IEnumerable<FamilyMigrationRequest> filteredListItems;

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = familyMigrationRequests.Where(c => (c.Family.Name.Trim().ToLower().Contains(searchValue) ||
                                                      (string.Concat(c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ",
                                                      c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name).Trim().ToLower().Contains(searchValue))));
            }
            else
            {
                filteredListItems = familyMigrationRequests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.Name) : filteredListItems.OrderByDescending(p => p.Family.Name);
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (string.Concat(p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name))) :
                    filteredListItems.OrderByDescending(p => (string.Concat(p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name)));
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.FamilyMembers.Count) : filteredListItems.OrderByDescending(p => p.Family.FamilyMembers.Count);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.Phone) : filteredListItems.OrderByDescending(p => p.Family.Phone);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Family.Community.Parish.Name) : filteredListItems.OrderByDescending(p => p.Family.Community.Parish.Name);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.FamilyId,
                           c.Id,
                           c.Family.Name,
                           string.Concat(c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", c.Family.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name),
                           c.Family.FamilyMembers.Count(f => f.Status == (int) FamilyMemberStatusEnum.Main && f.Parishioner.Status != (int)ParishionerStatusEnum.Deleted),
                           c.Family.Phone,
                           c.Parish.Name,
                           c.CreatedDate.ToString("dd/MM/yyyy"),
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        //-----------------------------------------------------------------------------------------------
        //count request
        public int CountAll(int id, out int parishionerSendingRequest, out int familyReceivingRequest,
            out int familySendingRequest)
        {
            return _approveRequestData.CountAll(id, out parishionerSendingRequest, out familyReceivingRequest, out familySendingRequest);
        }
    }
}
