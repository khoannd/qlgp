using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class RolePermissionData
    {
        private readonly PMSDataContext _db;

        public RolePermissionData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public List<RolePermissionViewModel> GetScreenPermissionByRole(int roleId)
        {
            string query = "SELECT a.Id AS ScreenId, a.Name AS ScreenName, b.Permission, " + roleId.ToString() + " AS RoleId " +
                " FROM ScreenAction a LEFT JOIN RolePermission b ON a.Id = b.ScreenId AND b.RoleId = {0}";
            return _db.ExecuteQuery<RolePermissionViewModel>(query, roleId).ToList();
        }
        public List<RolePermission> GetScreenPermissionByScreen(int screenId)
        {
            const string query = "SELECT * FROM RolePermission WHERE ScreenId = {0}";
            return _db.ExecuteQuery<RolePermission>(query, screenId).ToList();
        }
        public RolePermission GetScreenPermissionByRoleScreen(int roleId, string screenId)
        {
            const string query = "SELECT * FROM RolePermission WHERE RoleId = {0} AND ScreenId = {1}";
            return _db.ExecuteQuery<RolePermission>(query, roleId, screenId).FirstOrDefault();
        }
        public int Update(RolePermission data)
        {
            try
            {
                var item = _db.RolePermissions.SingleOrDefault(d => d.ScreenId == data.ScreenId && d.RoleId == data.RoleId);
                if (item == null)
                {
                    _db.RolePermissions.InsertOnSubmit(data);
                    _db.SubmitChanges();
                    return 1;
                }
                item.Permission = data.Permission;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
    }
}
