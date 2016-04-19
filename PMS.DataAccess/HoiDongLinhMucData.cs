using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class HoiDongLinhMucData
    {
        private readonly PMSDataContext _db;

        public HoiDongLinhMucData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<HDLMViewModel> GetAllHDLM()
        {
            const string query = @" SELECT hdlm.Name, hdlm.Id, pr.ChristianName, pr.Name AS PriestName,
                                    (SELECT COUNT(PriestID) FROM HDLMMember WHERE HdlmID = hdlm.Id) AS totalMembers
                                    FROM HoiDongLinhMuc AS hdlm
                                    LEFT JOIN 
									(SELECT * FROM HDLMMember WHERE HDLMMember.Role = 1) AS member
                                    ON hdlm.Id = member.HdlmID
                                    LEFT JOIN Priest AS pr
                                    ON member.PriestID = pr.Id ";
            return _db.ExecuteQuery<HDLMViewModel>(query);
        }

        public int AddHDLM(HoiDongLinhMuc hdlm)
        {
            try
            {
                _db.HoiDongLinhMucs.InsertOnSubmit(hdlm);
                _db.SubmitChanges();
                return hdlm.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public IEnumerable<HDLMMember> getHDLMLastRecord()
        {
            const string query = "SELECT TOP 1 Id from HoiDongLinhMuc ORDER BY Id DESC";

            return _db.ExecuteQuery<HDLMMember>(query);
        }

        public IEnumerable<HoiDongLinhMuc> getHDLMById(int id)
        {
            string query = "SELECT * FROM HoiDongLinhMuc ";
            if (id != 0)
            {
                query += "WHERE Id = {0}";
            }
            return _db.ExecuteQuery<HoiDongLinhMuc>(query, id);
        }

        public IEnumerable<HDLMMember> getHDLMMembers(int idHDLM)
        {
            const string query = "SELECT * FROM HDLMMember WHERE HdlmID = {0}";
            return _db.ExecuteQuery<HDLMMember>(query, idHDLM);
        }

        public int DeleteHDLM(int id)
        {
            try
            {
                HoiDongLinhMuc hdlm = _db.HoiDongLinhMucs.SingleOrDefault(s => s.Id == id);
                if (hdlm == null)
                {
                    return 0;
                }
                //delete hdlm members
                string query = "SELECT * FROM HDLMMember WHERE HdlmID = {0}";
                IEnumerable<HDLMMember> result = _db.ExecuteQuery<HDLMMember>(query, id);
                foreach (HDLMMember item in result)
                {
                    _db.HDLMMembers.DeleteOnSubmit(item);
                    _db.SubmitChanges();
                }

                _db.HoiDongLinhMucs.DeleteOnSubmit(hdlm);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int checkUniqueHDLM(string name, int id)
        {
            try
            {
                var item = _db.HoiDongLinhMucs.SingleOrDefault(a => a.Name.Equals(name) && a.Id != id);

                if (item == null)
                {
                    return 1;
                }

                return 0;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int RemovePriest(int id)
        {
            try
            {
                HDLMMember member = _db.HDLMMembers.SingleOrDefault(s => s.PriestID == id);
                if (member == null)
                {
                    return 0;
                }

                _db.HDLMMembers.DeleteOnSubmit(member);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateHDLM(HoiDongLinhMuc hdlm)
        {
            try
            {
                var item = _db.HoiDongLinhMucs.SingleOrDefault(d => d.Id == hdlm.Id);
                if (item == null)
                {
                    return 0;
                }

                //get all Priest in HDLM
                //var members = _db.HDLMMembers.Where(s => s.HdlmID == hdlm.Id);

                //foreach (var member in members)
                //{
                //    member.StartDate = thuyenChuyenLinhMuc.NgayHieuLuc;
                //}

                item.Name = hdlm.Name;
                item.Description = hdlm.Description;
                item.Note = hdlm.Note;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int UpdateMembers(HDLMMember member)
        {
            try
            {
                var item = _db.HDLMMembers.SingleOrDefault(d => d.PriestID == member.PriestID);
                if (item == null)
                {
                    return 0;
                }

                item.HdlmID = member.HdlmID;
                item.Role = member.Role;
                //item.ParishId = parishManager.ParishId;
                //item.PriestId = parishManager.PriestId;
                //item.StartDate = parishManager.StartDate;
                //item.EndDate = parishManager.EndDate;
                //item.Position = parishManager.Position;
                //item.PositionName = parishManager.PositionName;
                //item.IdThuyenChuyenLinhMuc = parishManager.IdThuyenChuyenLinhMuc;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateRole(int id, string columnName, string value)
        {
            try
            {
                HDLMMember member = _db.HDLMMembers.SingleOrDefault(s => s.PriestID == id);
                if (member == null)
                {
                    return 0;
                }
                if (columnName == "Position")
                {
                    if (Convert.ToInt16(value) == 1)
                    {
                        //kiểm tra trong 1 đợt thuyên chuyển, cùng 1 giáo xứ, chỉ được 1 Chánh xứ
                        string query = @"
                                            select  count(PriestID)
                                            from    HDLMMember
									        where	HdlmID = {0}
									        and		Role = 1
                                        ";
                        int iHoiTruong = _db.ExecuteQuery<int>(query, member.HdlmID, member.Role).SingleOrDefault();
                        if (iHoiTruong == 0)
                        {
                            member.Role = Convert.ToInt16(value);
                        }
                        else
                        {
                            return -2;
                        }
                    }
                    else
                    {
                        member.Role = Convert.ToInt16(value);
                    }
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
