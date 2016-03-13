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
    public class StatisticBusiness
    {
        private readonly StatisticData _statisticData;
        private readonly ParishionerData _parishionerData;
        private readonly FamilyData _familyData;
        private readonly MatrimonyData _matrimonyData;
        public StatisticBusiness(string connection)
        {
             _statisticData = new StatisticData(connection);
            _parishionerData = new ParishionerData(connection);
            _familyData = new FamilyData(connection);
            _matrimonyData = new MatrimonyData(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedParishionersByParamsAndPaging(int dioceseId, int vicariateId,
            int parishId, int communityId, int parishDivisionId, int rdValue, string fromDate, string toDate, bool includeRecord,
            bool includeWithoutDate, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Parishioner> parishioners;
            const bool isCounted = true;
            int status = (int)ParishionerStatusEnum.Available;
            if (includeRecord)
            {
                status = (int)ParishionerStatusEnum.AvailableAndSaved;
            }
            if (rdValue == 5)
            {
                status = (int)ParishionerStatusEnum.Saved;
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
            var conveter = new DateConverter();
            //Search

            fromDate = conveter.ConvertDateToString(fromDate);
            toDate = conveter.ConvertDateToString(toDate);
            int iFromDate = 0;
            int iToDate = 0;
            if (!string.IsNullOrEmpty(fromDate))
            {
                iFromDate = Int32.Parse(fromDate);
            }
            if (!string.IsNullOrEmpty(toDate))
            {
                iToDate = Int32.Parse(toDate);
            }

            if (rdValue == 1)
            {
                if (!includeWithoutDate)
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (!string.IsNullOrEmpty(c.BirthDate.Trim()) && (Int32.Parse(c.BirthDate.Trim()) >= iFromDate && (Int32.Parse(c.BirthDate.Trim()) <= iToDate))));
                }
                else
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (string.IsNullOrEmpty(c.BirthDate.Trim()) || Int32.Parse(c.BirthDate.Trim()) >= iFromDate && (Int32.Parse(c.BirthDate.Trim()) <= iToDate)));
                }
                    
            }


            else if (rdValue == 5)
            {
                if (!includeWithoutDate)
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (c.IsDead && (c.DeadDate != null && (!string.IsNullOrEmpty(c.DeadDate.Trim()) && (Int32.Parse(c.DeadDate.Trim()) >= iFromDate && (Int32.Parse(c.DeadDate.Trim()) <= iToDate)) )) ));
                }
                else
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (c.IsDead && (c.DeadDate == null || (string.IsNullOrEmpty(c.DeadDate.Trim()) || Int32.Parse(c.DeadDate.Trim()) >= iFromDate && (Int32.Parse(c.DeadDate.Trim()) <= iToDate)) )  ));
                }
            }

            else if (rdValue == 7)
            {
                if (!includeWithoutDate)
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (!string.IsNullOrEmpty(c.BirthDate.Trim()) && (Int32.Parse(c.BirthDate.Trim()) <= iToDate) ));
                }
                else
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (string.IsNullOrEmpty(c.BirthDate.Trim()) || (Int32.Parse(c.BirthDate.Trim()) <= iToDate)) );
                }
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
                           c.Community.Name,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }

        public IEnumerable<IConvertible[]> GetOrderedParishionersSacramentByParamsAndPaging(int dioceseId, int vicariateId,
            int parishId, int communityId, int parishDivisionId, int rdValue, string fromDate, string toDate, bool includeRecord,
            bool includeWithoutDate, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<ParishionerViewModel> parishioners;
            const bool isCounted = true;
            
            int status = (int)ParishionerStatusEnum.Available;
            if (includeRecord)
            {
                status = (int)ParishionerStatusEnum.AvailableAndSaved;
            }
            const int gender = -1;
            int type = 0;
            if (rdValue == 2)
            {
                type = (int) SacramentEnum.Baptism;
            }
            if (rdValue == 3)
            {
                type = (int)SacramentEnum.HolyCommunion;
            }
            if (rdValue == 4)
            {
                type = (int)SacramentEnum.Confirmation;
            }
            if (rdValue == 9)
            {
                type = (int)SacramentEnum.Baptism;
            }
            if (parishDivisionId != 0)
            {
                parishioners = _parishionerData.GetParishionerViewModelsBySacramentTypeAndParishDivisionId(parishDivisionId, type ,isCounted, status,
                    gender);
            }
            else
            {
                if (communityId != 0)
                {
                    parishioners = _parishionerData.GetParishionerViewModelsBySacramentTypeAndCommunityId(communityId, type, isCounted, status, gender);

                }
                else
                {
                    if (parishId != 0)
                    {
                        parishioners = _parishionerData.GetParishionerViewModelsBySacramentTypeAndParishId(parishId, type, isCounted, status, gender);
                    }
                    else
                    {
                        if (vicariateId != 0)
                        {
                            parishioners = _parishionerData.GetParishionerViewModelsBySacramentTypeAndVicairateId(vicariateId, type, isCounted, status, gender);
                        }
                        else
                        {
                            parishioners = _parishionerData.GetParishionerViewModelsBySacramentTypeAndDioceseId(dioceseId, type, isCounted, status, gender);
                        }
                    }
                }
            }



            IEnumerable<ParishionerViewModel> filteredListItems;
            var conveter = new DateConverter();
            //Search

            fromDate = conveter.ConvertDateToString(fromDate);
            toDate = conveter.ConvertDateToString(toDate);
            int iFromDate = 0;
            int iToDate = 0;
            if (!string.IsNullOrEmpty(fromDate))
            {
                iFromDate = Int32.Parse(fromDate);
            }
            if (!string.IsNullOrEmpty(toDate))
            {
                iToDate = Int32.Parse(toDate);
            }
     
            
            if (rdValue == 2 || rdValue == 3 || rdValue == 4)
            {
                if (!includeWithoutDate)
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (!string.IsNullOrEmpty(c.SacramentDate.Trim()) && (Int32.Parse(c.SacramentDate.Trim()) >= iFromDate && (Int32.Parse(c.SacramentDate.Trim()) <= iToDate))));
                }
                else
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (string.IsNullOrEmpty(c.SacramentDate.Trim()) || Int32.Parse(c.SacramentDate.Trim()) >= iFromDate && (Int32.Parse(c.SacramentDate.Trim()) <= iToDate)));
                }
            }

            else
            {
                if (!includeWithoutDate)
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (c.IsCatechumen && (!string.IsNullOrEmpty(c.SacramentDate.Trim()) && (Int32.Parse(c.SacramentDate.Trim()) >= iFromDate && (Int32.Parse(c.SacramentDate.Trim()) <= iToDate)))  ));
                }
                else
                {
                    filteredListItems =
                        parishioners.Where(
                        c => (c.IsCatechumen && (string.IsNullOrEmpty(c.SacramentDate.Trim()) || Int32.Parse(c.SacramentDate.Trim()) >= iFromDate && (Int32.Parse(c.SacramentDate.Trim()) <= iToDate))));
                }
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
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CommunityName) : filteredListItems.OrderByDescending(p => p.CommunityName);
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
                           c.ChristianName,
                           c.Name,
                           c.Gender == 0 ? "Nữ" : "Nam",
                           conveter.ConvertStringToDate(c.BirthDate),                        
                           c.CommunityName,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }

        public IEnumerable<IConvertible[]> GetOrderedFamiliesByParamsAndPaging(int dioceseId, int vicariateId,
            int parishId, int communityId, int parishDivisionId, int rdValue, string fromDate, string toDate, bool includeRecord,
            bool includeWithoutDate, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Family> families;
            const bool isCounted = true;
            int status = (int)FamilyStatusEnum.Available;
            if (includeRecord)
            {
                status = (int)FamilyStatusEnum.AvailableAndSaved;
            }

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
                    if (parishId != 0)
                    {
                        families = _familyData.GetFamiliesByParishId(parishId, isCounted, status);
                    }
                    else
                    {
                        if (vicariateId != 0)
                        {
                            families = _familyData.GetFamiliesByVicariateId(vicariateId, isCounted, status);
                        }
                        else
                        {
                            families = _familyData.GetFamiliesByDioceseId(dioceseId, isCounted, status);
                        }
                    }
                }
            }


            //IEnumerable<Family> filteredListItems;
            //var conveter = new DateConverter();

            //Statistic

            //fromDate = conveter.ConvertDateToString(fromDate);
            //toDate = conveter.ConvertDateToString(toDate);
            //int iFromDate = 0;
            //int iToDate = 0;
            //if (!string.IsNullOrEmpty(fromDate))
            //{
            //    iFromDate = Int32.Parse(fromDate);
            //}
            //if (!string.IsNullOrEmpty(toDate))
            //{
            //    iToDate = Int32.Parse(toDate);
            //}

            //if (rdValue == 8)
            //{
            //    if (!includeWithoutDate)
            //    {
            //        filteredListItems =
            //            families.Where(
            //            c => (!string.IsNullOrEmpty(c.BirthDate.Trim()) && (Int32.Parse(c.BirthDate.Trim()) >= iFromDate && (Int32.Parse(c.BirthDate.Trim()) <= iToDate))));
            //    }
            //    else
            //    {
            //        filteredListItems =
            //            parishioners.Where(
            //            c => (string.IsNullOrEmpty(c.BirthDate.Trim()) || Int32.Parse(c.BirthDate.Trim()) >= iFromDate && (Int32.Parse(c.BirthDate.Trim()) <= iToDate)));
            //    }

            //}

            ////else
            ////{
            //filteredListItems = families;
            ////}


            //Sort
            if (sortColumnIndex == 2)
            {
                families = sortDirection == "asc" ? families.OrderBy(p => p.Code) : families.OrderByDescending(p => p.Code);
            }
            else if (sortColumnIndex == 3)
            {
                families = sortDirection == "asc" ? families.OrderBy(p => p.Name) : families.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                families = sortDirection == "asc" ? families.OrderBy(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name))) :
                    families.OrderByDescending(p => (string.Concat(p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.ChristianName, " ", p.FamilyMembers.Single(fm => fm.IsHouseholder).Parishioner.Name)));
            }
            else if (sortColumnIndex == 5)
            {
                families = sortDirection == "asc" ? families.OrderBy(p => p.FamilyMembers.Count) : families.OrderByDescending(p => p.FamilyMembers.Count);
            }
            else if (sortColumnIndex == 6)
            {
                families = sortDirection == "asc" ? families.OrderBy(p => p.Phone) : families.OrderByDescending(p => p.Phone);
            }
            else if (sortColumnIndex == 7)
            {
                families = sortDirection == "asc" ? families.OrderBy(p => p.Community.Name) : families.OrderByDescending(p => p.Community.Name);
            }
            else
            {
                families = families.OrderByDescending(p => p.Id);
            }

            //Paging
            var list = families.ToList();
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
                           c.FamilyMembers.Count,
                           c.Phone,
                           (c.Community.ParentId != null) ? c.Community.Name : "",
                           (c.Community.ParentId != null) ? c.Community.Community1.Name : c.Community.Name,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }


        public IEnumerable<IConvertible[]> GetOrderedMatrimonyByParamsAndPaging(int dioceseId, int vicariateId,
            int parishId, int communityId, int parishDivisionId, int rdValue, string fromDate, string toDate, bool includeRecord,
            bool includeWithoutDate, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Matrimony> matrimonies;

            if (parishDivisionId != 0)
            {
                matrimonies = _matrimonyData.GetMatrimoniesByParishDivisionId(parishDivisionId);
            }
            else
            {
                if (communityId != 0)
                {
                    matrimonies = _matrimonyData.GetMatrimoniesByCommunityId(communityId);

                }
                else
                {
                    if (parishId != 0)
                    {
                        matrimonies = _matrimonyData.GetMatrimoniesByParishId(parishId);
                    }
                    else
                    {
                        if (vicariateId != 0)
                        {
                            matrimonies = _matrimonyData.GetMatrimoniesByVicariateId(vicariateId);
                        }
                        else
                        {
                            matrimonies = _matrimonyData.GetMatrimoniesByDioceseId(dioceseId);
                        }
                    }
                }
            }



            IEnumerable<Matrimony> filteredListItems;
            var conveter = new DateConverter();
            //Search

            fromDate = conveter.ConvertDateToString(fromDate);
            toDate = conveter.ConvertDateToString(toDate);
            int iFromDate = 0;
            int iToDate = 0;
            if (!string.IsNullOrEmpty(fromDate))
            {
                iFromDate = Int32.Parse(fromDate);
            }
            if (!string.IsNullOrEmpty(toDate))
            {
                iToDate = Int32.Parse(toDate);
            }

            if (!includeWithoutDate)
            {
                filteredListItems =
                    matrimonies.Where(
                    c => (!string.IsNullOrEmpty(c.Date.Trim()) && (Int32.Parse(c.Date.Trim()) >= iFromDate && (Int32.Parse(c.Date.Trim()) <= iToDate))));
            }
            else
            {
                filteredListItems =
                    matrimonies.Where(
                    c => (string.IsNullOrEmpty(c.Date.Trim()) || Int32.Parse(c.Date.Trim()) >= iFromDate && (Int32.Parse(c.Date.Trim()) <= iToDate)));

            }
            

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Number) : filteredListItems.OrderByDescending(p => p.Number);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner.Name) : filteredListItems.OrderByDescending(p => p.Parishioner.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parishioner1.Name) : filteredListItems.OrderByDescending(p => p.Parishioner1.Name);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Place) : filteredListItems.OrderByDescending(p => p.Place);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Date) : filteredListItems.OrderByDescending(p => p.Date);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Status) : filteredListItems.OrderByDescending(p => p.Status);
            }
            else if (sortColumnIndex == 8)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Priest) : filteredListItems.OrderByDescending(p => p.Priest);
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
                           c.Number,
                           c.Parishioner.Name,
                           c.Parishioner1.Name,
                           c.Place,                          
                           conveter.ConvertStringToDate(c.Date),                         
                           c.Status,
                           c.Priest,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }
    }

}
