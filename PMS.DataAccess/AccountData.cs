using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class AccountData
    {
        private readonly PMSDataContext _db;

        public AccountData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public Account CheckLogin(string username, string password, out int errorCode)
        {
            try
            {
                Account account = _db.Accounts.SingleOrDefault(a => a.Username.Equals(username) && a.Password.Equals(password));

                if (account == null)
                {
                    errorCode = (int)UserErrorEnum.NotExisted;
                    return null;
                }

                if (account.Status == (int)AccountStatusEnum.Deactive)
                {
                    errorCode = (int)UserErrorEnum.Deactive;
                    return null;
                }

                errorCode = (int)CommonErrorEnum.None;
                return account;
            }
            catch (Exception e)
            {
                errorCode = (int) CommonErrorEnum.Exception;
                return null;
            }
        }

        public int ChangePassword(string username, string currentPassword, string newPassword)
        {
            try
            {
                var item = _db.Accounts.SingleOrDefault(d => d.Username == username);

                if (item == null)
                {
                    return 0;
                }

                if (item.Password != currentPassword)
                {
                    return 0;
                }

                item.Password = newPassword;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public IEnumerable<Account> GetAccountsByDioceseId(int dioceseId)
        {
            const string query = "SELECT * FROM Account " +
                                 "WHERE DioceseId = {0}";
            return _db.ExecuteQuery<Account>(query, dioceseId);
        }

        public IEnumerable<Account> GetAccountsByParishId(int parishId)
        {
            const string query = "SELECT * FROM Account " +
                                 "WHERE ParishId = {0}";
            return _db.ExecuteQuery<Account>(query, parishId);
        }

        public int AddAccount(Account account)
        {

            try
            {
                _db.Accounts.InsertOnSubmit(account);
                _db.SubmitChanges();
                return account.Id;
            }
            catch (Exception e)
            {
                return 0;
            }

        }

        public int UpdateAccount(Account account)
        {
            try
            {
                var item = _db.Accounts.SingleOrDefault(a => a.Id == account.Id);

                if (item == null)
                {
                    return 0;
                }

                if (item.RoleId != (int) AccountEnum.Admin)
                {
                    item.RoleId = account.RoleId;
                    item.ParishId = account.ParishId;             
                }

                item.Name = account.Name;
                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int ChangeAccountStatus(int accountId, int status)
        {
            try
            {
                var item = _db.Accounts.SingleOrDefault(a => a.Id == accountId);

                if (item == null)
                {
                    return 0;
                }

                //item.Username = account.Username;
                item.Status = status;
                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public Account GetAccountById(int id)
        {
            try
            {
                return _db.Accounts.SingleOrDefault(a => a.Id == id);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public int CheckValidUsername(string username, int accountId)
        {
            try
            {
                var item = _db.Accounts.SingleOrDefault(a => a.Username.Equals(username) && a.Id != accountId);

                if (item == null)
                {
                    return 1;
                }

                return 0;
            }
            catch (Exception)
            {
                return -1;
            }
        }

    }

}
