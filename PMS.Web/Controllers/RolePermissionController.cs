using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using System.Transactions;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class RolePermissionController : Controller
    {
        //
        // GET: /Society/
        private readonly RolePermissionBusiness _rolePermissionBusiness = new RolePermissionBusiness(DbConfig.GetConnectionString());
        private readonly RoleBusiness _roleBusiness = new RoleBusiness(DbConfig.GetConnectionString());

        public RolePermissionController()
        {
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            ViewBag.Roles = _roleBusiness.GetAllRoles().ToList();
            return View();
        }
        public ActionResult LoadPermission(int roleId)
        {
            var result = _rolePermissionBusiness.GetScreenPermissionByRole(roleId);
            return Json(new {
                result
            }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult Update(RolePermission data)
        {
            var result = _rolePermissionBusiness.Update(data);
            return Json(new
            {
                result
            }, JsonRequestBehavior.AllowGet);
        }
    }
}