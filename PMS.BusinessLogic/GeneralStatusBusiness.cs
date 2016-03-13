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
    public class GeneralStatusBusiness
    {
        private readonly GeneralStatusData _generalStatusData;

        public GeneralStatusBusiness(string connection)
        {
            _generalStatusData = new GeneralStatusData(connection);
        }

        public IEnumerable<GeneralStatus> GetStatusByKey(string key)
        {
            return _generalStatusData.GetStatusByKey(key);
        }
        public IEnumerable<GeneralStatus> GetStatusTCLM()
        {
            return _generalStatusData.GetStatusTCLM();
        }
    }
}
