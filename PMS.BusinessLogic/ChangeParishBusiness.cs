using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;

namespace PMS.BusinessLogic
{
    public class ChangeParishBusiness
    {
        private readonly ChangeParishData _changeParishData;

        public ChangeParishBusiness(string connection)
        {
            _changeParishData = new ChangeParishData(connection);
        }

        public int ChangeParishForParishioner(string[] parishioners, int toParishId, string toParishName)
        {
            return _changeParishData.ChangeParishForParishioner(parishioners, toParishId, toParishName);
        }

        public int ChangeParishForFamily(string[] families, int toParishId, string toParishName)
        {
            return _changeParishData.ChangeParishForFamily(families, toParishId, toParishName);
        }
        public int CheckOtherParish(string name, int parishId, int dioceseId)
        {
            return _changeParishData.CheckOtherParish(name, parishId, dioceseId);
        }
    }
}
