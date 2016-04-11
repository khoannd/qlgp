using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using PMS.Web.Filters;
using PMS.Web.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Controllers
{
    public class SeminarianController : Controller
    {
        private readonly SeminarianBusiness _seminarianBusiness;

        public SeminarianController()
        {
            _seminarianBusiness = new SeminarianBusiness(DbConfig.GetConnectionString());
        }

        // GET: Seminarian
        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LoadSeminarianDatatable(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _seminarianBusiness.GetOrderedSeminariansByParamsAndPaging(param.sSearch,
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

        public ActionResult LoadSeminarianById(int id)
        {
            var seminarian = _seminarianBusiness.Get(id);
            var converter = new DateConverter();
            return Json(new
            {
                result = new
                {
                    seminarian.ParishionerId,
                    Date2 = converter.ConvertStringToDateObjectNullable(seminarian.Date2),
                    Date7 = converter.ConvertStringToDateObjectNullable(seminarian.Date7),
                    Date8 = converter.ConvertStringToDateObjectNullable(seminarian.Date8),
                    Parishioner = new
                    {
                        seminarian.Parishioner.Address,
                        BirthDate = converter.ConvertStringToDateObjectNullable(seminarian.Parishioner.BirthDate),
                        seminarian.Parishioner.BirthPlace,
                        seminarian.Parishioner.Career,
                        seminarian.Parishioner.ChristianName,
                        seminarian.Parishioner.Code,
                        seminarian.Parishioner.CreatedBy,
                        seminarian.Parishioner.CreatedDate,
                        seminarian.Parishioner.DeadDate,
                        seminarian.Parishioner.DomicilePlace,
                        seminarian.Parishioner.DomicileStatus,
                        seminarian.Parishioner.Education,
                        seminarian.Parishioner.Email,
                        seminarian.Parishioner.FatherName,
                        seminarian.Parishioner.Gender,
                        seminarian.Parishioner.Id,
                        seminarian.Parishioner.ImageUrl,
                        seminarian.Parishioner.IsCatechumen,
                        seminarian.Parishioner.IsCounted,
                        seminarian.Parishioner.IsDead,
                        seminarian.Parishioner.IsMarried,
                        seminarian.Parishioner.IsSingle,
                        seminarian.Parishioner.IsStudying,
                        seminarian.Parishioner.LastUpdatedBy,
                        seminarian.Parishioner.MobilePhone,
                        seminarian.Parishioner.MotherName,
                        seminarian.Parishioner.Name,
                        seminarian.Parishioner.Note,
                        seminarian.Parishioner.Phone,
                        seminarian.Parishioner.Status
                    },
                    seminarian.IsLeft,
                    LeaveVocationRequisitions = seminarian.LeaveVocationRequisitions.Select(l => new
                    {
                        l.ApplyDate,
                        l.EffectiveDate,
                        l.Id,
                        l.Status
                    }),
                    seminarian.Note,
                    seminarian.Phone,
                    seminarian.Position,
                    seminarian.Seminary,
                    seminarian.SeminaryAddress,
                    seminarian.ServedPlace,
                    DeaconRequisitionSessions = seminarian.VocationDeaconRequisitionSessions.GroupBy(l => l.DeaconRequisitionSession).Select(l => new
                    {
                        DeaconRequisitionComments = l.Where(c => c.DeaconRequisitionSessionId == l.Key.Id).SelectMany(c => c.DeaconRequisitionComments).Select(c => new
                        {
                            c.Comment,
                            c.CreatedAt,
                            c.Id,
                            ParishName = c.Parish.Name,
                            c.ParishId,
                            ParishionerName = c.Parishioner.Name + " " + c.Parishioner.Name,
                            c.ParishionerId,
                            PriestName = c.Priest.ChristianName + " " + c.Priest.Name,
                            c.VocationDeaconRequisitionId
                        }),
                        l.Key.CreatedAt,
                        l.Key.DeaconOrdinationMassParishId,
                        l.Key.DeaconOrdinationMassTime,
                        l.Key.DeadlineForParish,
                        l.Key.DeadlineForPriest,
                        l.Key.Id,
                        l.Key.SessionCode,
                        l.Key.SessionName,
                        l.Key.Status
                    }),
                    VocationSeminaryYears = seminarian.VocationSeminaryYears.Select(v => new
                    {
                        v.ActualEnd,
                        v.ActualStart,
                        v.Id,
                        SeminaryYear = new
                        {
                            v.SeminaryYear.EndAt,
                            v.SeminaryYear.Id,
                            v.SeminaryYear.SeminaryName,
                            v.SeminaryYear.SeminaryYearCode,
                            v.SeminaryYear.StartAt
                        },
                        v.SeminaryYearId,
                        v.Status
                    })
                }
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AddSeminarian(SeminarianPostModel model)
        {
            if (model.VocationSeminaryYears == null || model.VocationSeminaryYears.Count() == 0)
            {
                ModelState.AddModelError("VocationSeminaryYears", "Cần chọn ít nhất một niên khóa");
            }
            else if (model.VocationSeminaryYears.Any(v => v.ActualEnd.Year < v.ActualStart.Year))
            {
                ModelState.AddModelError("ActualStart", "Năm bắt đầu phải nhỏ hơn hoặc bằng năm kết thúc");
            }

            if (model.VocationSeminaryYears.GroupBy(v => v.SeminaryYearId).Any(g => g.Count() > 1))
            {
                ModelState.AddModelError("VocationSeminaryYears", "Một chủng sinh không thể có 2 niên khóa giống nhau");
            }

            if (!ModelState.IsValid)
            {
                return Json(new { Error = true, Errors = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage)) });
            }

            var dateConverter = new DateConverter();

            var vocation = new Vocation();
            var joinSeminaryDate = model.VocationSeminaryYears.OrderBy(o => o.ActualStart).FirstOrDefault();

            vocation.Date2 = dateConverter.ConvertDateToString(joinSeminaryDate.ActualStart.ToString("dd/MM/yyyy"));

            vocation.ParishionerId = model.Parishioner.Id;

            if (model.VocationSeminaryYears != null && model.VocationSeminaryYears.Count() != 0)
            {
                vocation.VocationSeminaryYears.AddRange(model.VocationSeminaryYears.Select(v => new VocationSeminaryYear
                {
                    ActualEnd = v.ActualEnd,
                    ActualStart = v.ActualStart,
                    SeminaryYearId = v.SeminaryYearId,
                    Status = v.Status
                }));
            }

            var result = _seminarianBusiness.Add(vocation);

            return Json(new
            {
                Error = result <= 0
            });
        }

        [HttpPost]
        public ActionResult UpdateSeminarian(SeminarianPostModel model)
        {
            if (model.VocationSeminaryYears == null || model.VocationSeminaryYears.Count() == 0)
            {
                ModelState.AddModelError("VocationSeminaryYears", "Cần chọn ít nhất một niên khóa");
            }
            else if (model.VocationSeminaryYears.Any(v => v.ActualEnd.Year < v.ActualStart.Year))
            {
                ModelState.AddModelError("ActualStart", "Năm bắt đầu phải nhỏ hơn hoặc bằng năm kết thúc");
            }

            if (model.VocationSeminaryYears.GroupBy(v => v.SeminaryYearId).Any(g => g.Count() > 1))
            {
                ModelState.AddModelError("VocationSeminaryYears", "Một chủng sinh không thể có 2 niên khóa giống nhau");
            }

            if (!ModelState.IsValid)
            {
                return Json(new { Error = true, Errors = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage)) });
            }

            var dateConverter = new DateConverter();

            var vocation = new Vocation();
            var joinSeminaryDate = model.VocationSeminaryYears.OrderBy(o => o.ActualStart).FirstOrDefault();

            vocation.Date2 = dateConverter.ConvertDateToString(joinSeminaryDate.ActualStart.ToString("dd/MM/yyyy"));

            vocation.ParishionerId = model.Parishioner.Id;

            if (model.VocationSeminaryYears != null && model.VocationSeminaryYears.Count() != 0)
            {
                vocation.VocationSeminaryYears.AddRange(model.VocationSeminaryYears.Select(v => new VocationSeminaryYear
                {
                    ActualEnd = v.ActualEnd,
                    ActualStart = v.ActualStart,
                    SeminaryYearId = v.SeminaryYearId,
                    Status = v.Status
                }));
            }

            var result = _seminarianBusiness.Update(vocation);

            return Json(new
            {
                Error = result <= 0
            });
        }

        [HttpPost]
        public ActionResult DeleteSeminarian(int id)
        {
            var result = _seminarianBusiness.Delete(id);
            return Json(new { Error = result <= 0 });
        }
    }
}