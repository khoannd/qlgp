using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class MenuData
    {
        private readonly PMSDataContext _db;

        public MenuData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public Menu GetMenuById(int menuId)
        {
            const string query = "SELECT * FROM Menu WHERE Id = {0}";
            return _db.ExecuteQuery<Menu>(query, menuId).SingleOrDefault();
        }
        
        public List<Menu> GetMenus(int menuType)
        {
            const string query = "SELECT * FROM Menu WHERE MenuType = {0} ORDER BY [Position] ASC";
            return _db.ExecuteQuery<Menu>(query, menuType).ToList();
        }
        
    }
}
