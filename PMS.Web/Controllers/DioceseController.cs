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

        [SessionExpireFilter]
        public ActionResult List()
        {
            int dioceseId = (int)Session["DioceseId"];
            List<Diocese> vicariates = _dioceseBusiness.GetAllDioceses();
            ViewBag.Vicariates = vicariates;
            return View();
        }

        public ActionResult LoadDioceses()
        {
            List<Diocese> dioceses = _dioceseBusiness.GetAllDioceses();

            List<DioceseViewModel> result = new List<DioceseViewModel>();
            foreach (var item in dioceses)
            {
                DioceseViewModel model = new DioceseViewModel();
                model.Id = item.Id;
                model.Name = item.Name;
                model.Church = item.Church;
                model.Phone = item.Phone;
                model.ImageUrl = item.ImageUrl;
                model.Bishop = item.Bishop;
                model.Code = item.Code;
                model.Email = item.Email;
                model.Website = item.Website;
                result.Add(model);
            }

            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadDioceseDatatables(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _dioceseBusiness.GetOrderedDioceseByParamsAndPaging(param.sSearch,
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

        public int Add(Diocese diocese)
        {
            if (diocese.ImageUrl == null)
            {
                diocese.ImageUrl = "";
            }
            return _dioceseBusiness.AddDiocese(diocese);
        }

        public ActionResult Update(Diocese diocese)
        {
            int result = _dioceseBusiness.UpdateDiocese(diocese);

            return Json(new { abc = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadDioceseById(int id) //lay id tu view
        {
            Diocese diocese = _dioceseBusiness.GetDiocesesByDioceseId(id);

            DioceseViewModel model = new DioceseViewModel();

            model.Id = diocese.Id;
            model.Code = diocese.Code;
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

        public ActionResult CheckUniqueDiocese(string name, string code, int id)
        {
            int result = _dioceseBusiness.CheckUniqueDiocese(name, code, id);
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