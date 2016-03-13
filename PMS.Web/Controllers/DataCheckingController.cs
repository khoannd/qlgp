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
    public class DataCheckingController : Controller
    {
        //
        // GET: /DataChecking/
        private readonly CommunityBusiness _communityBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;

        public DataCheckingController()
        {
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Parishioner()
        {
            int parishId = (int)Session["ParishId"];

            List<Community> communities = _communityBusiness.GetCommunitiesByParishId(parishId);
            List<Community> parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);

            ViewBag.Communities = communities;
            ViewBag.ParishDivisions = parishDivisions;
            return View();
        }


        public ActionResult LoadCheckingParishionerDatatables(jQueryDataTableParamModel param, int communityId, int parishDivisionId,
                                                              bool noBirthDate, bool wrongDate, bool earlyCommunion, bool manyMatrimony,
                                                            bool enoughMatrimony, bool noMatrimonyDate, bool noFamily, bool manyFamily, int firstCheck)
        {
            
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            if (firstCheck == 1)
            {
                var noData = new List<IConvertible[]>();

                return Json(new
                {
                    sEcho = param.sEcho,
                    iTotalRecords = totalRecords,
                    iTotalDisplayRecords = totalDisplayRecords,
                    aaData = noData
                }, JsonRequestBehavior.AllowGet);
            }

            var result = _parishionerBusiness.GetOrderedCheckingParishionersByParamsAndPaging(parishId, communityId, parishDivisionId,
                                                                         noBirthDate, wrongDate, earlyCommunion, manyMatrimony,
                                                                         enoughMatrimony, noMatrimonyDate, noFamily, manyFamily,
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



	}
}