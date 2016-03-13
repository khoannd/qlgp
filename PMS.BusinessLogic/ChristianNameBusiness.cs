using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class ChristianNameBusiness
    {
        private readonly ChristianNameData _christianNameData;
        public ChristianNameBusiness(string connection)
        {
            _christianNameData = new ChristianNameData(connection);
        }

        public List<string> GetChristianNamesByName(string name)
        {
            return _christianNameData.GetChristianNamesByName(name).ToList();
        }

    }
}
