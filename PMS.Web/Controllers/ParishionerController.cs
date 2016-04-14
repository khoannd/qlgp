using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using PMS.BusinessLogic;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ParishionerController : Controller
    {
        //
        // GET: /Parishioner/
        private readonly CommunityBusiness _communityBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;
        private readonly ChristianNameBusiness _christianNameBusiness;
        private readonly PlaceBusiness _placeBusiness;
        private readonly SacramentBusiness _sacramentBusiness;
        private readonly ConfigurationBusiness _configurationBusiness;
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly ParishBusiness _parishBusiness;
        private readonly PriestBusiness _priestBusiness;
        private readonly VocationBusiness _vocationBusiness;
        private readonly MatrimonyBusiness _matrimonyBusiness;
        private readonly ChangeParishBusiness _changeParishBusiness;
        private readonly MessageBusiness _messageBusiness;

        public ParishionerController()
        {
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
            _christianNameBusiness = new ChristianNameBusiness(DbConfig.GetConnectionString());
            _placeBusiness = new PlaceBusiness(DbConfig.GetConnectionString());
            _sacramentBusiness = new SacramentBusiness(DbConfig.GetConnectionString());
            _configurationBusiness = new ConfigurationBusiness(DbConfig.GetConnectionString());
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _priestBusiness = new PriestBusiness(DbConfig.GetConnectionString());
            _vocationBusiness = new VocationBusiness(DbConfig.GetConnectionString());
            _matrimonyBusiness = new MatrimonyBusiness(DbConfig.GetConnectionString());
            _changeParishBusiness = new ChangeParishBusiness(DbConfig.GetConnectionString());
            _messageBusiness = new MessageBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            int parishId = (int)Session["ParishId"];

            var configuration = _configurationBusiness.GetConfigurationByParishId(parishId);
            List<Community> communities = _communityBusiness.GetCommunitiesByParishId(parishId);
            List<Community> parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);

            ViewBag.Configuration = configuration.MultipleParishionerAdding;
            ViewBag.Communities = communities;
            ViewBag.ParishDivisions = parishDivisions;

            return View();
        }

        [SessionExpireFilter]
        public ActionResult SaveStorage()
        {
            int parishId = (int)Session["ParishId"];

            List<Community> communities = _communityBusiness.GetCommunitiesByParishId(parishId);
            List<Community> parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);

            ViewBag.Communities = communities;
            ViewBag.ParishDivisions = parishDivisions;

            return View();
        }

        [SessionExpireFilter]
        public ActionResult PrintPage()
        {
            return View();
        }

        public ActionResult PrintSacrament(string[] ids, int type)
        {

            int parishId = (int)Session["ParishId"];

            List<ParishionerSacramentViewModel> result;

            if (type != 4)
            {
                result = _parishionerBusiness.PrintSacrament(parishId, ids, type);
            }
            else
            {
                result = _parishionerBusiness.PrintMatrimony(parishId, ids);
            }

            var config = _configurationBusiness.GetConfigurationByParishId(parishId);

            string template = "";

            if (config != null)
            {
                if (type == 0)
                {
                    template = config.SacramentTemplate;
                }
                else if (type == 1)
                {
                    template = config.BaptismTemplate;
                }
                else if (type == 2)
                {
                    template = config.HolyCommunionTemplate;
                }
                else if (type == 3)
                {
                    template = config.ConfirmationTemplate;
                }
                else if (type == 4)
                {
                    template = config.MatrimonyTemplate;
                }
            }

            return Json(new
            {
                result = result,
                template = template,
                now = DateTime.Now.ToString("dd/MM/yyyy")
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishionerDatatables(jQueryDataTableParamModel param, int communityId, int parishDivisionId,
                                                                               int sacramentType, bool isCounted, int status,
                                                                               int deadParishioner = 0, int changeParishParishioner = 0)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _parishionerBusiness.GetOrderedParishionersByParamsAndPaging(parishId, communityId, parishDivisionId, sacramentType, isCounted, status,
                                                                         param.sSearch, deadParishioner, changeParishParishioner, param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                                                                         param.iDisplayLength, out totalRecords, out totalDisplayRecords);

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadChristianName(string name)
        {
            var result = _christianNameBusiness.GetChristianNamesByName(name);
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadCommunity()
        {
            int parishId = (int)Session["ParishId"];
            List<Community> communities = _communityBusiness.GetCommunitiesByParishId(parishId);

            foreach (var item in communities)
            {
                item.Communities = null;
                item.Families = null;
                item.Parishioners = null;
                item.Community1 = null;
                item.Parish = null;
                item.FamilyMigrationRequests = null;
                item.ParishionerMigrationRequests = null;
            }

            return Json(new
            {
                result = communities
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadCommunityAndParishDivisionTreeView()
        {
            int parishId = (int)Session["ParishId"];
            var communities = _communityBusiness.GetCommunitiesByParishId(parishId);
            var parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);
            var result = new List<CommunityTreeViewModel>();

            result.AddRange(communities.Select(item => new CommunityTreeViewModel()
            {
                Id = item.Id,
                Name = item.Name,
                ParishDivisions = parishDivisions.Where(p => p.ParentId == item.Id).ToList()
            }));
            ViewBag.CommunityTreeViewModel = result;

            return PartialView("_CommunityAndParishDivisionTreeView", result);
        }

        public ActionResult LoadPlaces(string name)
        {
            var result = _placeBusiness.GetPlacesByName(name);
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishNames(string name)
        {
            int parishId = (int)Session["ParishId"];
            var result = _parishBusiness.GetParishNamesByName(name, parishId);
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public int AddParishioner(Parishioner parishioner,
                                          string baptismDate, string baptismNumber, string baptismPlace, string baptismPatron, string baptismGiver,
                                          string holyCommunionDate, string holyCommunionNumber, string holyCommunionPlace, string holyCommunionGiver,
                                          string confirmationDate, string confirmationNumber, string confirmationPlace, string confirmationPatron, string confirmationGiver)
        {
            //Convert Date
            var converter = new DateConverter();
            parishioner.BirthDate = converter.ConvertDateToString(parishioner.BirthDate);
            parishioner.DeadDate = converter.ConvertDateToString(parishioner.DeadDate);
            baptismDate = converter.ConvertDateToString(baptismDate);
            holyCommunionDate = converter.ConvertDateToString(holyCommunionDate);
            confirmationDate = converter.ConvertDateToString(confirmationDate);

            //Add Parishioner - Using Transaction
            //Add time and account used to create
            parishioner.CreatedDate = DateTime.Now;
            string username = (string)Session["Username"];
            parishioner.CreatedBy = username;
            parishioner.LastUpdatedBy = username;

            //Check status base on input
            if (parishioner.IsDead)
            {
                parishioner.Status = (int)ParishionerStatusEnum.Saved;
            }
            else
            {
                parishioner.Status = (int)ParishionerStatusEnum.Available;
            }

            int parishId = (int)Session["ParishId"];
            int dioceseId = (int)Session["DioceseId"];

            // Code Generation       
            Configuration config = _configurationBusiness.GetConfigurationByParishId(parishId);
            if (config == null)
            {
                return 0;
            }

            if (config.ParishionerCodeGeneration != 0)
            {
                //Generate Code
                parishioner.Code = _parishionerBusiness.LoadParishionerCode(parishId, config.ParishionerPrefix, config.ParishionerCharacterNumber);
            }
            else
            {
                //Check Existed Code
                int result = _parishionerBusiness.CheckParishionerCode(parishioner.Code, parishId);
                if (result == 0)
                {
                    return -2;
                }
                else if (result == -1)
                {
                    return result;
                }
            }

            if (string.IsNullOrEmpty(parishioner.Code))
            {
                return 0;
            }

            using (var scope = new TransactionScope())
            {   // Add Basic information     
                //Add Parishioner
                int id = _parishionerBusiness.AddParishioner(parishioner);

                //If success
                if (id > 0)
                {

                    //Thuc hien chuyen xu neu co
                    if (parishioner.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish)
                    {

                        //Tim ra giao xu can duoc chuyen
                        if (string.IsNullOrEmpty(parishioner.DomicilePlace))
                        {
                            parishioner.DomicilePlace = "";
                        }

                        int toParishId = _changeParishBusiness.CheckOtherParish(parishioner.DomicilePlace, parishId,
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
                        ids[0] = id.ToString();

                        var result = _changeParishBusiness.ChangeParishForParishioner(ids, toParishId, parishioner.DomicilePlace);

                        if (result < 1)
                        {
                            return result;
                        }

                    }

                    //Check Code to update character number if auto code generation mode
                    if (config.ParishionerCodeGeneration != 0)
                    {
                        string codeCharacter;

                        if (!string.IsNullOrEmpty(config.ParishionerPrefix))
                        {
                            codeCharacter = parishioner.Code.Replace(config.ParishionerPrefix, "");
                        }
                        else
                        {
                            codeCharacter = parishioner.Code;
                        }

                        if (codeCharacter.Length > config.ParishionerCharacterNumber)
                        {
                            //+ 1 to character number
                            int row = _configurationBusiness.CharacterAutoIncreasement(parishId);

                            if (row <= 0)
                            {
                                return row;
                            }
                        }
                    }

                    //Add Sacrament Information
                    //Check it is not empty or not to add
                    if (string.IsNullOrEmpty(baptismDate) && string.IsNullOrEmpty(baptismNumber) &&
                        string.IsNullOrEmpty(baptismPlace) && string.IsNullOrEmpty(baptismPatron) && string.IsNullOrEmpty(baptismGiver))
                    {
                        //Do nothing
                    }
                    else
                    {
                        //Add Baptism Sacrament
                        var baptism = new Sacrament()
                        {
                            ParishionerId = id,
                            Number = baptismNumber,
                            Type = (int)SacramentEnum.Baptism,
                            Patron = baptismPatron,
                            Date = baptismDate,
                            Giver = baptismGiver,
                            ReceivedPlace = baptismPlace
                        };
                        int baptismId = _sacramentBusiness.AddSacrament(baptism);
                        if (baptismId <= 0)
                        {
                            return baptismId;
                        }
                    }

                    if (string.IsNullOrEmpty(holyCommunionDate) && string.IsNullOrEmpty(holyCommunionNumber) &&
                       string.IsNullOrEmpty(holyCommunionPlace) && string.IsNullOrEmpty(holyCommunionGiver))
                    {
                        //Do nothing
                    }
                    else
                    {
                        //Add Baptism Sacrament
                        var holyCommunion = new Sacrament()
                        {
                            ParishionerId = id,
                            Number = holyCommunionNumber,
                            Type = (int)SacramentEnum.HolyCommunion,
                            Date = holyCommunionDate,
                            Giver = holyCommunionGiver,
                            ReceivedPlace = holyCommunionPlace
                        };
                        int holyCommunionId = _sacramentBusiness.AddSacrament(holyCommunion);
                        if (holyCommunionId <= 0)
                        {
                            return holyCommunionId;
                        }
                    }

                    if (string.IsNullOrEmpty(confirmationDate) && string.IsNullOrEmpty(confirmationNumber) &&
                        string.IsNullOrEmpty(confirmationPlace) && string.IsNullOrEmpty(confirmationPatron) && string.IsNullOrEmpty(confirmationGiver))
                    {
                        //Do nothing
                    }
                    else
                    {
                        //Add Baptism Sacrament
                        var confirmation = new Sacrament()
                        {
                            ParishionerId = id,
                            Number = confirmationNumber,
                            Type = (int)SacramentEnum.Confirmation,
                            Patron = confirmationPatron,
                            Date = confirmationDate,
                            Giver = confirmationGiver,
                            ReceivedPlace = confirmationPlace
                        };
                        int confirmationId = _sacramentBusiness.AddSacrament(confirmation);
                        if (confirmationId <= 0)
                        {
                            return confirmationId;
                        }
                    }

                    //If success all
                    scope.Complete();
                }
                return id;
            }


        }

        public int UpdateParishioner(Parishioner parishioner,
                                          int baptismId, string baptismDate, string baptismNumber, string baptismPlace, string baptismPatron, string baptismGiver,
                                          int holyCommunionId, string holyCommunionDate, string holyCommunionNumber, string holyCommunionPlace, string holyCommunionGiver,
                                          int confirmationId, string confirmationDate, string confirmationNumber, string confirmationPlace, string confirmationPatron, string confirmationGiver,
                                          Vocation vocation, string servedPhone, string servedEmail, string servedNote)
        {
            //Assign for Vocation
            vocation.Phone = servedPhone;
            vocation.Email = servedEmail;
            vocation.Note = servedNote;

            //Convert Date
            var converter = new DateConverter();
            parishioner.BirthDate = converter.ConvertDateToString(parishioner.BirthDate);
            parishioner.DeadDate = converter.ConvertDateToString(parishioner.DeadDate);
            baptismDate = converter.ConvertDateToString(baptismDate);
            holyCommunionDate = converter.ConvertDateToString(holyCommunionDate);
            confirmationDate = converter.ConvertDateToString(confirmationDate);

            vocation.Date1 = converter.ConvertDateToString(vocation.Date1);
            vocation.Date2 = converter.ConvertDateToString(vocation.Date2);
            vocation.Date3 = converter.ConvertDateToString(vocation.Date3);
            vocation.Date4 = converter.ConvertDateToString(vocation.Date4);
            vocation.Date5 = converter.ConvertDateToString(vocation.Date5);
            vocation.Date6 = converter.ConvertDateToString(vocation.Date6);
            vocation.Date7 = converter.ConvertDateToString(vocation.Date7);
            vocation.Date8 = converter.ConvertDateToString(vocation.Date8);
            vocation.Date9 = converter.ConvertDateToString(vocation.Date9);

            //Add Parishioner - Using Transaction
            string username = (string)Session["Username"];
            parishioner.LastUpdatedBy = username;

            //Check status base on input
            if (parishioner.IsDead)
            {
                parishioner.Status = (int)ParishionerStatusEnum.Saved;
            }
            else
            {
                parishioner.Status = (int)ParishionerStatusEnum.Available;
            }

            int parishId = (int)Session["ParishId"];
            int dioceseId = (int)Session["DioceseId"];

            using (var scope = new TransactionScope())
            {
                // Update Basic information
                //Update Parishioner
                int result = _parishionerBusiness.UpdateParishioner(parishioner);

                //If success
                if (result > 0)
                {

                    //Thuc hien chuyen xu neu co
                    if (parishioner.DomicileStatus == (int)DomicileStatusEnum.TransferredToAnotherParish)
                    {
                        //Tim ra giao xu can duoc chuyen
                        if (string.IsNullOrEmpty(parishioner.DomicilePlace))
                        {
                            parishioner.DomicilePlace = "";
                        }

                        //Cho nay giao xu bi trung giao xu minh thi sao ?
                        int toParishId = _changeParishBusiness.CheckOtherParish(parishioner.DomicilePlace, parishId,
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
                        ids[0] = parishioner.Id.ToString();

                        var r = _changeParishBusiness.ChangeParishForParishioner(ids, toParishId, parishioner.DomicilePlace);

                        if (r < 1)
                        {
                            return r;
                        }
                    }

                    //Update Sacrament Information
                    //Check to delete if no data with existing baptism
                    if (string.IsNullOrEmpty(baptismDate) && string.IsNullOrEmpty(baptismNumber) &&
                        string.IsNullOrEmpty(baptismPlace) && string.IsNullOrEmpty(baptismPatron) && string.IsNullOrEmpty(baptismGiver))
                    {
                        if (baptismId != 0)
                        {
                            //Delete
                            int deleted = _sacramentBusiness.DeleteSacrament(baptismId);
                            if (deleted <= 0)
                            {
                                return deleted;
                            }
                        }
                    }
                    else
                    {
                        var baptism = new Sacrament()
                        {
                            ParishionerId = parishioner.Id,
                            Number = baptismNumber,
                            Type = (int)SacramentEnum.Baptism,
                            Patron = baptismPatron,
                            Date = baptismDate,
                            Giver = baptismGiver,
                            ReceivedPlace = baptismPlace
                        };

                        if (baptismId == 0)
                        {
                            int idResult = _sacramentBusiness.AddSacrament(baptism);
                            if (idResult <= 0)
                            {
                                return idResult;
                            }
                        }
                        else
                        {
                            baptism.Id = baptismId;
                            //Update Baptism
                            int updated = _sacramentBusiness.UpdateSacrament(baptism);
                            if (updated <= 0)
                            {
                                return updated;
                            }
                        }
                    }

                    if (string.IsNullOrEmpty(holyCommunionDate) && string.IsNullOrEmpty(holyCommunionNumber) &&
                       string.IsNullOrEmpty(holyCommunionPlace) && string.IsNullOrEmpty(holyCommunionGiver))
                    {
                        if (holyCommunionId != 0)
                        {
                            //Delete
                            int deleted = _sacramentBusiness.DeleteSacrament(holyCommunionId);
                            if (deleted <= 0)
                            {
                                return deleted;
                            }
                        }
                    }
                    else
                    {
                        var holyCommunion = new Sacrament()
                        {
                            ParishionerId = parishioner.Id,
                            Number = holyCommunionNumber,
                            Type = (int)SacramentEnum.HolyCommunion,
                            Date = holyCommunionDate,
                            Giver = holyCommunionGiver,
                            ReceivedPlace = holyCommunionPlace
                        };

                        if (holyCommunionId == 0)
                        {
                            int idResult = _sacramentBusiness.AddSacrament(holyCommunion);
                            if (idResult <= 0)
                            {
                                return idResult;
                            }
                        }
                        else
                        {
                            holyCommunion.Id = holyCommunionId;
                            //Update Holy Commuion
                            int updated = _sacramentBusiness.UpdateSacrament(holyCommunion);
                            if (updated <= 0)
                            {
                                return updated;
                            }
                        }
                    }

                    if (string.IsNullOrEmpty(confirmationDate) && string.IsNullOrEmpty(confirmationNumber) &&
                        string.IsNullOrEmpty(confirmationPlace) && string.IsNullOrEmpty(confirmationPatron) && string.IsNullOrEmpty(confirmationGiver))
                    {
                        if (confirmationId != 0)
                        {
                            //Delete
                            int deleted = _sacramentBusiness.DeleteSacrament(confirmationId);
                            if (deleted <= 0)
                            {
                                return deleted;
                            }
                        }
                    }
                    else
                    {
                        var confirmation = new Sacrament()
                        {
                            ParishionerId = parishioner.Id,
                            Number = confirmationNumber,
                            Type = (int)SacramentEnum.Confirmation,
                            Patron = confirmationPatron,
                            Date = confirmationDate,
                            Giver = confirmationGiver,
                            ReceivedPlace = confirmationPlace
                        };

                        if (confirmationId == 0)
                        {
                            int idResult = _sacramentBusiness.AddSacrament(confirmation);
                            if (idResult <= 0)
                            {
                                return idResult;
                            }
                        }
                        else
                        {
                            confirmation.Id = confirmationId;
                            //Update Confirmation
                            int updated = _sacramentBusiness.UpdateSacrament(confirmation);
                            if (updated <= 0)
                            {
                                return updated;
                            }
                        }

                    }

                    //Update Vocation
                    if (string.IsNullOrEmpty(vocation.Date1) && string.IsNullOrEmpty(vocation.Date2) &&
                        string.IsNullOrEmpty(vocation.Date3)
                        && string.IsNullOrEmpty(vocation.Date4) && string.IsNullOrEmpty(vocation.Date5) &&
                        string.IsNullOrEmpty(vocation.Date6)
                        && string.IsNullOrEmpty(vocation.Date7) && string.IsNullOrEmpty(vocation.Date8) &&
                        string.IsNullOrEmpty(vocation.Date9)
                        && string.IsNullOrEmpty(vocation.Seminary) && string.IsNullOrEmpty(vocation.SeminaryAddress) &&
                        string.IsNullOrEmpty(vocation.ServedPlace)
                        && string.IsNullOrEmpty(vocation.ServedAddress) && string.IsNullOrEmpty(vocation.Phone) &&
                        string.IsNullOrEmpty(vocation.Email)
                        && string.IsNullOrEmpty(vocation.Note) && vocation.Position == (int)VocationEnum.None &&
                        !vocation.IsLeft)
                    {
                        if (vocation.ParishionerId != 0)
                        {
                            //Delete
                            int deleted = _vocationBusiness.DeleteVocation(vocation.ParishionerId);
                            if (deleted <= 0)
                            {
                                return deleted;
                            }
                        }
                    }
                    else
                    {
                        if (vocation.ParishionerId == 0)
                        {
                            //Add new
                            vocation.ParishionerId = parishioner.Id;
                            int added = _vocationBusiness.AddVocation(vocation);
                            if (added <= 0)
                            {
                                return added;
                            }
                        }
                        else
                        {
                            //Update
                            int updated = _vocationBusiness.UpdateVocation(vocation);
                            if (updated <= 0)
                            {
                                return updated;
                            }
                        }
                    }

                    //If success all
                    scope.Complete();
                }
                return result;
            }

        }

        [HttpPost]
        public string UploadParishionerImage(HttpPostedFileWrapper imageFile)
        {
            if (imageFile == null || imageFile.ContentLength == 0)
            {
                return "";
            }

            var fileName = String.Format("{0}.jpg", Guid.NewGuid().ToString());
            var imagePath = Path.Combine(Server.MapPath(Url.Content("~/Images/Parishioners")), fileName);
            imageFile.SaveAs(imagePath);

            return Url.Content(String.Format("~/Images/Parishioners/{0}", fileName));
        }

        public int CheckParishionerCode()
        {
            int parishId = (int)Session["ParishId"];
            Configuration config = _configurationBusiness.GetConfigurationByParishId(parishId);

            if (config == null)
            {
                return -1;
            }

            if (config.ParishionerCodeGeneration == 0)
            {
                return 0;
            }

            return 1;
        }

        public ActionResult LoadVicariates()
        {
            int dioceseId = (int)Session["DioceseId"];
            var vicariates = _vicariateBusiness.GetVicariatesByDioceseId(dioceseId);

            foreach (var item in vicariates)
            {
                item.Diocese = null;
                item.Parishes = null;
                item.Parish = null;
            }

            return Json(new
            {
                result = vicariates
            }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult LoadParishies(int vicariateId)
        {
            List<Parish> parishes;

            if (vicariateId == 0)
            {
                int dioceseId = (int)Session["DioceseId"];
                parishes = _parishBusiness.GetParishesByDioceseId(dioceseId);
            }
            else
            {
                parishes = _parishBusiness.GetParishesByVicariateId(vicariateId);
            }

            foreach (var item in parishes)
            {
                item.Accounts = null;
                item.Communities = null;
                item.FamilyMigrationRequests = null;
                item.ParishionerMigrationRequests = null;
                item.SacramentGroups = null;
                item.Societies = null;
                item.Vicariates = null;
                item.Vicariate = null;
                item.Configuration = null;
                item.ClassGroups = null;
                item.Messages = null;
            }

            return Json(new
            {
                result = parishes
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishiesNotMine(int vicariateId)
        {
            List<Parish> parishes;
            int parishId = (int)Session["ParishId"];
            if (vicariateId == 0)
            {
                int dioceseId = (int)Session["DioceseId"];
                parishes = _parishBusiness.GetParishesByDioceseIdNotMine(dioceseId, parishId);
            }
            else
            {
                parishes = _parishBusiness.GetParishesByVicariateIdNotMine(vicariateId, parishId);
            }

            foreach (var item in parishes)
            {
                item.Accounts = null;
                item.Communities = null;
                item.FamilyMigrationRequests = null;
                item.ParishionerMigrationRequests = null;
                item.SacramentGroups = null;
                item.Societies = null;
                item.Vicariates = null;
                item.Vicariate = null;
                item.Configuration = null;
                item.ClassGroups = null;
                item.Messages = null;
            }

            return Json(new
            {
                result = parishes
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadCommunitites(int parishId, int vicariateId)
        {
            List<Community> communities;

            if (parishId == 0 && vicariateId == 0)
            {
                int dioceseId = (int)Session["DioceseId"];
                communities = _communityBusiness.GetNotDefaultCommunitiesByDioceseId(dioceseId);
            }
            else if (parishId != 0)
            {
                communities = _communityBusiness.GetNotDefaultCommunitiesByParishId(parishId);
            }
            else
            {
                communities = _communityBusiness.GetNotDefaultCommunitiesByVicariateId(vicariateId);
            }

            foreach (var item in communities)
            {
                item.Communities = null;
                item.Families = null;
                item.Parishioners = null;
                item.Community1 = null;
                item.Parish = null;
                item.FamilyMigrationRequests = null;
                item.ParishionerMigrationRequests = null;
            }

            return Json(new
            {
                result = communities
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishDivisions(int communityId, int parishId, int vicariateId)
        {
            List<Community> parishDivisions;

            if (communityId == 0 && parishId == 0 && vicariateId == 0)
            {
                int dioceseId = (int)Session["DioceseId"];
                parishDivisions = _communityBusiness.GetParishDivisionsByDioceseId(dioceseId);
            }
            else if (communityId != 0)
            {
                parishDivisions = _communityBusiness.GetParishDivisionsByCommunityId(communityId);
            }
            else if (parishId != 0)
            {
                parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);
            }
            else
            {
                parishDivisions = _communityBusiness.GetParishDivisionsByVicariateId(vicariateId);
            }

            foreach (var item in parishDivisions)
            {
                item.Communities = null;
                item.Families = null;
                item.Parishioners = null;
                item.Community1 = null;
                item.Parish = null;
                item.ParishionerMigrationRequests = null;
                item.FamilyMigrationRequests = null;
            }

            return Json(new
            {
                result = parishDivisions
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishDivisionsByCommunityId(int communityId)
        {
            List<Community> parishDivisions;

            if (communityId != 0)
            {
                parishDivisions = _communityBusiness.GetParishDivisionsByCommunityId(communityId);
            }
            else
            {
                int parishId = (int)Session["ParishId"];
                parishDivisions = _communityBusiness.GetParishDivisionsByParishId(parishId);
            }

            foreach (var item in parishDivisions)
            {
                item.Communities = null;
                item.Families = null;
                item.Parishioners = null;
                item.Community1 = null;
                item.Parish = null;
                item.FamilyMigrationRequests = null;
                item.ParishionerMigrationRequests = null;
            }

            return Json(new
            {
                result = parishDivisions
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishionerLookupDatatables(jQueryDataTableParamModel param, int parishDivisionId, int communityId,
            int parishId, int vicariateId, string parishionerName, int gender, int notSacramentType, int filterMatrimony,
            string sacramentDate = "", int familyId = 0, int societyId = 0, int classGroupId = 0, int classId = 0)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;

            if (parishionerName.Length < 2)
            {
                var noData = new List<IConvertible[]>();

                return Json(new
                {
                    sEcho = param.sEcho,
                    iTotalRecords = totalRecords,
                    iTotalDisplayRecords = totalDisplayRecords,
                    aaData = noData
                }, JsonRequestBehavior.AllowGet);
            }

            var result = _parishionerBusiness.GetOrderedParishionersByParamsAndPaging(notSacramentType, filterMatrimony, dioceseId, vicariateId, parishId, communityId, parishDivisionId, parishionerName, gender,
                                                     sacramentDate, familyId, societyId, classGroupId, classId,
                                                     param.iSortCol_0, param.sSortDir_0, param.iDisplayStart, param.iDisplayLength, out totalRecords, out totalDisplayRecords);

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);

        }


        public int ChangeParishionerStatus(int id, int status, bool isForced)
        {
            string username = (string)Session["Username"];
            return _parishionerBusiness.ChangeParishionerStatus(id, status, username, isForced);
        }

        public ActionResult CheckUniqueCode(int id, string code)
        {
            int result = 0;

            if (id == 0)
            {
                int parishId = (int)Session["ParishId"];
                result = _parishionerBusiness.CheckParishionerCode(code, parishId);
            }

            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadInsideParishioners(string name, int gender)
        {
            int parishId = (int)Session["ParishId"];

            var parishioners = _parishionerBusiness.LoadInsideParishioners(parishId, name, gender);

            var result = new List<string>();

            foreach (var item in parishioners)
            {
                var n = string.IsNullOrEmpty(item.ChristianName) ? item.Name : item.ChristianName + " " + item.Name;
                result.Add(n);
            }

            //foreach (var item in parishioners)
            //{
            //    item.ClassGroups = null;
            //    item.ClassMembers = null;
            //    item.Community = null;
            //    item.FamilyMembers = null;
            //    item.Matrimonies = null;
            //    item.Matrimonies1 = null;
            //    item.ParishionerMigrationRequests = null;
            //    item.Sacraments = null;
            //    item.Societies = null;
            //    item.SocietyMembers = null;
            //    item.Vocation = null;
            //}

            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadPriestNames(string name)
        {
            int dioceseId = (int)Session["DioceseId"];

            var result = _priestBusiness.GetPriestNamesByName(dioceseId, name);

            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadPriest(string name)
        {
            int dioceseId = (int)Session["DioceseId"];

            var result = _priestBusiness.GetPriestByName(dioceseId, name);
            if (result is List<string>)
            {
                string strPriestSource = "[]";
                List<string> listPriest = new List<string>();
                foreach (string item in (List<string>)result)
                {
                    //listPriest.Add("{\"Id\":" + item.Split('|')[0] + ",\"Priest\":\"" + item.Split('|')[1].Replace("'", "").Replace("\"", "") + "\"}");
                    listPriest.Add("{\"PriestId\":\"" + item.Split('|')[0] + "\" ,\"Priest\":\"" + item.Split('|')[1].Replace("'", "").Replace("\"", "") + "\"}");
                }
                strPriestSource = "[" + string.Join(",", listPriest.ToArray()) + "]";
                return Json(new
                {
                    result = strPriestSource
                }, JsonRequestBehavior.AllowGet);
            }
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadFullParishioner(int id)
        {
            //Get Basic Information
            var parishioner = _parishionerBusiness.LoadParishionerById(id);
            if (parishioner == null)
            {
                return null;
            }
            int communityIdTemp;
            //Get Sacrament Information
            var sacraments = _sacramentBusiness.GetSacramentsByParishionerId(id);
            //Get Vocation Information
            var vocation = _vocationBusiness.GetVocationByParishionerId(id);

            string communityName = (parishioner.Community.ParentId != null) ? parishioner.Community.Community1.Name : parishioner.Community.Name;
            string parishName = parishioner.Community.Parish.Name;

            communityIdTemp = parishioner.CommunityId;
            //Remove Parishioner Reference
            parishioner.ClassGroups = null;
            parishioner.ClassMembers = null;
            parishioner.Community = null;
            parishioner.FamilyMembers = null;
            parishioner.Matrimonies = null;
            parishioner.Matrimonies1 = null;
            parishioner.ParishionerMigrationRequests = null;
            parishioner.Sacraments = null;
            parishioner.Societies = null;
            parishioner.SocietyMembers = null;
            parishioner.Vocation = null;

            int vocationIdTemp = 0;
            //Remove Vocation Reference
            if (vocation != null)
            {
                vocationIdTemp = vocation.ParishionerId;
                vocation.Parishioner = null;
            }

            //Select Sacrament and remove reference
            var baptism = new Sacrament();
            var holyCommunion = new Sacrament();
            var confirmation = new Sacrament();

            foreach (var item in sacraments)
            {
                item.Parishioner = null;
                item.SacramentGroup = null;

                if (item.Type == (int)SacramentEnum.Baptism)
                {
                    baptism = item;
                }
                else if (item.Type == (int)SacramentEnum.HolyCommunion)
                {
                    holyCommunion = item;
                }
                else if (item.Type == (int)SacramentEnum.Confirmation)
                {
                    confirmation = item;
                }
            }

            return Json(new
            {
                parishioner = parishioner,
                communityId = communityIdTemp,
                baptism = baptism,
                holyCommunion = holyCommunion,
                confirmation = confirmation,
                vocation = vocation,
                vocationId = vocationIdTemp,
                communityName = communityName,
                parishName = parishName
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult RefreshMainParishionerModal()
        {
            return PartialView("_ParishionerInformation");
        }

        public int AddMatrimony(Matrimony matrimony, int parishionerId, int oldGender, int newGender)
        {
            int result = 0;

            int parishId = (int)Session["ParishId"];
            var husband = _parishionerBusiness.LoadParishionerById(matrimony.HusbandId);
            var wife = _parishionerBusiness.LoadParishionerById(matrimony.WifeId);

            if (husband == null || wife == null)
            {
                return 0;
            }

            if ((!string.IsNullOrEmpty(husband.ChristianName)) && (!string.IsNullOrEmpty(wife.ChristianName)))
            {
                if ((!string.IsNullOrEmpty(husband.ChristianName.Trim())) && (!string.IsNullOrEmpty(wife.ChristianName.Trim()))
                    && matrimony.Status == (int)MatrimonyStatusEnum.Standard)
                {
                    return -3;
                }
            }

            using (var scope = new TransactionScope())
            {
                var username = (string)Session["Username"];
                //Update gender
                if (oldGender != newGender)
                {
                    result = _parishionerBusiness.ChangeParishionerGender(parishionerId, newGender, username);

                    if (result <= 0)
                    {
                        return result;
                    }
                }

                //Add Matrimony
                result = _matrimonyBusiness.AddMatrimony(matrimony, username);
                if (result <= 0)
                {
                    return result;
                }

                //Thuc hien kiem tra va gui mail
                if (husband.Community.ParishId != parishId)
                {
                    int accountId = (int)Session["AccountId"];
                    int dioceseId = (int)Session["DioceseId"];
                    var ids = new string[1];
                    ids[0] = husband.Community.ParishId + "";

                    string wifeName = string.IsNullOrEmpty(wife.ChristianName)
                        ? wife.Name
                        : wife.ChristianName + " " + wife.Name;

                    string husbandName = string.IsNullOrEmpty(husband.ChristianName)
                        ? husband.Name
                        : husband.ChristianName + " " + husband.Name;

                    string title = "Hệ thống: Thông tin hôn phối";
                    string content = "Giáo dân " + wifeName + " thuộc Giáo xứ " + wife.Community.Parish.Name +
                                     " vừa thêm hôn phối với " +
                                     "giáo dân " + husbandName + " thuộc Giáo xứ của bạn";

                    int result2 = _messageBusiness.CreateMessage(ids, title, content, accountId, dioceseId);
                    if (result2 <= 0)
                    {
                        return result2;
                    }
                }
                else if (wife.Community.ParishId != parishId)
                {
                    int accountId = (int)Session["AccountId"];
                    int dioceseId = (int)Session["DioceseId"];
                    var ids = new string[1];
                    ids[0] = wife.Community.ParishId + "";

                    string wifeName = string.IsNullOrEmpty(wife.ChristianName)
                        ? wife.Name
                        : wife.ChristianName + " " + wife.Name;

                    string husbandName = string.IsNullOrEmpty(husband.ChristianName)
                        ? husband.Name
                        : husband.ChristianName + " " + husband.Name;

                    string title = "Hệ thống: Thông tin hôn phối";
                    string content = "Giáo dân " + husbandName + " thuộc Giáo xứ " + husband.Community.Parish.Name +
                                     " vừa thêm hôn phối với " +
                                     "giáo dân " + wifeName + " thuộc Giáo xứ của bạn";

                    int result2 = _messageBusiness.CreateMessage(ids, title, content, accountId, dioceseId);
                    if (result2 <= 0)
                    {
                        return result2;
                    }
                }

                scope.Complete();
            }

            return result;
        }

        public ActionResult RefreshMatrimonyTable(int id)
        {
            var matrimonies = _matrimonyBusiness.GetMatrimoniesByParishionerId(id);

            if (matrimonies.Count > 0)
            {
                if (matrimonies.First().HusbandId == id)
                {
                    ViewBag.Position = "Husband";
                }
                else
                {
                    ViewBag.Position = "Wife";
                }
            }
            return PartialView("_MatrimonyTableContent", matrimonies);
        }

        public ActionResult ViewReadonlyMatrimonyTable(int id)
        {
            var matrimonies = _matrimonyBusiness.GetMatrimoniesByParishionerId(id);

            if (matrimonies.Count > 0)
            {
                if (matrimonies.First().HusbandId == id)
                {
                    ViewBag.Position = "Husband";
                }
                else
                {
                    ViewBag.Position = "Wife";
                }
            }
            return PartialView("_ViewReadonlyMatrimonyTable", matrimonies);
        }
        public ActionResult LoadEditMatrimony(int id)
        {

            var matrimony = _matrimonyBusiness.GetMatrimonyById(id);
            int husbandId = 0;
            int wifeId = 0;
            string husbandName = "";
            string wifeName = "";

            if (matrimony != null)
            {
                husbandId = matrimony.HusbandId;
                wifeId = matrimony.WifeId;
                var husband = matrimony.Parishioner;
                var wife = matrimony.Parishioner1;

                husbandName = string.IsNullOrEmpty(husband.ChristianName)
                    ? husband.Name
                    : husband.ChristianName + " " + husband.Name;

                wifeName = string.IsNullOrEmpty(wife.ChristianName) ? wife.Name : wife.ChristianName + " " + wife.Name;

                //Remove Reference
                matrimony.Parishioner = null;
                matrimony.Parishioner1 = null;
                matrimony.SacramentGroup = null;
            }

            return Json(new
            {
                matrimony = matrimony,
                husbandId = husbandId,
                wifeId = wifeId,
                husbandName = husbandName,
                wifeName = wifeName
            }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult SearchParishionersForAddSeminarian(string keyword, int start = 0, int length = 10)
        {
            var parishioners = _parishionerBusiness.SearchParishionerByKeyword(keyword, start, length);
            var converter = new DateConverter();
            return Json(new
            {
                Result = parishioners.Select(p => new
                {
                    p.Address,
                    BirthDate = converter.ConvertStringToDateObjectNullable(p.BirthDate),
                    p.BirthPlace,
                    p.Career,
                    p.ChristianName,
                    p.Code,
                    p.CreatedBy,
                    p.CreatedDate,
                    p.DeadDate,
                    p.DomicilePlace,
                    p.DomicileStatus,
                    p.Education,
                    p.Email,
                    p.FatherName,
                    p.Gender,
                    p.Id,
                    p.ImageUrl,
                    p.IsCatechumen,
                    p.IsCounted,
                    p.IsDead,
                    p.IsMarried,
                    p.IsSingle,
                    p.IsStudying,
                    p.LastUpdatedBy,
                    p.MobilePhone,
                    p.MotherName,
                    p.Name,
                    p.Note,
                    p.Phone,
                    p.Status
                })
            }, JsonRequestBehavior.AllowGet);
        }


        public int UpdateMatrimony(Matrimony matrimony)
        {
            var username = (string)Session["Username"];

            int parishId = (int)Session["ParishId"];
            var husband = _parishionerBusiness.LoadParishionerById(matrimony.HusbandId);
            var wife = _parishionerBusiness.LoadParishionerById(matrimony.WifeId);

            if (husband == null || wife == null)
            {
                return 0;
            }

            if ((!string.IsNullOrEmpty(husband.ChristianName)) && (!string.IsNullOrEmpty(wife.ChristianName)))
            {
                if ((!string.IsNullOrEmpty(husband.ChristianName.Trim())) && (!string.IsNullOrEmpty(wife.ChristianName.Trim()))
                    && matrimony.Status == (int)MatrimonyStatusEnum.Standard)
                {
                    return -3;
                }
            }


            //Lay hon phoi cu ra kiem tra 
            var mat = _matrimonyBusiness.GetMatrimonyById(matrimony.Id);

            if ((mat != null) && ((mat.HusbandId != matrimony.HusbandId) || (mat.WifeId != matrimony.WifeId)))
            {
                //Thuc hien kiem tra va gui mail
                if (husband.Community.ParishId != parishId)
                {
                    int accountId = (int)Session["AccountId"];
                    int dioceseId = (int)Session["DioceseId"];
                    var ids = new string[1];
                    ids[0] = husband.Community.ParishId + "";

                    string wifeName = string.IsNullOrEmpty(wife.ChristianName)
                        ? wife.Name
                        : wife.ChristianName + " " + wife.Name;

                    string husbandName = string.IsNullOrEmpty(husband.ChristianName)
                        ? husband.Name
                        : husband.ChristianName + " " + husband.Name;

                    string title = "Hệ thống: Thông tin hôn phối";
                    string content = "Giáo dân " + wifeName + " thuộc Giáo xứ " + wife.Community.Parish.Name +
                                     " vừa thêm hôn phối với " +
                                     "giáo dân " + husbandName + " thuộc Giáo xứ của bạn";

                    int result = _messageBusiness.CreateMessage(ids, title, content, accountId, dioceseId);
                    if (result <= 0)
                    {
                        return result;
                    }
                }
                else if (wife.Community.ParishId != parishId)
                {
                    int accountId = (int)Session["AccountId"];
                    int dioceseId = (int)Session["DioceseId"];
                    var ids = new string[1];
                    ids[0] = wife.Community.ParishId + "";

                    string wifeName = string.IsNullOrEmpty(wife.ChristianName)
                        ? wife.Name
                        : wife.ChristianName + " " + wife.Name;

                    string husbandName = string.IsNullOrEmpty(husband.ChristianName)
                        ? husband.Name
                        : husband.ChristianName + " " + husband.Name;

                    string title = "Hệ thống: Thông tin hôn phối";
                    string content = "Giáo dân " + husbandName + " thuộc Giáo xứ " + husband.Community.Parish.Name +
                                     " vừa thêm hôn phối với " +
                                     "giáo dân " + wifeName + " thuộc Giáo xứ của bạn";

                    int result = _messageBusiness.CreateMessage(ids, title, content, accountId, dioceseId);
                    if (result <= 0)
                    {
                        return result;
                    }
                }
            }

            return _matrimonyBusiness.UpdateMatrimony(matrimony, username);
        }

        public int DeleteMatrimony(int id)
        {
            var username = (string)Session["Username"];
            return _matrimonyBusiness.DeleteMatrimony(id, username);
        }

        public string CheckValidMatrimony(int parishionerId)
        {
            int parishId = (int)Session["ParishId"];
            return _parishionerBusiness.CheckValidMatrimony(parishionerId, parishId);
        }

        public int CheckExistedMatrimony(int parishionerId1, int parishionerId2)
        {
            return _matrimonyBusiness.CheckExistedMatrimony(parishionerId1, parishionerId2);
        }

        public string GetCodeByParishionerId(int id)
        {
            return _parishionerBusiness.GetCodeByParishionerId(id);
        }

        //Get Parishioner Name to Auto Complete
        public ActionResult getAllParishionerByName(string name)
        {
            var result = _parishionerBusiness.getAllParishionerByName(name);
            return Json(new
            {
                result = result
            }, JsonRequestBehavior.AllowGet);
        }
    }
}