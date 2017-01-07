using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class MenuManagementData
    {
        private readonly PMSDataContext _db;

        public MenuManagementData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<MenuManagementViewModel> GetMenus(string id)
        {
            const string query = @"SELECT m.*
FROM (
SELECT m1.Id AS Id, m1.ScreenId AS ScreenId, m1.Text AS Text
, m1.NewWindow AS NewWindow, m1.IconClass AS IconClass, m1.ParentId AS ParentId
, IIF(m1.ParentId = m2.Id, m2.Text, '') AS Parent
, m1.Position AS Position, m1.Visible AS Visible, s.Enabled , m1.MenuType AS MenuType, m1.Link AS Link
FROM Menu m1
LEFT JOIN Menu m2 ON m1.ParentId = m2.Id OR m1.ParentId = 0
INNER JOIN ScreenAction s ON s.Id = m1.ScreenId
) AS m
WHERE Id LIKE {0}
GROUP BY Id, ScreenId, Text, NewWindow, IconClass, ParentId, Parent, Position, Visible, Enabled, MenuType, Link";
            return _db.ExecuteQuery<MenuManagementViewModel>(query, id);
        }

        public IEnumerable<Menu> GetParentsText(int menuType)
        {
            const string query = @"SELECT Id, Text FROM Menu WHERE ParentId = 0 AND MenuType = {0} GROUP BY Id, Text ORDER BY Text";
            return _db.ExecuteQuery<Menu>(query, menuType);
        }

        public MenuManagementViewModel LoadMenuById(int id)
        {
            const string query = @"SELECT m.*, s.Enabled FROM Menu m INNER JOIN ScreenAction s ON m.ScreenId = s.Id WHERE m.Id = {0}";
            return _db.ExecuteQuery<MenuManagementViewModel>(query, id).SingleOrDefault();
        }

        public int ChangeMenuVisible(int Id)
        {
            try
            {
                var item = _db.Menus.SingleOrDefault(m => m.Id == Id);

                if (item == null)
                {
                    return 0;
                }

                item.Visible = !item.Visible;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return -1;
            }
        }

        public Menu GetScreenIdById(int Id)
        {
            try
            {
                Menu menu = _db.Menus.SingleOrDefault(m => m.Id == Id);

                if (menu == null)
                {
                    return null;
                }
                return menu;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return null;
            }
        }

        public int UpdateMenu(Menu updateMenu)
        {
            Menu menu = null;
            try
            {
                menu = _db.Menus.FirstOrDefault(m => m.Id == updateMenu.Id);

                if (menu == null)
                {
                    return 0;
                }
                updateMenu.Visible = menu.Visible;
                Tools.CopyPropertiesTo(updateMenu, menu);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return -1;
            }
        }

        public int InsertMenu(Menu menu)
        {
            try
            {
                _db.Menus.InsertOnSubmit(menu);
                _db.SubmitChanges();
                return menu.Id;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return -1;
            }
        }
    }
}
