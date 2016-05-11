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
    public class ParishionerBusiness
    {
        private readonly ParishionerData _parishionerData;
        private readonly SocietyData _societyData;
        private readonly DoctrineCourseData _doctrineCourseData;

        public ParishionerBusiness(string connection)
        {
            _parishionerData = new ParishionerData(connection);
            _societyData = new SocietyData(connection);
            _doctrineCourseData = new DoctrineCourseData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedParishionersByParamsAndPaging(int parishId, int communityId, int parishDivisionId, int sacramentType,
                            bool isCounted, int status, string searchValue, int deadParishioner, int changeParishParishioner, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<Parishioner> parishioners;
            const int gender = -1;

            if (parishDivisionId != 0 && sacramentType == (int)SacramentEnum.All)
            {
                parishioners = _parishionerData.GetParishionersByParishDivisionId(parishDivisionId, isCounted, status,
                    gender);
            }
            else if (parishDivisionId != 0 && sacramentType != (int)SacramentEnum.All)
            {
                parishioners = _parishionerData.GetParishionersBySacramentTypeAndParishDivisionId(parishDivisionId,
                    sacramentType, isCounted, status);
            }
            else if (communityId == 0 && sacramentType == (int)SacramentEnum.All)
            {
                parishioners = _parishionerData.GetParishionersByParishId(parishId, isCounted, status, gender);
            }
            else if (communityId == 0 && sacramentType != (int)SacramentEnum.All)
            {
                parishioners = _parishionerData.GetParishionersBySacramentTypeAndParishId(parishId, sacramentType,
                    isCounted, status);
            }
            else if (communityId != 0 && sacramentType == (int)SacramentEnum.All)
            {
                parishioners = _parishionerData.GetParishionersByCommunityId(communityId, isCounted, status, gender);
            }
            else
            {
                parishioners = _parishionerData.GetParishionersBySacramentTypeAndCommunityId(communityId, sacramentType,
                    isCounted, status);
            }

            IEnumerable<Parishioner> filteredListItems = parishioners;

            if (deadParishioner == 1)
            {
                filteredListItems = filteredListItems.Where(c => (c.IsDead && c.Status != (int)ParishionerStatusEnum.Deleted));
            }

            if (changeParishParishioner == 1)
            {
                filteredListItems =
                    filteredListItems.Where(
                        c => ((c.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish
                              || c.ParishionerMigrationRequests.Any(p => p.Community.ParishId == parishId)) && c.Status != (int)ParishionerStatusEnum.Deleted));
            }

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = filteredListItems.Where(c => (c.Code.Trim().ToLower().Contains(searchValue) ||
                                                      (string.Concat(c.ChristianName, " ", c.Name).Trim().ToLower().Contains(searchValue))));
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

            IEnumerable<Parishioner> displayedList;

            if (displayLength != -1)
            {
                displayedList = list.Skip(displayStart).Take(displayLength);
            }
            else
            {
                displayedList = list;
            }

            var conveter = new DateConverter();
            IEnumerable<IConvertible[]> result;

            if (status != (int)ParishionerStatusEnum.Saved)
            {
                result = from c in displayedList
                         select new IConvertible[]
                           {
                               c.Id,
                               c.Id,
                               c.Code,
                               c.ChristianName,
                               c.Name,
                               c.Gender == 0 ? "Nữ" : "Nam",
                               conveter.ConvertStringToDate(c.BirthDate),
                               (c.Community.ParentId != null) ? c.Community.Name : "",
                               (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                               c.Id
                           };
            }
            else
            {
                int outside = 0;
                int approved = 0;
                ParishionerMigrationRequest request;

                result = from c in displayedList
                         select new IConvertible[]
                           {
                               (request = c.ParishionerMigrationRequests.FirstOrDefault(pmr => pmr.Community.ParishId == parishId)) != null ?
                               (approved = (c.Community.ParishId == parishId) ? -1 : -2) : 0,
                               c.Id,
                               c.Code,
                               c.ChristianName,
                               c.Name,
                               c.Gender == 0 ? "Nữ" : "Nam",
                               conveter.ConvertStringToDate(c.BirthDate),
                               (request == null || approved == -1) ? ((c.Community.ParentId != null) ? c.Community.Name : "")
                               : ((request.Community.ParentId != null) ? request.Community.Name : ""),
                               (request == null || approved == -1) ? ((c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name)
                               : ((request.Community.ParentId != null) ? request.Community.Community1.Name : request.Community.Name)  ,
                               c.Id
                           };
            }

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }
		
		//get all parishioner
        public IEnumerable<Parishioner> GetAllParishioner()
        {
            return _parishionerData.GetAllParishioner();
        }
		

        public int AddParishioner(Parishioner parishioner)
        {
            return _parishionerData.AddParishioner(parishioner);
        }

        public int UpdateParishioner(Parishioner parishioner)
        {
            return _parishionerData.UpdateParishioner(parishioner);
        }

        public string LoadParishionerCode(int parishId, string prefix, int characterNumber)
        {
            return _parishionerData.LoadParishionerCode(parishId, prefix, characterNumber);
        }

        public IEnumerable<IConvertible[]> GetOrderedParishionersByParamsAndPaging(int notSacramentType, int filterMatrimony, int dioceseId, int vicariateId, int parishId, int communityId, int parishDivisionId, string searchValue,
            int gender, string sacramentDate, int familyId, int societyId, int classGroupId, int classId,
            int sortColumnIndex, string sortDirection, int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {

            IEnumerable<Parishioner> parishioners;
            const int status = (int)ParishionerStatusEnum.Available;

            if (notSacramentType == 0)
            {
                if (parishDivisionId != 0)
                {
                    parishioners = _parishionerData.GetParishionersByParishDivisionId(parishDivisionId, null,
                        status,
                        gender);
                }
                else
                {
                    if (communityId != 0)
                    {
                        parishioners = _parishionerData.GetParishionersByCommunityId(communityId, null, status,
                            gender);

                    }
                    else
                    {
                        if (parishId != 0)
                        {
                            parishioners = _parishionerData.GetParishionersByParishId(parishId, null, status,
                                gender);
                        }
                        else
                        {
                            if (vicariateId != 0)
                            {
                                parishioners = _parishionerData.GetParishionersByVicariateId(vicariateId, null,
                                    status, gender);
                            }
                            else
                            {
                                parishioners = _parishionerData.GetParishionersByDioceseId(dioceseId, null, status,
                                    gender);
                            }
                        }
                    }
                }
            }
            else
            {
                if (parishDivisionId != 0)
                {
                    parishioners = _parishionerData.GetNotSacramentParishionersByParishDivisionId(notSacramentType, parishDivisionId, null,
                        status,
                        gender);
                }
                else
                {
                    if (communityId != 0)
                    {
                        parishioners = _parishionerData.GetNotSacramentParishionersByCommunityId(notSacramentType, communityId, null, status,
                            gender);

                    }
                    else
                    {
                        parishioners = _parishionerData.GetNotSacramentParishionersByParishId(notSacramentType, parishId, null, status,
                            gender);
                    }
                }
            }

            if (filterMatrimony != 0)
            {
                if (gender == 0)
                {
                    parishioners =
                    parishioners.Where(
                       p =>
                           ((p.IsSingle) || (p.Matrimonies1.Any() ? (p.Matrimonies1.Count(m => (m.Status != (int)MatrimonyStatusEnum.Removed
                                    && !m.Parishioner.IsDead && m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted)) == 0) : (p.IsSingle))));
                }
                else if (gender == 1)
                {
                    parishioners =
                    parishioners.Where(
                        p =>
                            ((p.IsSingle) || (p.Matrimonies.Any() ? (p.Matrimonies.Count(m => (m.Status != (int)MatrimonyStatusEnum.Removed
                                && !m.Parishioner1.IsDead && m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted)) == 0) : (p.IsSingle))));
                }

            }

            var conveter = new DateConverter();

            if (!string.IsNullOrEmpty(sacramentDate))
            {
                Sacrament b;
                Sacrament h;
                Sacrament c;
                var date = conveter.ConvertDateToString(sacramentDate);

                if (notSacramentType == (int)SacramentEnum.Baptism)
                {
                    parishioners =
                        parishioners.Where(p => ((string.IsNullOrEmpty(p.BirthDate.Trim()) || string.Compare(p.BirthDate, date) < 1)
                            && (string.IsNullOrEmpty((h = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.HolyCommunion)) != null ? h.Date.Trim() : "") || string.Compare(date, h.Date) < 1)
                            && (string.IsNullOrEmpty((c = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Confirmation)) != null ? c.Date.Trim() : "") || string.Compare(date, c.Date) < 1)));
                }
                else if (notSacramentType == (int)SacramentEnum.HolyCommunion)
                {
                    parishioners =
                        parishioners.Where(p => ((string.IsNullOrEmpty(p.BirthDate.Trim()) || string.Compare(p.BirthDate, date) < 1)
                            && (string.IsNullOrEmpty((b = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism)) != null ? b.Date.Trim() : "") || string.Compare(b.Date, date) < 1)
                            && (string.IsNullOrEmpty((c = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Confirmation)) != null ? c.Date.Trim() : "") || string.Compare(date, c.Date) < 1)));
                }
                else if (notSacramentType == (int)SacramentEnum.Confirmation)
                {
                    parishioners =
                        parishioners.Where(p => ((string.IsNullOrEmpty(p.BirthDate.Trim()) || string.Compare(p.BirthDate, date) < 1)
                            && (string.IsNullOrEmpty((b = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism)) != null ? b.Date.Trim() : "") || string.Compare(b.Date, date) < 1)
                            && (string.IsNullOrEmpty((h = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.HolyCommunion)) != null ? h.Date.Trim() : "") || string.Compare(h.Date, date) < 1)));
                }
            }

            //Khong hien thi ra chu ho cua gia dinh
            if (familyId != 0)
            {
                parishioners =
                    parishioners.Where(p => (p.FamilyMembers.FirstOrDefault(fm => ((fm.FamilyId == familyId && fm.Status == (int)FamilyMemberStatusEnum.Main)
                        || (fm.IsHouseholder && fm.Status == (int)FamilyMemberStatusEnum.Main))) == null));
            }

            if (societyId != 0)
            {
                //Lay them society ra nua
                var society = _societyData.GetSocietyBySocietyId(societyId);

                if (society != null)
                {
                    parishioners =
                        parishioners.Where(p => ((p.SocietyMembers.FirstOrDefault(sm => sm.SocietyId == societyId) == null) && (!society.ManagedBy.HasValue || p.Id != society.ManagedBy)));
                }
            }

            if (classGroupId != 0)
            {
                //Lay clasgroup ra nua
                var classGroup = _doctrineCourseData.GetClassGroupById(classGroupId);

                if (classGroup != null)
                {
                    parishioners =
                        parishioners.Where(p => (!classGroup.ManagedBy.HasValue || p.Id != classGroup.ManagedBy));
                }
            }

            if (classId != 0)
            {
                parishioners =
                 parishioners.Where(p => (p.ClassMembers.FirstOrDefault(cm => cm.ClassId == classId) == null));
            }

            IEnumerable<Parishioner> filteredListItems;
            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = parishioners.Where(c => ((string.Concat(c.ChristianName, " ", c.Name).Trim().ToLower().Contains(searchValue)) ||
                                                       c.Code.Trim().ToLower().Contains(searchValue)));
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

            //var result = from c in displayedList
            //             select new IConvertible[]
            //           {
            //               c.Id,                          
            //               c.Code,
            //               c.ChristianName + " " + c.Name,
            //               c.Gender == 0 ? "Nữ" : "Nam",
            //               conveter.ConvertStringToDate(c.BirthDate),
            //               c.FatherName,
            //               c.MotherName,
            //               c.Community.Name,
            //               c.Id
            //           };

            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Code,
                           c.ChristianName,
                           c.Name,
                           c.Gender == 0 ? "Nữ" : "Nam",
                           conveter.ConvertStringToDate(c.BirthDate),
                           c.Community.Name,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }

        public int CheckParishionerCode(string code, int parishId)
        {
            return _parishionerData.CheckParishionerCode(code, parishId);
        }

        public int ChangeParishionerStatus(int id, int status, string username, bool isForced)
        {
            return _parishionerData.ChangeParishionerStatus(id, status, username, isForced);
        }

        public Parishioner LoadParishionerById(int id)
        {
            var parishioner = _parishionerData.LoadParishionerById(id);

            if (parishioner == null)
            {
                return null;
            }

            var converter = new DateConverter();

            parishioner.BirthDate = converter.ConvertStringToDate(parishioner.BirthDate);
            parishioner.DeadDate = converter.ConvertStringToDate(parishioner.DeadDate);

            return parishioner;
        }

        public List<Parishioner> LoadInsideParishioners(int parishId, string name, int gender)
        {
            const bool isCounted = true;
            const int status = (int)ParishionerStatusEnum.Available;

            var parishioners = _parishionerData.GetInsideParishionersByName(parishId, name, gender, isCounted, status).OrderBy(p => p.ChristianName).ThenBy(p => p.Name).ToList();

            DateConverter converter = new DateConverter();

            foreach (var item in parishioners)
            {
                item.BirthDate = converter.ConvertStringToDate(item.BirthDate);
            }

            return parishioners;
        }

        public int ChangeParishionerGender(int parishionerId, int gender, string username)
        {
            return _parishionerData.ChangeParishionerGender(parishionerId, gender, username);
        }

        public int ChangeParishionerMarriedStatus(int parishionerId, bool isMarried, string username)
        {
            return _parishionerData.ChangeParishionerMarriedStatus(parishionerId, isMarried, username);
        }

        public string CheckValidMatrimony(int parishionerId, int parishId)
        {
            return _parishionerData.CheckValidMatrimony(parishionerId, parishId);
        }

        public string GetCodeByParishionerId(int id)
        {
            return _parishionerData.GetCodeByParishionerId(id);
        }

        public List<ParishionerSacramentViewModel> PrintSacrament(int parishId, string[] ids, int type)
        {
            return _parishionerData.PrintSacrament(parishId, ids, type);
        }

        public List<ParishionerSacramentViewModel> PrintMatrimony(int parishId, string[] ids)
        {
            return _parishionerData.PrintMatrimony(parishId, ids);
        }

        public IEnumerable<Parishioner> SearchParishionerByKeyword(string keyword, int start = 0, int length = 10)
        {
            return _parishionerData.SearchParishionersByKeyword(keyword, start, length);
        }

        public IEnumerable<IConvertible[]> GetOrderedCheckingParishionersByParamsAndPaging(int parishId, int communityId, int parishDivisionId,
                            bool noBirthDate, bool wrongDate, bool earlyCommunion, bool manyMatrimony,
                            bool enoughMatrimony, bool noMatrimonyDate, bool noFamily, bool manyFamily,
                            string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load data
            IEnumerable<Parishioner> parishioners;
            const int gender = -1;
            const int status = (int)ParishionerStatusEnum.AvailableAndSaved;

            if (parishDivisionId != 0)
            {
                parishioners = _parishionerData.GetCheckingParishionersByParishDivisionId(parishDivisionId, null, status,
                    gender);
            }
            else if (communityId != 0)
            {
                parishioners = _parishionerData.GetCheckingParishionersByCommunityId(communityId, null, status, gender);
            }
            else
            {
                parishioners = _parishionerData.GetCheckingParishionersByParishId(parishId, null, status, gender);
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

            var checkedList = new List<CheckingParishionerViewModel>();

            //Kiem tra du lieu
            foreach (var item in filteredListItems.ToList())
            {
                string error = _parishionerData.GetErrorByParishionerId(item.Id, noBirthDate, wrongDate, earlyCommunion, manyMatrimony,
                            enoughMatrimony, noMatrimonyDate, noFamily, manyFamily);

                //Neu co loi moi thuc hien add vao list khong thi thoi
                if (!string.IsNullOrEmpty(error))
                {
                    var clone = new CheckingParishionerViewModel()
                    {
                        Id = item.Id,
                        BirthDate = item.BirthDate,
                        ChristianName = item.ChristianName,
                        Code = item.Code,
                        Community = item.Community,
                        Gender = item.Gender,
                        Name = item.Name,
                        Error = error,
                        Status = item.Status,
                    };

                    checkedList.Add(clone);
                }

            }

            IEnumerable<CheckingParishionerViewModel> sortedList;
            //Sort
            if (sortColumnIndex == 3)
            {
                sortedList = sortDirection == "asc" ? checkedList.OrderBy(p => p.Code) : checkedList.OrderByDescending(p => p.Code);
            }
            else if (sortColumnIndex == 4)
            {
                sortedList = sortDirection == "asc" ? checkedList.OrderBy(p => p.ChristianName) : checkedList.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 5)
            {
                sortedList = sortDirection == "asc" ? checkedList.OrderBy(p => p.Name) : checkedList.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 6)
            {
                sortedList = sortDirection == "asc" ? checkedList.OrderBy(p => p.Gender) : checkedList.OrderByDescending(p => p.Gender);
            }
            else if (sortColumnIndex == 7)
            {
                sortedList = sortDirection == "asc" ? checkedList.OrderBy(p => p.BirthDate) : checkedList.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 8)
            {
                sortedList = sortDirection == "asc" ? checkedList.OrderBy(p => p.Community.Name) : checkedList.OrderByDescending(p => p.Community.Name);
            }
            else
            {
                sortedList = checkedList.OrderByDescending(p => p.Error.Length).ThenByDescending(p => p.Id);
            }


            //Paging
            var list = sortedList.ToList();
            int records = list.Count;

            IEnumerable<CheckingParishionerViewModel> displayedList;

            if (displayLength != -1)
            {
                displayedList = list.Skip(displayStart).Take(displayLength);
            }
            else
            {
                displayedList = list;
            }

            var conveter = new DateConverter();
            IEnumerable<IConvertible[]> result = from c in displayedList
                                                 select new IConvertible[]
                       {
                           c.Status,
                           c.Id,
                           c.Error,
                           c.Code,
                           c.ChristianName,
                           c.Name,
                           c.Gender == 0 ? "Nữ" : "Nam",
                           conveter.ConvertStringToDate(c.BirthDate),
                           (c.Community.ParentId != null) ? c.Community.Name : "",
                           (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }

        //Get Parishioner Name to Auto Complete
        public List<ParishionerViewModel> getAllParishionerByName(string name)
        {
            List<ParishionerViewModel> result = _parishionerData.getAllParishionerByName(name).ToList();
            var converter = new DateConverter();
            for (int i = 0; i < result.Count; i++)
            {
                result[i].BirthDate = converter.ConvertStringToDate(result[i].BirthDate);
            }
            return result;
        }

        public string getMaxCode(string code)
        {
            return _parishionerData.getMaxCode(code).ToList()[0];
        }

        public Parishioner getParishionerById(int id)
        {
            return _parishionerData.getParishionerById(id);
        }

    }
}
