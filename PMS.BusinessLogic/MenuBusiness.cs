using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class MenuBusiness
    {
        private readonly MenuData _menuData;
        private readonly RolePermissionData _rolePermissionData;
        private string connectionString = "";

        public MenuBusiness(string connection)
        {
            connectionString = connection;
            _menuData = new MenuData(connection);
            _rolePermissionData = new RolePermissionData(connection);
        }
        public List<Menu> GetMenuByRole(int roleId)
        {
            int menuType = (new AccountBusiness(connectionString)).IsDioceseRole(roleId) ? 1 : 2;

            List<Menu> menus = _menuData.GetMenus(menuType);
            List<Menu> menuResult = new List<Menu>();
            List<RolePermissionViewModel> permissions = _rolePermissionData.GetScreenPermissionByRole(roleId);
            foreach(Menu m in menus)
            {
                if(roleId == 1)
                {
                    menuResult.Add(m);
                    continue;
                }
                if(m.ScreenId == "")
                {
                    menuResult.Add(m);
                }
                else
                {
                    var url = m.ScreenId;
                    if(url != null)
                    {
                        if (url.Contains("?")) url = url.Substring(0, url.IndexOf('?'));
                        var check = permissions.Where<RolePermissionViewModel>(p => p.ScreenId == url && p.Permission != null && p.Permission == 1).SingleOrDefault();
                        if (check != null)
                        {
                            menuResult.Add(m);
                        }
                    }
                }
            }
            return menuResult;
        }
        public string RenderMenu(int roleId)
        {
            StringBuilder str = new StringBuilder();
            if (roleId > 0)
            {
                List<Menu> menus = GetMenuByRole(roleId);
                var submenu = menus.Where(p => p.ParentId == 0);
                renderMenu(submenu, menus, 0, ref str);
            }
            return str.ToString();
        }
        private void renderMenu(IEnumerable<Menu> menus, IEnumerable<Menu> allMenus, int parentId, ref StringBuilder str)
        {
            if(menus != null && menus.Count() > 0)
            {
                if (parentId == 0)
                {
                    str.AppendLine("<ul id=\"nav\" class=\"nav nav-list\">");
                }
                else
                {
                    str.AppendLine("<ul id=\"nav\" class=\"submenu\">");
                }
                foreach (var m in menus)
                {
                    str.AppendFormat("<li class=\"hover\"><a href =\"{0}\"><i class=\"menu-icon fa {1}\"></i>" +
                        "<span class=\"menu-text\"> {2} </span></a>" +
                        "<b class=\"arrow\"></b>", (m.Link != null && m.Link != "" ? m.Link : "#"), (m.IconClass == null && parentId > 0 ? "fa-caret-right" : m.IconClass), m.Text);
                    var submenu = allMenus.Where(p => p.ParentId == m.Id);
                    if (submenu != null && submenu.Count() != 0)
                    {
                        renderMenu(submenu, allMenus, m.Id, ref str);
                    }
                    str.AppendLine("</li>");
                }
                str.AppendLine("</ul>");
            }
        }
    }
}
