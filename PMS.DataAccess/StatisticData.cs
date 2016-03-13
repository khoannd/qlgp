using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class StatisticData
    {
        private readonly PMSDataContext _db;

        public StatisticData(string connection)
        {
            _db = new PMSDataContext(connection);
        }


    }
}
