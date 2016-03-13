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
    public class VaiTroBusiness
    {
        private readonly VaiTroData _vaiTroData;

        public VaiTroBusiness(string connection)
        {
            _vaiTroData = new VaiTroData(connection);
        }

        public IEnumerable<VaiTro> GetAllVaiTro()
        {
            return _vaiTroData.GetAllVaiTro();
        }
    }
}
