using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class PriestBusiness
    {
        private readonly PriestData _priestData;
        private string connectionString = "";

        public PriestBusiness(string connection)
        {
            _priestData = new PriestData(connection);
            connectionString = connection;
        }

        public List<string> GetPriestNamesByName(int dioceseId, string name)
        {
            return _priestData.GetPriestNamesByName(dioceseId, name).ToList();
        }

        public List<string> GetPriestByName(int dioceseId, string name)
        {
            return _priestData.GetPriestNamesByName(dioceseId, name).ToList();
        }

        public Priest GetPriestByPriestId(int id)
        {
            return _priestData.GetPriestByPriestId(id);
        }

        public Priest GetPriestByParishionerId(int id)
        {
            return _priestData.GetPriestByParishionerId(id);
        }

        public int AddPriest(Priest priest)
        {
            return _priestData.AddPriest(priest);
        }

        public IEnumerable<Priest> GetAllPriests()
        {
            return _priestData.GetAllPriests();
        }

        public int UpdatePriest(Priest priest)
        {
            return _priestData.UpdatePriest(priest);
        }

        public int DeletePriest(int id)
        {
            return _priestData.DeletePriest(id);
        }
        public List<PriestViewModel> GetOrderedPriestsByParamsAndPaging(jQueryDataTableParam param, out int totalRecords, out int totalDisplayRecords)
        {
            string searchValue = param.search["value"];
            int sortColumnIndex = Convert.ToInt32(param.order[0]["column"]);
            string sortDirection = param.order[0]["dir"];
            int displayStart = param.start;
            int displayLength = param.length;
            string orderBy = "";
            string orderDir = "";

            //get sort data
            if(param.data != null && param.data.ContainsKey("__sort") && !string.IsNullOrEmpty(param.data["__sort"]))
            {
                if(param.data["__sort"].IndexOf("|") != 0)
                {
                    string[] ss = param.data["__sort"].Split('|');
                    orderBy = ss[0];
                    orderDir = ss[1];
                }
                else if (param.data["__sort"].IndexOf("|") < 0)
                {
                    orderBy = param.data["__sort"];
                }
            }

            //get search parameters
            List<object> args = new List<object>();
            //args.Add(param.DioceseId.ToString());

            string strCondition = "";
            int index = 0;
            if (param.data != null) {
                foreach(var item in param.data)
                {
                    if(item.Key != "__sort")
                    {
                        if (Tools.IsNumber(item.Value))
                        {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " = {", index, "}");
                            args.Add(item.Value);
                        }
                        else if (Tools.IsDate(item.Value))
                        {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " = {", index, "}");
                            args.Add(Tools.ConvertVnDateToDBString(item.Value));
                        }
                        else {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " LIKE {", index, "}");
                            args.Add(string.Concat("", item.Value, "%"));
                        }
                        
                        index++;
                    }
                }
            }

            //Load Data
                IEnumerable<PriestViewModel> priests;
            priests = _priestData.GetPriestByDioceseId(strCondition, args, orderBy, orderDir).ToList();


            IEnumerable<PriestViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = priests.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = priests;
            }

            ////Sort
            //if (sortColumnIndex == 1)
            //{
            //    filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            //}
            //else if (sortColumnIndex == 2)
            //{
            //    filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            //}
            //else if (sortColumnIndex == 5)
            //{
            //    filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            //}
            //else if (sortColumnIndex == 6)
            //{
            //    filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
            //}

            //Paging
            IEnumerable<PriestViewModel> displayedList = null;
            var list = filteredListItems.ToList();
            int records = list.Count;
            if(displayLength > 0)
            {
                displayedList = list.Skip(displayStart).Take(displayLength);
            }
            else
            {
                displayedList = list;
            }
            var converter = new DateConverter();
            for (int i = 0; i < displayedList.ToList().Count; i++)
            {
                displayedList.ToList()[i].BirthDate = converter.ConvertStringToDate(displayedList.ToList()[i].BirthDate);
                displayedList.ToList()[i].StartDate = converter.ConvertStringToDate(displayedList.ToList()[i].StartDate);
                displayedList.ToList()[i].OrdinationDate = converter.ConvertStringToDate(displayedList.ToList()[i].OrdinationDate);
                //displayedList.ToList()[i].Age = DateConverter.CalCulateAgeInt(displayedList.ToList()[i].BirthDate);
                if (displayedList.ToList()[i].Age == 0) displayedList.ToList()[i].Age = null;
                if (displayedList.ToList()[i].PatronDate != null && displayedList.ToList()[i].PatronDate.Length > 2)
                {
                    displayedList.ToList()[i].PatronDate = string.Concat(displayedList.ToList()[i].PatronDate.Substring(0,2), "/", displayedList.ToList()[i].PatronDate.Substring(2));
                }

            }
            var result = displayedList.ToList();
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
        public IEnumerable<IConvertible[]> GetOrderedPriestsByParamsAndPagingForTCLM(int tclmId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Priest> priests;

            priests = _priestData.GetPriestForTCLM(tclmId);

            IEnumerable<Priest> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = priests.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = priests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
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
                           c.Id,
                           c.Id,
                           c.ChristianName,
                           c.Name,
                           converter.ConvertStringToDate(c.BirthDate),
                           c.Phone,
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        //VuongVM - Get Priest for HDLM Members
        public IEnumerable<IConvertible[]> GetOrderedPriestsByParamsAndPagingForHDLM(string searchValue, int sortColumnIndex, string sortDirection,
                           int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<Priest> priests;

            priests = _priestData.GetPriestForHDLM();

            IEnumerable<Priest> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = priests.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = priests;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ChristianName) : filteredListItems.OrderByDescending(p => p.ChristianName);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.BirthDate) : filteredListItems.OrderByDescending(p => p.BirthDate);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Phone) : filteredListItems.OrderByDescending(p => p.Phone);
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
                           c.Id,
                           c.ChristianName,
                           c.Name,
                           converter.ConvertStringToDate(c.BirthDate),
                           c.Phone,
                           c.Id
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public PriestViewModel GetPriestAndParishionerInfoByPriestId(int id)
        {
            return _priestData.GetPriestAndParishionerInfoByPriestId(id);
        }

        public IEnumerable<Priest> GetPriestsByName(int dioceseId, string name)
        {
            return _priestData.GetPriestsByName(dioceseId, name);
        }
        public IEnumerable<string> GetChristianList()
        {
            return _priestData.GetChristianList();
        }
        public IEnumerable<VaiTro> GetPositionList()
        {
            return _priestData.GetPositionList();
        }

    }
}
