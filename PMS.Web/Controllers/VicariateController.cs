﻿using System;
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
    public class VicariateController : Controller
    {
        //
        // GET: /Vicariate/
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly DioceseBusiness _dioceseBusiness;

        public VicariateController()
        {
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult Index()
        {
            ViewBag.Dioceses = _dioceseBusiness.GetAllDioceses();
            return View();
        }

        public ActionResult LoadVicariateDataTables(jQueryDataTableParamModel param, int? dioceseId)
        {
            dioceseId = dioceseId != null ? dioceseId : (int) Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _vicariateBusiness.GetOrderedVicariatesByParamsAndPaging((int)dioceseId, param.sSearch,
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

        //Drop down list load giáo xứ
        public ActionResult LoadParishForVicariate(int vicariateId)
        {
            int dioceseId = (int) Session["DioceseId"];
            var parishes = _vicariateBusiness.GetParishesForVicariate(dioceseId, vicariateId);
            foreach (var item in parishes)
            {
                item.Vicariate = null ;
                item.Vicariates = null;
                item.Accounts = null;
                item.Communities = null;
                //item.Configuration = null;
                item.FamilyMigrationRequests = null;
                item.SacramentGroups = null;
                item.Societies = null;
                item.Messages = null;
                item.ParishionerMigrationRequests = null;
                item.Priest = null;
                item.Messages = null;
                item.ClassGroups = null;

                item.ConstructionPermits = null;
                item.DeaconRequisitionComments = null;
                item.ParishManagers = null;
                item.ReligiousCommunityBases = null;
                item.SacramentGroups = null;
            }
            
            return Json(new {result = parishes}, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LoadVicariateByDiocese(int dioceseId)
        {
           // Parish parish = _parishBusiness.GetParishesByParishId(id);
            List<Vicariate> vicariates = _vicariateBusiness.GetVicariatesByDioceseId(dioceseId);
            List<VicariateViewModel> result = new List<VicariateViewModel>();
            foreach (Vicariate vicariate in vicariates)
            {
                VicariateViewModel model = new VicariateViewModel();

                if (vicariate.ParishId != null)
                {
                    model.ParishId = vicariate.ParishId;
                    model.ParishName = vicariate.Parish.Name;
                }
                else
                {
                    model.ParishId = 0;
                    model.ParishName = " ";
                }
                model.Id = vicariate.Id;
                model.Name = vicariate.Name;
                model.DioceseId = vicariate.DioceseId;
                result.Add(model);
            }

            return Json(new {result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadVicariateById(int vicariateId)
        {
            // Parish parish = _parishBusiness.GetParishesByParishId(id);
            Vicariate vicariate = _vicariateBusiness.GetVicariateByVicariateId(vicariateId);

            VicariateViewModel model = new VicariateViewModel();

            if (vicariate.ParishId != null)
            {
                model.ParishId = vicariate.ParishId;
                model.ParishName = vicariate.Parish.Name;
            }
            else
            {
                model.ParishId = 0;
                model.ParishName = " ";
            }
            model.Id = vicariate.Id;
            model.Name = vicariate.Name;
            model.DioceseId = vicariate.DioceseId;

            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        //Thêm xóa sửa giáo hạt
        public ActionResult AddVicariate(Vicariate vicariate)
        {
            int result = _vicariateBusiness.AddVicariate(vicariate);
            return Json(new {result = result}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UpdateVicariate(Vicariate vicariate)
        {
            int result = _vicariateBusiness.UpdateVicariate(vicariate);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteVicariate(int id)
        {
            int result = _vicariateBusiness.DeleteVicariate(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //Load giáo xứ = AutoComplete 
        //public ActionResult LoadParishName(string name)
        //{
        //    var result = _vicariateBusiness.LoadParishByName(name);
        //    return Json(new
        //    {
        //        result = result
        //    }, JsonRequestBehavior.AllowGet);
        //}


        //Validate giáo hạt

        public ActionResult CheckUniqueVicariate(string name, int vicariateId, int dioceseId)
        {
            int result = _vicariateBusiness.CheckUniquevicariate(name, vicariateId, dioceseId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
	}
}