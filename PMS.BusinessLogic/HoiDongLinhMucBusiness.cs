using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class HoiDongLinhMucBusiness
    {
        private readonly HoiDongLinhMucData _hdlmData;
        private readonly HDLMMemberData _hdlmMemberData;
        public HoiDongLinhMucBusiness(string connection)
        {
            _hdlmData = new HoiDongLinhMucData(connection);
            _hdlmMemberData = new HDLMMemberData(connection);
        }

        public IEnumerable<IConvertible[]> LoadAllHDLM(string searchValue, int sortColumnIndex
                                                                                    , string sortDirection, int displayStart, int displayLength
                                                                                    , out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<HDLMViewModel> hdlm;
            hdlm = _hdlmData.GetAllHDLM();
            IEnumerable<HDLMViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                filteredListItems = hdlm.Where(c => (c.Name.ToLower().Contains(searchValue.ToLower())));
            }
            else
            {
                filteredListItems = hdlm;
            }
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else
            {
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Id,
                           c.Name,
                           c.ChristianName + " " + c.PriestName,
                           c.totalMembers,
                           c.Id
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        //public List<HDLMViewModel> LoadAllHDLM(string searchValue, int sortColumnIndex
        //                                                                            , string sortDirection, int displayStart, int displayLength
        //                                                                            , out int totalRecords, out int totalDisplayRecords)
        //{
        //    return _hdlmData.GetAllHDLM().ToList();
        //}


        public int AddHDLM(HoiDongLinhMuc hdlm)
        {
            return _hdlmData.AddHDLM(hdlm);
        }

        public Dictionary<string, string> getHDLMById(int id)
        {
            IEnumerable<HoiDongLinhMuc> hdlm = _hdlmData.getHDLMById(id);
            Dictionary<string, string> result = new Dictionary<string, string>();
            if (hdlm != null)
            {
                HoiDongLinhMuc obj = hdlm.FirstOrDefault();
                result.Add("name", obj.Name);
                result.Add("des", obj.Description);
                result.Add("note", obj.Note);

            }

            return result;
        }

        public List<HDLMMember> getHDLMMembers(int idHDLM)
        {
            return _hdlmData.getHDLMMembers(idHDLM).ToList();
        }

        public int DeleteHDLM(int id)
        {
            return _hdlmData.DeleteHDLM(id);
        }

        public int CheckUniqueHDLM(string name, int id)
        {
            return _hdlmData.checkUniqueHDLM(name, id);
        }

        public int RemovePriest(int id)
        {
            return _hdlmData.RemovePriest(id);
        }

        public int UpdateHDLM(HoiDongLinhMuc hdlm)
        {
            return _hdlmData.UpdateHDLM(hdlm);
        }

        public int UpdateMembers(HDLMMember member)
        {
            return _hdlmData.UpdateMembers(member);
        }

        public int UpdateRole(int id, string columnName, string value)
        {
            return _hdlmData.UpdateRole(id, columnName, value);
        }

    }
}
