using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class VaiTroData
    {
        private readonly PMSDataContext _db;

        public VaiTroData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<VaiTro> GetAllVaiTro()
        {
            string query = "SELECT * FROM VaiTro";
            return _db.ExecuteQuery<VaiTro>(query, 0);
        }
    }
}
