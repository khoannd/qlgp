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

namespace PMS.Web.Controllers
{
    public class PriestController : Controller
    {
        //
        // GET: /Priest/
        private readonly PriestBusiness _priestBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;
        private readonly VocationBusiness _vocationBusiness;

        public PriestController()
        {
            _priestBusiness = new PriestBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
            _vocationBusiness = new VocationBusiness(DbConfig.GetConnectionString());
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
            Priest priest = _priestBusiness.GetPriestByPriestId(id);
            PriestViewModel model = new PriestViewModel();
            var converter = new DateConverter();
            model.Id = priest.Id;
            model.ChristianName = priest.ChristianName;
            model.Name = priest.Name;
            model.BirthDate = converter.ConvertStringToDate(priest.BirthDate);
            model.DioceseId = priest.DioceseId;
            model.Phone = priest.Phone;
            model.ParishionerId = priest.ParishionerId.GetValueOrDefault();
            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddPriest(Priest priest)
        {
            int dioceseId = (int)Session["DioceseId"];
            priest.DioceseId = dioceseId;
            var converter = new DateConverter();
            priest.BirthDate = converter.ConvertDateToString(priest.BirthDate);
            int result = 0;
            if (priest.ParishionerId == null)
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
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UpdatePriest(Priest priest)
        {
            var converter = new DateConverter();
            priest.BirthDate = converter.ConvertDateToString(priest.BirthDate);
            int result = _priestBusiness.UpdatePriest(priest);
            if (result > 0)
            {
                Parishioner parishioner = new Parishioner();
                parishioner = _parishionerBusiness.getParishionerById(priest.ParishionerId.GetValueOrDefault());
                parishioner.ChristianName = priest.ChristianName;
                parishioner.Name = priest.Name;
                parishioner.BirthDate = priest.BirthDate;
                parishioner.MobilePhone = priest.Phone;
                _parishionerBusiness.UpdateParishioner(parishioner);
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
                    Priest priest = new Priest();
                    priest.ChristianName = ds.Tables[0].Rows[i]["ChristianName"].ToString();
                    priest.Name = ds.Tables[0].Rows[i]["Name"].ToString();
                    priest.BirthDate = ds.Tables[0].Rows[i]["BirthDate"].ToString();
                    priest.DioceseId = Convert.ToInt16(ds.Tables[0].Rows[i]["DioceseId"]);
                    _priestBusiness.AddPriest(priest);
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
    }
}