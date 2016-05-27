using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class CommunityBusiness
    {
        private readonly CommunityData _communityData;

        public CommunityBusiness(string connection)
        {
            _communityData = new CommunityData(connection);
        }

        public List<Community> GetCommunitiesByParishId(int parishId)
        {
            return _communityData.GetCommunitiesByParishId(parishId).OrderByDescending(c => c.IsDefault).ThenBy(c => c.Name).ToList();
        }

        public List<Community> GetParishDivisionsByParishId(int parishId)
        {
            return _communityData.GetParishDivisionsByParishId(parishId).OrderBy(c => c.ParentId).ThenBy(c => c.Name).ToList();
        }

        public List<Community> GetParishDivisionsByCommunityId(int communityId)
        {
            return _communityData.GetParishDivisionsByCommunityId(communityId).OrderBy(c => c.Name).ToList();
        }

        public List<Community> GetParishDivisionsByVicariateId(int vicariateId)
        {
            return _communityData.GetParishDivisionsByVicariateId(vicariateId).OrderBy(c => c.Name).ToList();
        }

        public List<Community> GetParishDivisionsByDioceseId(int dioceseId)
        {
            return _communityData.GetParishDivisionsByDioceseId(dioceseId).OrderBy(c => c.Name).ToList();
        }

        public IEnumerable<IConvertible[]> GetOrderedCommunitiesByParamsAndPaging(int parishId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Community> communities;

            communities = _communityData.GetNotDefaultCommunitiesByParishId(parishId);

            IEnumerable<Community> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = communities.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = communities;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(c => c.Name ) : filteredListItems.OrderByDescending(c => c.Name);
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
                           c.Name,
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public IEnumerable<IConvertible[]> GetOrderedDivisionByParamsAndPaging(int communityId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Community> communities;

            communities = _communityData.GetParishDivisionsByCommunityId(communityId);

            IEnumerable<Community> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = communities.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = communities;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(c => c.Name) : filteredListItems.OrderByDescending(c => c.Name);
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
                           c.Name,
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
        public Community GetCommunitiesById(int id)
        {
            return _communityData.GetCommunitiesById(id);
        }

        public int GetDefaultCommunityIdByParishId(int parishId)
        {
            return _communityData.GetDefaultCommunityIdByParishId(parishId);
        }

        public List<Community> GetNotDefaultCommunitiesByParishId(int parishId)
        {
            return _communityData.GetNotDefaultCommunitiesByParishId(parishId).OrderBy(c => c.Name).ToList();
        }

        public List<Community> GetNotDefaultCommunitiesByVicariateId(int vicariateId)
        {
            return _communityData.GetNotDefaultCommunitiesByVicariateId(vicariateId).OrderBy(c => c.Name).ToList();
        }

        public List<Community> GetNotDefaultCommunitiesByDioceseId(int dioceseId)
        {
            return _communityData.GetNotDefaultCommunitiesByDioceseId(dioceseId).OrderBy(c => c.Name).ToList();
        }

        public int AddCommunity(Community community)
        {
            return _communityData.AddCommunity(community);
        }

        public int UpdateCommunity(Community community)
        {
            return _communityData.UpdateCommunity(community);
        }

        public int UpdateDivision(Community community)
        {
            return _communityData.UpdateDivision(community);
        }

        public int DeleteCommunity(int id)
        {
            return _communityData.DeleteCommunity(id);
        }

        public int CheckUniqueCommunity(string name, int communityId, int parishId)
        {
            return _communityData.CheckUniqueCommunity(name, communityId, parishId);
        }

        public int CheckUniqueDivision(string name, int communityId, int parentId)
        {
            return _communityData.CheckUniqueDivision(name, communityId, parentId);
        }
        
        public IEnumerable<Community> getAllCommunity()
        {
            return _communityData.getAllCommunity();
        }
    }
}
