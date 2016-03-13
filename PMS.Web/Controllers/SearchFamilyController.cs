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
    public class SearchFamilyController : Controller
    {
        //
        // GET: /SearchFamily/
        private readonly CommunityBusiness _communityBusiness;
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly SearchFamilyBusiness _searchFamilyBusiness;
        public SearchFamilyController()
        {
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _searchFamilyBusiness = new SearchFamilyBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult Family()
        {
            return View();
        }

        public ActionResult LoadFamilySearchDatatables(jQueryDataTableParamModel param, int vicariateId, int parishId,
            int communityId, int parishDivisionId, string code, string parishionerName, string fatherName, string motherName, bool notIncludeRecord)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            var result = _searchFamilyBusiness.GetOrderedFamiliesByParamsAndPaging(dioceseId, vicariateId, parishId,
                communityId, parishDivisionId, code, parishionerName, fatherName, motherName, notIncludeRecord, param.iSortCol_0, param.sSortDir_0,
                param.iDisplayStart, param.iDisplayLength, out totalRecords, out totalDisplayRecords);

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }


	}
}