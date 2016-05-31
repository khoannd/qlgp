using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ParishHomeController : Controller
    {
        //
        // GET: /ParishHome/
        private readonly ParishBusiness _parishBusiness;
        private readonly TreeBusiness _treeBusiness;

        public ParishHomeController()
        {
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _treeBusiness = new TreeBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            int parishId = (int)Session["ParishId"];
            Parish parish = _parishBusiness.GetParishesByParishId(parishId);
            ViewBag.Parish = parish;
            return View(parish);
        }

        public ActionResult LoadParishByParishId(int id)
        {
            Parish result = _parishBusiness.GetParishesByParishId(id);
            result.Accounts = null;
            result.Communities = null;
            //result.Configuration = null;
            result.FamilyMigrationRequests = null;
            result.ParishionerMigrationRequests = null;
            result.SacramentGroups = null;
            result.Societies = null;
            result.Vicariate = null;
            result.Vicariates = null;
            result.ClassGroups = null;
            result.Messages = null;
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishInformation(int id)
        {
            Parish parish = _parishBusiness.GetParishesByParishId(id);
            return PartialView("_ParishInformation", parish);
        }

        public ActionResult Update(Parish parish)
        {
            int id = (int)Session["ParishId"];
            string url = _parishBusiness.GetImageUrlByParishId(id);
            int result = _parishBusiness.UpdateParishManager(parish);
            if (!string.IsNullOrEmpty(parish.ImageUrl))
            {
                if (!string.IsNullOrEmpty(url))
                {
                    string path = Server.MapPath(Url.Content(url));
                    if (result > 0)
                    {
                        if (System.IO.File.Exists(path))
                        {
                            System.IO.File.Delete(path);
                        }
                    }
                }  
            }
            
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckUniqueParish(string name, int id)
        {
            int dioceseId = (int)Session["DioceseId"];
            int result = _parishBusiness.CheckUniqueParish(name, id, dioceseId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public string UploadParishImage(HttpPostedFileWrapper inputFile)
        {
            if (inputFile == null || inputFile.ContentLength == 0)
            {
                return "";
            }
            string s = inputFile.ContentType;
            var fileName = String.Format("{0}.jpg", Guid.NewGuid().ToString());
            var imagePath = Path.Combine(Server.MapPath(Url.Content("~/Images/Parishes/")), fileName);
            inputFile.SaveAs(imagePath);

            return Url.Content(String.Format("~/Images/Parishes/{0}", fileName));
        }

        public ActionResult GetItemTreeView(int itemType, int id = 0)
        {
            int dioceseId = (int) Session["DioceseId"];
            int? parishId = (int?) Session["ParishId"];

            var result = _treeBusiness.GetItemTreeView(dioceseId, parishId, id, itemType);

            return Json(new
                        {
                            result = result
                        }, JsonRequestBehavior.AllowGet);
        }

	}
}