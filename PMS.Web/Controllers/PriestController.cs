using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;
using System.Data;
using System.Data.OleDb;
using System.Xml;
using System.IO;
using System.Configuration;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using PMS.DataAccess.Enumerations;
using Excel = Microsoft.Office.Interop.Excel;

namespace PMS.Web.Controllers
{
    public class PriestController : Controller
    {
        //
        // GET: /Priest/
        private readonly PriestBusiness _priestBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;
        private readonly VocationBusiness _vocationBusiness;
        private readonly ConfigurationBusiness _configurationBusiness;
        private readonly DioceseBusiness _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
        private readonly VicariateBusiness _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
        private readonly ParishBusiness _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
        private readonly ParishManagerBusiness _parishManagerBusiness = new ParishManagerBusiness(DbConfig.GetConnectionString());

        public PriestController()
        {
            _priestBusiness = new PriestBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
            _vocationBusiness = new VocationBusiness(DbConfig.GetConnectionString());
            _configurationBusiness = new ConfigurationBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            ViewBag.Vicariates = _vicariateBusiness.getAllVicariate().ToList();
            ViewBag.Dioceses = _dioceseBusiness.GetAllDioceses();
            ViewBag.Parishes = _parishBusiness.GetAllParish().ToList();
            return View();
        }

        public ActionResult LoadParishDatatable(jQueryDataTableParam param)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            //var result = _priestBusiness.GetOrderedPriestsByParamsAndPaging(dioceseId, param.sSearch,
            //   param.iSortCol_0, param.sSortDir_0, param.iDisplayStart, param.iDisplayLength, out totalRecords,
            //   out totalDisplayRecords);
            param.DioceseId = dioceseId;

            var result = _priestBusiness.GetOrderedPriestsByParamsAndPaging(param, out totalRecords, out totalDisplayRecords);

            var fileThumbPath = ConfigurationManager.AppSettings["ParishionerThumbnailUrl"];
            for (int i = 0; i < result.Count; i++)
            {
                //result[i].ThumbnailURL = string.Concat(fileThumbPath, result[i].ImageURL);
                result[i].ThumbnailURL = _parishionerBusiness.GetImageUrl(string.Concat(fileThumbPath, result[i].ImageURL), (int)PMS.DataAccess.Enumerations.GenderEnum.Male);
            }

            //return Json(new
            //{
            //    sEcho = param.sEcho,
            //    iTotalRecords = totalRecords,
            //    iTotalDisplayRecords = totalDisplayRecords,
            //    aaData = result
            //}, JsonRequestBehavior.AllowGet);

