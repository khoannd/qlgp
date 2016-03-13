using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class PlaceData
    {
        private readonly PMSDataContext _db;

        public PlaceData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<string> GetPlacesByName(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                const string query1 = "SELECT Name FROM PlaceSuggestion " +
                                      "ORDER BY Name";
                return _db.ExecuteQuery<string>(query1);
            }

            name = name.Trim();

            const string query2 = "SELECT Name FROM PlaceSuggestion " +
                                 "WHERE Name LIKE {0} " +
                                 "ORDER BY Name";

            return _db.ExecuteQuery<string>(query2, "%" + name + "%");
        }

    }
}
