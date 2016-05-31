using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using PMS.BusinessLogic;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class AccountController : Controller
    {

        private readonly AccountBusiness _accountBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly CommunityBusiness _communityBusiness;
        private readonly VicariateBusiness _vicariateBusiness;

        public AccountController()
        {
            _accountBusiness = new AccountBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
        }

        // GET: /Account/
        public ActionResult Login()
        {
            string url = "";

            if (Session["RoleId"] != null)
            {
                int roleId = (int) Session["RoleId"];

                if (roleId == (int)AccountEnum.Admin)
                {
                    url = "/Diocese/Index";
                }
                else if (roleId == (int)AccountEnum.Manager)
                {
                    url = "/ParishHome/Index";
                }
                else if (roleId == (int)AccountEnum.Staff)
                {
                    url = "/ParishHome/Index";
                }
                else if (roleId == (int)AccountEnum.Teacher)
                {
                    url = "/DoctrineCourse/ManageClass";
                }
                return Redirect(url);
            }

            return View();
        }

        [HttpPost]
        public ActionResult CheckLogin(string username, string password)
        {
            int code;
            Account account = _accountBusiness.CheckLogin(username, password, out code);
            string url = "";
            var converter = new MessageConverter();

            if (account != null)
            {
                string role = account.Role.Name;
                int roleId = account.RoleId;

                Session["AccountId"] = account.Id;
                Session["Role"] = role;
                Session["RoleId"] = roleId;
                Session["Username"] = account.Username;
                Session["DioceseId"] = account.DioceseId;
                Session["ParishId"] = account.ParishId;
                Session["Name"] = account.Name;

                int defaultCommunity = 0;
                if (roleId != (int) AccountEnum.Admin)
                {
                    if (account.ParishId != null)
                    {
                        defaultCommunity = _communityBusiness.GetDefaultCommunityIdByParishId((int) account.ParishId);
                    }                 
                }
                Parish parish = _parishBusiness.GetParishesByParishId((int)account.ParishId);
                Session["VicariateId"] = parish.VicariateId;

                Session["DefaultCommunity"] = defaultCommunity;

                if (roleId == (int) AccountEnum.Admin)
                {
                    url = "/Diocese/Index";
                }
                else if (roleId == (int)AccountEnum.Manager)
                {
                    url = "/ParishHome/Index";
                }
                else if (roleId == (int)AccountEnum.Staff)
                {
                    url = "/ParishHome/Index";
                }
                else if (roleId == (int)AccountEnum.Teacher)
                {
                    url = "/DoctrineCourse/ManageClass";
                }

            }

            return Json(new { message = converter.LoginConverter(code), url = url },
                            JsonRequestBehavior.AllowGet);
        }

        public ActionResult Logout()
        {          
            Session["AccountId"] = null;
            Session["Role"] = null;
            Session["RoleId"] = null;
            Session["Username"] = null;
            Session["DioceseId"] = null;
            Session["ParishId"] = null;
            Session["Name"] = null;
            Session["DefaultCommunity"] = null;
            Session["VicariateId"] = null;

            return RedirectToAction("Login");
        }

        public ActionResult TimeoutRedirect()
        {
            return View();
        }
        [SessionExpireFilter]
        public ActionResult ChangePassword()
        {
            return View();
        }

        public ActionResult CheckPassword(string currentPassword, string newPassword)
        {
            string userName = (string) Session["UserName"];
            var result = _accountBusiness.ChangePassword(userName, currentPassword, newPassword);
            return Json(new {result = result}, JsonRequestBehavior.AllowGet);
        }

        [SessionExpireFilter]
        public ActionResult AccountManagement()
        {
            int dioceseId = (int) Session["DioceseId"];
            var parishes = _parishBusiness.GetParishesByDioceseId(dioceseId);
            ViewBag.Parishes = parishes;

            return View();
        }

        public ActionResult LoadAccount(jQueryDataTableParamModel param, int parishId)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            var result = _accountBusiness.GetOrderedAccountByParamsAndPaging(parishId, dioceseId, param.sSearch,
               param.iSortCol_0, param.sSortDir_0, param.iDisplayStart, param.iDisplayLength, out totalRecords,
               out totalDisplayRecords);

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public int AddAccount(Account account)
        {
            int dioceseId = (int) Session["DioceseId"];
            account.DioceseId = dioceseId;

            return _accountBusiness.AddAccount(account);
        }

        public int UpdateAccount(Account account)
        {
            return _accountBusiness.UpdateAccount(account);
        }

        public int ChangeAccountStatus(int accountId, int status)
        {
            return _accountBusiness.ChangeAccountStatus(accountId, status);
        }

        public ActionResult GetAccountById(int accountId)
        {
            var account = _accountBusiness.GetAccountById(accountId);

            int parishId = 0;
            int roleId = account.RoleId;
            if (account.RoleId != (int) AccountEnum.Admin)
            {
                if (account.ParishId != null)
                {
                    parishId = (int) account.ParishId;
                }
            }

            account.Role = null;
            account.Diocese = null;
            account.Parish = null;
            account.Messages = null;

            return Json(new
                        {
                            parishId = parishId,
                            roleId = roleId,
                            account = account,
                        }, JsonRequestBehavior.AllowGet);
        }

        public int CheckValidUsername(string username, int accountId)
        {
            return _accountBusiness.CheckValidUsername(username, accountId);
        }

    }
}