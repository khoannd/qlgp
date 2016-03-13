using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Ajax.Utilities;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;
using System.Transactions;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class DoctrineCourseController : Controller
    {
        private readonly DoctrineCourseBusiness _doctrineCourseBusiness;

        public DoctrineCourseController()
        {
            _doctrineCourseBusiness = new DoctrineCourseBusiness(DbConfig.GetConnectionString());
        }
        //
        // GET: /DoctrineCourse/
        // Quản lí khối giáo lí
        [SessionExpireFilter]
        public ActionResult Index()
        {
            return View();
        }

        //Load bảng danh sách khối giáo lí
        public ActionResult LoadClassGroupDataTables(jQueryDataTableParamModel param, int year)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _doctrineCourseBusiness.getOrderedClassGroupByParamsAndPaging(parishId, year, param.sSearch,
                                                                                       param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                                                                                       param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        //Thêm xóa sửa khối lớp giáo lí
        public ActionResult AddClassGroup(ClassGroup classGroup)
        {
            int parishId = (int)Session["ParishId"];
            classGroup.ParishId = parishId;
            int result = _doctrineCourseBusiness.AddClassGroup(classGroup);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult LoadClassGroupById(int id)
        {
            ClassGroup classGroup = _doctrineCourseBusiness.GetClassGroupById(id);

            ClassGroupViewModel model = new ClassGroupViewModel();

            model.Id = classGroup.Id;
            model.ParishId = classGroup.ParishId;
            model.Name = classGroup.Name;
            model.Year = classGroup.Year;
            model.Note = classGroup.Note;
            if (classGroup.ManagedBy != null)
            {
                model.ManagerName = classGroup.Parishioner.Name;
            }
            else model.ManagerName = " ";
            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult UpdateClassGroup(ClassGroup classGroup)
        {
            int parishId = (int)Session["ParishId"];
            classGroup.ParishId = parishId;
            int result = _doctrineCourseBusiness.UpdateClassGroup(classGroup);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteClassGroup(int id)
        {
            int result = _doctrineCourseBusiness.DeleteClassGroup(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        //Validate khối giáo lí
        public ActionResult CheckUniqueName(string name, int classGroupId)
        {
            int parishId = (int)Session["ParishId"];
            int result = _doctrineCourseBusiness.CheckUniqueName(name, classGroupId, parishId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //----------------------------------------------------------------------------------

        //Quản lí lớp giáo lí
        [SessionExpireFilter]
        public ActionResult ManageClass()
        {
            return View();
        }

        //Load bảng danh sách lớp giáo lí
        public ActionResult LoadClassesDataTables(jQueryDataTableParamModel param, int year, int classGroupId)
        {
            int parishId = (int)Session["ParishId"];
            int totalRecords = 0;
            int totalDisplayRecords = 0;
            var result = _doctrineCourseBusiness.getOrderedClassesByParamsAndPaging(parishId, year, classGroupId, param.sSearch,
                                                                                       param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
                                                                                       param.iDisplayLength, out totalRecords, out totalDisplayRecords);
            return Json(new
            {
                sEcho = param.sEcho,
                iTotalRecords = totalRecords,
                iTotalDisplayRecords = totalDisplayRecords,
                aaData = result
            }, JsonRequestBehavior.AllowGet);
        }

        //Load Khối giáo lí ra dropDown
        public ActionResult GetClassGroupByYear(int year)
        {
            int parishId = (int)Session["ParishId"];
            List<ClassGroup> classGroup;
            if (year == 0)
            {
                classGroup = _doctrineCourseBusiness.GetClassGroupsByParishId(parishId);
            }
            else
            {
                if (year < 0)
                {
                    classGroup = _doctrineCourseBusiness.GetClassGroupsByParishId(0);
                    //foreach (var item in classGroup)
                    //{
                    //    item.Name = " ";
                    //}
                }
                else
                {
                    classGroup = _doctrineCourseBusiness.GetClassGroupsByYear(parishId, year);
                }
            }
            foreach (var item in classGroup)
            {
                item.Classes = null;
                item.Parishioner = null;
                item.Parish = null;
            }
            return Json(new { result = classGroup }, JsonRequestBehavior.AllowGet);
        }

        //Thêm xóa sửa lớp giáo lí
        public int AddClass(Class class1, int parishionerId, string memberNote, int position)
        {
            int classId = class1.Id;

            using (var scope = new TransactionScope())
            {
                if (classId == 0)
                {
                    classId = _doctrineCourseBusiness.AddClass(class1);
                }

                if (parishionerId > 0 && classId > 0)
                {
                    var classMember = new ClassMember()
                    {
                        ParishionerId = parishionerId,
                        Position = position,
                        IsDone = false,
                        Note = memberNote,
                        ClassId = classId
                    };
                    int newClassMemberId = _doctrineCourseBusiness.AddClassMember(classMember);
                    if (newClassMemberId < 0)
                    {
                        return newClassMemberId;
                    }
                }
                else
                {
                    //return -1;
                }
                //If success all
                scope.Complete();
                return classId;
            }
        }
        public int UpdateClass(Class class1)
        {
            return _doctrineCourseBusiness.UpdateClass(class1);
        }
        //Load lớp giáo lý ra modal
        public ActionResult LoadClassById(int id)
        {
            Class class1 = _doctrineCourseBusiness.GetClassById(id);

            ClassViewModel model = new ClassViewModel();
            model.Id = class1.Id;
            model.Name = class1.Name;
            model.RoomNo = class1.RoomNo;
            model.Year = class1.Year;
            model.Note = class1.Note;
            model.ClassGroupId = class1.ClassGroup.Id;
            model.ClassGroupName = class1.ClassGroup.Name;
            return Json(new { result = model }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteClass(int id)
        {
            var result = _doctrineCourseBusiness.DeleteClass(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        //Validate lớp giáo lí
        public ActionResult CheckUniqueClassName(string name, int classId)
        {
            int parishId = (int)Session["ParishId"];
            int result = _doctrineCourseBusiness.CheckUniqueClassName(name, classId, parishId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }


        //Load bảng danh sách giáo lí viên
        public ActionResult LoadClassTeacherByClassId(int classId)
        {
            List<ClassMember> result = _doctrineCourseBusiness.GetClassTeacherByClassId(classId);
            return PartialView("_TeacherTable", result);
        }
        //public ActionResult LoadClassMemberDataTables(jQueryDataTableParamModel param, int classId)
        //{
        //    int totalRecords = 0;
        //    int totalDisplayRecords = 0;
        //    if (classId <= 0)
        //    {
        //        List<IConvertible[]> noData = new List<IConvertible[]>();

        //        return Json(new
        //        {
        //            sEcho = param.sEcho,
        //            iTotalRecords = totalRecords,
        //            iTotalDisplayRecords = totalDisplayRecords,
        //            aaData = noData
        //        }, JsonRequestBehavior.AllowGet);
        //    }

        //    var result = _doctrineCourseBusiness.getOrderedClassTeacherByParamsAndPaging(classId, param.sSearch,
        //        param.iSortCol_0, param.sSortDir_0, param.iDisplayStart,
        //        param.iDisplayLength, out totalRecords, out totalDisplayRecords);
        //    return Json(new
        //    {
        //        sEcho = param.sEcho,
        //        iTotalRecords = totalRecords,
        //        iTotalDisplayRecords = totalDisplayRecords,
        //        aaData = result
        //    }, JsonRequestBehavior.AllowGet);
        //}

        //Load bảng danh sách học viên
        public ActionResult LoadClassMemberByClassId(int classId)
        {
            List<ClassMember> result = _doctrineCourseBusiness.GetClassMemberByClassId(classId);
            return PartialView("_LearnerTable", result);
        }
        

        public ActionResult EditableClassMemberNote(ClassMember classMember)
        {
            int result = _doctrineCourseBusiness.EditClassMemberNote(classMember);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DeleteClassMember(int id)
        {
            var result = _doctrineCourseBusiness.DeleteClassMember(id);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //Validate ClassMember
        public ActionResult CheckUniqueClassMember(int classId, int parishionerId)
        {
            var result = _doctrineCourseBusiness.CheckUniqueClassMember(classId, parishionerId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //----------------------------------------------------------------------
        //Check hoàn thành khóa học
        public ActionResult CompleteCourseApprove(string[] learnerId)
        {
            var result = _doctrineCourseBusiness.CompleteCourseApprove(learnerId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult IncompleteCourseApprove(string[] learnerId)
        {
            var result = _doctrineCourseBusiness.IncompleteCourseApprove(learnerId);
            return Json(new { result = result }, JsonRequestBehavior.AllowGet);
        }
        //-------------------------------------------------------------------------
        //Chuyển lớp cho học viên

        //Load lớp giáo lí ra dropDownlist để chuyển lớp
        public ActionResult GetClassToChangeClass(int year, int classGroupId)
        {
            int parishId = (int)Session["ParishId"];
            List<Class> classes;
            classes = _doctrineCourseBusiness.GetClassesToChangeClass(parishId, year, classGroupId);
            foreach (var item in classes)
            {
                item.ClassGroup = null;
                item.ClassMembers = null;
            }
            return Json(new { result = classes}, JsonRequestBehavior.AllowGet);
        }

        //Load bảng danh sách học viên để chuyển lớp
        public ActionResult LoadClassMemberToChangeClass(int classId, int learnerType)
        {
            List<ClassMember> result = _doctrineCourseBusiness.GetClassMemberToChangeClassByClassId(classId, learnerType);
            return PartialView("_ChangeClassLearnerTable", result);
        }

        public ActionResult ChangeLearnerClass(string[] learnerId, int classId)
        {
            var result = _doctrineCourseBusiness.ChangeLearnerClass(learnerId, classId);
            return Json(new {result = result}, JsonRequestBehavior.AllowGet);
        }

        //Phần tìm kiếm--------------------------------------------------------------
        //Load bảng danh sách các lớp mà giáo dân đã tham gia
        public ActionResult LoadClassesByParishionerId(int parishionerId)
        {
            List<Class> result = _doctrineCourseBusiness.GetClassesByParishIonerId(parishionerId);
            ViewBag.parishionerId = parishionerId;
            return PartialView("_ViewParishionerClassesTable", result);
        }
    }
}