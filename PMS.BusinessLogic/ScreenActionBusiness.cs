using PMS.DataAccess;
using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class ScreenActionBusiness
    {
        private readonly ScreenActionData _screenActionData;
        private string connectionString = "";

        public ScreenActionBusiness(string connection)
        {
            _screenActionData = new ScreenActionData(connection);
            connectionString = connection;
        }

        public int ChangeScreenActionEnable(string Id)
        {
            return _screenActionData.ChangeScreenActionEnable(Id);
        }

        public ScreenAction GetScreenActionById(string Id)
        {
            return _screenActionData.GetScreenActionById(Id);
        }

        public int AddScreenAction(ScreenAction screenAction)
        {
            return _screenActionData.AddScreenAction(screenAction);
        }
        
        public int UpdateScreenActionName(string Id, string name)
        {
            return _screenActionData.UpdateScreenActionName(Id, name);
        }
    }
}
