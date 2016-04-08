using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class ConstructionPermitBusiness
    {
        private readonly ConstructionPermitData _constructionPermitData;
        public ConstructionPermitBusiness(string connection)
        {
            _constructionPermitData = new ConstructionPermitData(connection);
        }
        public List<ConstructionPermitViewModel> GetDataTableByParamsAndPaging(int permitType, int permitStatus,
            string searchValue, int sortColumnIndex, string sortDirection, int displayStart, int displayLength,
            out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<ConstructionPermitViewModel> constructionPermit;

            if (permitType == 0 && permitStatus == 0)
            {
                constructionPermit = _constructionPermitData.getAllConstructionPermit();
            }
            else if (permitType != 0 && permitStatus == 0)
            {
                constructionPermit = _constructionPermitData.GetConstructionPermitByPermitType(permitType);
            }
            else if (permitType == 0 && permitStatus != 0)
            {
                constructionPermit = _constructionPermitData.GetConstructionPermitByPermitStatus(permitStatus);
            }
            else
            {
                constructionPermit = _constructionPermitData.GetConstructionPermitByPermitTypeAndPermitStatus(permitType, permitStatus);
            }



            IEnumerable<ConstructionPermitViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = constructionPermit.Where(c => (c.ParishName.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = constructionPermit;
            }

            //Sort
            if (sortColumnIndex == 1)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.TypeName) : filteredListItems.OrderByDescending(p => p.TypeName);
            }
            else if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ParishName) : filteredListItems.OrderByDescending(p => p.ParishName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Description) : filteredListItems.OrderByDescending(p => p.Description);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.FilePath) : filteredListItems.OrderByDescending(p => p.FilePath);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.StatusName) : filteredListItems.OrderByDescending(p => p.StatusName);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Note) : filteredListItems.OrderByDescending(p => p.Note);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = displayedList.ToList();
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int createConstructionPermit(ConstructionPermit constructionPermit)
        {
            return _constructionPermitData.createConstructionPermit(constructionPermit);
        }

        public ConstructionPermit GetConstructionPermitById(int id)
        {
            return _constructionPermitData.GetConstructionPermitById(id);
        }

        public int UpdateConstructionPermit(ConstructionPermit constructionPermit)
        {
            return _constructionPermitData.UpdateConstructionPermit(constructionPermit);
        }

        public int DeleteConstructionPermit(int id)
        {
            return _constructionPermitData.DeleteConstructionPermit(id);
        }

        public int UpdateFilePath(int Id, string filePath)
        {
            return _constructionPermitData.UpdateFilePath(Id, filePath);
        }
    }
}
