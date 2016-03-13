using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class DioceseController : Controller
    {
        //
        // GET: /Diocese/
        private readonly DioceseBusiness _dioceseBusiness;

        public DioceseController()
        {
            _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            int dioceseId = (int)Session["DioceseId"];
            Diocese dioceses = _dioceseBusiness.GetDiocesesByDioceseId(dioceseId);
            ViewBag.Diocese = dioceses;
            return View(dioceses);

        }

        public ActionResult Update(Diocese diocese)
        {
            int dioceseId = (int)Session["DioceseId"];
            string url = _dioceseBusiness.GetImageUrlByDioceseId(dioceseId);
            int result = _dioceseBusiness.UpdateDiocese(diocese);

            if (!string.IsNullOrEmpty(diocese.ImageUrl))
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


            return Json(new { abc = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadDioceseById(int id) //lay id tu view
        {
            Diocese diocese = _dioceseBusiness.GetDiocesesByDioceseId(id);

            DioceseViewModel model = new DioceseViewModel();

            model.Id = diocese.Id;
            model.Name = diocese.Name;
            model.Church = diocese.Church;
            model.Address = diocese.Address;
            model.Bishop = diocese.Bishop;
            model.Website = diocese.Website;
            model.Phone = diocese.Phone;
            model.Email = diocese.Email;
            model.ImageUrl = diocese.ImageUrl;

            return Json(new { def = model }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadDioceseInformation(int Id)
        {
            Diocese diocese = _dioceseBusiness.GetDiocesesByDioceseId(Id);
            return PartialView("_DioceseInformation", diocese);
        }

        public ActionResult CheckUniqueDiocese(string name, int id)
        {
            int result = _dioceseBusiness.CheckUniqueDiocese(name, id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public string UploadDioceseImage(HttpPostedFileWrapper inputFile)
        {
            if (inputFile == null || inputFile.ContentLength == 0)
            {
                return "";
            }
            string s = inputFile.ContentType;
            var fileName = String.Format("{0}.jpg", Guid.NewGuid().ToString());
            var imagePath = Path.Combine(Server.MapPath(Url.Content("~/Images/Dioceses/")), fileName);
            inputFile.SaveAs(imagePath);

            return Url.Content(String.Format("~/Images/Dioceses/{0}", fileName));
        }
    }
}