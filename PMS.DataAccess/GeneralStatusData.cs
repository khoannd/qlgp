using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class GeneralStatusData
    {
        private readonly PMSDataContext _db;

        public GeneralStatusData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public IEnumerable<GeneralStatus> GetStatusTCLM()
        {
            string query = "SELECT * FROM GeneralStatus where [Key] = 'TCLM'";
            return _db.ExecuteQuery<GeneralStatus>(query, 0);
        }
        public IEnumerable<GeneralStatus> GetStatusByKey(string key)
        {
            string query = "SELECT * FROM GeneralStatus where [Key] = '{0}'";
            return _db.ExecuteQuery<GeneralStatus>(query, key);
        }
    }
}
