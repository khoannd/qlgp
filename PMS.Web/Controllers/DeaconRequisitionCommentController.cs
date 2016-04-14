using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.Web.Filters;
using PMS.Web.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Controllers
{
    public class DeaconRequisitionCommentController : Controller
    {
        private readonly DeaconRequisitionSessionBusiness _deaconRequisitionSessionBusiness;
        private readonly DeaconRequisitionCommentBusiness _deaconRequisitionCommentBusiness;

        public DeaconRequisitionCommentController()
        {
            _deaconRequisitionCommentBusiness = new DeaconRequisitionCommentBusiness(DbConfig.GetConnectionString());
            _deaconRequisitionSessionBusiness = new DeaconRequisitionSessionBusiness(DbConfig.GetConnectionString());
        }

        // GET: /DeaconRequisitionComment/Index/Id
        /// <summary>
        /// View comment for a deacon requisition session
        /// </summary>
        /// <param name="id">Id of Deacon Requisition Session</param>
        /// <returns></returns>
        [SessionExpireFilter]
        public ActionResult Index(int id)
        {
            var deaconSession = _deaconRequisitionSessionBusiness.Get(id);
            if (deaconSession == null)
            {
                return RedirectToAction("NotFound", "Home");
            }
            return View(deaconSession);
        }

        /// <summary>
        /// Get list comments of a Vocation Deacon Requisition
        /// </summary>
        /// <param name="id">Id of Vocation Deacon Requisition</param>
        /// <returns></returns>
        public ActionResult GetCommentsOfVocationDeaconRequisition(int id)
        {
            var comments = _deaconRequisitionCommentBusiness.GetCommentsOfVocationDeaconRequisition(id);
            var dateConverter = new DateConverter();
            return Json(comments.Select(c => new
            {
                c.Comment,
                c.CreatedAt,
                c.Id,
                Parish = c.Parish == null ? null : new
                {
                    c.Parish.Name,
                    c.Parish.Email,
                    c.Parish.Phone,
                    c.Parish.Website,
                    c.Parish.Address,
                    c.Parish.Ward,
                    c.Parish.District,
                    c.Parish.Province,
                    c.Parish.Id
                },
                Parishioner = c.Parishioner == null ? null : new
                {
                    c.Parishioner.Id,
                    c.Parishioner.Name,
                    c.Parishioner.ChristianName,
                    c.Parishioner.Phone,
                    c.Parishioner.MobilePhone,
                    BirthDate = dateConverter.ConvertStringToDateObjectNullable(c.Parishioner.BirthDate),
                    c.Parishioner.Address
                },
                Priest = c.Priest == null ? null : new
                {
                    c.Priest.ChristianName,
                    c.Priest.Name,
                    c.Priest.Phone,
                    c.Priest.Id,
                    BirthDate = dateConverter.ConvertStringToDateObjectNullable(c.Priest.BirthDate)
                }
            }), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SaveComment(AddDeaconRequisitionCommentModel model)
        {
            var count = 0;
            count = model.ParishId.HasValue && model.ParishId.Value > 0 ? count + 1 : count;
            count = model.ParishionerId.HasValue && model.ParishionerId.Value > 0 ? count + 1 : count;
            count = model.PriestId.HasValue && model.PriestId.Value > 0 ? count + 1 : count;

            if (count > 1)
            {
                ModelState.AddModelError("Invalid", "Không thể thêm 1 nhận xét từ nhiều loại");
            }
            else if (count == 0)
            {
                ModelState.AddModelError("Invalid", "Vui lòng chọn loại nhận xét");
            }

            if (!ModelState.IsValid)
            {
                return Json(new { Error = true, Errors = ModelState.Values.SelectMany(m => m.Errors.Select(e => e.ErrorMessage)) });
            }


            var comment = new DeaconRequisitionComment
            {
                Id = model.Id.HasValue ? model.Id.Value : 0,
                Comment = model.Comment,
                CreatedAt = model.CreatedAt,
                ParishId = model.ParishId,
                ParishionerId = model.ParishionerId,
                PriestId = model.PriestId,
                VocationDeaconRequisitionId = model.VocationDeaconRequisitionId
            };

            int result = 0;

            if (comment.Id > 0)
            {
                result = _deaconRequisitionCommentBusiness.UpdateComment(comment);
            }
            else
            {
                result = _deaconRequisitionCommentBusiness.AddComment(comment);
            }

            return Json(new { Error = result <= 0 });
        }

        /// <summary>
        /// Delete a comment
        /// </summary>
        /// <param name="id">Deacon Requisition Comment Id</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DeleteComment(int id)
        {
            var result = _deaconRequisitionCommentBusiness.DeleteComment(id);
            return Json(new { Error = result <= 0 });
        }
    }
}