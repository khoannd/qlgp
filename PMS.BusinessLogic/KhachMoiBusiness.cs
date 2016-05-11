using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess;

namespace PMS.BusinessLogic
{
    public class KhachMoiBusiness
    {
        private readonly KhachMoiData _khachmoiData;
        public KhachMoiBusiness(string connection)
        {
            _khachmoiData = new KhachMoiData(connection);
        }

        public List<KhachMoi> getAllKhachMoibyGiayMoiId(int id)
        {
            return _khachmoiData.GetKhachMoiByKhachMoiId(id).ToList();
        }

        public IEnumerable<IConvertible[]> GetKhachMoi(string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //load data
            IEnumerable<KhachMoi> khachmoi;

            khachmoi = _khachmoiData.GetKhachMoi();

            IEnumerable<KhachMoi> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = khachmoi.Where(c => (c.HoTen.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = khachmoi;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.HoTen) : filteredListItems.OrderByDescending(p => p.HoTen);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChucDanh) : filteredListItems.OrderByDescending(p => p.ChucDanh);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.DiaChi) : filteredListItems.OrderByDescending(p => p.DiaChi);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.SoDienThoai) : filteredListItems.OrderByDescending(p => p.SoDienThoai);
            }
            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            //var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.id,
                           c.HoTen,
                           c.ChucDanh,
                           c.DiaChi,
                           c.SoDienThoai,
                           c.Email,
                           c.GhiChu,
                           c.GiayMoiId
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
        public int AddKhachMoi()
        {
            throw new NotImplementedException();
        }

        public int AddKhachMoi(KhachMoi khachmoi)
        {
            return _khachmoiData.AddKhachMoi(khachmoi);
        }

        public int DeleteKhachMoi(int Id)
        {
            return _khachmoiData.DeleteKhachMoi(Id);
        }
        public List<KhachMoi> GetKhachMoiByGiayMoiId(int idGiayMoi)
        {
            return _khachmoiData.GetKhachMoiByKhachMoiId(idGiayMoi).ToList();
        }

       
        public int UpdateKhachMoi(KhachMoi khachmoi)
        {
            return _khachmoiData.UpdateKhachMoi(khachmoi);
        }

        public KhachMoi GetKhachMoiByKhachMoiId(int id)
        {
            return _khachmoiData.GetKhachMoiById(id);
        }
    }
}
