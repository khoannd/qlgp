using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;


namespace PMS.DataAccess
{
    public class SocietyData
    {
        private readonly PMSDataContext _db;

        public SocietyData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        //Load bảng danh sách hội đoàn
        public IEnumerable<Society> GetSocietyByParishId(int parishId)
        {
            const string query = "SELECT s.* " +
                                 "FROM ( Society AS s LEFT JOIN Parishioner AS pa ON s.ManagedBy = pa.Id ) " +
                                 "WHERE s.ParishId = {0} ";
            return _db.ExecuteQuery<Society>(query, parishId);
        }

        //Load bảng danh sách hội viên
        public IEnumerable<SocietyMember> GetSocietyMembersBySocietyId(int societyId)
        {
            const string query = "SELECT sm.* " +
                                 "FROM (SocietyMember AS sm INNER JOIN Society AS s ON sm.SocietyId = s.Id) " +
                                 "INNER JOIN Parishioner AS pa ON sm.ParishionerId = pa.Id " +
                                 "WHERE societyId = {0} AND pa.Status != -1 ";
            return _db.ExecuteQuery<SocietyMember>(query, societyId);
        }

        public Society GetSocietyBySocietyId(int id)
        {
            const string query = "SELECT * FROM Society WHERE Id ={0}";
            return _db.ExecuteQuery<Society>(query, id).SingleOrDefault();
        }

        //Thêm xóa sửa hội đoàn
        public int AddSociety(Society society)
        {
            try
            {
                _db.Societies.InsertOnSubmit(society);
                _db.SubmitChanges();
                return society.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int UpdateSociety(Society society)
        {
            try
            {
                var item = _db.Societies.SingleOrDefault(d => d.Id == society.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = society.Name;
                item.EstablishedDate = society.EstablishedDate;
                item.ManagedBy = society.ManagedBy;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }
        //Cập nhật chức vụ cho hội viên
        public int EditSocietyMemberPosition(SocietyMember societyMember)
        {
            try
            {
                var item = _db.SocietyMembers.SingleOrDefault(d => d.Id == societyMember.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Note = societyMember.Note;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        //Cập nhật ngày tham gia hội của hội viên
        //public int EditSocietyMemberJoinDate(SocietyMember societyMember)
        //{
        //    try
        //    {
        //        var item = _db.SocietyMembers.SingleOrDefault(d => d.Id == societyMember.Id);
        //        if (item == null)
        //        {
        //            return 0;
        //        }
        //        item.JoinDate = societyMember.JoinDate;
        //        _db.SubmitChanges();
        //        return 1;
        //    }
        //    catch (Exception e)
        //    {

        //        return -1;
        //    }
        //}

        public int DeleteSociety(int id)
        {
            try
            {
                Society society = _db.Societies.SingleOrDefault(p => p.Id == id);
                if (society == null)
                {
                    return 0;
                }
                else
                {
                    _db.Societies.DeleteOnSubmit(society);
                    _db.SubmitChanges();
                    return 1;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Xóa sửa hội viên
        public int AddSocietyMembers(SocietyMember societyMember)
        {
            try
            {
                _db.SocietyMembers.InsertOnSubmit(societyMember);
                _db.SubmitChanges();
                return societyMember.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteSocietyMember(int societyMemberId)
        {
            try
            {
                SocietyMember societyMember = _db.SocietyMembers.SingleOrDefault(sm => sm.Id == societyMemberId);
                if (societyMember == null)
                {
                    return 0;
                }
                else
                {
                    _db.SocietyMembers.DeleteOnSubmit(societyMember);
                    _db.SubmitChanges();
                    return 1;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Validate hội đoàn
        public int CheckuniqueName(string name, int societyId, int parishId)
        {
            try
            {
                name = name.Trim();
                const string query = "SELECT Name FROM Society " +
                                     "WHERE LOWER(RTRIM(LTRIM(Name))) = {0} AND Id !={1} AND ParishId={2} ";
                string unique = _db.ExecuteQuery<string>(query, name, societyId, parishId).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Validate hội viên
        public int CheckUniqueMember(int societyId, int parishionerId)
        {
            try
            {
                const string query = "SELECT Id FROM SocietyMember WHERE SocietyId = {0} AND ParishionerId = {1} ";
                int unique = _db.ExecuteQuery<int>(query, societyId, parishionerId).SingleOrDefault();
                if (unique == null || unique == 0)
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Phần tìm kiếm------------------------------
        //Load bảng danh sách các hội mà giáo dân đã tham gia 
        public IEnumerable<Society> GetSocietyByParishionerId(int parishionerId)
        {
            const string query = "SELECT s.* " +
                                 "FROM SocietyMember AS sm INNER JOIN Society AS s ON s.Id = sm.SocietyId " +
                                 "WHERE sm.ParishionerId = {0} ";
            return _db.ExecuteQuery<Society>(query, parishionerId);
        }
        
    }
}
