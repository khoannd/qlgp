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
    public class FamilyController : Controller
    {

        private readonly CommunityBusiness _communityBusiness;
        private readonly FamilyBusiness _familyBusiness;
        private readonly ConfigurationBusiness _configurationBusiness;
        private readonly ChangeParishBusiness _changeParishBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly VocationBusiness _vocationBusiness;
        private readonly VaiTroBusiness _vaitroBusiness;
        private readonly DioceseBusiness _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
        private readonly VicariateBusiness _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());

        public FamilyController()
        {
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _familyBusiness = new FamilyBusiness(DbConfig.GetConnectionString());
            _configurationBusiness = new ConfigurationBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _vocationBusiness = new VocationBusiness(DbConfig.GetConnectionString());
            _vaitroBusiness = new VaiTroBusiness(DbConfig.GetConnectionString());
        }
        //
        // GET: /Family/
        [SessionExpireFilter]
        public ActionResult Index()
        {
            int parishId = (int)Session["ParishId"];

            List<Community> communities = _communityBusiness.GetCommunitiesByParishId(parishId);
            List<Community> parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);

            List<Vicariate> vicariates = _vicariateBusiness.getAllVicariate().ToList();
            List<Parish> parishs = _parishBusiness.GetAllParish().ToList();
            List<Diocese> dioceses = _dioceseBusiness.GetAllDioceses();

            ViewBag.Communities = communities;
            ViewBag.ParishDivisions = parishDivisions;
            ViewBag.Parishes = parishs;
            ViewBag.Vicariates = vicariates;
            ViewBag.Dioceses = dioceses;

            ViewBag.VaiTro = _vaitroBusiness.GetAllVaiTro().ToList();
            ViewBag.TypeCode = _vocationBusiness.GetTypeCodes().ToList();

            return View();
        }

        [SessionExpireFilter]
        public ActionResult SaveStorage()
        {
            int parishId = (int)Session["ParishId"];

            List<Community> communities = _communityBusiness.GetCommunitiesByParishId(parishId);
            List<Community> parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);
            //2023/08/27 gnguyen start add 
            List<Parish> parishs = _parishBusiness.GetAllParish().ToList();
            ViewBag.Parishes = parishs;
            //2023/08/27 gnguyen end add 
            ViewBag.Communities = communities;
            ViewBag.ParishDivisions = parishDivisions;

            return View();
        }

        public ActionResult LoadFamiliesDatatables(jQueryDataTableParamModel param, int communityId, int parishDivisionId,
                                                                                bool isCounted, int status, int changeParishFamily = 0)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            var result = _familyBusiness.GetOrderedFamiliesByParamsAndPaging(parishId, communityId, parishDivisionId, isCounted, status,
                                                                         param.sSearch, changeParishFamily, param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                                                                         param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);


        }
        public int CheckFamilyCode()
        {
            int parishId = (int)Session["ParishId"];
            Configuration config = _configurationBusiness.GetConfigurationByParishId(parishId);

            if (config == null)
            {
                return -1;
            }

            if (config.FamilyCodeGeneration == 0)
            {
                return 0;
            }
            return 1;
        }

        public ActionResult CheckFamilyMember(int parishionerId)
        {
            bool isHouseholder = false;
            int result = 0;
            int status = 0;

            var family = _familyBusiness.GetFamilyByParishionerId(parishionerId, out isHouseholder, out status, out result);

            string familyName = "";
            int id = 0;

            if (family != null)
            {
                familyName = family.Name;
                id = family.Id;
            }

            return Json(new
            {
                result = result,
                isHouseholder = isHouseholder,
                familyName = familyName,
                familyId = id,
                status = status
            }, JsonRequestBehavior.AllowGet);
        }

        public int ChangeFamilyStatus(int id, int status, bool isForced)
        {
            string username = (string)Session["Username"];
            return _familyBusiness.ChangeFamilyStatus(id, status, username, isForced);
        }

        //-----------------------------------------
        public ActionResult GetFamilyMembersByFamilyId(int id)
        {
            var members = _familyBusiness.GetFamilyMembersByFamilyId(id);
            return PartialView("_FamilyMember", members);
        }
        public ActionResult GetReadonlyFamilyMembersByFamilyId(int id)
        {
            var members = _familyBusiness.GetFamilyMembersByFamilyId(id);
            return PartialView("_ViewReadonlyFamilyMember", members);
        }

        public ActionResult AddFamilyMember(Family family, int parishionerId)
        {

            //Them Family vao neu chua co
            using (var scope = new TransactionScope(Utilities.PMSCommon.GetTransactionOption()))
            {

                if (family.Id == 0)
                {
                    family.Status = (int)FamilyStatusEnum.Available;
                    int parishId = (int)Session["ParishId"];
                    int dioceseId = (int)Session["DioceseId"];

                    // Code Generation       
                    Configuration config = _configurationBusiness.GetConfigurationByParishId(parishId);

                    if (config == null)
                    {
                        return Json(new
                        {
                            result = 0
                        }, JsonRequestBehavior.AllowGet);
                    }

                    if (config.FamilyCodeGeneration != 0)
                    {
                        //Generate Code
                        family.Code = _familyBusiness.LoadFamilyCode(parishId, config.FamilyPrefix, config.FamilyCharacterNumber);
                    }
                    else
                    {
                        //Check Existed Code
                        int result = _familyBusiness.CheckFamilyCode(family.Code, parishId);
                        if (result == 0)
                        {
                            return Json(new
                            {
                                result = -2
                            }, JsonRequestBehavior.AllowGet);
                        }
                        else if (result == -1)
                        {
                            return Json(new
                            {
                                result = -1
                            }, JsonRequestBehavior.AllowGet);
                        }
                    }

                    if (string.IsNullOrEmpty(family.Code))
                    {
                        return Json(new
                        {
                            result = 0
                        }, JsonRequestBehavior.AllowGet);
                    }

                    family.Id = _familyBusiness.AddFamily(family);

                    //if (family.Id > 0)
                    //{

                    //    if (family.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish)
                    //    {
                    //        //Tim ra giao xu can duoc chuyen
                    //        if (string.IsNullOrEmpty(family.DomicilePlace))
                    //        {
                    //            family.DomicilePlace = "";
                    //        }

                    //        //Cho nay giao xu bi trung giao xu minh thi sao ?
                    //        int toParishId = _changeParishBusiness.CheckOtherParish(family.DomicilePlace, parishId,
                    //            dioceseId);

                    //        if (toParishId == -1)
                    //        {
                    //            return -1;
                    //        }
                    //        else if (toParishId == 0)
                    //        {
                    //            toParishId = -1;
                    //        }

                    //        //Goi ham chuyen xu
                    //        var ids = new string[1];
                    //        ids[0] = family.Id.ToString();

                    //        var r = _changeParishBusiness.ChangeParishForFamily(ids, toParishId, family.DomicilePlace);

                    //        if (r < 1)
                    //        {
                    //            return r;
                    //        }
                    //    }

                    //}

                }

                //Add thanh vien //De nghi suggest thanh vien
                int id = _familyBusiness.AddFamilyMember(family.Id, parishionerId);

                if (id <= 0)
                {
                    return Json(new
                    {
                        result = 0
                    }, JsonRequestBehavior.AllowGet);
                }

                scope.Complete();
                return Json(new
                {
                    result = 1,
                    familyId = family.Id,
                    memberId = id
                }, JsonRequestBehavior.AllowGet);
            }

        }

        public ActionResult SuggestMoreMember(int memberId)
        {
            int parishId = (int)Session["ParishId"];
            var parishioner = _familyBusiness.SuggestMoreMember(memberId, parishId);

            if (parishioner == null)
            {
                return Json(new
                {
                    result = 0
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                result = 1,
                parishionerId = parishioner.Id,
                name = string.IsNullOrEmpty(parishioner.ChristianName) ? parishioner.Name : parishioner.ChristianName + " " + parishioner.Name
            }, JsonRequestBehavior.AllowGet);
        }

        public int CheckExistedFamilyCode(string code)
        {
            int parishId = (int)Session["ParishId"];
            // Code Generation       
            Configuration config = _configurationBusiness.GetConfigurationByParishId(parishId);
            if (config == null)
            {
                return 0;
            }

            if (config.FamilyCodeGeneration == 0)
            {
                //Check Existed Code
                int result = _familyBusiness.CheckFamilyCode(code, parishId);
                if (result == 0)
                {
                    return -2;
                }
            }

            return 1;
        }

        public int UpdateFamily(Family family)
        {

            int result = _familyBusiness.UpdateFamily(family);
            if (result > 0)
            {
                int parishId = (int)Session["ParishId"];
                int dioceseId = (int)Session["DioceseId"];

                if (family.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish)
                {
                    //Tim ra giao xu can duoc chuyen
                    if (string.IsNullOrEmpty(family.DomicilePlace))
                    {
                        family.DomicilePlace = "";
                    }

                    //Cho nay giao xu bi trung giao xu minh thi sao ?
                    int toParishId = _changeParishBusiness.CheckOtherParish(family.DomicilePlace, parishId,
                        dioceseId);

                    if (toParishId == parishId)
                    {
                        return -4;
                    }

                    if (toParishId == -1)
                    {
                        return -1;
                    }
                    else if (toParishId == 0)
                    {
                        toParishId = -1;
                    }

                    //Goi ham chuyen xu
                    var ids = new string[1];
                    ids[0] = family.Id.ToString();

                    var r = _changeParishBusiness.ChangeParishForFamily(ids, toParishId, family.DomicilePlace);

                    if (r < 1)
                    {
                        return r;
                    }
                }
            }
            else
            {
                return result;
            }

            return 1;
        }

        public int DeleteFamilyMember(int id)
        {
            int result = _familyBusiness.DeleteFamilyMember(id);
            return result;
        }

        public ActionResult GetFamilyById(int id)
        {
            var family = _familyBusiness.GetFamilyById(id);

            int? communityId = 0;
            string communityName = null;
            string parishName = "";
            if (family != null)
            {
                communityId = family.CommunityId;
                communityName = family.Community.Name;
                parishName = family.Community.Parish.Name;
                //Remove Reference
                family.FamilyMembers = null;
                family.FamilyMigrationRequests = null;
                family.Community = null;
            }

            return Json(new
            {
                result = family,
                communityId = communityId,
                communityName = communityName,
                parishName = parishName
            }, JsonRequestBehavior.AllowGet);
        }

        public int ChangeFamilyPosition(int memberId, int familyId, int position)
        {
            return _familyBusiness.ChangeFamilyPosition(memberId, familyId, position);
        }

        //-----------------------------------------

    }
}