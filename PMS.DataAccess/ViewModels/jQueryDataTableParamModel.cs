using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class jQueryDataTableParamModel
    {
        /// <summary>
        /// Request sequence number sent by DataTable,
        /// same value must be returned in response
        /// </summary>       
        public string sEcho { get; set; }

        /// <summary>
        /// Text used for filtering
        /// </summary>
        public string sSearch { get; set; }

        /// <summary>
        /// Number of records that should be shown in table
        /// </summary>
        public int iDisplayLength { get; set; }

        /// <summary>
        /// First record that should be shown(used for paging)
        /// </summary>
        public int iDisplayStart { get; set; }

        /// <summary>
        /// Number of columns in table
        /// </summary>
        public int iColumns { get; set; }

        /// <summary>
        /// Number of columns that are used in sorting
        /// </summary>
        public int iSortingCols { get; set; }

        /// <summary>
        /// Comma separated list of column names
        /// </summary>
        public string sColumns { get; set; }

        public int iSortCol_0 { get; set; }

        public string sSortDir_0 { get; set; }
        public string parishId { get; set; }
    }

    public class jQueryDataTableParam
    {
        /// <summary>
        /// Text used for filtering
        /// </summary>
        public Dictionary<string, string> search { get; set; }

        /// <summary>
        /// First record that should be shown(used for paging)
        /// </summary>
        public int start { get; set; }

        /// <summary>
        /// Number of records that should be shown in table
        /// </summary>
        public int length { get; set; }

        /// <summary>
        /// Column list
        /// </summary>
        public List<Dictionary<string, object>> columns { get; set; }

        /// <summary>
        /// unknown
        /// </summary>
        public int draw { get; set; }

        /// <summary>
        /// Number of columns that are used in sorting
        /// </summary>
        public List<Dictionary<string, string>> order { get; set; }

        public int? DioceseId { get; set; }
        public int? VicariateId { get; set; }
        public int? ParishId { get; set; }

        public Dictionary<string, object> data { get; set; }
    }
}
