using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.DataAccess.Models;
using PMS.BusinessLogic;
using PMS.DataAccess.ViewModels;
using System.Transactions;
using PMS.DataAccess.Utilities;

namespace PMS.Web.Controllers
{
    public class HoiDongLinhMucController : Controller
    {
        private readonly PriestBusiness _priestBusiness;
        private readonly HoiDongLinhMucBusiness _hdlmBusiness;
        private readonly HDLMMemberBusiness _hdlmMemberBusiness;
        private readonly ValueSetBusiness _valuesetBusiness;

        public HoiDongLinhMucController()
        {
            _priestBusiness = new PriestBusiness(DbConfig.GetConnectionString());
            _hdlmBusiness = new HoiDongLinhMucBusiness(DbConfig.GetConnectionString());
            _hdlmMemberBusiness = new HDLMMemberBusiness(DbConfig.GetConnectionString());
            _valuesetBusiness = new ValueSetBusiness(DbConfig.GetConnectionString());
        } 

        // GET: HoiDongLinhMuc
        public ActionResult Index()
        {
            //get all priest -> need to improve (all priest not are leader of any HDLM)
            var priest = _priestBusiness.GetAllPriests().ToList();
            ViewBag.Priests = priest;
            return View();
        }

        public ActionResult LoadAllHoiDongLinhMuc(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _hdlmBusiness.LoadAllHDLM(param.sSearch,
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

        /// <summary>
        /// Add Hoi Hong Linh Muc
        /// VuongVM
        /// </summary>
        /// <returns>id</returns>
        public int AddHDLM(HoiDongLinhMuc hdlm, int priestId)
        {
            int id = hdlm.Id;
            using (var scope = new TransactionScope())
            {
                if (id == 0)
                {
                    id = _hdlmBusiness.AddHDLM(hdlm);
                    if (id < 0)
                    {
                        return -1;
                    }
                }
                Priest priest = _priestBusiness.GetPriestByPriestId(priestId);
                if (priest != null)
                {
                    var hdlmMember = new HDLMMember()
                    {
                        HdlmID = id,
                        PriestID = priest.Id,
                        Role = 0
                    };
                    int memberStatus = _hdlmMemberBusiness.AddMember(hdlmMember);
                    if (memberStatus < 0)
                    {
                        return memberStatus;
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

        /// <summary>
        /// Load HDLM After Added
        /// VuongVM
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult LoadHDLMById(int id)
        {
            var hdlm = _hdlmBusiness.getHDLMById(id);
            return Json(new { result = hdlm }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Update HDLM
        /// VuongVM
        /// </summary>
        /// <param name="hdlm"></param>
        /// <returns></returns>
        public ActionResult UpdateHDLM(HoiDongLinhMuc hdlm)
        {
            int result = _hdlmBusiness.UpdateHDLM(hdlm);
            List<HDLMMember> lstMembers = _hdlmMemberBusiness.GetMemberByHDLM(hdlm.Id);
            if (lstMembers != null && lstMembers.Count > 0)
            {
                foreach (HDLMMember member in lstMembers)
                {
                    _hdlmBusiness.UpdateMembers(member);
                }
            }
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Load HDLM Members Whenever load HDLM
        ///  VuongVM
        /// </summary>
        /// <param name="idTCLM"></param>
        /// <returns></returns>
        public ActionResult LoadHDLMMembers(int idHDLM)
        {
            List<HDLMMember> result = _hdlmBusiness.getHDLMMembers(idHDLM);
            List<HDLMMemberViewModel> lstModel = new List<HDLMMemberViewModel>();
            if (result.Count > 0)
            {
                var converter = new DateConverter();
                foreach (HDLMMember item in result)
                {
                    HDLMMemberViewModel vm = new HDLMMemberViewModel();
                    vm.Id = item.PriestID;
                    vm.HdlmId = item.HdlmID;
                    vm.Phone = item.Priest.Phone;
                    vm.BirthDate = converter.ConvertStringToDate(item.Priest.BirthDate);
                    vm.ChristianName = item.Priest.ChristianName;
                    vm.Name = item.Priest.Name;
                    vm.Position = item.Role;
                    //getMemberRole
                    string roleName = _hdlmMemberBusiness.getMemberRole(item.Role);
                    vm.PositionName = roleName;
                    lstModel.Add(vm);
                }
                ViewBag.ListRole = _valuesetBusiness.getAllHDLMRole();
            }
            return PartialView("_HDLMMemberTable", lstModel);
        }

        public ActionResult DeleteHDLM(int id)
        {
            int result = _hdlmBusiness.DeleteHDLM(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public int CheckUniqueHDLM(string name, int id)
        {
            return _hdlmBusiness.CheckUniqueHDLM(name, id);
        }

        //remove Priest
        public ActionResult RemovePriestFromHDLM(int id)
        {
            int result = _hdlmBusiness.RemovePriest(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Update Role when change from dropdown list
        /// VuongVM
        /// </summary>
        /// <param name="id"></param>
        /// <param name="columnName"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public ActionResult UpdateRole(int id, string columnName, string value)
        {
            int result = _hdlmBusiness.UpdateRole(id, columnName, value);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

    }
}