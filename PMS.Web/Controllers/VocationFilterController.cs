using OfficeOpenXml;
using PMS.BusinessLogic;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Controllers
{
    public class VocationFilterController : Controller
    {
        // GET: VocationFilter
        private readonly ParishBusiness _parishBusiness;
        private readonly VaiTroBusiness _vaitroBusiness;
        private readonly VocationFilterBusiness _vocationFilterBusiness;
        private readonly ParishionerBusiness _parishionerBusiness;
        private readonly VocationBusiness _vocationBusiness;
        private readonly DioceseBusiness _dioceseBusiness;
        private readonly VicariateBusiness _vicariateBusiness;
        private readonly ValueSetBusiness _valuesetBusiness;

        public VocationFilterController()
        {
            _parishBusiness = new ParishBusiness(DbConfig.GetConnectionString());
            _vaitroBusiness = new VaiTroBusiness(DbConfig.GetConnectionString());
            _vocationFilterBusiness = new VocationFilterBusiness(DbConfig.GetConnectionString());
            _parishionerBusiness = new ParishionerBusiness(DbConfig.GetConnectionString());
            _vocationBusiness = new VocationBusiness(DbConfig.GetConnectionString());
            _dioceseBusiness = new DioceseBusiness(DbConfig.GetConnectionString());
            _vicariateBusiness = new VicariateBusiness(DbConfig.GetConnectionString());
            _valuesetBusiness = new ValueSetBusiness(DbConfig.GetConnectionString());
        }
        public ActionResult Index()
        {
            ViewBag.Parishes = _parishBusiness.GetAllParish().ToList();
            ViewBag.VaiTro = _vaitroBusiness.GetAllVaiTro().ToList();
            ViewBag.TypeCode = _vocationBusiness.GetTypeCodes().ToList();
            ViewBag.Dioceses = _dioceseBusiness.GetAllDioceses().ToList();
            ViewBag.Vicariates = _vicariateBusiness.getAllVicariate().ToList();
            ViewBag.Seminary = _parishBusiness.GetParishFilter().ToList();
            return View();
        }

        public ActionResult LoadParishionerDatatable(jQueryDataTableParam param, string seminary, string seminaryPosition, string servedPlace, string vocationServedRole)
        {
            int dioceseId = (int)Session["DioceseId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            param.DioceseId = dioceseId;

            var result = _vocationFilterBusiness.GetOrderedParishionersByParamsAndPaging(param, out totalRecords, out totalDisplayRecords,
                                seminary, seminaryPosition, servedPlace, vocationServedRole);

            var fileThumbPath = ConfigurationManager.AppSettings["ParishionerThumbnailUrl"];
            for (int i = 0; i < result.Count; i++)
            {
                result[i].ThumbnailURL = _parishionerBusiness.GetImageUrl(string.Concat(fileThumbPath, result[i].ImageURL), (int)PMS.DataAccess.Enumerations.GenderEnum.Male);
            }

            return Json(new
            {
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ExportExcel(int? ParishId, int? VicariateId, List<Dictionary<string, string>> Columns, Dictionary<string, string> Data,
            int Draw, int Length, List<Dictionary<string, string>> Order, Dictionary<string, string> Search, int Start,
            string seminary, string seminaryPosition, string servedPlace, string vocationServedRole)
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

            var result = _vocationFilterBusiness.GetOrderedParishionersByParamsAndPaging(param, out totalRecords, out totalDisplayRecords,
                                seminary, seminaryPosition, servedPlace, vocationServedRole);
            string sheetName = "Danh sách Linh Mục";
            ExcelPackage p = new ExcelPackage();
            p.Workbook.Worksheets.Add(sheetName);
            ExcelWorksheet exSheet = p.Workbook.Worksheets[1];
            exSheet.Name = sheetName; //Setting Sheet's name

            //write data
            string[] captions = new string[] {
              "Mã",
              "Mừng",
              "D.xưng",
              "T.Thánh",
              "Họ và",
              "Tên",
              "Dòng",
              "Chức vụ",
              "Giáo xứ",
              "Giáo hạt",
              "Mã Nhóm",
              "Tên Nhóm",
              "Ghi chú",
              "M.vụ/Hưu",
              "Địa chỉ",
              "Đ Thoại bàn",
              "Di động",
              "Email",
              "Ngày Sinh",
              "Năm sinh",
              "Tuổi",
              "Nơi sinh",
              "Rửa tội",
              "Nơi RT",
              "Chịu Chức",
              "Tại",
              "Do ĐGM."
            };
            for (int i = 0; i < captions.Length; i++)
            {
                exSheet.Cells[1, i + 1].Value = captions[i];
            }
            exSheet.Cells[1, 1, 1, captions.Length].Style.Font.Bold = true;

            for (int i = 0; i < result.Count; i++)
            {
                int j = 1;
                exSheet.Cells[i + 2, j++].Value = result[i].Code;
                exSheet.Cells[i + 2, j++].Value = result[i].PatronDate;
                exSheet.Cells[i + 2, j++].Value = result[i].Title;
                exSheet.Cells[i + 2, j++].Value = result[i].ChristianName;
                exSheet.Cells[i + 2, j++].Value = result[i].LastName;
                exSheet.Cells[i + 2, j++].Value = result[i].FirstName;
                exSheet.Cells[i + 2, j++].Value = result[i].Seminary;
                exSheet.Cells[i + 2, j++].Value = result[i].Role;
                exSheet.Cells[i + 2, j++].Value = result[i].ParishName;
                exSheet.Cells[i + 2, j++].Value = result[i].VicariateName;
                exSheet.Cells[i + 2, j++].Value = result[i].TypeCode;
                exSheet.Cells[i + 2, j++].Value = result[i].TypeName;
                exSheet.Cells[i + 2, j++].Value = result[i].Note;
                exSheet.Cells[i + 2, j++].Value = result[i].IsRetired == 1 ? "Hưu" : "Mục vụ";
                exSheet.Cells[i + 2, j++].Value = result[i].ServedAddress;
                exSheet.Cells[i + 2, j++].Value = result[i].ServedPhone;
                exSheet.Cells[i + 2, j++].Value = result[i].Phone;
                exSheet.Cells[i + 2, j++].Value = result[i].Email;
                exSheet.Cells[i + 2, j++].Value = result[i].BirthDate;
                exSheet.Cells[i + 2, j++].Value = result[i].BirthYear;
                exSheet.Cells[i + 2, j++].Value = result[i].Age;
                exSheet.Cells[i + 2, j++].Value = result[i].BirthPlace;
                exSheet.Cells[i + 2, j++].Value = result[i].BaptismDate;
                exSheet.Cells[i + 2, j++].Value = result[i].BaptismPlace;
                exSheet.Cells[i + 2, j++].Value = result[i].OrdinationDate;
                exSheet.Cells[i + 2, j++].Value = result[i].OrdinationPlace;
                exSheet.Cells[i + 2, j++].Value = result[i].OrdinationBy;
            }

            exSheet.Cells.AutoFitColumns();

            Byte[] bin = p.GetAsByteArray();
            string fileName = Server.MapPath("/exports");
            if (!Directory.Exists(fileName))
            {
                Directory.CreateDirectory(fileName);
            }

            fileName += "/danh_sach_LM_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx";

            System.IO.File.WriteAllBytes(fileName, bin);

            p.Dispose();

            return Json(new { fileName = Path.GetFileName(fileName) }, JsonRequestBehavior.AllowGet);
        }

        [SessionExpireFilter]
        public ActionResult PrintPage()
        {
            return View();
        }

        public ActionResult PrintParishioner(string[] ids)
        {
            int parishId = (int)Session["ParishId"];

            List<PriestViewModel> result = _parishionerBusiness.PrintPriest(parishId, ids);

            StreamReader reader = new StreamReader(Server.MapPath("\\Views\\VocationFilter\\_templateParishionerCard.html"));
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
    }
}