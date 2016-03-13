using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ApproveRequestController : Controller
    {
        //
        // GET: /ApproveRequest/
        private readonly ApproveRequestBusiness _approveRequestBusiness;

        public ApproveRequestController()
        {
            _approveRequestBusiness = new ApproveRequestBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Parishioner()
        {
            return View();
        }

        public ActionResult LoadParishionerMigrationRequest(jQueryDataTableParamModel param)
        {
            int id = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _approveRequestBusiness.GetOrderedMigrationRequestByParamsAndPaging(id, param.sSearch,
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

        //public int CountParishionerMigrationRequestByParishId()
        //{
        //    int id = (int)Session["ParishId"];
        //    var result = _approveRequestBusiness.CountParishionerMigrationRequestByParishId(id);
        //    return result;
        //}

        public int ApproveParishionerMigrationRequest(int communityId, int[] ids)
        {
            int accountId = (int)Session["AccountId"];
            int result = _approveRequestBusiness.ApproveParishionerMigrationRequest(communityId, ids, accountId);
            return result;
        }

        public int DenyParishionerMigrationRequest(int id)
        {
            int result = _approveRequestBusiness.DenyParishionerMigrationRequest(id);
            return result;
        }

        [SessionExpireFilter]
        public ActionResult ViewParishionerRequest()
        {
            return View();
        }

        public ActionResult LoadParishionerMigrationSendingRequest(jQueryDataTableParamModel param)
        {
            int id = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _approveRequestBusiness.GetOrderedMigrationRequestSendingByParamsAndPaging(id, param.sSearch,
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
        //public int CountParishionerMigrationRequestSendingByParishId()
        //{
        //    int id = (int)Session["ParishId"];
        //    var result = _approveRequestBusiness.CountParishionerMigrationSendingRequestByParishId(id);
        //    return result;
        //}

        public int CancelParishionerMigrationRequestSending(int id)
        {
            int result = _approveRequestBusiness.CancelParishionerMigrationRequestSending(id);
            return result;
        }
        //------------------------------------------------------------------------------------------------------
        //Family
        [SessionExpireFilter]
        public ActionResult Family()
        {
            return View();
        }
        [SessionExpireFilter]
        public ActionResult ViewFamilyRequest()
        {
            return View();
        }
        public int ApproveFamilyMigrationRequest(int communityId, string[] ids)
        {
            int accountId = (int)Session["AccountId"];
            int result = _approveRequestBusiness.ApproveFamilyMigrationRequest(communityId, ids, accountId);
            return result;
        }

        public int DenyFamilyMigrationRequest(int id)
        {
            int result = _approveRequestBusiness.DenyFamilyMigrationRequest(id);
            return result;
        }

        public int CancelFamilyMigrationRequestSending(int id)
        {
            int result = _approveRequestBusiness.CancelFamilyMigrationRequestSending(id);
            return result;
        }

        //public int CountFamilyMigrationRequestByParishId()
        //{
        //    int id = (int)Session["ParishId"];
        //    var result = _approveRequestBusiness.CountFamilyMigrationRequestByParishId(id);
        //    return result;
        //}

        //public int CountFamilyMigrationRequestSendingByParishId()
        //{
        //    int id = (int)Session["ParishId"];
        //    var result = _approveRequestBusiness.CountFamilyMigrationSendingRequestByParishId(id);
        //    return result;
        //}

        public ActionResult LoadFamilyMigrationRequest(jQueryDataTableParamModel param)
        {
            int id = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _approveRequestBusiness.GetOrderedFamilyMigrationRequestByParamsAndPaging(id, param.sSearch,
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

        public ActionResult LoadFamilyMigrationSendingRequest(jQueryDataTableParamModel param)
        {
            int id = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _approveRequestBusiness.GetOrderedFamilyMigrationSendingRequestByParamsAndPaging(id, param.sSearch,
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

        //------------------------------------------------------------------------------------------------------
        //Count all
        public ActionResult CountAllMigrateRequest()
        {
           int id = (int)Session["ParishId"];
            int parishionerSendingRequest = 0;
            int familyReceivingRequest = 0;
            int familySendingRequest = 0;
            var result = _approveRequestBusiness.CountAll(id, out parishionerSendingRequest, out familyReceivingRequest,
                out familySendingRequest);
            return Json(new
            {
                parishionerReceiving = result,
                parishionerSending = parishionerSendingRequest,
                familyReceiving = familyReceivingRequest,
                familySending = familySendingRequest
            }, JsonRequestBehavior.AllowGet);
        }
	}
}