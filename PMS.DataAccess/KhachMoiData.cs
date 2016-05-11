using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class KhachMoiData
    {
        private readonly PMSDataContext _db;

        public KhachMoiData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public IEnumerable<KhachMoi> GetKhachMoi()
        {
            const string query = "select * from KhachMoi";
            return _db.ExecuteQuery<KhachMoi>(query);
        }

        //add khach moi
        public int AddKhachMoi(KhachMoi khachmoi)
        {
            try
            {
                _db.KhachMois.InsertOnSubmit(khachmoi);
                _db.SubmitChanges();
                return khachmoi.id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //delete khach moi
        public int DeleteKhachMoi(int id)
        {
            try
            {
                KhachMoi khachmoi = _db.KhachMois.SingleOrDefault(g => g.id == id);
                if (khachmoi == null)
                {
                    return 0;
                }
                _db.KhachMois.DeleteOnSubmit(khachmoi);
                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }

        }

        //load khach moi id
        public IEnumerable<KhachMoi> GetKhachMoiByKhachMoiId(int idGiayMoi)
        {
            const string query = "select * from KhachMoi where GiayMoiId = {0}";
            return _db.ExecuteQuery<KhachMoi>(query, idGiayMoi);
        }
        //get khach moi by khachmoiId
        public KhachMoi GetKhachMoiById(int id)
        {
            const string query = "SELECT * FROM KhachMoi WHERE id = {0}";
            return _db.ExecuteQuery<KhachMoi>(query, id).SingleOrDefault();
        }
        //update giay moi
        public int UpdateKhachMoi(KhachMoi khachmoi)
        {
            try
            {
                var item = _db.KhachMois.SingleOrDefault(d => d.id == khachmoi.id);
                if (item == null)
                {
                    return 0;
                }

                item.HoTen = khachmoi.HoTen;
                item.ChucDanh = khachmoi.ChucDanh;
                item.DiaChi = khachmoi.GhiChu;
                item.SoDienThoai = khachmoi.SoDienThoai;
                item.Email = khachmoi.Email;
                item.GhiChu = khachmoi.DiaChi;
                item.GiayMoiId = khachmoi.GiayMoiId;



                _db.SubmitChanges();
                return khachmoi.id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }


    }
}
