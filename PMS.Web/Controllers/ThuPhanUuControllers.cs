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
    public class ThuPhanUuController : Controller
    {
        private readonly ThuPhanUuBusiness _thuPhanUuBusiness;
        private readonly ParishBusiness _parishBusiness;

        public ThuPhanUuController()
        {
            _thuPhanUuBusiness = new ThuPhanUuBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
        }
        
        public ActionResult Index()
        {
            List<ThuPhanUuViewModel> lstEmail = _thuPhanUuBusiness.GetAllThuPhanUu();
            var parish = _parishBusiness.GetAllParish().ToList();
            ViewBag.Parishes = parish;
            return View(lstEmail);
        }

        public ActionResult GetOrderedThuPhanUuByParamsAndPaging(jQueryDataTableParamModel param, int type)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            var result = _thuPhanUuBusiness.GetOrderedThuPhanUuByParamsAndPaging(type,
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

        public ActionResult AddThuPhanUu(string parentRole, int deathManId, string deathDate)
        {
            var thuPhanUu = new ThuPhanUu();
            thuPhanUu.MaGiaoDan = deathManId;
            thuPhanUu.ChucVu = parentRole;
            //thuPhanUu.MauThu = letterTemplate;
            thuPhanUu.NgayMat = Convert.ToDateTime(deathDate);
            int idNew = _thuPhanUuBusiness.AddThuPhanUu(thuPhanUu);
            ThuPhanUuViewModel item = _thuPhanUuBusiness.GetThuPhanUuById(idNew.ToString());
            return Json(new { result = item }, JsonRequestBehavior.AllowGet);
        }

        public int AddThuPhanUu_NguoiNhan(int id, int nguoiNhan)
        {
            var item = new ThuPhanUu_NguoiNhan();
            item.ThuPhanUuId = id;
            item.NguoiNhanId = nguoiNhan;

            int result = _thuPhanUuBusiness.AddThuPhanUu_NguoiNhan(item);
            return result;
        }

        public int DeleteThuPhanUu_NguoiNhan(int id, int maGiaoDan)
        {
            return _thuPhanUuBusiness.DeleteThuPhanUu_NguoiNhan(id, maGiaoDan);
        }

        public int DeleteThuPhanUu(int id)
        {
            return _thuPhanUuBusiness.DeleteThuPhanUu(id);
        }

        public string UpdateThuPhanUu_NguoiNhan(int id, string christianName, string sendToName)
        {
            string strResult = string.Empty;
            ThuPhanUu_NguoiNhan item = new ThuPhanUu_NguoiNhan();
            int result = 0;// _thuPhanUuBusiness.UpdateThuPhanUu_NguoiNhan(id, christianName, sendToName);
            if (result >= 0)
            {
                string buttonRender = "<a class='btn btn-minier btn-primary' onclick=\"LoadThuPhanUu_NguoiNhan('"
                    + id.ToString() + "','" + christianName + "','" + sendToName + "')\"><i class='ace-icon fa fa-pencil'></i>Sửa" +
                        "</a>&nbsp;<a class='btn btn-minier btn-danger' onclick=\"DeleteCESendToConfirm('" + id.ToString() + "')\"><i class='ace-icon fa fa-trash-o'></i>Xóa</a>";
                strResult = "<tr id='trSendTo" + id.ToString() + "'><td>" + christianName + "</td><td>" + sendToName + "</td><td>" + buttonRender + "</td></tr>";
            }
            return strResult;
        }

        public int UpdateThuPhanUu(int thuPhanUuId, string parentRole, int deathManId, string deathDate)
        {
            var thuPhanUu = new ThuPhanUu();
            thuPhanUu.Id = thuPhanUuId;
            thuPhanUu.MaGiaoDan = deathManId;
            thuPhanUu.ChucVu = parentRole;
            thuPhanUu.NgayMat = Convert.ToDateTime(deathDate);
            _thuPhanUuBusiness.UpdateThuPhanUu(thuPhanUu);
            return thuPhanUu.Id;
        }

        public ActionResult GetThuPhanUuById(string Id)
        {
            //return string.Empty;
            ThuPhanUuViewModel thuPhanUu = _thuPhanUuBusiness.GetThuPhanUuById(Id);

            JsonResult jr = Json(new { result = thuPhanUu }, JsonRequestBehavior.AllowGet);
            return jr;
        }

        public ActionResult LoadDanhSachNguoiNhanThu(string Id)
        {
            var result = _thuPhanUuBusiness.LoadDanhSachNguoiNhanThu(Id);
            return Json(new
            {
                //sEcho = param.sEcho,
                //iTotalRecords = totalRecords,
                //iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult InThuPhanUu(int idThuPhanUu, string Ids)
        {
            var lstThuPhanUu = _thuPhanUuBusiness.PrintThuPhanUuByIds(idThuPhanUu, Ids);
            // Khoan mod start
            //return PartialView(lstThuPhanUu);
            string html = Utilities.PMSCommon.RenderViewToString(this.ControllerContext, "InThuPhanUu", lstThuPhanUu);
            ViewBag.Body = html;
            ViewBag.Title = "In Thu Phan Uu";
            return PartialView("_PrintLayout");
            // Khoan mod end
        }
    }
}