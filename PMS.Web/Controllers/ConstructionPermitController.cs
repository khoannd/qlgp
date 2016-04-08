using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Controllers
{
    public class ConstructionPermitController : Controller
    {
        private readonly ParishBusiness _parishBusiness;
        private readonly ValueSetBusiness _valueSetBusiness;
        private readonly ConstructionPermitBusiness _contructionPermitBusiness;

        public ConstructionPermitController()
        {
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _valueSetBusiness = new ValueSetBusiness(DbConfig.GetConnectionString());
            _contructionPermitBusiness = new ConstructionPermitBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        // GET: ConstructionPermit
        public ActionResult Index()
        {
            List<Parish> parishes = _parishBusiness.GetAllParish().ToList();
            ViewBag.Parishes = parishes;
            List<ValueSet> permitTypes = _valueSetBusiness.getValueByCategory("PermitType").ToList();
            ViewBag.PermitTypes = permitTypes;
            List<ValueSet> permitStatus = _valueSetBusiness.getValueByCategory("PermitStatus").ToList();
            ViewBag.PermitStatus = permitStatus;
            return View();
        }

        public ActionResult LoadDataTable(jQueryDataTableParamModel param, int permitType, int permitStatus)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _contructionPermitBusiness.GetDataTableByParamsAndPaging(permitType, permitStatus, param.sSearch,
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

        public int createConstructionPermit(ConstructionPermit constructionPermit)
        {
            return _contructionPermitBusiness.createConstructionPermit(constructionPermit);
        }

        public ActionResult LoadConstructionPermitById(int id)
        {
            ConstructionPermit constructionPermit = _contructionPermitBusiness.GetConstructionPermitById(id);
            ConstructionPermitViewModel model = new ConstructionPermitViewModel();
            model.Id = constructionPermit.Id;
            model.PermitType = constructionPermit.PermitType;
            model.ParishId = constructionPermit.ParishId;
            model.Description = constructionPermit.Description;
            model.FilePath = constructionPermit.FilePath;
            model.PermitStatus = constructionPermit.PermitStatus;
            model.Note = constructionPermit.Note;
            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        public int UpdateConstructionPermit(ConstructionPermit constructionPermit)
        {
            return _contructionPermitBusiness.UpdateConstructionPermit(constructionPermit);
        }

        public ActionResult DeleteConstructionPermit(int id)
        {
            int result = _contructionPermitBusiness.DeleteConstructionPermit(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult UpdateFilePath(ConstructionPermit constructionPermit, HttpPostedFileBase file)
        {
            string path = "";
            string fileName = "";
            string extension = "";
            if (Request.Files["file"].ContentLength > 0)
            {
                fileName = System.IO.Path.GetFileNameWithoutExtension(file.FileName);
                extension = System.IO.Path.GetExtension(file.FileName);
                path = string.Format("{0}/{1}{2}", Server.MapPath("~/UploadFiles"), fileName, extension);
                if (System.IO.File.Exists(path))
                    System.IO.File.Delete(path);
                Request.Files["file"].SaveAs(path);
            }
            _contructionPermitBusiness.UpdateFilePath(constructionPermit.Id, "UploadFiles/" + fileName + extension);
            return RedirectToAction("Index");
        }
    }
}