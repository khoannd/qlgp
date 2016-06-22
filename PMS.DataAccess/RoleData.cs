using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Utilities;

namespace PMS.DataAccess
{
    public class RoleData
    {
        private readonly PMSDataContext _db;

        public RoleData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Role> GetAllRoles()
        {
            const string query = @" select * FROM [Role] ORDER BY Name ASC";
            return _db.ExecuteQuery<Role>(query);
        }

        public IEnumerable<Role> GetRoleForDiocese()
        {
            const string query = @" select * FROM [Role] WHERE ForDiocese=1";
            return _db.ExecuteQuery<Role>(query);
        }

        public IEnumerable<Role> GetRoleForParish()
        {
            const string query = @" select * FROM [Role] WHERE ForDiocese=0";
            return _db.ExecuteQuery<Role>(query);
        }

        public Role GetRoleById(int id)
        {
            const string query = "SELECT * FROM [Role] WHERE Id = {0}";
            return _db.ExecuteQuery<Role>(query, id).SingleOrDefault();
        }

        public int AddRole(Role role)
        {
            try
            {
                _db.Roles.InsertOnSubmit(role);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int UpdateRole(Role role)
        {
            try
            {
                var item = _db.Roles.SingleOrDefault(d => d.Id == role.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Name = role.Name;
                item.ForDiocese = role.ForDiocese;

                _db.SubmitChanges();
                return item.Id;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int DeleteRole(int id)
        {
            try
            {
                Role role = _db.Roles.SingleOrDefault(p => p.Id == id);

                if (role == null)
                {
                    return 0;
                }

                _db.Roles.DeleteOnSubmit(role);
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
