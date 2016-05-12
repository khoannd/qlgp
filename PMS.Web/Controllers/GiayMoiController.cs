﻿using System.Web.Mvc;
using PMS.DataAccess.ViewModels;
using PMS.BusinessLogic;
using PMS.Web;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.Models;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;

namespace PMS.Web.Controllers
{
    public class GiayMoiController : Controller
    {
        private readonly GiayMoiBusiness _giaymoiBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;
        private readonly ValueSetBusiness _valuesetBusiness;
        private readonly LetterAndReportBusiness _letterAndReportBusiness;
        private readonly KhachMoiBusiness _khachmoiBusiness;


        public GiayMoiController()
        {
            _giaymoiBusiness = new GiayMoiBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
            _valuesetBusiness = new ValueSetBusiness(DbConfig.GetConnectionString());
            _letterAndReportBusiness = new LetterAndReportBusiness(DbConfig.GetConnectionString());
            _khachmoiBusiness = new KhachMoiBusiness(DbConfig.GetConnectionString());

        }
        // GET: GiayMoi

        //Get parishioner
        public ActionResult GiayMoi()
        {

            List<Parishioner> parishioner = _parishionerBusiness.GetAllParishioner().ToList();
            ViewBag.Parishioner = parishioner;
            List<ValueSet> valueset = _valuesetBusiness.GetAllValueSet();
            ViewBag.Valueset = valueset;

            List<LetterAndReport> letterAndReport = _letterAndReportBusiness.GetAllLetterAndReport();
            ViewBag.LetterAndReport = letterAndReport;
            return View();

        }

        public string GetTemplateContent(int id)
        {
            return _letterAndReportBusiness.getTemplate(id);

        }
        //get ValueSet



        public ActionResult LoadGiayMoiDatatable(jQueryDataTableParamModel param)
        {
            //int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            var result = _giaymoiBusiness.GetGiayMoi(param.sSearch,
               param.iSortCol_0, param.sSortDir_0, param.iDisplayStart, param.iDisplayLength, out totalRecords,
               out totalDisplayRecords);
            var converter = new DateConverter();


            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }
        [ValidateInput(false)]
        public int AddGiayMoi(GiayMoi giaymoi)
        {
            int id = giaymoi.Id;

            using (var scope = new TransactionScope())
            {
                if (id == 0)
                {
                    id = _giaymoiBusiness.AddGiayMoi(giaymoi);
                    if (id < 0)
                    {
                        return -1;
                    }
                }

                scope.Complete();
                return id;

            }

        }

        public int AddOnlyGiayMoi(GiayMoi giaymoi)
        {
            return _giaymoiBusiness.AddGiayMoi(giaymoi);
        }

        public ActionResult AddKhachMoi(KhachMoi khachmoi)
        {

            int idkhachmoi = _khachmoiBusiness.AddKhachMoi(khachmoi);
            return Json(new { result = idkhachmoi }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteGiayMoi(int Id)
        {
            int result = _giaymoiBusiness.DeleteGiayMoi(Id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult DeleteKhachMoi(int Id)
        {
            int result = _khachmoiBusiness.DeleteKhachMoi(Id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }


        //load giay moi by ID
        public ActionResult LoadGiayMoiById(int id)
        {

            GiayMoi result = _giaymoiBusiness.GetGiayMoitByGiayMoitId(id);
            GiayMoiViewModel _giaymoiviewmodel = new GiayMoiViewModel();
            _giaymoiviewmodel.id = result.Id;
            _giaymoiviewmodel.Ten = result.Ten;
            _giaymoiviewmodel.Loai = result.Loai;
            _giaymoiviewmodel.Mau = result.Mau;
            _giaymoiviewmodel.NgayMoi = result.NgayMoi;
            _giaymoiviewmodel.NgaySuKien = result.NgaySuKien;
            _giaymoiviewmodel.DiaDiem = result.DiaDiem;
            _giaymoiviewmodel.NguoiGoi = result.NguoiGoi;
            _giaymoiviewmodel.ThoiGian = result.ThoiGian;
            _giaymoiviewmodel.MauId = result.MauId;
            if (_giaymoiviewmodel.MauId.Equals("0"))
            {
                _giaymoiviewmodel.MauId = null;
            }



            return Json(new { result = _giaymoiviewmodel }, JsonRequestBehavior.AllowGet);
        }
        //load khach moi by ID
        public ActionResult LoadKhachMoiById(int id)
        {

            KhachMoi result = _khachmoiBusiness.GetKhachMoiByKhachMoiId(id);
            KhachMoiViewModel _khachmoiviewmodel = new KhachMoiViewModel();
            _khachmoiviewmodel.id = result.id;
            _khachmoiviewmodel.HoTen = result.HoTen;
            _khachmoiviewmodel.ChucDanh = result.ChucDanh;
            _khachmoiviewmodel.DiaChi = result.DiaChi;
            _khachmoiviewmodel.SoDienThoai = result.SoDienThoai;
            _khachmoiviewmodel.Email = result.Email;
            _khachmoiviewmodel.GhiChu = result.GhiChu;

            return Json(new { result = _khachmoiviewmodel }, JsonRequestBehavior.AllowGet);
        }


        



        //update giay moi 
        [ValidateInput(false)]
        public ActionResult UpdateGiayMoi(GiayMoi giaymoi)
        {
            int result = _giaymoiBusiness.UpdateGiayMoi(giaymoi);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }

        //update khach moi 
        
        public ActionResult UpdateKhachMoi(KhachMoi khachmoi)
        {
            int result = _khachmoiBusiness.UpdateKhachMoi(khachmoi);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult LoadKhachMoi(int idGiayMoi)
        {
            List<KhachMoi> result = _khachmoiBusiness.getAllKhachMoibyGiayMoiId(idGiayMoi);
            List<KhachMoiViewModel> lstModel = new List<KhachMoiViewModel>();
            if (result.Count > 0)
            {

                foreach (KhachMoi item in result)
                {
                    KhachMoiViewModel vm = new KhachMoiViewModel();
                    vm.id = item.id;
                    vm.HoTen = item.HoTen;
                    vm.ChucDanh = item.ChucDanh;
                    vm.DiaChi = item.DiaChi;
                    vm.SoDienThoai = item.SoDienThoai;
                    vm.Email = item.Email;
                    vm.GhiChu = item.GhiChu;
                    vm.GiayMoiId = item.GiayMoiId;

                    lstModel.Add(vm);
                }
            }
            return PartialView("_KhachMoiMember", lstModel);
        }
    }
}