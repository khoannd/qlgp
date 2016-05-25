using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess;

namespace PMS.BusinessLogic
{

    public class GiayMoiBusiness
    {

        private readonly GiayMoiData _giaymoiData;

        public GiayMoiBusiness(string connection)
        {
            _giaymoiData = new GiayMoiData(connection);
        }

        public IEnumerable<IConvertible[]> GetGiayMoi(string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {

            //Load Data
            IEnumerable<GiayMoi> giaymoi;

            giaymoi = _giaymoiData.GetGiayMoi();

            IEnumerable<GiayMoi> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = giaymoi.Where(c => (c.Ten.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = giaymoi;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Loai) : filteredListItems.OrderByDescending(p => p.Loai);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.NgayMoi) : filteredListItems.OrderByDescending(p => p.NgayMoi);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.NgaySuKien) : filteredListItems.OrderByDescending(p => p.NgaySuKien);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.NguoiGoi) : filteredListItems.OrderByDescending(p => p.NguoiGoi);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            //var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Ten,
                           c.NgaySuKien,
                           c.ThoiGian,
                           c.DiaDiem,
                           c.NguoiGoi,
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int AddGiayMoi()
        {
            throw new NotImplementedException();
        }

        public int AddGiayMoi(GiayMoi giaymoi)
        {
            return _giaymoiData.AddGiayMoi(giaymoi);
        }

        public int DeleteGiayMoi(int Id)
        {
            return _giaymoiData.DeleteGiayMoi(Id);
        }
        public GiayMoi GetGiayMoitByGiayMoitId(int id)
        {
            return _giaymoiData.GetGiayMoitByGiayMoitId(id);
        }

        public int UpdateGiayMoi(GiayMoi giaymoi)
        {
            return _giaymoiData.UpdateGiayMoi(giaymoi);
        }

    }
}
