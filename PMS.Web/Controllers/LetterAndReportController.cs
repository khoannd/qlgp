using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.DataAccess.ViewModels;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class LetterAndReportController : Controller
    {
        // GET: LetterAndReport
        private readonly LetterAndReportBusiness _letterAndReportBusiness;

        public LetterAndReportController()
        {
            _letterAndReportBusiness = new LetterAndReportBusiness(DbConfig.GetConnectionString());

        }

        public ActionResult Index()
        {

            var loai = _letterAndReportBusiness.GetLoai();
            ViewBag.Loai = loai;

            return View();
        }


        public ActionResult LoadLetterAndReportDataTables(jQueryDataTableParamModel param)
        {
            //int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _letterAndReportBusiness.GetLetterAndReportByParamsAndPaging(param.sSearch,
                param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public int CheckTen(string ten)
        {
            return _letterAndReportBusiness.CheckValidTen(ten);
        }

        //[SessionExpireFilter]
        //public ActionResult PreviewTemplate()
        //{
        //    return View();
        //}
        [ValidateInput(false)]
        public int AddLetterAndReport(LetterAndReport letterandreport)
        {
            return _letterAndReportBusiness.AddLetterAndReport(letterandreport);
        }

        public ActionResult LoadLetterAndReportById(int Id)
        {
            // Parish parish = _parishBusiness.GetParishesByParishId(id);
            LetterAndReport letterandreport = _letterAndReportBusiness.GetLetterAndReportId(Id);
            LetterAndReportViewModel model = new LetterAndReportViewModel();

            model.Id = letterandreport.Id;
            model.Ten = letterandreport.Ten;
            model.Loai = letterandreport.Loai;
            model.MoTa = letterandreport.MoTa;
            model.Mau = letterandreport.Mau;

            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }
        [ValidateInput(false)]
        public ActionResult UpdateLetterAndReport(LetterAndReport letterandreport)
        {
            int result = _letterAndReportBusiness.UpdateLetterAndReport(letterandreport);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteLetterAndReport(int id)
        {
            int result = _letterAndReportBusiness.DeleteLetterAndReport(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
    }
}