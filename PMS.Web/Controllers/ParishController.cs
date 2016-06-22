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
    public class ParishController : Controller
    {
        //
        // GET: /Parish/
        private readonly ParishBusiness _parishBusiness;
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly CommunityBusiness _communityBusiness;
        private readonly ConfigurationBusiness _configurationBusiness;
        private readonly DioceseBusiness _dioceseBusiness;

        public ParishController()
        {
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _communityBusiness = new CommunityBusiness(DbConfig.GetConnectionString());
            _configurationBusiness = new ConfigurationBusiness(DbConfig.GetConnectionString());
            _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
        }
        [SessionExpireFilter]
        public ActionResult Index()
        {
            //int dioceseId = (int)Session["DioceseId"];
            List<Vicariate> vicariates = _vicariateBusiness.getAllVicariate().ToList();
            ViewBag.Vicariates = vicariates;
            ViewBag.Dioceses = _dioceseBusiness.GetAllDioceses();
            return View();
        }

        public ActionResult LoadParishDatatables(jQueryDataTableParamModel param, int vicariateId)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _parishBusiness.GetOrderedParishesByParamsAndPaging(dioceseId, vicariateId, param.sSearch,
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

        public ActionResult LoadVicariate()
        {
            int dioceseId = (int)Session["DioceseId"];
            List<Vicariate> vicariates = _vicariateBusiness.GetVicariatesByDioceseId(dioceseId);

            foreach (var item in vicariates)
            {
                item.Parishes = null;
            }
            return Json(new
            {
                result = vicariates
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckUniqueParish(string name, int parishId)
        {
            int dioceseId = (int)Session["DioceseId"];
            int result = _parishBusiness.CheckUniqueParish(name, parishId, dioceseId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public int AddParish(Parish parish)
        {
            
            using (var scope = new TransactionScope())
            {
                int result = _parishBusiness.AddParish(parish);

                if (result > 0)
                {
                    var config = new Configuration()
                    {
                        ParishId = result,
                        MultipleParishionerAdding = 0,
                        ParishionerCodeGeneration = 1,
                        ParishionerPrefix = "",
                        ParishionerCharacterNumber = 1,
                        FamilyCodeGeneration = 1,
                        FamilyPrefix = "",
                        FamilyCharacterNumber = 1
                        //---------------------------------------------------------------------------------------

                        //---------------------------------------------------------------------------------------
                    };
                    int configId = _configurationBusiness.AddConfiguration(config);
                    if (configId < 0)
                    {
                        return configId;
                    }

                    var community = new Community()
                    {
                        Name = "Ngoài xứ",
                        IsDefault = true,
                        ParishId = result
                    };
                    int communityId = _communityBusiness.AddCommunity(community);
                    if (communityId < 0)
                    {
                        return communityId;
                    }

                }
                scope.Complete();
                return result;
            }
            
        }

        public ActionResult UpdateParish(Parish parish)
        {
            string url = _parishBusiness.GetImageUrlByParishId(parish.Id);
            int result = _parishBusiness.UpdateParish(parish);

            if (!string.IsNullOrEmpty(parish.ImageUrl))
            {
                if (!string.IsNullOrEmpty(url))
                {
                    string path = Server.MapPath(Url.Content(url));
                    if (result > 0)
                    {
                        if (System.IO.File.Exists(path))
                        {
                            System.IO.File.Delete(path);
                        }
                    }
                }         
            }

            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteParish(int id)
        {
            int result = _parishBusiness.DeleteParish(id);
            return Json(new {result = result}, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LoadParishById(int id)
        {
            Parish parish = _parishBusiness.GetParishesByParishId(id);
            ParishViewModel model = new ParishViewModel();
            model.Id = parish.Id;
            model.Name = parish.Name;
            model.Address = parish.Address;
            model.Ward = parish.Ward;
            model.District = parish.District;
            model.Province = parish.Province;
            model.Priest = parish.Priest;
            model.Website = parish.Website;
            model.Phone = parish.Phone;
            model.Email = parish.Email;
            model.VicariateId = parish.VicariateId;
            model.ImageUrl = parish.ImageUrl;
            model.Patron = parish.Patron;
            model.PatronDate = parish.PatronDate;
            model.ChauLuot = parish.ChauLuot;

            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SearchParishByKeyword(string keyword, int start, int length)
        {
            var parishes = _parishBusiness.SearchParishByKeyword(keyword, start, length);
            return Json(parishes.Select(p => new {
                p.Name,
                p.Email,
                p.Phone,
                p.Website,
                p.Address,
                p.Ward,
                p.District,
                p.Province,
                p.Id
            }), JsonRequestBehavior.AllowGet);
        }

        public string UploadParishImage(HttpPostedFileWrapper inputFile)
        {
            if (inputFile == null || inputFile.ContentLength == 0)
            {
                return "";
            }
            string s = inputFile.ContentType;
            var fileName = String.Format("{0}.jpg", Guid.NewGuid().ToString());
            var imagePath = Path.Combine(Server.MapPath(Url.Content("~/Images/Parishes/")), fileName);
            inputFile.SaveAs(imagePath);

            return Url.Content(String.Format("~/Images/Parishes/{0}", fileName));
        }
	}
}