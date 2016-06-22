using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class RoleBusiness
    {
        private readonly RoleData _roleData;

        public RoleBusiness(string connection)
        {
            _roleData = new RoleData(connection);
        }

        public IEnumerable<Role> GetAllRoles()
        {
            return _roleData.GetAllRoles();
        }
        public IEnumerable<Role> GetRoleForDiocese()
        {
            return _roleData.GetRoleForDiocese();
        }

        public IEnumerable<Role> GetRoleForParish()
        {
            return _roleData.GetRoleForParish();
        }

        public Role GetRoleById(int id)
        {
            return _roleData.GetRoleById(id);
        }

        public int AddRole(Role role)
        {
            return _roleData.AddRole(role);
        }
        public int UpdateRole(Role role)
        {
            return _roleData.UpdateRole(role);
        }
        public int DeleteRole(int id)
        {
            return _roleData.DeleteRole(id);
        }

    }
}
