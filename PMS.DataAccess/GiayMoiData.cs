using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;


namespace PMS.DataAccess
{


    public class GiayMoiData
    {
        private readonly PMSDataContext _db;
        public GiayMoiData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public IEnumerable<GiayMoi> GetGiayMoi()
        {
            const string query = "SELECT * FROM GiayMoi";
            return _db.ExecuteQuery<GiayMoi>(query);
        }


        //add giay moi data
        public int AddGiayMoi(GiayMoi giaymoi)
        {
            try
            {
                //_db.GiayMois.InsertOnSubmit(giaymoi);
                _db.GiayMois.InsertOnSubmit(giaymoi);
                _db.SubmitChanges();
                return giaymoi.Id;
            }
            catch (Exception e)
            {
                return -1;
               Console.WriteLine(e.ToString());
            }
        }
        //delete giay moi
        public int DeleteGiayMoi(int id)
        {
            try
            {
                GiayMoi giaymoi = _db.GiayMois.SingleOrDefault(g => g.Id == id);
                if (giaymoi == null)
                {
                    return 0;
                }
                _db.GiayMois.DeleteOnSubmit(giaymoi);
                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }

        }

        //load giay moi id
        public GiayMoi GetGiayMoitByGiayMoitId(int id)
        {
            const string query = "select * from GiayMoi where Id = {0}";
            return _db.ExecuteQuery<GiayMoi>(query, id).SingleOrDefault();
        }

        //update giay moi
        public int UpdateGiayMoi(GiayMoi giaymoi)
        {
            try
            {
                var item = _db.GiayMois.SingleOrDefault(d => d.Id == giaymoi.Id);
                if (item == null)
                {
                    return 0;
                }

                item.Ten = giaymoi.Ten;
                item.Loai = giaymoi.Loai;
                item.Mau = giaymoi.Mau;
                item.NgayMoi = giaymoi.NgayMoi;
                item.NgaySuKien = giaymoi.NgaySuKien;
                item.DiaDiem = giaymoi.DiaDiem;
                item.NguoiGoi = giaymoi.NguoiGoi;
                item.ThoiGian = giaymoi.ThoiGian;
                item.MauId = giaymoi.MauId;



                _db.SubmitChanges();
                return giaymoi.Id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
    }
}
