using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using PMS.BusinessLogic;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ChangeCommunityController : Controller
    {
        private readonly ChangeCommunityBusiness _changeCommunityBusiness;
        
        public ChangeCommunityController()
        {
            _changeCommunityBusiness = new ChangeCommunityBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult Parishioner()
        {
            return View();
        }
        [SessionExpireFilter]
        public ActionResult Family()
        {
            return View();
        }
        public ActionResult LoadCommunityAndParishDivisionTreeView()
        {
            int parishId = (int)Session["ParishId"];
            var communities = _changeCommunityBusiness.GetCommunitiesByParishId(parishId);
            var parishDivisions = _changeCommunityBusiness.GetParishDivisionsByParishId(parishId);
            var result = new List<CommunityTreeViewModel>();

            if (parishDivisions.Count > 0)
            {
                result.AddRange(communities.Select(item => new CommunityTreeViewModel()
                {
                    Id = item.Id,
                    Name = item.Name,
                    ParishDivisions = parishDivisions.Where(p => p.ParentId == item.Id).ToList(),
                }));
            }

            ViewBag.CommunityTreeViewModel = result;

            return PartialView("_CommunityAndParishDivisionTree", result);
        }
        public ActionResult LoadTargetCommunityAndParishDivisionTreeView(int communitySourceId)
        {
            int parishId = (int)Session["ParishId"];
            var communities = _changeCommunityBusiness.GetCommunitiesByParishId(parishId);
            var parishDivisions = _changeCommunityBusiness.GetParishDivisionsByParishId(parishId);
            var result = new List<CommunityTreeViewModel>();

            if (parishDivisions.Count > 0)
            {
                result.AddRange(communities.Select(item => new CommunityTreeViewModel()
                {
                    Id = item.Id,
                    Name = item.Name,
                    ParishDivisions = parishDivisions.Where(p => p.ParentId == item.Id).ToList(),
                }));
            }

            ViewBag.communitySourceId = communitySourceId;
            ViewBag.CommunityTreeViewModel = result;

            return PartialView("_TargetCommunityAndParishDivisionTree", result);
        }

        public ActionResult LoadParishionerDatatables(jQueryDataTableParamModel param, int communityId, bool isCounted)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _changeCommunityBusiness.GetOrderedParishionersByParamsAndPaging(parishId, communityId, isCounted,
                                                                         param.sSearch, param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                                                                         param.iDisplayLength, out totalRecords, out totalDisplayRecords);

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);

        }
        //Chyển họ cho giáo dân
        public ActionResult ChangeParishionersCommunity(string[] parishioners, int communityTargetId)
        {
            var result = _changeCommunityBusiness.ChangeParishionersCommunity(parishioners, communityTargetId);
            return Json(new {result = result}, JsonRequestBehavior.AllowGet);
        }

        //Phần gia đình

        //load gia đình ra dataTable
        public ActionResult LoadFamiliesDatatables(jQueryDataTableParamModel param, int communityId, bool isCounted)
         {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _changeCommunityBusiness.GetOrderedFamiliesByParamsAndPaging(parishId, communityId, isCounted,
                                                                         param.sSearch, param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                                                                         param.iDisplayLength, out totalRecords, out totalDisplayRecords);

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        //Chuyển họ cho gia đình
        public ActionResult ChangeFamiliesCommunity(string[] families, int communityTargetId)
        {
            var result = _changeCommunityBusiness.ChangeFamiliesCommunity(families, communityTargetId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

	}
}