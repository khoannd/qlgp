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
    public class RolePermissionBusiness
    {
        private readonly RolePermissionData _rolePermissionData;

        public RolePermissionBusiness(string connection)
        {
            _rolePermissionData = new RolePermissionData(connection);
        }

        public List<RolePermissionViewModel> GetScreenPermissionByRole(int roleId)
        {
            return _rolePermissionData.GetScreenPermissionByRole(roleId);
        }

        public List<RolePermission> GetScreenPermissionByScreen(int screenId)
        {
            return _rolePermissionData.GetScreenPermissionByScreen(screenId);
        }

        public RolePermission GetScreenPermissionByRoleScreen(int roleId, string screenId)
        {
            return _rolePermissionData.GetScreenPermissionByRoleScreen(roleId, screenId);
        }
        public int Update(RolePermission data)
        {
            return _rolePermissionData.Update(data);
        }
    }
}
