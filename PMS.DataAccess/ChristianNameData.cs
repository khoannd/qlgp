using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class ChristianNameData
    {
        private readonly PMSDataContext _db;

        public ChristianNameData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<string> GetChristianNamesByName(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                const string query1 = "SELECT Name FROM ChristianSuggestion " +
                                      "ORDER BY Name";
                return _db.ExecuteQuery<string>(query1);
            }

            name = name.Trim();

            const string query2 = "SELECT Name FROM ChristianSuggestion " +
                                 "WHERE Name LIKE {0} " +
                                 "ORDER BY Name";

            return _db.ExecuteQuery<string>(query2, "%" + name + "%");
        }

    }
}
