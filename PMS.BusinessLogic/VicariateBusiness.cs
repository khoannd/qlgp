using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class VicariateBusiness
    {
        private readonly VicariateData _vicariateData;

        public VicariateBusiness(string connection)
        {
            _vicariateData = new VicariateData(connection);
        }

        public List<Vicariate> GetVicariatesByDioceseId(int dioceseId)
        {
            return _vicariateData.GetVicariateByDioceseId(dioceseId).OrderBy(c => c.Name).ToList();
        }
        
        public IEnumerable<IConvertible[]> GetOrderedVicariatesByParamsAndPaging(int dioceseId, string searchValue, int sortColumnIndex
                                                                                    , string sortDirection, int displayStart, int displayLength
                                                                                    , out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Vicariate> vicariates;
            vicariates = _vicariateData.GetVicariateByDioceseId(dioceseId);
            IEnumerable<Vicariate> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                filteredListItems = vicariates.Where(c => (c.Name.ToLower().Contains(searchValue.ToLower())));
            }
            else
            {
                filteredListItems = vicariates;
            }
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else
            {
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
                           c.Name,
                           c.ParishId == null ? " " : c.Parish.Name,                          
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        // Load Parish ra DropDownList
        public List<Parish> GetParishesForVicariate(int dioceseId, int vicariateId)
        {
            return _vicariateData.GetParishesForVicariate(dioceseId, vicariateId).OrderBy(c => c.Name).ToList();
        }
        public Vicariate GetVicariateByVicariateId(int id)
        {
            return _vicariateData.GetVicariateByVicariateId(id);
        }


        // Thêm xóa sửa giáo hạt
        public int AddVicariate(Vicariate vicariate)
        {
            return _vicariateData.AddVicariate(vicariate);
        }

        public Vicariate GetVicariatesByVicariateId(int id)
        {
            return _vicariateData.GetVicariateByVicariateId(id);
        }

        //Load giáo xứ = Autocomplete
        //public List<string> LoadParishByName(string name)
        //{
        //    return _vicariateData.LoadParishByName(name).ToList();
        //    ;
        //}
        public int UpdateVicariate(Vicariate vicariate)
        {
            return _vicariateData.UpdateVicariate(vicariate);
        }

        public int DeleteVicariate(int id)
        {
            return _vicariateData.DeleteVicariate(id);
        }

        //Validate giáo hạt

        public int CheckUniquevicariate(string name, int vicariateId, int dioceseId)
        {
            return _vicariateData.CheckUniqueParish(name, vicariateId, dioceseId);
        }

        public IEnumerable<Vicariate> getAllVicariate()
        {
            return _vicariateData.getAllVicariate();
        }
    }
}