            return Json(new
            {
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetFilterParams(jQueryDataTableParam param)
        {
            IEnumerable<Parish> parishes = _parishBusiness.GetAllParish();
            List<ParishViewModel> parishViewModels = new List<ParishViewModel>();
            Tools.CopyPropertiesTo(parishes, parishViewModels);
            //foreach(var p in parishes)
            //{
            //    var model = new ParishViewModel();
            //    Tools.CopyPropertiesTo(p, model);
            //    parishViewModels.Add(model);
            //}
            IEnumerable<Vicariate> vicariates = _vicariateBusiness.getAllVicariate().ToList();
            List<VicariateViewModel> vicariatesModels = new List<VicariateViewModel>();
            Tools.CopyPropertiesTo(vicariates, vicariatesModels);
            IEnumerable<string> christianNames = _priestBusiness.GetChristianList();
            IEnumerable<VaiTro> vaitro = _priestBusiness.GetPositionList();
            List<string> positions = new List<string>();
            foreach (var item in vaitro)
            {
                positions.Add(item.Name);
            }
            IEnumerable<ValueSet> typeCodes = _vocationBusiness.GetTypeCodes();

            return Json(new
            {
                parishes = parishViewModels,
                vicariates = vicariatesModels,
                christianNames = christianNames,
                positions = positions,
                typeCodes = typeCodes
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadParishDatatableForTCLM(jQueryDataTableParamModel param)
        {
            object id = Session["TCLMId"];
            int tclmId = 0;
            if (id != null)
            {
                tclmId = (int)id;
            }
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _priestBusiness.GetOrderedPriestsByParamsAndPagingForTCLM(tclmId, param.sSearch,
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

        public ActionResult LoadPriestById(int id)
        {
            PriestViewModel priest = _priestBusiness.GetPriestAndParishionerInfoByPriestId(id);
            Session["ImageName"] = priest.ImageURL;

            var converter = new DateConverter();
            priest.BirthDate = converter.ConvertStringToDate(priest.BirthDate);

            var imageName = priest.ImageURL;
            var fileImagePath = ConfigurationManager.AppSettings["ParishionerImageUrl"];
            priest.ImageURL = string.Concat(fileImagePath, imageName);

            var fileThumbnailPath = ConfigurationManager.AppSettings["ParishionerThumbnailUrl"];
            priest.ThumbnailURL = string.Concat(fileThumbnailPath, imageName);

            return Json(new { result = priest }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult LoadPriestsByName(int dioceseId, string name)
        {
            var result = new List<PriestViewModel>();
            if (!string.IsNullOrEmpty(name) && name.Trim() != "")
            {
                var priests = _priestBusiness.GetPriestsByName(dioceseId, name);
                if (priests != null)
                {
                    foreach (var item in priests)
                    {
                        result.Add(new PriestViewModel()
                        {
                            Id = item.Id,
                            ChristianName = item.ChristianName,
                            Name = item.Name,
                            BirthDate = item.BirthDate,
                            DioceseId = item.DioceseId,
                            Phone = item.Phone,
                            ParishionerId = item.ParishionerId
                        });
                    }
                }
            }
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AddPriest(PriestViewModel priestViewModel)
        {
            var result = addPriest(priestViewModel);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        private int addPriest(PriestViewModel priestViewModel)
        {
            int result = 0;
            try
            {
                int dioceseId = (int)Session["DioceseId"];

                var priest = new Priest();
                //priest.ChristianName = priestViewModel.ChristianName;
                //priest.Name = priestViewModel.Name;
                //priest.BirthDate = priestViewModel.BirthDate;
                //priest.Phone = priestViewModel.Phone;
                //priest.ParishionerId = priestViewModel.ParishionerId;
                //priest.DioceseId = dioceseId;
                Tools.CopyPropertiesTo(priestViewModel, priest);

                var converter = new DateConverter();
                priest.BirthDate = converter.ConvertDateToString(priest.BirthDate);
                if (priest.BirthDate.Length > 8) priest.BirthDate = priest.BirthDate.Substring(0, 8);

                if (priestViewModel.ParishionerId == 0 || priestViewModel.ParishionerId == null)
                {
                    Parishioner parishioner = new Parishioner();
                    if (string.IsNullOrEmpty(priestViewModel.Code))
                    {
                        var maxcode = _parishionerBusiness.getMaxCode("LM");
                        if (maxcode == null)
                        {
                            parishioner.Code = "LM00001";
                        }
                        else
                        {
                            String[] splitString = maxcode.Split('M');
                            var code = String.Format("{0:00000}", Int32.Parse(splitString[1]) + 1);
                            parishioner.Code = String.Concat("LM", code);
                        }
                    }
                    else
                    {
                        parishioner.Code = priestViewModel.Code;
                    }

                    parishioner.ImageUrl = priestViewModel.ImageURL;
                    assignParishionerProp(parishioner, priestViewModel);

                    priest.ParishionerId = _parishionerBusiness.AddParishioner(parishioner);
                    if (priest.ParishionerId > 0)
                    {
                        priestViewModel.ParishionerId = priest.ParishionerId;
                        importBaptism(priestViewModel);

                        Vocation vocation = new Vocation();
                        assignVocationProp(vocation, priestViewModel);

                        var vocationParishionerId = _vocationBusiness.AddVocation(vocation);

                        if (vocationParishionerId == priest.ParishionerId)
                        {
                            result = _priestBusiness.AddPriest(priest);
                            priestViewModel.Id = result;
                        }
                        else result = 0;
                    }
                    else
                    {
                        writeLog(string.Concat(priestViewModel.Name, ": insert parishioner fail"));
                    }
                }
                else
                {
                    Vocation vocation = null;

                    Parishioner parishioner = _parishionerBusiness.getParishionerById((int)priestViewModel.ParishionerId);
                    if (parishioner.Vocation != null)
                    {
                        vocation = parishioner.Vocation;
                        assignVocationProp(vocation, priestViewModel);
                        //_vocationBusiness.UpdateVocation(vocation);

                    }
                    else
                    {
                        vocation = new Vocation();
                        assignVocationProp(vocation, priestViewModel);
                        _vocationBusiness.AddVocation(vocation);
                    }
                    assignParishionerProp(parishioner, priestViewModel);
                    result = _parishionerBusiness.UpdateParishioner(parishioner, false);
                    if (result > 0)
                    {
                        importBaptism(priestViewModel);
                        var priestCheck = _priestBusiness.GetPriestByParishionerId((int)priest.ParishionerId);
                        if (priestCheck != null)
                        {
                            priest.Id = priestCheck.Id;
                            priestViewModel.Id = priest.Id;
                            result = _priestBusiness.UpdatePriest(priest);
                        }
                        else
                        {
                            result = _priestBusiness.AddPriest(priest);
                            priestViewModel.Id = result;
                        }
                    }
                    else
                    {
                        writeLog(string.Concat(priestViewModel.Name, ": update parishioner fail"));
                    }
                }
                if (result <= 0)
                {
                    writeLog(string.Concat(priestViewModel.Name, ": add priest failed: "));
                }
                else
                {
                    int resultParishManager = addParishManager(priestViewModel);
                    if (resultParishManager <= 0)
                    {
                        writeLog(string.Concat(priestViewModel.Name, ": update parish manager fail"));
                    }
                }
                return result;
            }
            catch (Exception ex)
            {
                writeLog(string.Concat(priestViewModel.Name, ": add priest exception: ", ex.Message));
                return 0;
            }
        }
        /// <summary>
        /// Add division history
        /// </summary>
        /// <returns></returns>
        private int addParishManager(PriestViewModel priest)
        {
            int result = 0;
            try
            {
                if (priest.Additional != null && priest.Additional is List<Dictionary<string, string>>
                    && (priest.Additional as List<Dictionary<string, string>>).Count > 0)
                {
                    List<Dictionary<string, string>> history = (List<Dictionary<string, string>>)priest.Additional;
                    foreach (var item in history)
                    {
                        if (item["nam"] != "")
                        {
                            ParishManager parishManager = null;
                            bool exists = false;
                            //Check exists
                            parishManager = _parishManagerBusiness.GetParishManagerByPriestIdAndDate(priest.Id, item["nam"]);
                            if (parishManager == null)
                            {
                                parishManager = new ParishManager();
                                parishManager.PriestId = priest.Id;
                            }
                            else
                            {
                                exists = true;
                            }

                            //set ParishId
                            Parish parish = _parishBusiness.GetParishesByParishName(item["noi"], 0);
                            if (parish != null)
                            {
                                parishManager.ParishId = parish.Id;
                            }

                            //Set StartDate
                            parishManager.StartDate = item["nam"];

                            //Set ParishName
                            if (item["noi"] != "")
                            {
                                parishManager.ParishName = item["noi"];
                            }

                            //Set position and position name
                            if (item["chucvu"] != "")
                            {
                                parishManager.PositionName = item["chucvu"];
                                parishManager.Position = getRoleId(parishManager.PositionName);
                            }
                            parishManager.StatusId = (int)ParishManagerStatusEnum.DaNhanNhiemVu;
                            if (exists)
                            {
                                result = _parishManagerBusiness.UpdateParishManager(parishManager);
                            }
                            else
                            {
                                result = _parishManagerBusiness.AddParishManager(parishManager);
                            }
                        }
                    }
                }
                else
                {
                    result = 1;
                }
            }
            catch (Exception ex)
            {
                writeLog(string.Concat(priest.Name, ": add parish manager exception: ", ex.Message));
            }
            return result;
        }

        private void assignVocationProp(Vocation vocation, PriestViewModel priest)
        {
            vocation.ParishionerId = priest.ParishionerId.GetValueOrDefault();
            vocation.Position = 4; // Linh mục
            vocation.IsLeft = false;
            vocation.IsRetired = priest.IsRetired == 1 ? true : false;
            vocation.TypeCode = priest.TypeCode;
            vocation.ServedId = priest.ServedPlaceId;
            vocation.Seminary = priest.Seminary;
            vocation.ServedAddress = priest.ServedAddress;
            vocation.ServedPlace = priest.ServedPlace;
            vocation.ServedStartDate = priest.StartDate;
            vocation.Phone = priest.ServedPhone;
            vocation.Email = priest.ServedEmail;
            vocation.Date8 = priest.OrdinationDate; // ngay thu phong LM
            vocation.Place8 = priest.OrdinationPlace; // noi thu phong
            vocation.Giver8 = priest.OrdinationBy; // DGM thu phong
            vocation.ServedType = priest.ParishTypeCode;
            vocation.Note = priest.Note;
            vocation.ServedRole = priest.RoleId;
            //if (priest.ParishId != null)
            //{
            //    Parish parish = _parishBusiness.GetParishesByParishId((int)priest.ParishId);
            //    vocation.ServedType = parish.Category;
            //}
        }
        private void assignParishionerProp(Parishioner parishioner, PriestViewModel priest)
        {
            if (!string.IsNullOrEmpty(priest.Code))
            {
                parishioner.Code = priest.Code;
            }
            parishioner.ChristianName = priest.ChristianName;
            parishioner.Name = priest.Name;
            parishioner.Gender = 1;
            parishioner.BirthDate = priest.BirthDate;
            parishioner.IsCounted = false;
            parishioner.Status = 1;
            parishioner.DomicileStatus = 0;
            parishioner.IsStudying = false;
            parishioner.MobilePhone = priest.Phone;
            parishioner.IsCatechumen = false;
            parishioner.IsDead = false;
            parishioner.IsMarried = false;
            parishioner.IsSingle = true;
            parishioner.ParishId = 1;

            parishioner.Title = priest.Title;
            parishioner.PatronDate = priest.PatronDate;
            parishioner.Email = priest.Email;

            parishioner.CreatedDate = DateTime.Now;
        }

        private bool importBaptism(PriestViewModel priest)
        {
            try
            {
                if (priest.ParishionerId != null && priest.ParishionerId != 0 && !string.IsNullOrEmpty(priest.BaptismDate))
                {
                    SacramentBusiness sacramentBusiness = new SacramentBusiness(DbConfig.GetConnectionString());
                    Sacrament sacramentCheck = sacramentBusiness.GetSacramentsByParishionerIdAndType((int)priest.ParishionerId, (int)PMS.DataAccess.Enumerations.SacramentEnum.Baptism);
                    Sacrament sacrament = null;
                    if (sacramentCheck == null)
                    {
                        sacrament = new Sacrament();
                    }
                    else
                    {
                        sacrament = sacramentCheck;
                    }
                    sacrament.ParishionerId = (int)priest.ParishionerId;
                    sacrament.Type = (int)PMS.DataAccess.Enumerations.SacramentEnum.Baptism;
                    sacrament.Date = convertDateForImport(priest.BaptismDate);
                    sacrament.Giver = priest.BaptismPriest;
                    sacrament.ReceivedPlace = priest.BaptismPlace;
                    int result = 0;
                    if (sacramentCheck == null)
                    {
                        result = sacramentBusiness.AddSacrament(sacrament);
                    }
                    else
                    {
                        result = sacramentBusiness.UpdateSacrament(sacrament);
                    }
                    if (result <= 0)
                    {
                        writeLog(string.Concat(priest.Name, ": add sacrament failed: "));
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                writeLog(string.Concat(priest.Name, ": exception when inport baptism: ", ex.Message));
                return false;
            }
        }

        [ValidateInput(false)]
        public ActionResult UpdatePriest(PriestViewModel priestViewModel)
        {
            var converter = new DateConverter();

            priestViewModel.BirthDate = converter.ConvertDateToString(priestViewModel.BirthDate);
            Priest priest = new Priest();
            priest.Id = priestViewModel.Id;
            priest.ChristianName = priestViewModel.ChristianName;
            priest.Name = priestViewModel.Name;
            priest.BirthDate = priestViewModel.BirthDate;
            priest.DioceseId = priestViewModel.DioceseId;
            priest.Phone = priestViewModel.Phone;
            priest.ParishionerId = priestViewModel.ParishionerId;
            int priestId = _priestBusiness.UpdatePriest(priest);
            int parishionerId = _parishionerBusiness.checkExistsCodeOrNot(priestViewModel.Code);

            int result;
            if (priestId > 0 && (parishionerId == 0 || parishionerId == priestViewModel.ParishionerId))
            {
                Parishioner parishioner = new Parishioner();
                parishioner = _parishionerBusiness.getParishionerById((int)priestViewModel.ParishionerId);
                parishioner.Code = priestViewModel.Code;
                if (priestViewModel.ImageURL != null && priestViewModel.ImageURL != "")
                {
                    parishioner.ImageUrl = System.IO.Path.GetFileName(priestViewModel.ImageURL);
                }
                else
                {
                    parishioner.ImageUrl = priestViewModel.ImageURL;
                }

                parishioner.ChristianName = priestViewModel.ChristianName;
                parishioner.Name = priestViewModel.Name;
                parishioner.BirthDate = priestViewModel.BirthDate;
                parishioner.MobilePhone = priestViewModel.Phone;
                result = _parishionerBusiness.UpdateParishioner(parishioner, false);
            }
            else
            {
                result = 0;
            }
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult DeletePriest(int id)
        {
            Priest priest = _priestBusiness.GetPriestByPriestId(id);
            if (priest.ParishionerId != null && priest.ParishionerId != 0)
            {
                Parishioner parishioner = _parishionerBusiness.getParishionerById((int)priest.ParishionerId);
                parishioner.Status = (int)PMS.DataAccess.Enumerations.ParishionerStatusEnum.Deleted;
                parishioner.IsCounted = false;
                _parishionerBusiness.UpdateParishioner(parishioner, false);
            }

            int result = _priestBusiness.DeletePriest(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckYearOld(string date)
        {
            string currentTime = DateTime.Now.ToString("dd/MM/yyyy");
            var converter = new DateConverter();
            currentTime = converter.ConvertDateToString(currentTime);
            int current = Int32.Parse(currentTime);
            date = converter.ConvertDateToString(date);
            int birthdate = Int32.Parse(date);
            var result = current - birthdate;
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ImportFromExcel(HttpPostedFileBase file)
        {
            DataSet ds = new DataSet();
            if (Request.Files["file"].ContentLength > 0)
            {
                string fileExtension = System.IO.Path.GetExtension(Request.Files["file"].FileName);
                string fileName = System.IO.Path.GetFileNameWithoutExtension(Request.Files["file"].FileName);

                if (fileExtension == ".xls" || fileExtension == ".xlsx")
                {
                    string fileLocation = Server.MapPath("~/ImportExcel/") + fileName + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + fileExtension;
                    if (System.IO.File.Exists(fileLocation))
                    {
                        System.IO.File.Delete(fileLocation);
                    }
                    Request.Files["file"].SaveAs(fileLocation);
                    string excelConnectionString = string.Empty;
                    excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    //connection String for xls file format.
                    if (fileExtension == ".xls")
                    {
                        excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileLocation + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                    }
                    //connection String for xlsx file format.
                    else if (fileExtension == ".xlsx")
                    {
                        excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    }
                    //Create Connection to Excel work book and add oledb namespace
                    OleDbConnection excelConnection = new OleDbConnection(excelConnectionString);
                    excelConnection.Open();
                    DataTable dt = new DataTable();

                    dt = excelConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                    if (dt == null)
                    {
                        return null;
                    }

                    String[] excelSheets = new String[dt.Rows.Count];
                    int t = 0;
                    //excel data saves in temp file here.
                    foreach (DataRow row in dt.Rows)
                    {
                        excelSheets[t] = row["TABLE_NAME"].ToString();
                        t++;
                    }
                    OleDbConnection excelConnection1 = new OleDbConnection(excelConnectionString);

                    string query = string.Format("Select * from [{0}]", excelSheets[0]);
                    using (OleDbDataAdapter dataAdapter = new OleDbDataAdapter(query, excelConnection1))
                    {
                        dataAdapter.Fill(ds);
                    }
                    excelConnection.Close();
                    excelConnection1.Close();
                }
                if (fileExtension.ToString().ToLower().Equals(".xml"))
                {
                    string fileLocation = Server.MapPath("~/Content/") + Request.Files["FileUpload"].FileName;
                    if (System.IO.File.Exists(fileLocation))
                    {
                        System.IO.File.Delete(fileLocation);
                    }

                    Request.Files["FileUpload"].SaveAs(fileLocation);
                    XmlTextReader xmlreader = new XmlTextReader(fileLocation);
                    // DataSet ds = new DataSet();
                    ds.ReadXml(xmlreader);
                    xmlreader.Close();
                }
                List<PriestViewModel> listPriests = new List<PriestViewModel>();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    try
                    {
                        //insert to db
                        PriestViewModel priest = new PriestViewModel();
                        if (ds.Tables[0].Columns.Contains("ChristianName"))
                        {
                            priest.ChristianName = ds.Tables[0].Rows[i]["ChristianName"].ToString();
                            priest.Name = ds.Tables[0].Rows[i]["Name"].ToString();
                            priest.BirthDate = ds.Tables[0].Rows[i]["BirthDate"].ToString();
                            priest.DioceseId = Convert.ToInt16(ds.Tables[0].Rows[i]["DioceseId"]);
                            //_priestBusiness.AddPriest(priest); Khoan del
                        }
                        else if (ds.Tables[0].Columns.Contains("T#Thánh"))
                        {
                            priest.Code = string.Concat(ds.Tables[0].Rows[i]["Mã"].ToString().Trim().Replace(" ", ""));
                            priest.ChristianName = ds.Tables[0].Rows[i]["T#Thánh"].ToString().Trim();
                            priest.Name = normalizeVnSign(string.Concat(ds.Tables[0].Rows[i]["Họ và"].ToString().Trim(), " ", ds.Tables[0].Rows[i]["Tên"].ToString().Trim()));
                            priest.BirthDate = convertDateForImport(ds.Tables[0].Rows[i]["Sinh"]);
                            priest.BirthPlace = ds.Tables[0].Rows[i]["Nơi sinh"].ToString().Trim();
                            priest.Phone = ds.Tables[0].Rows[i]["Di động "].ToString().Trim();
                            priest.Email = ds.Tables[0].Rows[i]["Email"].ToString().Trim();

                            priest.ParishName = normalizeVnSign(ds.Tables[0].Rows[i]["Giáo xứ "].ToString().Trim());
                            if (priest.ParishName == "HongKong") priest.ParishName = "Hong Kong";
                            if (priest.ParishName == "Chánh Tòa") priest.ParishName = "Chính Tòa";
                            if (priest.ParishName == "Đức Mẹ VNNT") priest.ParishName = "Đức Mẹ Vô Nhiễm Nguyên Tội";
                            if (priest.ParishName == "Xuân Thanh") priest.ParishName = "Xuân Thành";
                            //if (priest.ParishName == "Đan Kar") priest.ParishName = "Đankar";
                            //if (priest.ParishName == "Na Goa") priest.ParishName = "Nagoa";
                            if (priest.ParishName == "ĐakLua") priest.ParishName = "Đắc Lua";
                            if (priest.ParishName == "Phaolô") priest.ParishName = "Thánh Phaolô";
                            if (priest.ParishName == "Cha Rang") priest.ParishName = "Chà Rang";

                            priest.PatronDate = ds.Tables[0].Rows[i]["Mừng "].ToString().Trim().Replace("-", "").Replace(".", "").Replace(" ", "");
                            priest.Title = ds.Tables[0].Rows[i]["D#xưng"].ToString().Trim();
                            priest.Seminary = normalizeVnSign(ds.Tables[0].Rows[i]["Dòng"].ToString().Trim());
                            priest.VicariateName = normalizeVnSign(ds.Tables[0].Rows[i]["Giáo hạt"].ToString().Trim());
                            priest.TypeCode = ds.Tables[0].Rows[i]["Note"].ToString().Trim().Replace(" ", "");
                            priest.Note = ds.Tables[0].Rows[i]["Ghi chú"].ToString().Trim();
                            priest.IsRetired = ds.Tables[0].Rows[i]["Hưu"].ToString().Trim() != "" ? 1 : 0;
                            priest.Diocesan = ds.Tables[0].Rows[i]["Dòng"].ToString().Trim() != "" ? false : true;
                            priest.ServedPlace = priest.ParishName;
                            priest.ServedAddress = ds.Tables[0].Rows[i]["Địa chỉ"].ToString().Trim();
                            priest.ServedPhone = ds.Tables[0].Rows[i]["Đ Thoại bàn"].ToString().Trim();
                            priest.BaptismDate = convertDateForImport(ds.Tables[0].Rows[i]["Rửa tội"]);
                            priest.BaptismPlace = normalizeVnSign(ds.Tables[0].Rows[i]["Nơi RT"].ToString().Trim());
                            priest.OrdinationDate = convertDateForImport(ds.Tables[0].Rows[i]["Chịu Chức"]);
                            priest.OrdinationPlace = normalizeVnSign(ds.Tables[0].Rows[i]["Tại"].ToString().Trim());
                            priest.OrdinationBy = normalizeVnSign(ds.Tables[0].Rows[i]["Do ĐGM#"].ToString().Trim());
                            //priest.StartDate = convertDateForImport(ds.Tables[0].Rows[i]["Rửa tội"]);

                            string hienNay = ds.Tables[0].Rows[i]["Hiện nay"].ToString().Trim();

                            priest.RoleId = getRoleId(hienNay);
                            priest.Role = hienNay;
                            string roleNote = getRoleNote(hienNay);
                            if (!string.IsNullOrEmpty(priest.Note))
                            {
                                priest.Note = string.Concat(priest.Note, ". ", roleNote);
                            }
                            else
                            {
                                priest.Note = roleNote;
                            }

                            //get vicariate and diocese
                            Vicariate vicariate = _vicariateBusiness.GetVicariateByVicariateName(priest.VicariateName);
                            if (vicariate != null)
                            {
                                priest.VicariateId = vicariate.Id;
                                priest.DioceseId = vicariate.DioceseId;
                                addParishIfNotExist(priest, vicariate.Id);
                            }
                            else
                            {
                                priest.DioceseId = (int)Session["DioceseId"];
                                addParishIfNotExist(priest, 0);
                                //writeLog(string.Concat(priest.Name, ": Vicariate is not found, ", priest.VicariateName));
                            }

                            priest.Additional = getDivisionHistory(ds.Tables[0].Rows[i]);
                            priest.StartDate = getStartDate((List<Dictionary<string, string>>)priest.Additional);

                            //find existing parishioner
                            Parishioner parishioner = _parishionerBusiness.GetParishionerByForCheck(priest.Name, priest.ChristianName, priest.BirthDate);
                            if (parishioner != null)
                            {
                                priest.ParishionerId = parishioner.Id;
                            }
                            else
                            {
                                writeLog(string.Concat("\tParishioner not found: ", "\t", priest.Name, "\t", priest.ParishName, "\t", priest.Role, "\t", priest.VicariateName));
                            }
                        }
                        listPriests.Add(priest);
                        // Khoan add start
                        addPriest(priest);
                        // Khoan add end
                    }
                    catch (Exception ex)
                    {
                        writeLog(string.Concat(ds.Tables[0].Rows[i]["Mã"], ": exception when inport: ", ex.Message));
                    }
                }

            }
            return RedirectToAction("Index");
        }

        private string normalizeVnSign(string s)
        {
            // replace oà into òa, aò into ào (Hòa, Hào)
            string[] ss = s.Split(' ');
            for (int i = 0; i < ss.Length; i++)
            {
                if (ss[i].EndsWith("oà"))
                {
                    ss[i] = ss[i].Replace("oà", "òa");
                }
                else if (ss[i].EndsWith("aò"))
                {
                    ss[i] = ss[i].Replace("òa", "ào");
                }
            }
            return string.Join(" ", ss);
        }

        private string getStartDate(List<Dictionary<string, string>> divisionHistory)
        {
            string lastDate = "";
            if (divisionHistory != null && divisionHistory.Count > 0)
            {
                foreach (var item in divisionHistory)
                {
                    if (item["nam"] != "")
                    {
                        lastDate = item["nam"];
                    }
                    else
                    {
                        break;
                    }
                }
            }
            return lastDate;
        }

        private List<Dictionary<string, string>> getDivisionHistory(DataRow row)
        {
            DateConverter dateConverter = new DateConverter();
            List<Dictionary<string, string>> thuyenChuyen = new List<Dictionary<string, string>>();
            string nam = "Năm ";
            string giup = "Giúp ";
            string chucvu = "Chuc vu ";
            string noi = "Noi ";
            for (int i = 1; i <= 10; i++)
            {
                string nam_i = string.Concat(nam, i);
                string chucvu_i = string.Concat(chucvu, i);
                string noi_i = string.Concat(noi, i);
                string giup_i = string.Concat(giup, i);

                Dictionary<string, string> data = new Dictionary<string, string>();
                data["nam"] = "";
                data["chucvu"] = "";
                data["noi"] = "";
                if (row.Table.Columns.Contains(nam_i))
                {
                    data["nam"] = dateConverter.ConvertDateToString(row[nam_i].ToString().Trim()).Trim();
                    if (data["nam"].Length > 8)
                    {
                        data["nam"] = data["nam"].Substring(data["nam"].Length - 8);
                    }
                    if (!string.IsNullOrEmpty(data["nam"]))
                    {
                        if (row.Table.Columns.Contains(chucvu_i))
                        {
                            data["chucvu"] = row[chucvu_i].ToString().Trim();
                        }
                        if (row.Table.Columns.Contains(noi_i))
                        {
                            data["noi"] = row[noi_i].ToString().Trim();
                        }
                        else if (row.Table.Columns.Contains(giup_i))
                        {
                            data["noi"] = row[giup_i].ToString().Trim();
                        }
                        thuyenChuyen.Add(data);
                    }
                }
            }
            return thuyenChuyen;
        }

        private static Dictionary<string, int> roleData = new Dictionary<string, int>();
        private Dictionary<string, int> getMappingForRole()
        {
            if (roleData.Count == 0)
            {
                roleData.Add("du học", 4);
                roleData.Add("bề trên cđ. vinhsơn túc trưng -", 5);
                roleData.Add("bề trên cộng đoàn đaminh -", 5);
                roleData.Add("bê trên đan viện biển đức -", 5);
                roleData.Add("bề trên đan viện xitô an phước -", 5);
                roleData.Add("chánh xứ", 1);
                roleData.Add("cộng đoàn", 6);
                roleData.Add("cộng đoàn đaminh -", 6);
                roleData.Add("cộng đoàn don bosco -", 6);
                roleData.Add("cộng đoàn đồng công -", 6);
                roleData.Add("cộng đoàn dòng tên -", 6);
                roleData.Add("cộng đoàn gioan tc -", 6);
                roleData.Add("cộng đoàn nhà chúa -", 6);
                roleData.Add("cộng đoàn thánh gia -", 6);
                roleData.Add("cộng đoàn thánh tâm huế -", 6);
                roleData.Add("cộng đoàn thánh thể -", 6);
                roleData.Add("cộng đoàn vinhsơn -", 6);
                roleData.Add("cộng đoàn vinhsơn túc trưng -", 6);
                roleData.Add("đặc trách", 7);
                roleData.Add("đan viện biển đức -", 7);
                roleData.Add("đan viện xitô an phước -", 7);
                roleData.Add("đan viện xitô phước lý -", 7);
                roleData.Add("dòng thánh gioan tc -", 7);
                roleData.Add("giám đốc", 8);
                roleData.Add("giáo xứ", 16);
                roleData.Add("linh phụ", 10);
                roleData.Add("nhà riêng", 17);
                roleData.Add("phó ht", 11);
                roleData.Add("hiệu trưởng", 9);
                roleData.Add("phó xứ", 2);
                roleData.Add("phụ tá", 2);
                roleData.Add("phụ trách", 12);
                roleData.Add("quản nhiệm", 13);
                roleData.Add("tổng đại diện gp. xuân lộc", 14);
                roleData.Add("truyền giáo", 3);
                roleData.Add("viện phụ đv. xitô phước lý", 15);
            }

            return roleData;
        }

        private int getRoleId(string name)
        {
            var roleMapping = getMappingForRole();
            name = name.Trim().ToLower();
            if (roleMapping.ContainsKey(name))
            {
                return roleMapping[name];
            }
            return -1;
        }


        private static Dictionary<string, string> roleNoteData = new Dictionary<string, string>();
        private Dictionary<string, string> getMappingForRoleNote()
        {
            if (roleNoteData.Count == 0)
            {
                roleNoteData.Add("bề trên cđ. vinhsơn túc trưng -", "Cộng đoàn Vinhsơn Túc Trưng");
                roleNoteData.Add("bề trên cộng đoàn đaminh -", "Cộng đoàn Đaminh");
                roleNoteData.Add("bê trên đan viện biển đức -", "Đan viện Biển Đức");
                roleNoteData.Add("bề trên đan viện xitô an phước -", "Đan viện Xitô An Phước");
                roleNoteData.Add("cộng đoàn đaminh -", "Cộng đoàn Đaminh");
                roleNoteData.Add("cộng đoàn don bosco -", "Cộng đoàn Don Bosco");
                roleNoteData.Add("cộng đoàn đồng công -", "Cộng đoàn Đồng Công");
                roleNoteData.Add("cộng đoàn dòng tên -", "Cộng đoàn Dòng Tên");
                roleNoteData.Add("cộng đoàn gioan tc -", "Cộng đoàn Gioan TC");
                roleNoteData.Add("cộng đoàn nhà chúa -", "Cộng đoàn Nhà Chúa");
                roleNoteData.Add("cộng đoàn thánh gia -", "Cộng đoàn Thánh Gia");
                roleNoteData.Add("cộng đoàn thánh tâm huế -", "Cộng đoàn Thánh Tâm Huế");
                roleNoteData.Add("cộng đoàn thánh thể -", "Cộng đoàn Thánh Thể");
                roleNoteData.Add("cộng đoàn vinhsơn -", "Cộng đoàn Vinhsơn");
                roleNoteData.Add("cộng đoàn vinhsơn túc trưng -", "Cộng đoàn Vinhsơn Túc Trưng");
                roleNoteData.Add("đan viện biển đức -", "Đan viện Biển Đức");
                roleNoteData.Add("đan viện xitô an phước -", "Đan viện Xitô An Phước");
                roleNoteData.Add("đan viện xitô phước lý -", "Đan viện Xitô Phước Lý");
                roleNoteData.Add("dòng thánh gioan tc -", "Dòng Thánh Gioan TC");
            }

            return roleNoteData;
        }

        private string getRoleNote(string name)
        {
            var roleMapping = getMappingForRoleNote();
            name = name.Trim().ToLower();
            if (roleMapping.ContainsKey(name))
            {
                return roleMapping[name];
            }
            return "";
        }

        private void addParishIfNotExist(PriestViewModel priest, int vicariateId)
        {
            Parish parish = _parishBusiness.GetParishesByParishName(priest.ParishName, 0);
            if (parish != null)
            {
                priest.ParishId = parish.Id;
                priest.ServedPlaceId = parish.Id;
                priest.ParishTypeCode = parish.Category;
            }
            else
            {
                //writeLog(string.Concat(priest.Name, ": Parish is not found, ", priest.ParishName, ", role: ", priest.Role, ", vicariate: ", priest.VicariateName));
                writeLog(string.Concat("\tParish not found: ", "\t", priest.Name, "\t", priest.ParishName, "\t", priest.Role, "\t", priest.VicariateName));
                ////Add parish if not exists
                //Parish newParish = new Parish();
                //newParish.Name = priest.ParishName;
                //newParish.DioceseId = priest.DioceseId;
                //newParish.VicariateId = vicariateId;
                //if(priest.Role == "Chánh xứ" || priest.Role == "Phó xứ")
                //{
                //    newParish.Category = 2;//Nhà thờ giáo xứ
                //}
                //else
                //{
                //    newParish.Category = -1;//Không xác định
                //}
                //int parishId = _parishBusiness.AddParish(parish);
                //if (parishId > 0)
                //{
                //    priest.ParishId = parishId;
                //    priest.ServedPlaceId = parishId;
                //    priest.ParishTypeCode = newParish.Category;
                //    writeLog(string.Concat(priest.Name, ": Add Parish successful, ", priest.ParishName));
                //}
                //else
                //{
                //    writeLog(string.Concat(priest.Name, ": Add Parish failed, ", priest.ParishName));
                //}
            }
        }
        private void writeLog(string log)
        {
            System.IO.File.AppendAllText(Server.MapPath(@"/log.txt"), string.Concat(Environment.NewLine, DateTime.Now, ": ", log), System.Text.Encoding.UTF8);
        }
        private string convertDateForImport(object date)
        {
            if (date != null && date is DateTime)
            {
                return ((DateTime)date).ToString("yyyyMMdd");
            }
            return "";
        }

        //VuongVM - Load priest for HDLM Members
        public ActionResult LoadParishDatatableForHDLM(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _priestBusiness.GetOrderedPriestsByParamsAndPagingForHDLM(param.sSearch,
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

        [SessionExpireFilter]
        public ActionResult PrintPage()
        {
            return View();
        }

        public ActionResult PrintPriest(string[] ids)
        {
            int parishId = (int)Session["ParishId"];

            List<ParishionerViewModel> result;
            result = _parishionerBusiness.PrintPriest(parishId, ids);

            StreamReader reader = new StreamReader(Server.MapPath("\\Views\\Priest\\_templatePriestCard.html"));
            string readFile = reader.ReadToEnd();
            reader.Close();

            string template = "";

            template = readFile;

            var fileThumbPath = ConfigurationManager.AppSettings["ParishionerThumbnailUrl"];

            for (int i = 0; i < result.Count; i++)
            {
                result[i].ImageURL = string.Concat(fileThumbPath, result[i].ImageURL);
            }

            return Json(new
            {
                result = result,
                template = template,
                now = DateTime.Now.ToString("dd/MM/yyyy"),
                threeYear = DateTime.Now.AddYears(3).ToString("dd/MM/yyyy")
            }, JsonRequestBehavior.AllowGet);
        }

        public string UploadPriestImage(HttpPostedFileWrapper inputFile)
        {
            var fileImagePath = ConfigurationManager.AppSettings["ParishionerImageUrl"];

            if (!Directory.Exists(Server.MapPath(fileImagePath)))
            {
                Directory.CreateDirectory(Server.MapPath(fileImagePath));
            }

            if (inputFile == null || inputFile.ContentLength == 0)
            {
                return "";
            }
            string s = inputFile.ContentType;
            var fileName = "";
            //if (Session["ImageName"] == null)
            //{
            //    fileName = String.Format("{0}.jpg", DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
            //}
            //else
            //{
            //    fileName = String.Format(Session["ImageName"].ToString());
            //}
            fileName = String.Format("{0}.jpg", DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);

            var imagePath = Path.Combine(Server.MapPath(Url.Content(fileImagePath)), fileName);
            //inputFile.SaveAs(imagePath);

            Image imageUpload = Image.FromStream(inputFile.InputStream);
            // Khoan mod start
            //Image image = ResizeImage(imageUpload, 300, 400);
            int width = (int)((400f / (float)imageUpload.Height) * imageUpload.Width);
            Image image = ResizeImage(imageUpload, width, 400);
            // Khoan mod end
            image.Save(imagePath, ImageFormat.Jpeg);

            var fileThumbPath = ConfigurationManager.AppSettings["ParishionerThumbnailUrl"];

            if (!Directory.Exists(Server.MapPath(fileThumbPath)))
            {
                Directory.CreateDirectory(Server.MapPath(fileThumbPath));
            }

            var thumbPath = Path.Combine(Server.MapPath(Url.Content(fileThumbPath)), fileName);
            // Khoan mod start
            //Image thumb = imageUpload.GetThumbnailImage(135, 180, () => false, IntPtr.Zero);
            width = (int)((180f / (float)imageUpload.Height) * imageUpload.Width);
            Image thumb = imageUpload.GetThumbnailImage(width, 180, () => false, IntPtr.Zero);
            // Khoan mod end
            thumb.Save(Path.ChangeExtension(thumbPath, "jpg"));

            return Url.Content(String.Format(fileName));
        }

        public static Bitmap ResizeImage(Image image, int width, int height)
        {
            var destRect = new Rectangle(0, 0, width, height);
            var destImage = new Bitmap(width, height);

            destImage.SetResolution(image.HorizontalResolution, image.VerticalResolution);

            using (var graphics = Graphics.FromImage(destImage))
            {
                graphics.CompositingMode = CompositingMode.SourceCopy;
                graphics.CompositingQuality = CompositingQuality.HighQuality;
                graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphics.SmoothingMode = SmoothingMode.HighQuality;
                graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;

                using (var wrapMode = new ImageAttributes())
                {
                    wrapMode.SetWrapMode(WrapMode.TileFlipXY);
                    graphics.DrawImage(image, destRect, 0, 0, image.Width, image.Height, GraphicsUnit.Pixel, wrapMode);
                }
            }
            return destImage;
        }

        public ActionResult ExportExcel(int? ParishId, int? VicariateId, List<Dictionary<string, string>> Columns, Dictionary<string, string> Data,
            int Draw, int Length, List<Dictionary<string, string>> Order, Dictionary<string, string> Search, int Start)
        {
            int DioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            jQueryDataTableParam param = new jQueryDataTableParam();

            param.DioceseId = DioceseId;
            param.ParishId = ParishId;
            param.VicariateId = VicariateId;
            param.columns = Columns;
            param.data = Data;
            param.draw = Draw;
            param.length = Length;
            param.order = Order;
            param.search = Search;
            param.start = Start;

            var result = _priestBusiness.GetOrderedPriestsByParamsAndPaging(param, out totalRecords, out totalDisplayRecords);

            Excel.Application exApp = new Excel.Application();
            Excel.Workbook exBook = exApp.Workbooks.Add(Excel.XlWBATemplate.xlWBATWorksheet);

            //get sheet 1
            Excel.Worksheet exSheet = (Excel.Worksheet)exBook.Worksheets[1];
            //Range is [1,1] (A1)
            Excel.Range r = (Excel.Range)exSheet.Cells[1, 1];
            //write data
            exSheet.Cells[1, 1].Value2 = "Mã";
            exSheet.Cells[1, 2].Value2 = "Mừng";
            exSheet.Cells[1, 3].Value2 = "D.xưng";
            exSheet.Cells[1, 4].Value2 = "T.Thánh";
            exSheet.Cells[1, 5].Value2 = "Họ và";
            exSheet.Cells[1, 6].Value2 = "Tên";
            exSheet.Cells[1, 7].Value2 = "Dòng";
            exSheet.Cells[1, 8].Value2 = "Chức vụ";
            exSheet.Cells[1, 9].Value2 = "Giáo xứ";
            exSheet.Cells[1, 10].Value2 = "Giáo hạt";
            exSheet.Cells[1, 11].Value2 = "Mã Nhóm";
            exSheet.Cells[1, 12].Value2 = "Tên Nhóm";
            exSheet.Cells[1, 13].Value2 = "Ghi chú";
            exSheet.Cells[1, 14].Value2 = "M.vụ";
            exSheet.Cells[1, 15].Value2 = "Hưu";
            exSheet.Cells[1, 16].Value2 = "Địa chỉ";
            exSheet.Cells[1, 17].Value2 = "Đ Thoại bàn";
            exSheet.Cells[1, 18].Value2 = "Di động";
            exSheet.Cells[1, 19].Value2 = "Email";
            exSheet.Cells[1, 20].Value2 = "Sinh";
            exSheet.Cells[1, 21].Value2 = "Năm sinh";
            exSheet.Cells[1, 22].Value2 = "Tuổi";
            exSheet.Cells[1, 23].Value2 = "Nơi sinh";
            exSheet.Cells[1, 24].Value2 = "Rửa tội";
            exSheet.Cells[1, 25].Value2 = "Nơi RT";
            exSheet.Cells[1, 26].Value2 = "Chịu Chức";
            exSheet.Cells[1, 27].Value2 = "Tại";
            exSheet.Cells[1, 28].Value2 = "Do ĐGM.";

            for (int i = 0; i < result.Count; i++)
            {
                exSheet.Cells[i + 2, 1].Value2 = result[i].Code;
                exSheet.Cells[i + 2, 2].Value2 = result[i].PatronDate;
                exSheet.Cells[i + 2, 3].Value2 = result[i].Title;
                exSheet.Cells[i + 2, 4].Value2 = result[i].ChristianName;
                exSheet.Cells[i + 2, 5].Value2 = result[i].LastName;
                exSheet.Cells[i + 2, 6].Value2 = result[i].FirstName;
                exSheet.Cells[i + 2, 7].Value2 = result[i].Seminary;
                exSheet.Cells[i + 2, 8].Value2 = result[i].Role;
                exSheet.Cells[i + 2, 9].Value2 = result[i].ParishName;
                exSheet.Cells[i + 2, 10].Value2 = result[i].VicariateName;
                exSheet.Cells[i + 2, 11].Value2 = result[i].TypeCode;
                exSheet.Cells[i + 2, 12].Value2 = result[i].TypeName;
                exSheet.Cells[i + 2, 13].Value2 = result[i].Note;
                exSheet.Cells[i + 2, 14].Value2 = result[i].IsRetired;
                exSheet.Cells[i + 2, 15].Value2 = result[i].IsRetired;
                exSheet.Cells[i + 2, 16].Value2 = result[i].ServedAddress;
                exSheet.Cells[i + 2, 17].Value2 = result[i].ServedPhone;
                exSheet.Cells[i + 2, 18].Value2 = result[i].Phone;
                exSheet.Cells[i + 2, 19].Value2 = result[i].Email;
                exSheet.Cells[i + 2, 20].Value2 = result[i].BirthDate;
                exSheet.Cells[i + 2, 21].Value2 = result[i].BirthYear;
                exSheet.Cells[i + 2, 22].Value2 = result[i].Age;
                exSheet.Cells[i + 2, 23].Value2 = result[i].BirthPlace;
                exSheet.Cells[i + 2, 24].Value2 = result[i].BaptismDate;
                exSheet.Cells[i + 2, 25].Value2 = result[i].BaptismPlace;
                exSheet.Cells[i + 2, 26].Value2 = result[i].OrdinationDate;
                exSheet.Cells[i + 2, 27].Value2 = result[i].OrdinationPlace;
                exSheet.Cells[i + 2, 28].Value2 = result[i].OrdinationBy;
            }

            exApp.Visible = true;

            exApp.Quit();

            return RedirectToAction("Index");
        }
    }
}