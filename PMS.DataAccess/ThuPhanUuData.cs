using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class ThuPhanUuData
    {
        private readonly PMSDataContext _db;

        public ThuPhanUuData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public ThuPhanUuViewModel GetThuPhanUuById(string Id)
        {
            string query = @"select TPU.Id, concat(P.ChristianName,' ',P.Name) as NguoiMat, TPU.ChucVu,TPU.NgayMat
                    from ThuPhanUu TPU
                    left join Parishioner P on TPU.MaGiaoDan = P.Id
                    where TPU.Id={0}";
            ThuPhanUuViewModel ce = _db.ExecuteQuery<ThuPhanUuViewModel>(query,Id).SingleOrDefault();
            query = @"select NN.ThuPhanUuId, NN.NguoiNhanId, concat(P.Name,' ',P.ChristianName) as NguoiNhan
                            from ThuPhanUu_NguoiNhan NN
                            left join Parishioner P on NN.NguoiNhanId = P.Id
                            where NN.ThuPhanUuId={0}";
            ce.ThuPhanUu_NguoiNhanList = _db.ExecuteQuery<ThuPhanUu_NguoiNhanViewModel>(query, Id).ToList();
            return ce;
        }

        public List<ThuPhanUu_NguoiNhanViewModel> LoadDanhSachNguoiNhanThu(string Id)
        {
            string query = @"select NN.ThuPhanUuId, NN.NguoiNhanId, concat(P.ChristianName,' ',P.Name) as NguoiNhan
                            from ThuPhanUu_NguoiNhan NN
                            left join Parishioner P on NN.NguoiNhanId = P.Id
                            where NN.ThuPhanUuId={0}";
            List<ThuPhanUu_NguoiNhanViewModel> ce = _db.ExecuteQuery<ThuPhanUu_NguoiNhanViewModel>(query, Id).ToList();
            return ce;
        }

        public List<ThuPhanUuViewModel> GetAllThuPhanUu()
        {
            string query = @"select TPU.Id, TPU.MaGiaoDan as IdNguoiMat, concat(TPU.ChucVu, ' ', P.ChristianName,' ',P.Name) as NguoiMat, TPU.ChucVu,TPU.NgayMat
                    from ThuPhanUu TPU
                    left join Parishioner P on TPU.MaGiaoDan = P.Id";
            var lstCE = _db.ExecuteQuery<ThuPhanUuViewModel>(query, 0).ToList();
            foreach(var item in lstCE)
            {
                query = @"select NN.ThuPhanUuId, NN.NguoiNhanId, concat(P.ChristianName,' ',P.Name) as NguoiNhan
                            from ThuPhanUu_NguoiNhan NN
                            left join Parishioner P on NN.NguoiNhanId = P.Id
                            where NN.ThuPhanUuId = {0}";
                item.ThuPhanUu_NguoiNhanList = _db.ExecuteQuery<ThuPhanUu_NguoiNhanViewModel>(query, item.Id).ToList();
            }
            return lstCE;
        }

        public int AddThuPhanUu(ThuPhanUu ThuPhanUu)
        {
            try
            {
                _db.ThuPhanUus.InsertOnSubmit(ThuPhanUu);
                Parishioner pr = _db.Parishioners.SingleOrDefault(d => d.Id == ThuPhanUu.MaGiaoDan);
                pr.DeadDate = string.Format("{0:yyyyMMdd}", ThuPhanUu.NgayMat);
                pr.IsDead = true;
                _db.SubmitChanges();

                return ThuPhanUu.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int AddThuPhanUu_NguoiNhan(ThuPhanUu_NguoiNhan ThuPhanUu_NguoiNhan)
        {
            try
            {
                _db.ThuPhanUu_NguoiNhans.InsertOnSubmit(ThuPhanUu_NguoiNhan);
                _db.SubmitChanges();
                return ThuPhanUu_NguoiNhan.NguoiNhanId;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteThuPhanUu_NguoiNhan(int Id,int MaGiaoDan)
        {
            try
            {
                ThuPhanUu_NguoiNhan ThuPhanUu_NguoiNhan = _db.ThuPhanUu_NguoiNhans.SingleOrDefault(c => c.ThuPhanUuId == Id && c.NguoiNhanId == MaGiaoDan);
                _db.ThuPhanUu_NguoiNhans.DeleteOnSubmit(ThuPhanUu_NguoiNhan);
                _db.SubmitChanges();
                return ThuPhanUu_NguoiNhan.NguoiNhanId;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteThuPhanUu(int Id)
        {
            try
            {
                ThuPhanUu ThuPhanUu = _db.ThuPhanUus.SingleOrDefault(c => c.Id == Id);
                var itemSendTos = _db.ThuPhanUu_NguoiNhans.Where(d => d.ThuPhanUuId == ThuPhanUu.Id);
                _db.ThuPhanUu_NguoiNhans.DeleteAllOnSubmit(itemSendTos);
                _db.ThuPhanUus.DeleteOnSubmit(ThuPhanUu);                
                
                _db.SubmitChanges();
                return ThuPhanUu.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateThuPhanUu(ThuPhanUu ThuPhanUu)
        {
            try
            {
                var item = _db.ThuPhanUus.SingleOrDefault(d => d.Id == ThuPhanUu.Id);
                
                if (item == null)
                {
                    return 0;
                }
                item.MaGiaoDan = ThuPhanUu.MaGiaoDan;
                item.ChucVu = ThuPhanUu.ChucVu;
                item.NgayMat = ThuPhanUu.NgayMat;
                item.MauThu = ThuPhanUu.MauThu;
                Parishioner pr = _db.Parishioners.SingleOrDefault(d => d.Id == ThuPhanUu.MaGiaoDan);
                pr.DeadDate = string.Format("{0:yyyyMMdd}", ThuPhanUu.NgayMat);
                pr.IsDead = true;

                _db.SubmitChanges();
                return item.Id;
            }
            catch (Exception e)            {

                return -1;
            }
        }

        public List<ThuPhanUu_InViewModel> PrintThuPhanUuByIds(int idThuPhanUu, string Ids)
        {
            try
            {
                string query = @"select concat(TPU.ChucVu, ' ', P.ChristianName,' ',P.Name) as NguoiMat , concat(PP.ChristianName,' ',PP.Name) as NguoiNhanThu
                                from ThuPhanUu TPU
                                left join Parishioner P on TPU.MaGiaoDan = P.Id
                                left join ThuPhanUu_NguoiNhan NN on TPU.Id = NN.ThuPhanUuId
                                left join Parishioner PP on NN.NguoiNhanId = PP.Id
                                where NN.NguoiNhanId in ({0}) and TPU.Id = {1}";
                query = string.Format(query, Ids, idThuPhanUu);
                return _db.ExecuteQuery<ThuPhanUu_InViewModel>(query).ToList();
            }
            catch
            {
                return null;
            }
        }
    }
}
