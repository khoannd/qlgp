using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class MessageController : Controller
    {
        //
        // GET: /Message/
        private readonly MessageBusiness _messageBusiness;
        private readonly ParishBusiness _parishBusiness;

        public MessageController()
        {
            _messageBusiness = new MessageBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult CreateMessage()
        {
            List<Parish> parishes;
            int dioceseId = (int)Session["DioceseId"];
            int role = (int)Session["RoleId"];
            if (role == (int)AccountEnum.Manager)
            {
                int parishId = (int)Session["ParishId"];
                parishes = _parishBusiness.GetParishesByDioceseIdNotMine(dioceseId, parishId);
            }
            else
            {
                parishes = _parishBusiness.GetParishesByDioceseId(dioceseId);
            }
            
            ViewBag.Parishes = parishes;
            return View();
        }

        public ActionResult LoadInboxMessage(jQueryDataTableParamModel param)
        {
            int parishId = 0;
            int role = (int) Session["RoleId"];
            if (role == (int) AccountEnum.Manager)
            {
                parishId = (int)Session["ParishId"];
            }
            int dioceseId = (int) Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _messageBusiness.GetOrderedInboxByParamsAndPaging(dioceseId, parishId, role, param.sSearch,
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

        public ActionResult LoadSentMessage(jQueryDataTableParamModel param)
        {
            int accountId = (int)Session["AccountId"];
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _messageBusiness.GetOrderedSentByParamsAndPaging(accountId, dioceseId, param.sSearch,
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

        [ValidateInput(false)]
        public int AddMessage(string[] ids, string title, string content)
        {
            int accountId = (int)Session["AccountId"];
            int dioceseId = (int)Session["DioceseId"];
            int result = _messageBusiness.CreateMessage(ids, title, content, accountId, dioceseId);
            return result;
        }

        public ActionResult LoadMessageById(int id)
        {
            Message message = _messageBusiness.GetMessageByMessageId(id);
            var date = message.CreatedDate.ToString("hh:mm:ss tt - dd/MM/yyyy");
            var sender = message.Account;
            var sendPlace = "";
            int sendId = 0;
            if (sender.RoleId == (int)AccountEnum.Admin)
            {
                sendPlace = string.Format("{0} {1}", "Được gửi từ giáo phận", sender.Diocese.Name);
                sendId = -1;
            }
            else
            {
                sendPlace = string.Format("{0} {1}", "Được gửi từ giáo xứ", sender.Parish.Name);
                sendId = sender.Parish.Id;
            }
            message.Account = null;
            message.Parish = null;
            return Json(new
            {
                result = message,
                sendPlace = sendPlace,
                sendId = sendId,
                time = date
            
            }, JsonRequestBehavior.AllowGet);
        }

        public int DeleteMessage(int id)
        {
            int result = _messageBusiness.DeleteMessage(id);
            return result;
        }

        public int CountMessageByParishId()
        {
            int id = (int)Session["ParishId"];
            int result = _messageBusiness.CountMessageByParishId(id);
            return result;
        }
        public int CountMessageByDioceseId()
        {
            int id = (int)Session["DioceseId"];
            int result = _messageBusiness.CountMessageByDiocese(id);
            return result;
        }
	}
}