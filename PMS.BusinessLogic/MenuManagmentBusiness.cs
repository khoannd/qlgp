using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class MenuManagmentBusiness
    {
        private readonly MenuManagementData _menuManagementData;
        private string connectionString = "";

        public MenuManagmentBusiness(string connection)
        {
            _menuManagementData = new MenuManagementData(connection);
            connectionString = connection;
        }

        public List<MenuManagementViewModel> GetOrderedMenusByParamsAndPaging(string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<MenuManagementViewModel> menus;
            menus = _menuManagementData.GetMenus("%");

            IEnumerable<MenuManagementViewModel> filteredListItems;
            if(!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = menus.Where(c => (c.Text.Trim().ToLower().Contains(searchValue)));

            }
            else
            {
                filteredListItems = menus;
            }

            //Sort
            if(sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.ScreenId) : filteredListItems.OrderByDescending(p => p.ScreenId);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Text) : filteredListItems.OrderByDescending(p => p.Text);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Parent) : filteredListItems.OrderByDescending(p => p.Parent);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Position) : filteredListItems.OrderByDescending(p => p.Position);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.MenuType) : filteredListItems.OrderByDescending(p => p.MenuType);
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Link) : filteredListItems.OrderByDescending(p => p.Link);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = displayedList.ToList();
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public IEnumerable<Menu> GetParentsText(int menuType)
        {
            return _menuManagementData.GetParentsText(menuType);
        }

        public MenuManagementViewModel LoadMenuById(int id)
        {
            return _menuManagementData.LoadMenuById(id);
        }

        public int ChangeMenuVisible(int Id)
        {
            return _menuManagementData.ChangeMenuVisible(Id);
        }

        public Menu GetScreenIdById(int Id)
        {
            return _menuManagementData.GetScreenIdById(Id);
        }

        public int UpdateMenu(Menu menu)
        {
            return _menuManagementData.UpdateMenu(menu);
        }

        public int InsertMenu(Menu menu)
        {
            return _menuManagementData.InsertMenu(menu);
        }
    }
}
