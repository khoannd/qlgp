using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.Enumerations;

namespace PMS.DataAccess
{
    public class DoctrineCourseData
    {
        public readonly PMSDataContext _db;

        public DoctrineCourseData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        //Load bảng danh sách khối giáo lý 
        public IEnumerable<ClassGroup> GetClassGroupsByYear(int parishId, int year)
        {
            const string query = "SELECT cg.* " +
                                 "FROM ClassGroup AS cg LEFT JOIN Parishioner AS pa ON cg.ManagedBy = pa.Id " +
                                 "WHERE cg.ParishId = {0} AND cg.Year = {1} ";
            return _db.ExecuteQuery<ClassGroup>(query, parishId, year);
        }
        public IEnumerable<ClassGroup> GetClassGroupsByParishId(int parishId)
        {
            const string query = "SELECT * FROM ClassGroup WHERE ParishId = {0} ";
            return _db.ExecuteQuery<ClassGroup>(query, parishId);
        }


        //Thêm xóa sửa khối giáo lý
        public int AddClassGroup(ClassGroup classGroup)
        {
            try
            {
                _db.ClassGroups.InsertOnSubmit(classGroup);
                _db.SubmitChanges();
                return classGroup.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        //load Data Modal
        public ClassGroup GetClassGroupById(int id)
        {
            const string query = "SELECT * FROM ClassGroup WHERE Id = {0}";
            return _db.ExecuteQuery<ClassGroup>(query, id).SingleOrDefault();
        }
        public int UpdateClassGroup(ClassGroup classGroup)
        {
            try
            {
                var item = _db.ClassGroups.SingleOrDefault(d => d.Id == classGroup.Id);
                if (item == null)
                {
                    return 0;
                }

                item.Year = classGroup.Year;
                item.Name = classGroup.Name;
                item.Note = classGroup.Note;
                item.ManagedBy = classGroup.ManagedBy;
                item.ParishId = classGroup.ParishId;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteClassGroup(int id)
        {
            try
            {
                ClassGroup classGroup = _db.ClassGroups.SingleOrDefault(p => p.Id == id);
                if (classGroup == null)
                {
                    return 0;
                }
                else
                {
                    _db.ClassGroups.DeleteOnSubmit(classGroup);
                    _db.SubmitChanges();
                    return 1;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Validate Khối giáo lí
        public int CheckUniqueName(string name, int classGroupId, int parishId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT Name " +
                                     "FROM ClassGroup " +
                                     "WHERE LOWER(RTRIM(LTRIM((Name)))) = {0} AND Id != {1} AND ParishId = {2} ";
                string unique = _db.ExecuteQuery<string>(query, name, classGroupId, parishId).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        //----------------------------------------------------------------------------------------
        //Quản lí lớp giáo lí

        //Load bảng danh sách lớp giáo lý
        public IEnumerable<Class> GetClassesByParishId(int parishId)
        {
            const string query = "SELECT c.* " +
                                 "FROM Class AS c INNER JOIN ClassGroup AS cg ON c.ClassGroupId = cg.Id " +
                                 "WHERE cg.ParishId = {0} ";
            return _db.ExecuteQuery<Class>(query, parishId);
        }
        public IEnumerable<Class> GetClassesByYear(int parishId, int year)
        {
            const string query = "SELECT c.* " +
                                 "FROM Class AS c INNER JOIN ClassGroup AS cg ON c.ClassGroupId = cg.Id " +
                                 "WHERE cg.ParishId = {0} AND c.Year = {1} ";
            return _db.ExecuteQuery<Class>(query, parishId, year);
        }
        public IEnumerable<Class> GetClassesByClassGroupIdAndYear(int parishId, int year, int classGroupId)
        {
            const string query = "SELECT c.* " +
                                 "FROM Class AS c INNER JOIN ClassGroup AS cg ON c.ClassGroupId = cg.Id " +
                                 "WHERE cg.ParishId = {0} AND c.Year = {1} AND c.ClassGroupId = {2} ";
            return _db.ExecuteQuery<Class>(query, parishId, year, classGroupId);
        }
        public IEnumerable<Class> GetClassesByClassGroupId(int parishId, int classGroupId)
        {
            const string query = "SELECT c.* " +
                                 "FROM Class AS c INNER JOIN ClassGroup AS cg ON c.ClassGroupId = cg.Id " +
                                 "WHERE cg.ParishId = {0} AND c.ClassGroupId = {1} ";
            return _db.ExecuteQuery<Class>(query, parishId, classGroupId);
        }
        //------------------------------------------------------------------------------------------------
        //Lấy tên giáo viên 
        public IEnumerable<ClassMember> GetTeachersByClassId(int classId)
        {
            const string query = "SELECT * FROM ClassMember WHERE Position = {0} AND ClassId = {1} ";
            return _db.ExecuteQuery<ClassMember>(query, (int)ClassMemberPositionEnum.Teacher, classId);
        }


        //-----------------------------------------------------------------

        //Thêm xóa sửa lớp giáo lý
        public int AddClass(Class class1)
        {
            try
            {
                _db.Classes.InsertOnSubmit(class1);
                _db.SubmitChanges();
                return class1.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        //load Data Modal
        public Class GetClassById(int id)
        {
            const string query = "SELECT * FROM Class WHERE Id = {0}";
            return _db.ExecuteQuery<Class>(query, id).SingleOrDefault();
        }
        public int UpdateClass(Class class1)
        {
            try
            {
                var item = _db.Classes.SingleOrDefault(d => d.Id == class1.Id);
                if (item == null)
                {
                    return 0;
                }

                item.Name = class1.Name;
                item.RoomNo = class1.RoomNo;
                item.Year = class1.Year;
                item.Note = class1.Note;
                item.ClassGroupId = class1.ClassGroupId;


                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteClass(int id)
        {
            try
            {
                Class class1 = _db.Classes.SingleOrDefault(p => p.Id == id);
                if (class1 == null)
                {
                    return 0;
                }
                else
                {
                    _db.Classes.DeleteOnSubmit(class1);
                    _db.SubmitChanges();
                    return 1;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Validate lớp giáo lí
        public int CheckUniqueClassName(string name, int classId, int parishId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT c.Name " +
                                     "FROM Class AS c INNER JOIN ClassGroup AS cg ON c.ClassGroupId = cg.Id " +
                                     "WHERE LOWER(RTRIM(LTRIM((c.Name)))) = {0} AND c.Id != {1} AND cg.ParishId = {2} ";
                string unique = _db.ExecuteQuery<string>(query, name, classId, parishId).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {

                return -1;
            }
        }



        //Load bảng danh sách giáo lý viên
        public IEnumerable<ClassMember> GetClassTeacherByClassId(int ClassId)
        {
            const string query = "SELECT cm.* " +
                                 "FROM (ClassMember AS cm INNER JOIN Class AS c ON cm.ClassId = c.Id) " +
                                 "INNER JOIN Parishioner AS pa ON cm.ParishionerId = pa.Id " +
                                 "WHERE c.Id = {0} AND cm.Position = {1} AND pa.Status != -1 ";
            return _db.ExecuteQuery<ClassMember>(query, ClassId, (int)ClassMemberPositionEnum.Teacher);
        }
        //Load bảng danh sách học viên
        public IEnumerable<ClassMember> GetClassLearnerByClassId(int classId)
        {
            const string query = "SELECT cm.* " +
                                 "FROM (ClassMember AS cm INNER JOIN Class AS c ON cm.ClassId = c.Id) " +
                                 "INNER JOIN Parishioner AS pa ON cm.ParishionerId = pa.Id " +
                                 "WHERE c.Id = {0} AND cm.Position = {1} AND pa.Status != -1 ";
            return _db.ExecuteQuery<ClassMember>(query, classId, (int)ClassMemberPositionEnum.Learner);
        }
        //Load học viên để chuyển lớp
        public IEnumerable<ClassMember> GetAllLearnerToChangeClassByClassId(int classId)
        {
            const string query = "SELECT cm.* " +
                                 "FROM (ClassMember AS cm INNER JOIN Class AS c ON cm.ClassId = c.Id) " +
                                 "INNER JOIN Parishioner AS pa ON cm.ParishionerId = pa.Id " +
                                 "WHERE c.Id = {0} AND cm.Position = {1} AND pa.Status != -1 " ;
            return _db.ExecuteQuery<ClassMember>(query, classId, (int)ClassMemberPositionEnum.Learner);
        }
        public IEnumerable<ClassMember> GetCompleteLearnerToChangeClassByClassId(int classId)
        {
            const string query = "SELECT cm.* " +
                                 "FROM (ClassMember AS cm INNER JOIN Class AS c ON cm.ClassId = c.Id) " +
                                 "INNER JOIN Parishioner AS pa ON cm.ParishionerId = pa.Id " +
                                 "WHERE c.Id = {0} AND cm.Position = {1} AND pa.Status != -1 AND cm.IsDone = 'true'";
            return _db.ExecuteQuery<ClassMember>(query, classId, (int)ClassMemberPositionEnum.Learner);
        }
        public IEnumerable<ClassMember> GetIncompleteLearnerToChangeClassByClassId(int classId)
        {
            const string query = "SELECT cm.* " +
                                 "FROM (ClassMember AS cm INNER JOIN Class AS c ON cm.ClassId = c.Id) " +
                                 "INNER JOIN Parishioner AS pa ON cm.ParishionerId = pa.Id " +
                                 "WHERE c.Id = {0} AND cm.Position = {1} AND pa.Status != -1 AND cm.IsDone = 'false'";
            return _db.ExecuteQuery<ClassMember>(query, classId, (int)ClassMemberPositionEnum.Learner);
        }
        //--------------------------------------------------------------------------------------------------------

        //Thêm xóa sửa ClassMember
        public int AddClassMember(ClassMember classMember)
        {
            try
            {
                _db.ClassMembers.InsertOnSubmit(classMember);
                _db.SubmitChanges();
                return classMember.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }
        public int EditClassMemberNote(ClassMember classMember)
        {
            try
            {
                var item = _db.ClassMembers.SingleOrDefault(d => d.Id == classMember.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Note = classMember.Note;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int DeleteClassMember(int id)
        {
            try
            {
                ClassMember classMember = _db.ClassMembers.SingleOrDefault(p => p.Id == id);
                if (classMember == null)
                {
                    return 0;
                }
                else
                {
                    _db.ClassMembers.DeleteOnSubmit(classMember);
                    _db.SubmitChanges();
                    return 1;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int CheckUniqueClassMember(int classId, int parishionerId)
        {
            try
            {
                const string query = "SELECT * FROM ClassMember WHERE ClassId = {0} AND ParishionerId = {1} AND Position = {2} ";
                ClassMember unique = _db.ExecuteQuery<ClassMember>(query, classId, parishionerId, 1).SingleOrDefault();
                ClassMember unique1 = _db.ExecuteQuery<ClassMember>(query, classId, parishionerId, 2).SingleOrDefault();
                if (unique == null && unique1 == null)
                {
                    return 1;
                }
                else
                {
                    if (unique != null)
                    {
                        return -2;
                    }
                    else
                    {
                        return -3;
                    }
                }

            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Check hoàn thành khóa học
        public int CompleteCourseApprove(string[] learnerId)
        {
            try
            {
                foreach (var item in learnerId)
                {
                    int id = Int32.Parse(item);
                    var learner = _db.ClassMembers.SingleOrDefault(p => p.Id == id);
                    if (learner == null)
                    {
                        return 0;
                    }
                    else
                    {
                        learner.IsDone = true;

                    }
                }
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int IncompleteCourseApprove(string[] learnerId)
        {
            try
            {
                foreach (var item in learnerId)
                {
                    int id = Int32.Parse(item);
                    var learner = _db.ClassMembers.SingleOrDefault(p => p.Id == id);
                    if (learner == null)
                    {
                        return 0;
                    }
                    else
                    {
                        learner.IsDone = false;

                    }
                }
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Chuyển lớp học viên
        public int ChangeLearnerClass(string[] learnerId, int classId)
        {
            try
            {
                foreach (var item in learnerId)
                {
                    int id = Int32.Parse(item);
                    var learner = _db.ClassMembers.SingleOrDefault(p => p.Id == id);
                    if (learner == null)
                    {
                        return 0;
                    }
                    var parishionerId = learner.ParishionerId;
                    //Validate thêm người vào lớp mới nếu lớp đã có người đó thì retun 0
                    var learners = _db.ClassMembers.SingleOrDefault(p => p.ParishionerId == parishionerId && p.ClassId == classId);
                    if (learners == null)
                    {
                        var classMember = new ClassMember()
                        {
                            ClassId = classId,
                            ParishionerId = learner.ParishionerId,
                            Position = (int)ClassMemberPositionEnum.Learner,
                            IsDone = false,
                        };
                        _db.ClassMembers.InsertOnSubmit(classMember);
                    }
                    

                }
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        //Tìm kiếm các lớp của giáo dân
        public IEnumerable<Class> GetClassesByParishionerId(int parishionerId)
        {
            const string query = "SELECT c.* " +
                                 "FROM Class AS c INNER JOIN ClassMember AS cm ON c.Id = cm.ClassId " +
                                 "WHERE cm.ParishionerId ={0} ";
            return _db.ExecuteQuery<Class>(query, parishionerId);
        }

    }
}
