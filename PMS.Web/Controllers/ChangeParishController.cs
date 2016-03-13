using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ChangeParishController : Controller
    {
        //
        // GET: /ChangeParish/
        private readonly ParishBusiness _parishBusiness;
        private readonly ChangeParishBusiness _changeParishBusiness;

        public ChangeParishController()
        {
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _changeParishBusiness = new ChangeParishBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]

        public ActionResult Parishioner()
        {
            return View();
        }

        public ActionResult LoadFromParishies()
        {
            int parishId = (int)Session["parishId"];
            Parish parishes = _parishBusiness.GetParishesByParishId(parishId);
            ParishViewModel model = new ParishViewModel();
            model.Id = parishes.Id;
            model.Name = parishes.Name;
            model.Address = parishes.Address;
            model.Website = parishes.Website;
            model.Phone = parishes.Phone;
            model.Email = parishes.Email;
            model.VicariateId = parishes.VicariateId;
            model.ImageUrl = parishes.ImageUrl;
            return Json(new
            {
                result = model
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ParishionerSelected(string[] parishioners, int toParishId, string toParishName)
        {
            int result = _changeParishBusiness.ChangeParishForParishioner(parishioners, toParishId, toParishName);
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        [SessionExpireFilter]
        public ActionResult Family()
        {
            return View();
        }
        public ActionResult ChangeParishForFamily(string[] families, int toParishId, string toParishName)
        {
            int result = _changeParishBusiness.ChangeParishForFamily(families, toParishId, toParishName);
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult CheckOtherParish(string name, int parishId)
        {
            int dioceseId = (int)Session["DioceseId"];
            int result = _changeParishBusiness.CheckOtherParish(name, parishId, dioceseId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
	}
}