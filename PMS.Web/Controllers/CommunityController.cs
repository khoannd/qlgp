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
    public class CommunityController : Controller
    {
        //
        // GET: /Community/
        private readonly CommunityBusiness _communityBusiness;

        public CommunityController()
        {
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddCommunity(Community community)
        {
            int parishId = (int)Session["ParishId"];
            community.ParishId = parishId;
            
            community.IsDefault = false;
            int result = _communityBusiness.AddCommunity(community);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AddDivision(Community community, int parentId)
        {
            int parishId = (int)Session["ParishId"];
            community.ParishId = parishId;
            community.ParentId = parentId;
            community.IsDefault = false;
            int result = _communityBusiness.AddCommunity(community);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadCommunityDatatable(jQueryDataTableParamModel param)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _communityBusiness.GetOrderedCommunitiesByParamsAndPaging(parishId, param.sSearch,
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

        public ActionResult LoadDivisionDatatable(jQueryDataTableParamModel param, int communityId)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            if (communityId <= 0)
            {
                List<IConvertible[]> noData = new List<IConvertible[]>();

                return Json(new
                {
                    sEcho = param.sEcho,
                    iTotalRecords = totalRecords,
                    iTotalDisplayRecords = totalDisplayRecords,
                    aaData = noData
                }, JsonRequestBehavior.AllowGet);
            }
            
            var result = _communityBusiness.GetOrderedDivisionByParamsAndPaging(communityId, param.sSearch,
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

        public ActionResult LoadCommunityById(int id)
        {
            Community result = _communityBusiness.GetCommunitiesById(id);
            result.Communities = null;
            result.Families = null;
            result.Parishioners = null;
            result.Community1 = null;
            result.Parish = null;
            result.ParishionerMigrationRequests = null;
            result.FamilyMigrationRequests = null;
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
            
        }
        public ActionResult UpdateCommunity(Community community)
        {
            int result = _communityBusiness.UpdateCommunity(community);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult UpdateDivision(Community community)
        {
            int result = _communityBusiness.UpdateDivision(community);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }


        public ActionResult DeleteCommunity(int id)
        {
            int result = _communityBusiness.DeleteCommunity(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckUniqueCommunity(string name, int communityId)
        {
            int parishId = (int)Session["ParishId"];
            int result = _communityBusiness.CheckUniqueCommunity(name, communityId, parishId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckUniqueDivision(string name, int communityId, int parentId)
        {
            int result = _communityBusiness.CheckUniqueDivision(name, communityId, parentId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
	}
}