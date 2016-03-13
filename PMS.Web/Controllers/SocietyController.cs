using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using System.Transactions;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class SocietyController : Controller
    {
        //
        // GET: /Society/
        private readonly SocietyBusiness _societyBusiness;

        public SocietyController()
        {
            _societyBusiness = new SocietyBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }

        //load bảng danh sách hội đoàn
        public ActionResult LoadSocietyDataTables(jQueryDataTableParamModel param)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _societyBusiness.getOrderedSocietiesByParamsAndPaging(parishId, param.sSearch,
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

        //Load bảng danh sách hội viên
        public ActionResult LoadSocietyMemberBySocietyId(int societyId)
        {
            List<SocietyMember> result = _societyBusiness.GetSocietyMembersBySocietyId(societyId);
            return PartialView("_SocietyMemberTable", result);
        }
        //public ActionResult LoadSocietyMemberDataTables(jQueryDataTableParamModel param, int societyId)
        //{
        //    int totalRecords = 0;
        //    int totalDisplayRecords = 0;
        //    if (societyId <= 0)
        //    {
        //        List<IConvertible[]> noData = new List<IConvertible[]>();

        //        return Json(new
        //        {
        //            sEcho = param.sEcho,
        //            iTotalRecords = totalRecords,
        //            iTotalDisplayRecords = totalDisplayRecords,
        //            aaData = noData
        //        }, JsonRequestBehavior.AllowGet);
        //    }

        //    var result = _societyBusiness.getOrderedSocietyMemberByParamsAndPaging(societyId, param.sSearch,
        //        param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
        //        param.iDisplayLength, out totalRecords, out totalDisplayRecords);
        //    return Json(new
        //    {
        //        sEcho = param.sEcho,
        //        iTotalRecords = totalRecords,
        //        iTotalDisplayRecords = totalDisplayRecords,
        //        aaData = result
        //    }, JsonRequestBehavior.AllowGet);
        //}

        public ActionResult LoadSocietyById(int id)
        {
            Society society = _societyBusiness.GetSocietyBySocietyId(id);
            SocietyViewModel model = new SocietyViewModel();
            var converter = new DateConverter();
            if (society.ManagedBy != null)
            {
                model.Manager = society.Parishioner.Name;
            }
            else
            {
                model.Manager = "";
            }
            model.Id = society.Id;
            model.Name = society.Name;
            model.EstablishedDate = converter.ConvertStringToDate(society.EstablishedDate);

            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        //Thêm xóa sửa hội đoàn
        public int AddSociety(Society society, int parishionerId, int position, string note)
        {
            var converter = new DateConverter();
            int societyId = society.Id;

            society.EstablishedDate = converter.ConvertDateToString(society.EstablishedDate);
            using (var scope = new TransactionScope())
            {
                if (societyId == 0)
                {
                    societyId = _societyBusiness.AddSociety(society);
                }

                if (parishionerId > 0 && societyId > 0)
                {
                    var societyMember = new SocietyMember()
                    {
                        SocietyId = societyId,
                        ParishionerId = parishionerId,
                        Position = position,
                    };
                    int newSocietyMemberId = _societyBusiness.AddSocietyMember(societyMember);
                    if (newSocietyMemberId < 0)
                    {
                        return newSocietyMemberId;
                    }
                }
                else
                {
                }
                //If success all
                scope.Complete();
                return societyId;
            }
        }

        public ActionResult UpdateSociety(Society society)
        {
            var converter = new DateConverter();
            society.EstablishedDate = converter.ConvertDateToString(society.EstablishedDate);
            int result = _societyBusiness.UpdateSociety(society);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSociety(int id)
        {
            int result = _societyBusiness.DeleteSociety(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }


        //Xóa sửa hội viên
        public ActionResult EditableSocietyMemberPosition(SocietyMember societyMember)
        {
            if (societyMember.Note == null)
            {
                societyMember.Note = "";
            }
            int result = _societyBusiness.EditSocietyMemberPosition(societyMember);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //public ActionResult EditableSocietyMemberJoinDate(SocietyMember societyMember)
        //{
        //    DateConverter converter = new DateConverter();
        //    societyMember.JoinDate = converter.ConvertDateToString(societyMember.JoinDate);
        //    int result = _societyBusiness.EditSocietyMemberPosition(societyMember);
        //    return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        //}
        public ActionResult DeleteSocietyMember(int societyMemberId)
        {
            var result = _societyBusiness.DeleteSocietyMember(societyMemberId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //Validate hội đoàn
        public ActionResult CheckUniqueName(string name, int societyId)
        {
            int parishId = (int)Session["ParishId"];
            int result = _societyBusiness.CheckUniqueName(name, societyId, parishId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        //Validate hội viên
        public ActionResult CheckUniqueMember(int parishionerId, int societyId)
        {
            int result = _societyBusiness.CheckUniqueMember(societyId, parishionerId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        //Phần tìm kiếm--------------------------------------------------------------
        //Load bảng danh sách các hội giáo dân đã tham gia
        public ActionResult LoadSocietiesByParishionerId(int parishionerId)
        {
            List<Society> result = _societyBusiness.GetSocietiesByParishIonerId(parishionerId);
            return PartialView("_ViewParishionerSocietyTable", result);
        }
    }
}