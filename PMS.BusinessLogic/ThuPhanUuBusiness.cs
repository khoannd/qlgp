using System;
using System.Collections.Generic;
using System.Linq;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class ThuPhanUuBusiness
    {
        private readonly ThuPhanUuData _thuPhanUuData;

        public ThuPhanUuBusiness(string connection)
        {
            _thuPhanUuData = new ThuPhanUuData(connection);
        }

        public ThuPhanUuViewModel GetThuPhanUuById(string Id)
        {
            return _thuPhanUuData.GetThuPhanUuById(Id);
        }

        public List<ThuPhanUuViewModel> GetAllThuPhanUu()
        {
            return _thuPhanUuData.GetAllThuPhanUu();
        }

        public IEnumerable<IConvertible[]> GetOrderedThuPhanUuByParamsAndPaging(int id,
            string searchValue, int sortColumnIndex, string sortDirection,
            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            List<ThuPhanUuViewModel> thuPhanUuList;

            thuPhanUuList = _thuPhanUuData.GetAllThuPhanUu();

            IEnumerable<ThuPhanUuViewModel> filteredListItems;

            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = thuPhanUuList.Where(c => (c.NguoiMat.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = thuPhanUuList;
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
                           c.NguoiMat,
                           string.Format("{0:dd/MM/yyyy}", c.NgayMat),
                           c.ThuPhanUu_NguoiNhanList.Count,                                                      
                           string.Concat(c.Id,"-", c.IdNguoiMat ,"-",c.ChucVu)
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public IEnumerable<IConvertible[]> LoadDanhSachNguoiNhanThu(string Id)
        {
            //Load Data
            List<ThuPhanUu_NguoiNhanViewModel> thuPhanUuList;

            thuPhanUuList = _thuPhanUuData.LoadDanhSachNguoiNhanThu(Id);

            //IEnumerable<ThuPhanUu_NguoiNhanViewModel> filteredListItems;

            var displayedList = thuPhanUuList;

            //Paging
            //var list = filteredListItems.ToList();
            //int records = list.Count;
            //var displayedList = list.Skip(displayStart).Take(displayLength);
            var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.NguoiNhanId,
                           c.NguoiNhanId,
                           c.NguoiNhan,
                           c.NguoiNhanId,                           
                       };

            return result;
            //return _thuPhanUuData.LoadDanhSachNguoiNhanThu(Id);
        }

        public int AddThuPhanUu(ThuPhanUu condolencesEmail)
        {
            return _thuPhanUuData.AddThuPhanUu(condolencesEmail);
        }

        public int AddThuPhanUu_NguoiNhan(ThuPhanUu_NguoiNhan condolencesEmailSendTo)
        {
            return _thuPhanUuData.AddThuPhanUu_NguoiNhan(condolencesEmailSendTo);
        }

        public int DeleteThuPhanUu_NguoiNhan(int IdThuPhanUu, int MaGiaoDan)
        {
            return _thuPhanUuData.DeleteThuPhanUu_NguoiNhan(IdThuPhanUu, MaGiaoDan);
        }

        public int DeleteThuPhanUu(int Id)
        {
            return _thuPhanUuData.DeleteThuPhanUu(Id);
        }

        public int UpdateThuPhanUu(ThuPhanUu thuPhanUu)
        {
            return _thuPhanUuData.UpdateThuPhanUu(thuPhanUu);
        }

        public List<ThuPhanUu_InViewModel> PrintThuPhanUuByIds(int idThuPhanUu, string Ids)
        {
            return _thuPhanUuData.PrintThuPhanUuByIds(idThuPhanUu, Ids);
        }
    }
}
