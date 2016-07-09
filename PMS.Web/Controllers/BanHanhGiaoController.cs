using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.IO;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class BanHanhGiaoController : Controller
    {
        //
        // GET: /BanHanhGiao/
        private readonly BanHanhGiaoBusiness _banHanhGiaoBusiness = new BanHanhGiaoBusiness(DbConfig.GetConnectionString());
        private readonly DioceseBusiness _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
        private readonly VicariateBusiness _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
        private readonly ParishBusiness _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());

        public BanHanhGiaoController()
        {
            
        }
        [SessionExpireFilter]
        public ActionResult Index()
        {
            ViewBag.Vicariates = _vicariateBusiness.getAllVicariate().ToList();
		    ViewBag.Dioceses = _dioceseBusiness.GetAllDioceses();
            ViewBag.Parishes = _parishBusiness.GetAllParish().ToList();
            ViewBag.BHGRoles = _banHanhGiaoBusiness.GetMemberRoleData();
            return View();
        }

        public ActionResult LoadBanHanhGiaoDatatables(jQueryDataTableParam param)
        {
			int totalRecords = 0;
            int totalDisplayRecords = 0;
            
            var result = _banHanhGiaoBusiness.GetOrderedBanHanhGiaoByParamsAndPaging(param, out totalRecords, out totalDisplayRecords);

            return Json(new
                {
                    iTotalRecords = totalRecords,
                    iTotalDisplayRecords = totalDisplayRecords,
                    aaData = result
                }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckUniqueBanHanhGiao(string name, int banHanhGiaoId)
        {
            int result = _banHanhGiaoBusiness.CheckUniqueBanHanhGiao(name, banHanhGiaoId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

		public ActionResult CheckUniqueBanHanhGiaoMember(int banHanhGiaoId, int parishionerId)
        {
            int result = _banHanhGiaoBusiness.CheckUniqueBanHanhGiaoMember(banHanhGiaoId, parishionerId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public int AddBanHanhGiao(BanHanhGiao banHanhGiao)
        {
            using (var scope = new TransactionScope())
            {
                int result = _banHanhGiaoBusiness.AddBanHanhGiao(banHanhGiao);
				
                scope.Complete();
                return result;
            }
        }

        public ActionResult UpdateBanHanhGiao(BanHanhGiao banHanhGiao, List<BanHanhGiaoMember> banHanhGiaoMembers)
        {
            int result = _banHanhGiaoBusiness.UpdateBanHanhGiao(banHanhGiao, banHanhGiaoMembers);

            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteBanHanhGiao(int id)
        {
            int result = _banHanhGiaoBusiness.DeleteBanHanhGiao(id);
            return Json(new {result = result}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadBanHanhGiaoById(int id)
        {
            BanHanhGiao banHanhGiao = _banHanhGiaoBusiness.GetBanHanhGiaoById(id);

            return Json(new { result = banHanhGiao }, JsonRequestBehavior.AllowGet);
        }

		public int AddBanHanhGiaoMember(BanHanhGiaoMember banHanhGiaoMember)
        {
            int result = _banHanhGiaoBusiness.AddBanHanhGiaoMember(banHanhGiaoMember);
            return result;
        }

        public int DeleteBanHanhGiaoMember(int banHanhGiaoId, int parishionerId)
        {
            return _banHanhGiaoBusiness.DeleteBanHanhGiaoMember(banHanhGiaoId, parishionerId);
        }

		public int UpdateBanHanhGiaoMember(BanHanhGiaoMember banHanhGiaoMember)
        {
            int result = _banHanhGiaoBusiness.UpdateBanHanhGiaoMember(banHanhGiaoMember);
            
            return result;
        }

		public ActionResult LoadBanHanhGiaoMemberDataTable(string Id)
        {
            var result = _banHanhGiaoBusiness.LoadBanHanhGiaoMemberList(Id);
            return Json(new
            {
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadMemberRoles()
        {
            var result = _banHanhGiaoBusiness.GetMemberRoleData();
            return Json(new
            {
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
