using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Security.Cryptography;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class DoctrineCourseBusiness
    {
        private readonly DoctrineCourseData _doctrineCourseData ;

        public DoctrineCourseBusiness(string connection)
        {
            _doctrineCourseData = new DoctrineCourseData(connection);
        }

        //load bảng danh sách khối giáo lý
        public IEnumerable<IConvertible[]> getOrderedClassGroupByParamsAndPaging(int parishId, int year, string searchValue,int sortColumnIndex,
                                                                                string sortDirection, int displayStart, int displayLength,
                                                                                out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<ClassGroup> classGroups;
            if (year <= 0)
            {
                classGroups = _doctrineCourseData.GetClassGroupsByParishId(parishId);
            }
            else
            {
                classGroups = _doctrineCourseData.GetClassGroupsByYear(parishId, year);
            }
            IEnumerable<ClassGroup> filterListItems;

            //Search
            if(!string.IsNullOrEmpty((searchValue)))
            {
                filterListItems = classGroups.Where(cg => (cg.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filterListItems = classGroups;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.Id)
                    : filterListItems.OrderByDescending(s => s.Id);
            }
            if (sortColumnIndex == 3)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.Name)
                    : filterListItems.OrderByDescending(s => s.Name);
            }
            if (sortColumnIndex == 4)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.Parishioner.Name)
                    : filterListItems.OrderByDescending(s => s.Parishioner.Name);
            }
            else
            {
            }
            //Paging
            var list = filterListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);

            var converter = new DateConverter();
            var result = from c in displayedList
                select new IConvertible[]
                {
                    c.Id,
                    c.Id,
                    c.Year,
                    c.Name,
                    c.ManagedBy != null ? (c.Parishioner.ChristianName + " " + c.Parishioner.Name) : "",
                    c.Note,
                    c.Id
                };
            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }


        //Thêm xóa sửa khối lớp giáo lý
        public int AddClassGroup(ClassGroup classGroup)
        {
            return _doctrineCourseData.AddClassGroup(classGroup);
        }

        public ClassGroup GetClassGroupById(int id)
        {
            return _doctrineCourseData.GetClassGroupById(id);
        }
        public int UpdateClassGroup(ClassGroup classGroup)
        {
            return _doctrineCourseData.UpdateClassGroup(classGroup);
        }

        public int DeleteClassGroup(int id)
        {
            return _doctrineCourseData.DeleteClassGroup(id);
        }
        public string GetTeacherNameByClassId(int id)
        {
            var teachers = _doctrineCourseData.GetTeachersByClassId(id).ToList();
            string names = "";
            foreach (var item in teachers)
            {
                if (item == teachers.Last())
                {
                    names += item.Parishioner.Name;
                }
                else
                {
                    names += item.Parishioner.Name + ", ";
                }
            }

            return names;
        }

        //Validate Khối giáo lý
        public int CheckUniqueName(string name, int classGroupId, int parishId)
        {
            return _doctrineCourseData.CheckUniqueName(name, classGroupId, parishId);
        }


       
        //------------------------------------------------------------
        //Quản lí lớp giáo lí

        //Load Khối giáo lí ra DropDownList
        public List<ClassGroup> GetClassGroupsByYear(int parishId, int year)
        {
                return _doctrineCourseData.GetClassGroupsByYear(parishId, year).OrderBy(c => c.Name).ToList();
        }

        //Load Khối giáo lý ra DropDownModal
        public List<ClassGroup> GetClassGroupsByParishId(int parishId)
        {
            return _doctrineCourseData.GetClassGroupsByParishId(parishId).OrderBy(c => c.Name).ToList();
        }

        //-----------------------------------------------------------

        //load bảng danh sách lớp giáo lý
        public IEnumerable<IConvertible[]> getOrderedClassesByParamsAndPaging(int parishId, int year, int classGroupId, string searchValue, int sortColumnIndex,
                                                                                string sortDirection, int displayStart, int displayLength,
                                                                                out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Class> classes ;
            if (year <= 0 && classGroupId <= 0)
            {
                classes = _doctrineCourseData.GetClassesByParishId(parishId);
            }
            else
            {
                if (year <= 0 && classGroupId > 0)
                {
                    classes = _doctrineCourseData.GetClassesByClassGroupId(parishId, classGroupId);
                }
                else
                {
                    if (year > 0 && classGroupId <= 0)
                    {
                        classes = _doctrineCourseData.GetClassesByYear(parishId, year);
                    }
                    else
                    {
                        classes = _doctrineCourseData.GetClassesByClassGroupIdAndYear(parishId, year, classGroupId);
                    }
                }
            }
            IEnumerable<Class> filterListItems;

            //Search
            if (!string.IsNullOrEmpty((searchValue)))
            {
                filterListItems = classes.Where(cg => (cg.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filterListItems = classes;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.Year)
                    : filterListItems.OrderByDescending(s => s.Year);
            }
            if (sortColumnIndex == 3)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.ClassGroup.Name)
                    : filterListItems.OrderByDescending(s => s.ClassGroup.Name);
            }
            if (sortColumnIndex == 4)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.Name)
                    : filterListItems.OrderByDescending(s => s.Name);
            }
            if (sortColumnIndex == 5)
            {
                filterListItems = sortDirection == "asc"
                    ? filterListItems.OrderBy(s => s.RoomNo)
                    : filterListItems.OrderByDescending(s => s.RoomNo);
            }
            else
            {
            }
            //Paging
            var list = filterListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);

            var converter = new DateConverter();
            var result = from c in displayedList
                         select new IConvertible[]
                {
                    c.Id,
                    c.Id,
                    c.Year,
                    c.ClassGroup.Name,
                    c.Name,
                    c.RoomNo,
                    GetTeacherNameByClassId(c.Id),
                    c.Note,
                    c.Id
                };
            totalRecords = records;
            totalDisplayRecords = records;
            return result;
        }


        //Thêm xóa sửa lớp giáo lý
        public int AddClass(Class class1)
        {
            return _doctrineCourseData.AddClass(class1);
        }

        public Class GetClassById(int id)
        {
            return _doctrineCourseData.GetClassById(id);
        }
        public int UpdateClass(Class class1)
        {
            return _doctrineCourseData.UpdateClass(class1);
        }

        public int DeleteClass(int id)
        {
            return _doctrineCourseData.DeleteClass(id);
        }

        //Validate Lớp giáo lý
        public int CheckUniqueClassName(string name, int classId, int parishId)
        {
            return _doctrineCourseData.CheckUniqueClassName(name, classId, parishId);
        }

        //Load bảng danh sách giáo lý viên Modal
        public List<ClassMember> GetClassTeacherByClassId(int classId)
        {
            return _doctrineCourseData.GetClassTeacherByClassId(classId).OrderBy(p => p.Parishioner.Name).ToList();
        }
        //public IEnumerable<IConvertible[]> getOrderedClassTeacherByParamsAndPaging(int ClassId, string searchValue, int sortColumnIndex,
        //                                                                        string sortDirection, int displayStart, int displayLength,
        //                                                                        out int totalRecords, out int totalDisplayRecords)
        //{
        //    //Load Data
        //    IEnumerable<ClassMember> classMembers;
        //    classMembers = _doctrineCourseData.GetClassTeacherByClassId(ClassId);
        //    IEnumerable<ClassMember> filterListItems;

        //    //Search
        //    if (!string.IsNullOrEmpty(searchValue))
        //    {
        //        filterListItems = classMembers.Where(s => (s.Parishioner.Name.Trim().ToLower().Contains(searchValue)));
        //    }
        //    else
        //    {
        //        filterListItems = classMembers;
        //    }

        //    //Sort
        //    if (sortColumnIndex == 2)
        //    {
        //        filterListItems = sortDirection == "asc"
        //            ? filterListItems.OrderBy(p => p.Parishioner.ChristianName)
        //            : filterListItems.OrderByDescending(p => p.Parishioner.ChristianName);
        //    }
        //    if (sortColumnIndex == 3)
        //    {
        //        filterListItems = sortDirection == "asc"
        //            ? filterListItems.OrderBy(p => p.Parishioner.Name)
        //            : filterListItems.OrderByDescending(p => p.Parishioner.Name);
        //    }
        //    else
        //    {
        //    }

        //    //Paging
        //    var list = filterListItems.ToList();
        //    int records = list.Count;
        //    var displayedList = list.Skip(displayStart).Take(displayLength);

        //    var conveter = new DateConverter();
        //    var result = from c in displayedList
        //                 select new IConvertible[]
        //        {
        //            c.Id,
        //            c.Id,
        //            c.Parishioner.ChristianName,
        //            c.Parishioner.Name,
        //            c.Id
        //        };

        //    totalRecords = records;
        //    totalDisplayRecords = records;

        //    return result;
        //}

        //Load bảng học viên Modal
        public List<ClassMember> GetClassMemberByClassId(int classId)
        {
            return _doctrineCourseData.GetClassLearnerByClassId(classId).OrderBy(p => p.Parishioner.Name).ToList();
        }

        public List<ClassMember> GetClassMemberToChangeClassByClassId(int classId, int learnerType)
        {
            List<ClassMember> learnerList;
            if (learnerType == 0)
            {
                learnerList = _doctrineCourseData.GetAllLearnerToChangeClassByClassId(classId).OrderBy(p => p.Parishioner.Name).ToList();
            }
            else
            {
                if (learnerType == 1)
                {
                    learnerList = _doctrineCourseData.GetCompleteLearnerToChangeClassByClassId(classId).OrderBy(p => p.Parishioner.Name).ToList();
                }
                else
                {
                    learnerList = _doctrineCourseData.GetIncompleteLearnerToChangeClassByClassId(classId).OrderBy(p => p.Parishioner.Name).ToList();
                }
            }
            return learnerList;
        }
        
        public int AddClassMember(ClassMember classMember)
        {
            return _doctrineCourseData.AddClassMember(classMember);
        }
        public int EditClassMemberNote(ClassMember classMember)
        {
            return _doctrineCourseData.EditClassMemberNote(classMember);
        }
        public int DeleteClassMember(int id)
        {
            return _doctrineCourseData.DeleteClassMember(id);
        }
        //Validate ClassMember
        public int CheckUniqueClassMember(int classId, int parishionerId)
        {
            return _doctrineCourseData.CheckUniqueClassMember(classId, parishionerId);
        }
        //-----------------------------------------------------------------------------
        //Check hoàn thành khóa học
        public int CompleteCourseApprove(string[] learnerId)
        {
            return _doctrineCourseData.CompleteCourseApprove(learnerId);
        }
        public int IncompleteCourseApprove(string[] learnerId)
        {
            return _doctrineCourseData.IncompleteCourseApprove(learnerId);
        }
        //-------------------------------------------------------------------------------
        
        //Chuyển lớp cho học viên
        public List<Class> GetClassesToChangeClass(int parishId, int year, int classGroupId)
        {
            List<Class> classes;
            if (year <= 0 && classGroupId <= 0)
            {
                classes = _doctrineCourseData.GetClassesByParishId(parishId).OrderByDescending(p => p.Year).ToList();
            }
            else
            {
                if (year <= 0 && classGroupId > 0)
                {
                    classes = _doctrineCourseData.GetClassesByClassGroupId(parishId, classGroupId).OrderByDescending(p => p.Year).ToList();
                }
                else
                {
                    if (year > 0 && classGroupId <= 0)
                    {
                        classes = _doctrineCourseData.GetClassesByYear(parishId, year).OrderByDescending(p => p.Year).ToList();
                    }
                    else
                    {
                        classes = _doctrineCourseData.GetClassesByClassGroupIdAndYear(parishId, year, classGroupId).OrderByDescending(p =>p.Year).ToList();
                    }
                }
            }

            return classes;
        }

        public int ChangeLearnerClass(string[] learnerId, int classId)
        {
            return _doctrineCourseData.ChangeLearnerClass(learnerId, classId);
        }
        //Phần tìm kiếm-----------------------------------------
        //Load bảng danh sách các lớp mà học viên đã tham gia
        public List<Class> GetClassesByParishIonerId(int parishionerId)
        {
            return _doctrineCourseData.GetClassesByParishionerId(parishionerId).OrderBy(p => p.Year).ToList();
        }

    }
}
