using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ThuyenChuyenLinhMucController : Controller
    {
        private readonly ThuyenChuyenLinhMucBusiness _thuyenChuyenLinhMucBusiness;
        private readonly ParishManagerBusiness _parishManagerBusiness;
        private readonly PriestBusiness _priestBusiness;
        private readonly VaiTroBusiness _vaiTroBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly GeneralStatusBusiness _generalStatusBusiness;
        public ThuyenChuyenLinhMucController()
        {
            _thuyenChuyenLinhMucBusiness = new ThuyenChuyenLinhMucBusiness(DbConfig.GetConnectionString());
            _parishManagerBusiness = new ParishManagerBusiness(DbConfig.GetConnectionString());
            _priestBusiness = new PriestBusiness(DbConfig.GetConnectionString());
            _vaiTroBusiness = new VaiTroBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _generalStatusBusiness = new GeneralStatusBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult LoadDataThuyenChuyenLinhMuc(jQueryDataTableParamModel param, int type)
        {
            //int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _thuyenChuyenLinhMucBusiness.GetOrderedThuyenChuyenLinhMucByParamsAndPaging(0,
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
        public ActionResult LoadTCLMById(int id)
        {
            ThuyenChuyenLinhMuc thuyenChuyenLinhMuc = _thuyenChuyenLinhMucBusiness.GetThuyenChuyenLinhMucById(id);
            var converter = new DateConverter();
            thuyenChuyenLinhMuc.NgayQuyetDinh = converter.ConvertStringToDate(thuyenChuyenLinhMuc.NgayQuyetDinh);
            thuyenChuyenLinhMuc.NgayHieuLuc = converter.ConvertStringToDate(thuyenChuyenLinhMuc.NgayHieuLuc);
            thuyenChuyenLinhMuc.ParishManagers = null;
            return Json(new { result = thuyenChuyenLinhMuc }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LoadParishManagerByTCLM(int idTCLM)
        {
            Session["TCLMId"] = idTCLM;
            List<ParishManager> result = _parishManagerBusiness.GetParishManagerByTCLMId(idTCLM);
            List<ParishManagerViewModel> lstModel = new List<ParishManagerViewModel>();
            if (result.Count > 0)
            {
                var converter = new DateConverter();
                foreach (ParishManager item in result)
                {
                    ParishManagerViewModel vm = new ParishManagerViewModel();
                    vm.Id = item.Id;
                    vm.ParishId = item.ParishId;
                    vm.PriestId = item.PriestId;
                    vm.StartDate = converter.ConvertStringToDate(item.StartDate);
                    vm.EndDate = converter.ConvertStringToDate(item.EndDate);
                    vm.Position = item.Position;
                    vm.PositionName = item.VaiTro != null ? item.VaiTro.Name : string.Empty;
                    vm.IdThuyenChuyenLinhMuc = item.IdThuyenChuyenLinhMuc;
                    vm.Parish = item.Parish != null ? item.Parish.Name : string.Empty;
                    vm.Priest = item.Priest.Name;
                    vm.ChristianName = item.Priest.ChristianName;
                    vm.BirthDate = converter.ConvertStringToDate(item.Priest.BirthDate);
                    vm.ParishCurrent = _parishManagerBusiness.GetCurrentParishByParishManagerId(item.Id);
                    if (vm.ParishCurrent == null || vm.ParishCurrent == string.Empty)
                    {
                        if (item.Priest != null)
                        {
                            if (item.Priest.Parishes != null && item.Priest.Parishes.Count > 0)
                            {
                                vm.ParishCurrent = item.Priest.Parishes.FirstOrDefault().Name;
                            }
                        }
                    }
                    vm.Code = item.Code;
                    vm.StatusId = item.StatusId;
                    lstModel.Add(vm);
                }
                ViewBag.ListVaiTro = _vaiTroBusiness.GetAllVaiTro();
                ViewBag.ListParish = _parishBusiness.GetAllParish();
                ViewBag.ListStatus = _generalStatusBusiness.GetStatusTCLM();
            }
            return PartialView("_ParishManagerTable", lstModel);
        }
        public int AddThuyenChuyenLinhMuc(ThuyenChuyenLinhMuc thuyenChuyenLinhMuc, int priestId)
        {
            //int parishId = (int)Session["ParishId"];
            var converter = new DateConverter();
            thuyenChuyenLinhMuc.NgayQuyetDinh = converter.ConvertDateToString(thuyenChuyenLinhMuc.NgayQuyetDinh);
            thuyenChuyenLinhMuc.NgayHieuLuc = converter.ConvertDateToString(thuyenChuyenLinhMuc.NgayHieuLuc);
            //thuyenChuyenLinhMuc.ParishId = parishId;
            int id = thuyenChuyenLinhMuc.Id;
            using (var scope = new TransactionScope())
            {
                if (id == 0)
                {
                    //Add ThuyenChuyenLinhMuc
                    id = _thuyenChuyenLinhMucBusiness.AddThuyenChuyenLinhMuc(thuyenChuyenLinhMuc);
                    //Add ParishManager
                    if (id < 0)
                    {
                        return -1;
                    }
                }
                //check exist priest
                bool bExistPriest = _parishManagerBusiness.CheckExistPriest(id, priestId);
                if (bExistPriest)
                {
                    return -2;
                }

                Priest priest = _priestBusiness.GetPriestByPriestId(priestId);
                if (priest != null)
                {
                    var parishManager = new ParishManager()
                    {
                        IdThuyenChuyenLinhMuc = id,
                        ParishId = null,
                        PriestId = priest.Id,
                        StartDate = thuyenChuyenLinhMuc.NgayHieuLuc,
                        EndDate = string.Empty,
                        Position = null,
                        PositionName = string.Empty
                    };
                    int newParishManagerId = _parishManagerBusiness.AddParishManager(parishManager);
                    if (newParishManagerId < 0)
                    {
                        return newParishManagerId;
                    }                    
                }
                else
                {
                    return -1;
                }

                //If success all
                scope.Complete();
                return id;

            }
        }
        public ActionResult UpdateThuyenChuyenLinhMuc(ThuyenChuyenLinhMuc thuyenChuyenLinhMuc)
        {
            var converter = new DateConverter();
            thuyenChuyenLinhMuc.NgayQuyetDinh = converter.ConvertDateToString(thuyenChuyenLinhMuc.NgayQuyetDinh);
            thuyenChuyenLinhMuc.NgayHieuLuc = converter.ConvertDateToString(thuyenChuyenLinhMuc.NgayHieuLuc);
            int result = _thuyenChuyenLinhMucBusiness.UpdateSacramentGroup(thuyenChuyenLinhMuc);
            List<ParishManager> lstParishManager = _parishManagerBusiness.GetParishManagerByTCLMId(thuyenChuyenLinhMuc.Id);
            if (lstParishManager != null && lstParishManager.Count > 0)
            {
                foreach (ParishManager parishManager in lstParishManager)
                {
                    parishManager.StartDate = thuyenChuyenLinhMuc.NgayHieuLuc;
                    _parishManagerBusiness.UpdateParishManager(parishManager);
                    _parishManagerBusiness.UpdateEndDateParishManager(parishManager);
                }
            }
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteTCLM(int id)
        {
            int result = _thuyenChuyenLinhMucBusiness.DeleteThuyenChuyenLinhMuc(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult RemovePriestFromTCLM(int id)
        {
            int result = _thuyenChuyenLinhMucBusiness.RemovePriest(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UpdateValue(int id, string columnName, string value)
        {
            int result = _thuyenChuyenLinhMucBusiness.UpdateValue(id, columnName, value);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ViewHistoryThuyenChuyen(int priestId)
        {
            List<ParishManager> result = _parishManagerBusiness.GetParishManagerByPriestId(priestId);
            List<ParishManagerViewModel> lstModel = new List<ParishManagerViewModel>();
            if (result.Count > 0)
            {
                var converter = new DateConverter();
                foreach (ParishManager item in result)
                {
                    ParishManagerViewModel vm = new ParishManagerViewModel();
                    vm.Id = item.Id;
                    vm.ParishId = item.ParishId;
                    vm.PriestId = item.PriestId;
                    vm.StartDate = converter.ConvertStringToDate(item.StartDate);
                    vm.EndDate = converter.ConvertStringToDate(item.EndDate);
                    vm.Position = item.Position;
                    vm.PositionName = item.VaiTro != null ? item.VaiTro.Name : string.Empty;
                    vm.IdThuyenChuyenLinhMuc = item.IdThuyenChuyenLinhMuc;
                    vm.Parish = item.Parish != null ? item.Parish.Name : string.Empty;
                    vm.Priest = item.Priest.Name;
                    vm.ChristianName = item.Priest.ChristianName;
                    vm.BirthDate = converter.ConvertStringToDate(item.Priest.BirthDate);
                    lstModel.Add(vm);
                }
            }
            return PartialView("_ParishManagerHistory", lstModel);
        }

        public ActionResult InQuyetDinh(string Ids)
        {
            List<ParishManager> result = _parishManagerBusiness.GetParishManagerByListId(Ids);
            List<PrintParishManagerViewModel> lstModel = new List<PrintParishManagerViewModel>();
            if (result != null && result.Count > 0)
            {
                var converter = new DateConverter();
                foreach (ParishManager item in result)
                {
                    PrintParishManagerViewModel vm = new PrintParishManagerViewModel();
                    vm.Id = item.Id;
                    vm.ParishId = item.ParishId;
                    vm.PriestId = item.PriestId;
                    vm.StartDate = converter.ConvertStringToDate(item.StartDate);
                    vm.EndDate = converter.ConvertStringToDate(item.EndDate);
                    vm.Position = item.Position;
                    vm.PositionName = item.VaiTro != null ? item.VaiTro.Name : string.Empty;
                    vm.IdThuyenChuyenLinhMuc = item.IdThuyenChuyenLinhMuc;
                    vm.Parish = item.Parish != null ? item.Parish.Name : string.Empty;
                    vm.Priest = item.Priest.Name;
                    vm.ChristianName = item.Priest.ChristianName;
                    vm.BirthDate = converter.ConvertStringToDate(item.Priest.BirthDate);
                    //vm.ParishCurrent = _parishManagerBusiness.GetCurrentParishByParishManagerId(item.Id);
                    if (item.Parish != null)
                    {
                        vm.ParishAddress = item.Parish.Address;
                        vm.ParishWard = item.Parish.Ward;
                        vm.ParishDistrict = item.Parish.District;
                        vm.ParishProvince = item.Parish.Province;
                    }
                    //get current Parish
                    int currentParishId = _parishManagerBusiness.GetCurrentParishIdByParishManagerId(item.Id);
                    if (currentParishId != 0)
                    {
                        Parish parish = _parishBusiness.GetParishesByParishId(currentParishId);
                        if (parish != null)
                        {
                            vm.ParishCurrent = parish.Name;
                            vm.ParishCurrentAddress = parish.Address;
                            vm.ParishCurrentWard = parish.Ward;
                            vm.ParishCurrentDistrict = parish.District;
                            vm.ParishCurrentProvince = parish.Province;
                        }
                    }
                    else
                    {
                        if (item.Priest != null)
                        {
                            if (item.Priest.Parishes != null && item.Priest.Parishes.Count > 0)
                            {
                                vm.ParishCurrent = item.Priest.Parishes.FirstOrDefault().Name;
                                vm.ParishCurrentAddress = item.Priest.Parishes.FirstOrDefault().Address;
                                vm.ParishCurrentWard = item.Priest.Parishes.FirstOrDefault().Ward;
                                vm.ParishCurrentDistrict = item.Priest.Parishes.FirstOrDefault().District;
                                vm.ParishCurrentProvince = item.Priest.Parishes.FirstOrDefault().Province;
                            }
                        }
                    }
                    vm.Code = item.Code;
                    vm.NguoiQuyetDinh = item.ThuyenChuyenLinhMuc.NguoiQuyetDinh;

                    lstModel.Add(vm);

                    item.StatusId = 2;
                    item.TakenDate = null;
                    _parishManagerBusiness.UpdateParishManager(item);
                }
                //ViewBag.ListVaiTro = _vaiTroBusiness.GetAllVaiTro();
                //ViewBag.ListParish = _parishBusiness.GetAllParish();
            }
            return PartialView(lstModel);
        }
        public ActionResult InGiayMoi(string Ids)
        {
            List<ParishManager> result = _parishManagerBusiness.GetParishManagerByListId(Ids);
            List<PrintParishManagerViewModel> lstModel = new List<PrintParishManagerViewModel>();
            if (result != null && result.Count > 0)
            {
                var converter = new DateConverter();
                foreach (ParishManager item in result)
                {
                    PrintParishManagerViewModel vm = new PrintParishManagerViewModel();
                    vm.Id = item.Id;
                    vm.ParishId = item.ParishId;
                    vm.PriestId = item.PriestId;
                    vm.StartDate = converter.ConvertStringToDate(item.StartDate);
                    vm.EndDate = converter.ConvertStringToDate(item.EndDate);
                    vm.Position = item.Position;
                    vm.PositionName = item.VaiTro != null ? item.VaiTro.Name : string.Empty;
                    vm.IdThuyenChuyenLinhMuc = item.IdThuyenChuyenLinhMuc;
                    vm.Parish = item.Parish != null ? item.Parish.Name : string.Empty;
                    vm.Priest = item.Priest.Name;
                    vm.ChristianName = item.Priest.ChristianName;
                    vm.BirthDate = converter.ConvertStringToDate(item.Priest.BirthDate);
                    //vm.ParishCurrent = _parishManagerBusiness.GetCurrentParishByParishManagerId(item.Id);                    
                    if (item.Parish != null)
                    {
                        vm.ParishAddress = item.Parish.Address;
                        vm.ParishWard = item.Parish.Ward;
                        vm.ParishDistrict = item.Parish.District;
                        vm.ParishProvince = item.Parish.Province;
                        vm.VicariateName = item.Parish.Vicariate.Name;
                    }
                    //get current Parish
                    int currentParishId = _parishManagerBusiness.GetCurrentParishIdByParishManagerId(item.Id);
                    if (currentParishId != 0)
                    {
                        Parish parish = _parishBusiness.GetParishesByParishId(currentParishId);
                        if (parish != null)
                        {
                            vm.ParishCurrent = parish.Name;
                            vm.ParishCurrentAddress = parish.Address;
                            vm.ParishCurrentWard = parish.Ward;
                            vm.ParishCurrentDistrict = parish.District;
                            vm.ParishCurrentProvince = parish.Province;
                            vm.VicariateName = parish.Vicariate.Name;
                        }
                    }
                    else
                    {
                        if (item.Priest != null)
                        {
                            if (item.Priest.Parishes != null && item.Priest.Parishes.Count > 0)
                            {
                                vm.ParishCurrent = item.Priest.Parishes.FirstOrDefault().Name;
                                vm.ParishCurrentAddress = item.Priest.Parishes.FirstOrDefault().Address;
                                vm.ParishCurrentWard = item.Priest.Parishes.FirstOrDefault().Ward;
                                vm.ParishCurrentDistrict = item.Priest.Parishes.FirstOrDefault().District;
                                vm.ParishCurrentProvince = item.Priest.Parishes.FirstOrDefault().Province;
                                vm.VicariateName = item.Priest.Parishes.FirstOrDefault().Vicariate.Name;
                            }
                        }
                    }
                    vm.Code = item.Code;
                    vm.NguoiQuyetDinh = item.ThuyenChuyenLinhMuc.NguoiQuyetDinh;

                    lstModel.Add(vm);

                    item.StatusId = 1;
                    item.TakenDate = null;
                    _parishManagerBusiness.UpdateParishManager(item);
                }
                //ViewBag.ListVaiTro = _vaiTroBusiness.GetAllVaiTro();
                //ViewBag.ListParish = _parishBusiness.GetAllParish();
            }
            return PartialView(lstModel);
        }
        public ActionResult UpdateEditableCode(ParishManager parishManager)
        {
            int result = _parishManagerBusiness.UpdateEditableCode(parishManager);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
	}
}