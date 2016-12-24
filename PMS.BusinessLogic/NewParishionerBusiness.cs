using PMS.DataAccess;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class NewParishionerBusiness
    {
        private readonly NewParishionerData _newParishionerData;
        private string connectionString = "";

        public NewParishionerBusiness(string connection)
        {
            _newParishionerData = new NewParishionerData(connection);
            connectionString = connection;
        }

        public List<NewParishionerViewModel> GetOrderedParishionersByParamsAndPaging(jQueryDataTableParam param, out int totalRecords, out int totalDisplayRecords,
                                                                                        string seminary, string seminaryPosition, string servedPlace, string vocationServedRole)
        {
            string searchValue = param.search["value"];
            int sortColumnIndex = Convert.ToInt32(param.order[0]["column"]);
            string sortDirection = param.order[0]["dir"];
            int displayStart = param.start;
            int displayLength = param.length;
            string orderBy = "";
            string orderDir = "";

            //get sort data
            if (param.data != null && param.data.ContainsKey("__sort") && !string.IsNullOrEmpty(param.data["__sort"]))
            {
                if (param.data["__sort"].IndexOf("|") != 0)
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

            string strCondition = "";
            int index = 0;
            if (param.data != null)
            {
                foreach (var item in param.data)
                {
                    if (item.Key != "__sort")
                    {
                        if (Tools.IsNumber(item.Value))
                        {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " = {", index, "}");
                            args.Add(item.Value);
                        }
                        else if (item.Key == "TypeCode"
                            || item.Key == "TypeName"
                             || item.Key == "Role"
                              || item.Key == "ServedPlace"
                               || item.Key == "VicariateName"
                                || item.Key == "ChristianName"
                                 || item.Key == "IsRetired")
                        {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " LIKE {", index, "}");
                            args.Add(item.Value);
                        }
                        else if (Tools.IsDate(item.Value))
                        {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " = {", index, "}");
                            args.Add(Tools.ConvertVnDateToDBString(item.Value));
                        }
                        else
                        {
                            strCondition = string.Concat(strCondition, " AND ", item.Key, " LIKE {", index, "}");
                            args.Add(string.Concat("%", item.Value, "%"));
                        }

                        index++;
                    }
                }
            }
            strCondition = string.Concat(strCondition, " AND ", "Seminary", " LIKE '", seminary, "'");
            strCondition = string.Concat(strCondition, " AND ", "Position", " LIKE '", seminaryPosition, "'");
            strCondition = string.Concat(strCondition, " AND ", "ServedPlace", " LIKE '", servedPlace, "'");
            strCondition = string.Concat(strCondition, " AND ", "RoleId", " LIKE '", vocationServedRole, "'");

            //Load Data
            IEnumerable<NewParishionerViewModel> parishioners;
            parishioners = _newParishionerData.GetParishionersByDioceseId(strCondition, args, orderBy, orderDir).ToList();


            IEnumerable<NewParishionerViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = parishioners.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = parishioners;
            }
            //Paging
            IEnumerable<NewParishionerViewModel> displayedList = null;
            var list = filteredListItems.ToList();
            int records = list.Count;
            if (displayLength > 0)
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
                displayedList.ToList()[i].BaptismDate = converter.ConvertStringToDate(displayedList.ToList()[i].BaptismDate);
                if (displayedList.ToList()[i].Age == 0) displayedList.ToList()[i].Age = null;
                if (displayedList.ToList()[i].PatronDate != null && displayedList.ToList()[i].PatronDate.Length > 2)
                {
                    displayedList.ToList()[i].PatronDate = string.Concat(displayedList.ToList()[i].PatronDate.Substring(0, 2), "/", displayedList.ToList()[i].PatronDate.Substring(2));
                }

            }
            var result = displayedList.ToList();
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }
    }
}
