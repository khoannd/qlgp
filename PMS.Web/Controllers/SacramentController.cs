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
    public class SacramentController : Controller
    {
        //
        // GET: /Sacrament/
        private readonly SacramentGroupBusiness _sacramentGroupBusiness;
        private readonly SacramentBusiness _sacramentBusiness;
        private readonly MatrimonyBusiness _matrimonyBusiness;
        private readonly ConfigurationBusiness _configurationBusiness;
        private readonly FamilyBusiness _familyBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;

        public SacramentController()
        {
            _sacramentGroupBusiness = new SacramentGroupBusiness(DbConfig.GetConnectionString());
            _sacramentBusiness = new SacramentBusiness(DbConfig.GetConnectionString());
            _matrimonyBusiness = new MatrimonyBusiness(DbConfig.GetConnectionString());
            _configurationBusiness = new ConfigurationBusiness(DbConfig.GetConnectionString());
            _familyBusiness = new FamilyBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]

        public ActionResult Index(int type)
        {
            if (type == 1 || type == 2 || type == 3 || type == 4)
            {
                ViewBag.SacramentType = type;

                int parishId = (int)Session["ParishId"];   
                Configuration familyConfig = _configurationBusiness.GetConfigurationByParishId(parishId);
                ViewBag.FamilyConfig = familyConfig.FamilyCodeGeneration;

                return View();
            }
            return HttpNotFound();
        }

        public ActionResult LoadSacramentGroupDatatables(jQueryDataTableParamModel param, int type)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _sacramentGroupBusiness.GetOrderedSacramentGroupByParamsAndPaging(type, parishId,
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

        public int AddSacramentGroup(SacramentGroup sacramentGroup, int parishionerId, string number, int type, string patron)
        {
            int parishId = (int)Session["ParishId"];
            var converter = new DateConverter();
            sacramentGroup.Date = converter.ConvertDateToString(sacramentGroup.Date);
            sacramentGroup.ParishId = parishId;
            int id = sacramentGroup.Id;
            using (var scope = new TransactionScope())
            {
                if (id == 0)
                {
                    //Add sacrament group
                    id = _sacramentGroupBusiness.AddSaracmentGroup(sacramentGroup);
                    //Add sacrament  
                     if(id < 0)
                    {
                        return -1;
                    }
                }
                var newsacrament = new Sacrament()
                {
                    SacramentGroupId = id,
                    ParishionerId = parishionerId,
                    Number = number,
                    Type = type,
                    Patron = patron,
                    Date = sacramentGroup.Date,
                    Giver = sacramentGroup.Giver,
                    ReceivedPlace = sacramentGroup.ReceivedPlace
                };
                int newsacramentId = _sacramentBusiness.AddSacrament(newsacrament);
                if (newsacramentId < 0)
                {
                    return newsacramentId;
                }
                          
                //If success all
                scope.Complete();
                return id;

            }
        }
        public int AddMatrimonySacramentGroup(SacramentGroup sacramentGroup)
        {
            int parishId = (int)Session["ParishId"];
            var converter = new DateConverter();
            sacramentGroup.Date = converter.ConvertDateToString(sacramentGroup.Date);
            sacramentGroup.ParishId = parishId;
            int id = sacramentGroup.Id;
            using (var scope = new TransactionScope())
            {
                if (id == 0)
                {
                    //Add sacrament group
                    id = _sacramentGroupBusiness.AddSaracmentGroup(sacramentGroup);
                    //Add sacrament  
                    if (id < 0)
                    {
                        return -1;
                    }
                }
     

                //If success all
                scope.Complete();
                return id;

            }
        }

        public int CheckMatrimonyCoupleBelongInternalParish(int husbandId, int wifeId)
        {
            int parishId = (int)Session["ParishId"];
            var husband = _parishionerBusiness.LoadParishionerById(husbandId);
            var wife = _parishionerBusiness.LoadParishionerById(wifeId);
            int result;
            if (husband.Community.ParishId != parishId && wife.Community.ParishId != parishId)
            {
                result = -2;
            }
            else if (husband.Community.ParishId != parishId || wife.Community.ParishId != parishId)
            {
                result = -1;
            }
            else
            {
                result = 0;
            }
            return result;
        }

        public int AddFamilyAndFamilyMember(Family family, int matrimonyId)
        {

            //Them Family vao neu chua co
            using (var scope = new TransactionScope())
            {
                Matrimony matrimony = _matrimonyBusiness.GetMatrimonyById(matrimonyId);
                if (matrimony == null)
                {
                    return 0;
                }

                if (family.Id == 0)
                {
                    family.Status = (int)FamilyStatusEnum.Available;
                    int parishId = (int)Session["ParishId"];

                    // Code Generation       
                    Configuration config = _configurationBusiness.GetConfigurationByParishId(parishId);

                    if (config == null)
                    {
                        return 0;
                    } 
                    //Generate Code
                    if (config.FamilyCodeGeneration == 1)
                    {
                        family.Code = _familyBusiness.LoadFamilyCode(parishId, config.FamilyPrefix, config.FamilyCharacterNumber);
                        if (string.IsNullOrEmpty(family.Code))
                        {
                            return 0;
                        }
                    }
                    else
                    {
                        family.Code = "";
                    }
                    
                    family.Name = matrimony.Name;
                    family.DomicileStatus = (int) DomicileStatusEnum.InParish;
                    family.IsCounted = true;
                    family.Status = (int) FamilyStatusEnum.Available;
                    family.CommunityId = matrimony.Parishioner.CommunityId;
                    
                    family.Id = _familyBusiness.AddFamily(family);
                }

                //Add thanh vien //De nghi suggest thanh vien
                int houseHolderId = _familyBusiness.AddFamilyMember(family.Id, matrimony.HusbandId);
                if (houseHolderId <= 0)
                {
                    return 0;
                }
                int wifeId = _familyBusiness.AddFamilyMember(family.Id, matrimony.WifeId);
                _familyBusiness.ChangeFamilyPosition(wifeId, family.Id, (int)FamilyEnum.Vo);
                if (wifeId <= 0)
                {
                    return 0;
                }

                scope.Complete();
                return family.Id;
            }

        }

        public int AddSacramentGroupIdForMatrimony(int id, int sacramentGroupId)
        {
            int result = _matrimonyBusiness.AddSacramentGroupIdForMatrimony(id, sacramentGroupId);
            return result;
        }

        public ActionResult CheckSacrament(int parishionerId, int type)
        {
            int result = _sacramentBusiness.CheckSacrament(parishionerId, type);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadSacramentGroupsById(int id)
        {
            SacramentGroup sacramentGroup = _sacramentGroupBusiness.GetSacramentGroupsById(id);
            var converter = new DateConverter();
            sacramentGroup.Date = converter.ConvertStringToDate(sacramentGroup.Date);
            //xoa lien ket bang
            sacramentGroup.Matrimonies = null;
            sacramentGroup.Parish = null;
            sacramentGroup.Sacraments = null;
            return Json(new { result = sacramentGroup }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UpdateSacramentGroup(SacramentGroup sacramentGroup)
        {
            var converter = new DateConverter();
            sacramentGroup.Date = converter.ConvertDateToString(sacramentGroup.Date);
            int result = _sacramentGroupBusiness.UpdateSacramentGroup(sacramentGroup);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LoadSacramentBySacramentGroupId(int sacramentGroupId)
        {
            List<Sacrament> result = _sacramentBusiness.GetSacramentsBySacramentGroupId(sacramentGroupId);
            return PartialView("_SacramentParishionerTable", result);
        }

        public ActionResult LoadMatrimonyBySacramentGroupId(int sacramentGroupId)
        {
            List<Matrimony> result = _matrimonyBusiness.GetMatrimonyBySacramentGroupId(sacramentGroupId);
            return PartialView("_SacramentMatrimonyTable", result);
        }

        public ActionResult UpdateEditableNumber(Sacrament sacrament)
        {
            int result = _sacramentBusiness.UpdateEditableNumber(sacrament);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UpdateEditableNote(Sacrament sacrament)
        {
            int result = _sacramentBusiness.UpdateEditableNote(sacrament);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UpdateEditablePatron(Sacrament sacrament)
        {
            int result = _sacramentBusiness.UpdateEditablePatron(sacrament);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UpdateEditableMatrimonyNumber(Matrimony matrimony)
        {
            int result = _matrimonyBusiness.UpdateEditableNumber(matrimony);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UpdateEditableFirstWitness(Matrimony matrimony)
        {
            int result = _matrimonyBusiness.UpdateEditableFirstWitness(matrimony);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UpdateEditableSecondWitness(Matrimony matrimony)
        {
            int result = _matrimonyBusiness.UpdateEditableSecondWitness(matrimony);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSacramentGroup(int id)
        {
            int result = _sacramentGroupBusiness.DeleteSacramentGroup(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteSacrament(int id)
        {
            int result = _sacramentBusiness.DeleteSacrament(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteSacramentFromSacramentGroup(int id)
        {
            int result = _sacramentBusiness.DeleteSacramentFromSacramentGroup(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult RemoveMatrimonyFromSacramentGroup(int id)
        {
            int result = _matrimonyBusiness.RemoveMatrimonyFromSacramentGroup(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckExistedSacramentGroup(string date, int type, int sacramentGroupId)
        {
            int parishId = (int)Session["ParishId"];
            int result = _sacramentGroupBusiness.CheckExistedSacramentGroup(date, type, parishId, sacramentGroupId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public string CheckInvalidParticipants(int sacramentGroupId, string sacramentDate)
        {
            return _sacramentBusiness.CheckInvalidParticipants(sacramentGroupId, sacramentDate);
        }

    }
}