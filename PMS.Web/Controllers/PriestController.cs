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
            return View();
        }

        public ActionResult LoadParishDatatable(jQueryDataTableParamModel param)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _priestBusiness.GetOrderedPriestsByParamsAndPaging(dioceseId, param.sSearch,
               param.iSortCol_0, param.sSortDir_0, param.iDisplayStart, param.iDisplayLength, out totalRecords,
               out totalDisplayRecords);

            var fileThumbPath = ConfigurationManager.AppSettings["ParishionerThumbnailUrl"];
            for (int i = 0; i < result.Count; i++)
            {
                result[i].ThumbnailURL = string.Concat(fileThumbPath, result[i].ImageURL);
            }

            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
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
        public ActionResult AddPriest(PriestViewModel priestViewModel)
        {
            var result = addPriest(priestViewModel);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        private int addPriest(PriestViewModel priestViewModel)
        {
            int dioceseId = (int)Session["DioceseId"];

            var priest = new Priest();
            priest.ChristianName = priestViewModel.ChristianName;
            priest.Name = priestViewModel.Name;
            priest.BirthDate = priestViewModel.BirthDate;
            priest.Phone = priestViewModel.Phone;
            priest.ParishionerId = priestViewModel.ParishionerId;
            priest.DioceseId = dioceseId;
            var converter = new DateConverter();
            priest.BirthDate = converter.ConvertDateToString(priest.BirthDate);
            if (priest.BirthDate.Length > 8) priest.BirthDate = priest.BirthDate.Substring(0, 8);
            int result = 0;
            if (priestViewModel.ParishionerId == 0)
            {
                Parishioner parishioner = new Parishioner();
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
                parishioner.ImageUrl = priestViewModel.ImageURL;
                parishioner.ChristianName = priest.ChristianName;
                parishioner.Name = priest.Name;
                parishioner.Gender = 1;
                parishioner.BirthDate = priest.BirthDate;
                parishioner.IsCounted = false;
                parishioner.Status = 0;
                parishioner.DomicileStatus = 0;
                parishioner.IsStudying = false;
                parishioner.MobilePhone = priest.Phone;
                parishioner.IsCatechumen = false;
                parishioner.IsDead = false;
                parishioner.IsMarried = false;
                parishioner.IsSingle = true;
                parishioner.CommunityId = 1;
                parishioner.CreatedDate = DateTime.Now;
                priest.ParishionerId = _parishionerBusiness.AddParishioner(parishioner);

                Vocation vocation = new Vocation();
                vocation.ParishionerId = priest.ParishionerId.GetValueOrDefault();
                vocation.Position = 4;
                vocation.IsLeft = false;
                var vocationParishionerId = _vocationBusiness.AddVocation(vocation);

                if (vocationParishionerId == priest.ParishionerId)
                {
                    result = _priestBusiness.AddPriest(priest);
                }
                else result = 0;
            }
            else
            {
                Vocation vocation = new Vocation();
                vocation.ParishionerId = priest.ParishionerId.GetValueOrDefault();
                vocation.Position = 4;
                vocation.IsLeft = false;
                var vocationParishionerId = _vocationBusiness.AddVocation(vocation);

                if (vocationParishionerId == priest.ParishionerId)
                {
                    result = _priestBusiness.AddPriest(priest);
                }
                else result = 0;
            }
            return result;
        }

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
                parishioner = _parishionerBusiness.getParishionerById(priestViewModel.ParishionerId);
                parishioner.Code = priestViewModel.Code;
                parishioner.ImageUrl = priestViewModel.ImageURL;
                parishioner.ChristianName = priestViewModel.ChristianName;
                parishioner.Name = priestViewModel.Name;
                parishioner.BirthDate = priestViewModel.BirthDate;
                parishioner.MobilePhone = priestViewModel.Phone;
                result = _parishionerBusiness.UpdateParishioner(parishioner);
            }
            else
            {
                result = 0;
            }
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);

        }

        public ActionResult DeletePriest(int id)
        {
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

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    //insert to db
                    PriestViewModel priest = new PriestViewModel();
                    priest.ChristianName = ds.Tables[0].Rows[i]["ChristianName"].ToString();
                    priest.Name = ds.Tables[0].Rows[i]["Name"].ToString();
                    priest.BirthDate = ds.Tables[0].Rows[i]["BirthDate"].ToString();
                    priest.DioceseId = Convert.ToInt16(ds.Tables[0].Rows[i]["DioceseId"]);
                    //_priestBusiness.AddPriest(priest); Khoan del

                    // Khoan add start
                    addPriest(priest);
                    // Khoan add end
                }

            }
            return RedirectToAction("Index");
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

            for(int i = 0; i< result.Count; i++)
            {
                result[i].ImageURL = string.Concat(fileThumbPath, result[i].ImageURL);
            }

            return Json(new
            {
                result = result,
                template = template,
                now = DateTime.Now.ToString("dd/MM/yyyy")
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
            if (Session["ImageName"] == null)
            {
                fileName = String.Format("{0}.jpg", DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
            }
            else
            {
                fileName = String.Format(Session["ImageName"].ToString());
            }

            var imagePath = Path.Combine(Server.MapPath(Url.Content(fileImagePath)), fileName);
            //inputFile.SaveAs(imagePath);

            Image imageUpload = Image.FromStream(inputFile.InputStream);
            // Khoan mod start
            //Image image = ResizeImage(imageUpload, 300, 400);
            int width = (int)((400f/(float)imageUpload.Height) * imageUpload.Width);
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
    }
}