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
    public class SearchController : Controller
    {
        
        //
        // GET: /Search/
        private readonly SearchBusiness _searchBusiness;
        private readonly CommunityBusiness _communityBusiness;
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly ParishBusiness _parishBusiness;

        public SearchController()
        {
            _searchBusiness = new SearchBusiness(DbConfig.GetConnectionString());
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult Parishioner()
        {
            return View();
        }     

        public ActionResult LoadParishionerSearchDatatables(jQueryDataTableParamModel param, int vicariateId, int parishId,
            int communityId, int parishDivisionId, string code, string parishionerName, string fatherName, string motherName, bool notIncludeRecord)
        {
            int dioceseId = (int) Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            var result = _searchBusiness.GetOrderedParishionersByParamsAndPaging(dioceseId, vicariateId, parishId,
                communityId, parishDivisionId, code, parishionerName, fatherName, motherName , notIncludeRecord, param.iSortCol_0, param.sSortDir_0,
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