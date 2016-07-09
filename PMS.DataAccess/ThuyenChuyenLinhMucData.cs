using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Enumerations;

namespace PMS.DataAccess
{
    public class ThuyenChuyenLinhMucData
    {
        private readonly PMSDataContext _db;

        public ThuyenChuyenLinhMucData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<ThuyenChuyenLinhMuc> GetThuyenChuyenLinhMucById(int id)
        {
            string query = "SELECT * FROM ThuyenChuyenLinhMuc ";
            if (id != 0)
            {
                query += "WHERE Id = {0}";
            }
            query += " ORDER BY NgayQuyetDinh";
            return _db.ExecuteQuery<ThuyenChuyenLinhMuc>(query, id);
        }

        public int AddThuyenChuyenLinhMuc(ThuyenChuyenLinhMuc thuyenChuyenLinhMuc)
        {
            try
            {
                _db.ThuyenChuyenLinhMucs.InsertOnSubmit(thuyenChuyenLinhMuc);
                _db.SubmitChanges();
                return thuyenChuyenLinhMuc.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateThuyenChuyenLinhMuc(ThuyenChuyenLinhMuc thuyenChuyenLinhMuc)
        {
            try
            {
                var item = _db.ThuyenChuyenLinhMucs.SingleOrDefault(d => d.Id == thuyenChuyenLinhMuc.Id);
                if (item == null)
                {
                    return 0;
                }

                //Lay ra thong tin nhung Linh muc tham gia vao dot thuyen chuyen
                var parishManagers = _db.ParishManagers.Where(s => s.Id == thuyenChuyenLinhMuc.Id);

                foreach (var parishManager in parishManagers)
                {
                    parishManager.StartDate = thuyenChuyenLinhMuc.NgayHieuLuc;
                    if (parishManager.ParishId != null && parishManager.ParishId != 0
                    && parishManager.Position == 1
                    && parishManager.StatusId == (int)ParishManagerStatusEnum.DaNhanNhiemVu)
                    {
                        var parishOld = _db.Parishes.SingleOrDefault(d => d.PriestId == parishManager.PriestId);
                        if (parishOld != null)
                        {
                            parishOld.PriestId = null;
                            parishOld.Priest = "";
                        }

                        var parish = _db.Parishes.SingleOrDefault(d => d.Id == parishManager.ParishId);
                        if (parish == null)
                        {
                            return 0;
                        }

                        parish.Priest = parishManager.Priest.ChristianName + " " + parishManager.Priest.Name;
                        parish.PriestId = parishManager.PriestId;
                    }
                }

                item.NgayQuyetDinh = thuyenChuyenLinhMuc.NgayQuyetDinh;
                item.NguoiQuyetDinh = thuyenChuyenLinhMuc.NguoiQuyetDinh;
                item.MoTa = thuyenChuyenLinhMuc.MoTa;
                item.NgayHieuLuc = thuyenChuyenLinhMuc.NgayHieuLuc;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int DeleteThuyenChuyenLinhMuc(int id)
        {
            try
            {                
                ThuyenChuyenLinhMuc thuyenChuyenLinhMuc = _db.ThuyenChuyenLinhMucs.SingleOrDefault(s => s.Id == id);
                if (thuyenChuyenLinhMuc == null)
                {                    
                    return 0;
                }
                //xoa ParishManager
                string query = "select * from ParishManager where IdThuyenChuyenLinhMuc = {0}";
                IEnumerable<ParishManager> result = _db.ExecuteQuery<ParishManager>(query, id);
                foreach (ParishManager item in result)
                {
                    _db.ParishManagers.DeleteOnSubmit(item);
                    _db.SubmitChanges();
                }

                _db.ThuyenChuyenLinhMucs.DeleteOnSubmit(thuyenChuyenLinhMuc);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int RemovePriest(int id)
        {
            try
            {
                ParishManager parishManager = _db.ParishManagers.SingleOrDefault(s => s.Id == id);
                if (parishManager == null)
                {
                    return 0;
                }

                _db.ParishManagers.DeleteOnSubmit(parishManager);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int GetNumberPriestOfTCLM(int id)
        {
            try
            {
                string query = "select * from ParishManager where IdThuyenChuyenLinhMuc = {0}";
                IEnumerable<ParishManager> result = _db.ExecuteQuery<ParishManager>(query, id);
                if (result == null)
                {
                    return -1;
                }
                int numberPriest = 0;
                foreach (ParishManager parishManager in result)
                {
                    numberPriest++;
                }
                return numberPriest;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int UpdateValue(int id, string columnName, string value)
        {
            try
            {
                ParishManager parishManager = _db.ParishManagers.SingleOrDefault(s => s.Id == id);
                if (parishManager == null)
                {
                    return 0;
                }
                if (columnName == "Position")
                {
                    if (Convert.ToInt16(value) == 1 && parishManager.ParishId != null)
                    {
                        //kiểm tra trong 1 đợt thuyên chuyển, cùng 1 giáo xứ, chỉ được 1 Chánh xứ
                        string query = @"
                                            select  count(Id)
                                            from    ParishManager
									        where	IdThuyenChuyenLinhMuc = {0}
									        and		ParishId = {1}
									        and		Position = 1
                                        ";
                        int iChanhXu = _db.ExecuteQuery<int>(query, parishManager.IdThuyenChuyenLinhMuc, parishManager.ParishId).SingleOrDefault();
                        if (iChanhXu == 0)
                        {
                            parishManager.Position = Convert.ToInt16(value);
                        }
                        else
                        {
                            return -2;
                        }
                    }
                    else
                    {
                        parishManager.Position = Convert.ToInt16(value);
                    }
                }
                else if (columnName == "ParishId")
                {
                    if (parishManager.Position != null && parishManager.Position == 1)
                    {
                        //kiểm tra trong 1 đợt thuyên chuyển, cùng 1 giáo xứ, chỉ được 1 Chánh xứ
                        string query = @"
                                            select  count(Id)
                                            from    ParishManager
									        where	IdThuyenChuyenLinhMuc = {0}
									        and		ParishId = {1}
									        and		Position = 1
                                        ";
                        int iChanhXu = _db.ExecuteQuery<int>(query, parishManager.IdThuyenChuyenLinhMuc, value).SingleOrDefault();
                        if (iChanhXu == 0)
                        {
                            parishManager.ParishId = Convert.ToInt16(value);
                        }
                        else
                        {
                            return -3;
                        }
                    }
                    else
                    {
                        parishManager.ParishId = Convert.ToInt16(value);
                    }
                }
                else if (columnName == "StatusId")
                {
                    parishManager.StatusId = Convert.ToInt16(value);
                    if (parishManager.StatusId == 3)
                    {
                        parishManager.TakenDate = DateTime.Now;
                    }
                }

                if (parishManager.ParishId != null && parishManager.ParishId != 0
                    && parishManager.Position == 1
                    && parishManager.StatusId == (int)ParishManagerStatusEnum.DaNhanNhiemVu)
                {
                    var parishOld = _db.Parishes.SingleOrDefault(d => d.PriestId == parishManager.PriestId && d.Id != parishManager.ParishId);
                    if (parishOld != null)
                    {
                        parishOld.PriestId = null;
                        parishOld.Priest = "";
                    }

                    var parish = _db.Parishes.SingleOrDefault(d => d.Id == parishManager.ParishId);
                    if (parish == null)
                    {
                        return 0;
                    }

                    parish.Priest = parishManager.Priest.ChristianName + " " + parishManager.Priest.Name;
                    parish.PriestId = parishManager.PriestId;
                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
    }
}
