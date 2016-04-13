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
    public class DeaconRequisitionController : Controller
    {
        private readonly DeaconRequisitionSessionBusiness _deaconRequisitionSessionBusiness;

        public DeaconRequisitionController()
        {
            _deaconRequisitionSessionBusiness = new DeaconRequisitionSessionBusiness(DbConfig.GetConnectionString());
        }

        //
        // GET: /DeaconRequisition/
        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddDeaconRequisitionSession(DeaconRequisitionSessionPostModel model)
        {
            if (!ModelState.IsValid)
            {
                return Json(new { Error = true, Errors = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage)) });
            }

            DeaconRequisitionSession session = new DeaconRequisitionSession
            {
                Year = model.Year,
                CreatedAt = DateTime.Now,
                DeaconOrdinationMassParish = model.DeaconOrdinationMassParish,
                DeaconOrdinationMassTime = model.DeaconOrdinationMassTime,
                DeadlineForParish = model.DeadlineForParish,
                DeadlineForPriest = model.DeadlineForPriest,
                SessionCode = model.SessionCode,
                SessionName = model.SessionName,
                Status = (int)model.Status
            };

            session.VocationDeaconRequisitionSessions.AddRange(model.VocationDeaconRequisitionSessions.Select(v => new VocationDeaconRequisitionSession
                {
                    Status = (int)v.Status,
                    VocationId = v.SeminarianId
                }));

            var result = _deaconRequisitionSessionBusiness.Add(session);

            return Json(new { Error = result <= 0 });
        }

        [HttpPost]
        public ActionResult UpdateDeaconRequisitionSession(DeaconRequisitionSessionPostModel model)
        {
            if (!model.Id.HasValue || model.Id.Value <= 0)
            {
                ModelState.AddModelError("Id", "Đợt xin chức phó tế không tồn tại");
            }

            if (model.VocationDeaconRequisitionSessions.GroupBy(v => v.SeminarianId).Any(v => v.Count() > 1))
            {
                ModelState.AddModelError("VocationDeaconRequisitionSessions", "Chủng sinh trong danh sách xin chức phó tế bị trùng. Xin vui lòng kiểm tra lại");
            }

            if (!ModelState.IsValid)
            {
                return Json(new { Error = true, Errors = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage)) });
            }

            DeaconRequisitionSession session = new DeaconRequisitionSession
            {
                Id = model.Id.Value,                 
                Year = model.Year,
                CreatedAt = DateTime.Now,
                DeaconOrdinationMassParish = model.DeaconOrdinationMassParish,
                DeaconOrdinationMassTime = model.DeaconOrdinationMassTime,
                DeadlineForParish = model.DeadlineForParish,
                DeadlineForPriest = model.DeadlineForPriest,
                SessionCode = model.SessionCode,
                SessionName = model.SessionName,
                Status = (int)model.Status
            };

            session.VocationDeaconRequisitionSessions.AddRange(model.VocationDeaconRequisitionSessions.Select(v => new VocationDeaconRequisitionSession
            {
                Status = (int)v.Status,
                VocationId = v.SeminarianId
            }));

            var result = _deaconRequisitionSessionBusiness.Update(session);

            return Json(new { Error = result <= 0 });
        }

        [HttpPost]
        public ActionResult DeleteDeaconRequisitionSession(int id)
        {
            var result = _deaconRequisitionSessionBusiness.Delete(id);
            return Json(new { Error = result <= 0 });
        }

        public ActionResult LoadDeaconRequisitionSessionDatatable(jQueryDataTableParamModel param)
        {
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _deaconRequisitionSessionBusiness.GetOrderedDeaconRequisitionSessionsByParamsAndPaging(param.sSearch,
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

        public ActionResult LoadDeaconRequisitionSessionById(int id)
        {
            var session = _deaconRequisitionSessionBusiness.Get(id);

            var converter = new DateConverter();

            return Json(new
            {
                result = new
                {
                    session.CreatedAt,
                    session.DeaconOrdinationMassParish,
                    session.DeaconOrdinationMassTime,
                    session.DeadlineForParish,
                    session.DeadlineForPriest,
                    session.Id,
                    session.SessionCode,
                    session.SessionName,
                    Status = session.Status.ToString(),
                    session.Year,
                    VocationDeaconRequisitionSessions = session.VocationDeaconRequisitionSessions.Select(v => new
                    {
                        Vocation = new
                        {
                            Parishioner = new
                            {
                                v.Vocation.Parishioner.Address,
                                BirthDate = converter.ConvertStringToDateObjectNullable(v.Vocation.Parishioner.BirthDate),
                                v.Vocation.Parishioner.BirthPlace,
                                v.Vocation.Parishioner.Career,
                                v.Vocation.Parishioner.ChristianName,
                                v.Vocation.Parishioner.Code,
                                v.Vocation.Parishioner.CreatedBy,
                                v.Vocation.Parishioner.CreatedDate,
                                v.Vocation.Parishioner.DeadDate,
                                v.Vocation.Parishioner.DomicilePlace,
                                v.Vocation.Parishioner.DomicileStatus,
                                v.Vocation.Parishioner.Education,
                                v.Vocation.Parishioner.Email,
                                v.Vocation.Parishioner.FatherName,
                                v.Vocation.Parishioner.Gender,
                                v.Vocation.Parishioner.Id,
                                v.Vocation.Parishioner.ImageUrl,
                                v.Vocation.Parishioner.IsCatechumen,
                                v.Vocation.Parishioner.IsCounted,
                                v.Vocation.Parishioner.IsDead,
                                v.Vocation.Parishioner.IsMarried,
                                v.Vocation.Parishioner.IsSingle,
                                v.Vocation.Parishioner.IsStudying,
                                v.Vocation.Parishioner.LastUpdatedBy,
                                v.Vocation.Parishioner.MobilePhone,
                                v.Vocation.Parishioner.MotherName,
                                v.Vocation.Parishioner.Name,
                                v.Vocation.Parishioner.Note,
                                v.Vocation.Parishioner.Phone,
                                Status = v.Vocation.Parishioner.Status.ToString()
                            }
                        },
                        Status = v.Status.ToString(),
                        Id = v.Id
                    })
                }
            }, JsonRequestBehavior.AllowGet);
        }
    }
}