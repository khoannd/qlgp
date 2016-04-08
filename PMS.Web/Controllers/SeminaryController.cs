using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Controllers
{
    public class SeminaryController : Controller
    {
        // GET: Seminary
        private readonly SeminaryYearBusiness _seminaryYearBusiness;

        public SeminaryController()
        {
            _seminaryYearBusiness = new SeminaryYearBusiness(DbConfig.GetConnectionString());
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LoadSeminaryYearDatatable(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _seminaryYearBusiness.GetOrderedSeminaryYearsByParamsAndPaging(param.sSearch,
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

        public ActionResult LoadSeminaryYearById(int id)
        {
            SeminaryYear result = _seminaryYearBusiness.Get(id);
            result.VocationSeminaryYears = null;
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetAllSeminaryYears()
        {
            var seminaryYears = _seminaryYearBusiness.GetAll();
            return Json(seminaryYears.Select(s => new
            {
                s.EndAt,
                s.Id,
                s.SeminaryName,
                s.SeminaryYearCode,
                s.StartAt
            }), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AddSeminaryYear(SeminaryYear seminaryYear)
        {
            int result = _seminaryYearBusiness.Add(seminaryYear);
            return Json(new { result = result });
        }

        [HttpPost]
        public ActionResult UpdateSeminaryYear(SeminaryYear seminaryYear)
        {
            int result = _seminaryYearBusiness.Update(seminaryYear);
            return Json(new { result = result });
        }

        [HttpPost]
        public ActionResult DeleteSeminaryYear(int id)
        {
            int result = _seminaryYearBusiness.Delete(id);
            return Json(new { result = result });
        }
    }
}