using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Controllers
{
    public class MenuManagementController : Controller
    {
        // GET: MenuManagement
        private readonly MenuManagmentBusiness _menuManagementBusiness;
        private readonly ScreenActionBusiness _screenActionBusiness;
        public MenuManagementController()
        {
            _menuManagementBusiness = new MenuManagmentBusiness(DbConfig.GetConnectionString());
            _screenActionBusiness = new ScreenActionBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LoadMenuDatatables(jQueryDataTableParam param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _menuManagementBusiness.GetOrderedMenusByParamsAndPaging(param.search["value"], Convert.ToInt32(param.order[0]["column"]),
                param.order[0]["dir"], param.start, param.length, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult GetParentByMenuType(int menuType)
        {
            List<Menu> menus = _menuManagementBusiness.GetParentsText(menuType).ToList();
            return Json(menus);
        }

        public ActionResult LoadMenuById(int id)
        {
            MenuManagementViewModel model = _menuManagementBusiness.LoadMenuById(id);
            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        public int ChangeMenuVisible(int Id)
        {
            return _menuManagementBusiness.ChangeMenuVisible(Id);
        }

        public int ChangeScreenActionEnabled(int Id)
        {
            Menu menu = _menuManagementBusiness.GetScreenIdById(Id);
            if (menu == null)
            {
                return 0;
            }
            else
            {
                return _screenActionBusiness.ChangeScreenActionEnable(menu.ScreenId);
            }
        }

        public ActionResult UpdateMenu(MenuManagementViewModel menuManagement)
        {
            ScreenAction screenAction = _screenActionBusiness.GetScreenActionById(menuManagement.ScreenId);
            int result = 0;
            int result2 = 0;
            var menu = new Menu();
            if (screenAction == null)
            {
                screenAction = new ScreenAction();
                screenAction.Id = menuManagement.ScreenId;
                screenAction.Name = menuManagement.Text;
                screenAction.Enabled = true;
                result = _screenActionBusiness.AddScreenAction(screenAction);
            }
            else
            {
                result = _screenActionBusiness.UpdateScreenActionName(menuManagement.ScreenId, menuManagement.Text);
            }

            if (result > 0)
            {
                Tools.CopyPropertiesTo(menuManagement, menu);
                result2 = _menuManagementBusiness.UpdateMenu(menu);
            }
            return Json(new { result = result2 }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult InsertMenu(MenuManagementViewModel menuManagement)
        {
            ScreenAction screenAction = _screenActionBusiness.GetScreenActionById(menuManagement.ScreenId);
            int result = 0;
            int result2 = 0;
            var menu = new Menu();
            if (screenAction == null)
            {
                screenAction = new ScreenAction();
                screenAction.Id = menuManagement.ScreenId;
                screenAction.Name = menuManagement.Text;
                screenAction.Enabled = true;
                result = _screenActionBusiness.AddScreenAction(screenAction);
            }
            else
            {
                result = _screenActionBusiness.UpdateScreenActionName(menuManagement.ScreenId, menuManagement.Text);
            }

            if (result > 0)
            {
                Tools.CopyPropertiesTo(menuManagement, menu);
                result2 = _menuManagementBusiness.InsertMenu(menu);
            }
            return Json(new { result = result2 }, JsonRequestBehavior.AllowGet);
        }
    }
}