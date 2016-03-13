using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Security.Cryptography;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class SocietyBusiness
    {
        private readonly SocietyData _societyData;

        public SocietyBusiness(string connection)
        {
            _societyData = new SocietyData(connection);
        }

        //public List<Society> GetSocietyBySocietyId(int parishId)
        //{
        //    return _societyData.GetSocietyByParishId(parishId).ToList();
        //}

        //load bảng danh sách hội đoàn
        public IEnumerable<IConvertible[]> getOrderedSocietiesByParamsAndPaging(int parishId, string searchValue,int sortColumnIndex,
                                                                                string sortDirection, int displayStart, int displayLength, 
                                                                                out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Society> societies;
            societies = _societyData.GetSocietyByParishId(parishId);
            IEnumerable<Society> filterListItems;

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                filterListItems = societies.Where(s => (s.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filterListItems = societies;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(p => p.Name)
                    : filterListItems.OrderByDescending(p => p.Name);
            }
            else
            {
                
            }

            //Paging
            var list = filterListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);

            var conveter = new DateConverter();
            var result = from c in displayedList
                select new IConvertible[]
                {
                    c.Id,
                    c.Id,
                    c.Name,
                    c.ManagedBy != null ? (c.Parishioner.ChristianName + " " + c.Parishioner.Name) : "",
                    conveter.ConvertStringToDate(c.EstablishedDate),
                    c.Id
                };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        //Load bảng danh sách hội viên
        public List<SocietyMember> GetSocietyMembersBySocietyId(int societyId)
        {
            return _societyData.GetSocietyMembersBySocietyId(societyId).OrderBy(p => p.Parishioner.Name).ToList();
        }
        public Society GetSocietyBySocietyId(int id)
        {
            return _societyData.GetSocietyBySocietyId(id);
        }

        //Thêm xóa sửa hội đoàn
        public int AddSociety(Society society)
        {
            return _societyData.AddSociety(society);
        }

        public int UpdateSociety(Society society)
        {
            return _societyData.UpdateSociety(society);
        }

        public int DeleteSociety(int id)
        {
            return _societyData.DeleteSociety(id);
        }

        //Xóa sửa hội viên
        public int AddSocietyMember(SocietyMember societyMember)
        {
            return _societyData.AddSocietyMembers(societyMember);
        }
        public int EditSocietyMemberPosition(SocietyMember societyMember)
        {
            return _societyData.EditSocietyMemberPosition(societyMember);
        }
        //public int EditSocietyMemberJoinDate(SocietyMember societyMember)
        //{
        //    return _societyData.EditSocietyMemberJoinDate(societyMember);
        //}
        public int DeleteSocietyMember(int societyMemberId)
        {
            return _societyData.DeleteSocietyMember(societyMemberId);
        }


        // Valide hội đoàn
        public int CheckUniqueName(string name, int societyId, int parishId)
        {
            return  _societyData.CheckuniqueName(name, societyId, parishId);
        }

        //Validate hội viên
        public int CheckUniqueMember(int societyId, int parishionerId)
        {
            return _societyData.CheckUniqueMember(societyId, parishionerId);
        }

        //Phần tìm kiếm-----------------------------------------
        //Load bảng danh sách các hội mà giáo dân đã tham gia
        public List<Society> GetSocietiesByParishIonerId(int parishionerId)
        {
            return _societyData.GetSocietyByParishionerId(parishionerId).OrderBy(p => p.EstablishedDate).ToList();
        }
    }
}
