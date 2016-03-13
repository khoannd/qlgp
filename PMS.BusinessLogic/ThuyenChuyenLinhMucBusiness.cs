using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class ThuyenChuyenLinhMucBusiness
    {
        private readonly ThuyenChuyenLinhMucData _thuyenChuyenLinhMucData;

        public ThuyenChuyenLinhMucBusiness(string connection)
        {
            _thuyenChuyenLinhMucData = new ThuyenChuyenLinhMucData(connection);
        }

        public ThuyenChuyenLinhMuc GetThuyenChuyenLinhMucById(int id)
        {
            return _thuyenChuyenLinhMucData.GetThuyenChuyenLinhMucById(id).SingleOrDefault();
        }

        public IEnumerable<IConvertible[]> GetOrderedThuyenChuyenLinhMucByParamsAndPaging(int id,
            string searchValue, int sortColumnIndex, string sortDirection,
            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<ThuyenChuyenLinhMuc> thuyenChuyenLinhMuc;

            thuyenChuyenLinhMuc = _thuyenChuyenLinhMucData.GetThuyenChuyenLinhMucById(id);

            IEnumerable<ThuyenChuyenLinhMuc> filteredListItems;

            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = thuyenChuyenLinhMuc.Where(c => (c.MoTa.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = thuyenChuyenLinhMuc;
            }

            //Sort
            //if (sortColumnIndex == 2)
            //{
            //    filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Date) : filteredListItems.OrderByDescending(p => p.Date);
            //}

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
                           converter.ConvertStringToDate(c.NgayQuyetDinh),
                           c.MoTa,
                           converter.ConvertStringToDate(c.NgayHieuLuc),
                           c.NguoiQuyetDinh,
                           c.ParishManagers.Count,
                           //getNumberPriestOfTCLMId(c.Id),                           
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int AddThuyenChuyenLinhMuc(ThuyenChuyenLinhMuc thuyenChuyenLinhMuc)
        {
            return _thuyenChuyenLinhMucData.AddThuyenChuyenLinhMuc(thuyenChuyenLinhMuc);
        }

        public int UpdateSacramentGroup(ThuyenChuyenLinhMuc thuyenChuyenLinhMuc)
        {
            return _thuyenChuyenLinhMucData.UpdateThuyenChuyenLinhMuc(thuyenChuyenLinhMuc);
        }

        public int DeleteThuyenChuyenLinhMuc(int id)
        {
            return _thuyenChuyenLinhMucData.DeleteThuyenChuyenLinhMuc(id);
        }

        //public int CheckExistedSacramentGroup(string date, int type, int parishId, int sacramentGroupId)
        //{
        //    return _thuyenChuyenLinhMucData.CheckExistedSacramentGroup(date, type, parishId, sacramentGroupId);
        //}

        public int RemovePriest(int id)
        {
            return _thuyenChuyenLinhMucData.RemovePriest(id);
        }

        private int getNumberPriestOfTCLMId(int id)
        {
            return _thuyenChuyenLinhMucData.GetNumberPriestOfTCLM(id);
        }

        public int UpdateValue(int id, string columnName, string value)
        {
            return _thuyenChuyenLinhMucData.UpdateValue(id, columnName, value);
        }
    }
}
