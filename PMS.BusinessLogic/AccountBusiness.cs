using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class AccountBusiness
    {
        private readonly AccountData _accountData;
        private readonly RoleData _roleData;
        private readonly RolePermissionData _rolePermissionData;

        public AccountBusiness(string connection)
        {
            _accountData = new AccountData(connection);
            _roleData = new RoleData(connection);
            _rolePermissionData = new RolePermissionData(connection);
        }

        public Account CheckLogin(string username, string password, out int code)
        {
              password = EncodeMd5(password);  
              return _accountData.CheckLogin(username, password, out code);          
        }

        public int ChangePassword(string userName, string currentPassword, string newPassword)
        {
            currentPassword = EncodeMd5(currentPassword);
            newPassword = EncodeMd5(newPassword);
            return _accountData.ChangePassword(userName, currentPassword, newPassword);
        }

        public IEnumerable<IConvertible[]> GetOrderedAccountByParamsAndPaging(int parishId, int dioceseId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data

            IEnumerable<Account> accounts;

            if (parishId != 0)
            {
                accounts = _accountData.GetAccountsByParishId(parishId);
            }
            else
            {
                accounts = _accountData.GetAccountsByDioceseId(dioceseId);
            }

            IEnumerable<Account> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = accounts.Where(c => (c.Username.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = accounts;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Username) : filteredListItems.OrderByDescending(p => p.Username);
            }
            else if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }
            else if (sortColumnIndex == 5)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.RoleId) : filteredListItems.OrderByDescending(p => p.RoleId);
            }
            else if (sortColumnIndex == 6)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (p.Parish == null ? "" : p.Parish.Name)) : filteredListItems.OrderByDescending(p => (p.Parish == null ? "" : p.Parish.Name));
            }
            else if (sortColumnIndex == 7)
            {
                filteredListItems = sortDirection == "asc"
                    ? filteredListItems.OrderBy(p => p.Status)
                    : filteredListItems.OrderByDescending(p => p.Status);
            }
            else
            {
                filteredListItems = sortDirection == "asc"
                   ? filteredListItems.OrderBy(p => p.RoleId).ThenByDescending(p => p.Id)
                   : filteredListItems.OrderByDescending(p => p.RoleId).ThenByDescending(p => p.Id);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);

            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.RoleId,
                           c.Id,
                           c.Username,
                           c.Name,
                           c.CreatedDate.ToString("dd/MM/yyyy"),
                           ConvertRole(c.RoleId),
                           c.Parish != null ? c.Parish.Name : "" ,
                           c.Status,
                           c.Id             
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int AddAccount(Account account)
        {
            //Ma hoa MD5
            account.Password = EncodeMd5(account.Password);
            account.CreatedDate = DateTime.Now;
            account.Status = (int) AccountStatusEnum.Active;

            return _accountData.AddAccount(account);
        }

        public int UpdateAccount(Account account)
        {
            return _accountData.UpdateAccount(account);
        }

        public int ChangeAccountStatus(int accountId, int status)
        {
            return _accountData.ChangeAccountStatus(accountId, status);
        }

        public string EncodeMd5(string password)
        {
            var x = new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] bs = System.Text.Encoding.UTF8.GetBytes(password);
            bs = x.ComputeHash(bs);
            var s = new System.Text.StringBuilder();
            foreach (byte b in bs)
            {
                s.Append(b.ToString("x2").ToLower());
            }
            return s.ToString();
        }

        public Account GetAccountById(int id)
        {
            return _accountData.GetAccountById(id);
        }

        public int CheckValidUsername(string username, int accountId)
        {
            return _accountData.CheckValidUsername(username, accountId);
        }

        public string ConvertRole(int roleId)
        {
            //if (roleId == (int) AccountEnum.Admin)
            //{
            //    return "Quản trị viên";
            //}

            //if (roleId == (int) AccountEnum.Manager)
            //{
            //    return "Quản lý";
            //}

            //if (roleId == (int) AccountEnum.Staff)
            //{
            //    return "Nhập liệu";
            //}
            //else
            //{
            //    return "Giáo lý viên";
            //}
            var role = _roleData.GetRoleById(roleId);
            return role != null ? role.Name : "";
        }
        public bool IsDioceseRole(int roleId)
        {
            var role = _roleData.GetRoleById(roleId);
            return role != null ? role.ForDiocese : false;
        }
    }
}
