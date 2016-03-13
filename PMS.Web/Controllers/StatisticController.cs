using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class StatisticController : Controller
    {
        
        //
        // GET: /Statistic/
        private readonly StatisticBusiness _statisticBusiness;

        public StatisticController()
        {
            _statisticBusiness = new StatisticBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LoadParishionerStatisticDatatables(jQueryDataTableParamModel param, int vicariateId, int parishId,
            int communityId, int parishDivisionId, int rdValue, string fromDate, string toDate, bool includeRecord,
            bool includeWithoutDate)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            IEnumerable<IConvertible[]> result;
            if (rdValue == 1 || rdValue == 5 || rdValue == 7)
            {
                result = _statisticBusiness.GetOrderedParishionersByParamsAndPaging(dioceseId, vicariateId, parishId,
                communityId, parishDivisionId, rdValue, fromDate, toDate, includeRecord, includeWithoutDate, param.iSortCol_0, param.sSortDir_0,
                param.iDisplayStart, param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            }
            else if (rdValue == 8)
            {
                result = _statisticBusiness.GetOrderedFamiliesByParamsAndPaging(dioceseId, vicariateId, parishId,
                    communityId, parishDivisionId, rdValue, fromDate, toDate, includeRecord, includeWithoutDate,
                    param.iSortCol_0, param.sSortDir_0,
                    param.iDisplayStart, param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            }
            else if (rdValue == 6)
            {
                result = _statisticBusiness.GetOrderedMatrimonyByParamsAndPaging(dioceseId, vicariateId, parishId,
                    communityId, parishDivisionId, rdValue, fromDate, toDate, includeRecord, includeWithoutDate,
                    param.iSortCol_0, param.sSortDir_0,
                    param.iDisplayStart, param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            }
            else
            {
               result = _statisticBusiness.GetOrderedParishionersSacramentByParamsAndPaging(dioceseId, vicariateId, parishId,
               communityId, parishDivisionId, rdValue, fromDate, toDate, includeRecord, includeWithoutDate, param.iSortCol_0, param.sSortDir_0,
               param.iDisplayStart, param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            }
            

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CompareStatisticDate(string fromDate, string toDate)
        {
            var converter = new DateConverter();
            fromDate = converter.ConvertDateToString(fromDate);
            int iFromDate = Int32.Parse(fromDate);
            toDate = converter.ConvertDateToString(toDate);
            int iToDate = Int32.Parse(toDate);
            var result = iToDate - iFromDate;
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Vocation()
        {
            return View();
        }
	}
}