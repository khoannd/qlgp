using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.Enumerations;

namespace PMS.DataAccess
{
    public class VocationData
    {
        private readonly PMSDataContext _db;

        public VocationData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public Vocation GetVocationByParishionerId(int parishionerId)
        {
            try
            {
                const string query = "SELECT * " +
                                        "FROM Vocation " +
                                        "WHERE ParishionerId = {0}";
                return _db.ExecuteQuery<Vocation>(query, parishionerId).SingleOrDefault();
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public int AddVocation(Vocation vocation)
        {
            try
            {
                _db.Vocations.InsertOnSubmit(vocation);
                _db.SubmitChanges();
                return vocation.ParishionerId;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateVocation(Vocation vocation)
        {
            try
            {
                var item = _db.Vocations.SingleOrDefault(v => v.ParishionerId == vocation.ParishionerId);

                if (item == null)
                {
                    return 0;
                }

                item.Date1 = vocation.Date1;
                item.Date2 = vocation.Date2;
                item.Date3 = vocation.Date3;
                item.Date4 = vocation.Date4;
                item.Date5 = vocation.Date5;
                item.Date6 = vocation.Date6;
                item.Date7 = vocation.Date7;
                item.Date8 = vocation.Date8;
                item.Date9 = vocation.Date9;

                item.Position = vocation.Position;
                item.Seminary = vocation.Seminary;
                item.SeminaryAddress = vocation.SeminaryAddress;
                item.ServedPlace = vocation.ServedPlace;
                item.ServedAddress = vocation.ServedAddress;
                item.Phone = vocation.Phone;
                item.Email = vocation.Email;
                item.Note = vocation.Note;
                item.IsLeft = vocation.IsLeft;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteVocation(int id)
        {
            try
            {
                var item = _db.Vocations.SingleOrDefault(v => v.ParishionerId == id);

                if (item == null)
                {
                    return 0;
                }

                _db.Vocations.DeleteOnSubmit(item);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public static string GetPositionText(int? position, int gender)
        {
            if(position == null)
            {
                return "";
            }
            switch((VocationEnum)position)
            {
                case VocationEnum.Cleric: //tu sĩ
                    if (gender == (int)GenderEnum.Female)
                        return "Sơ";
                    else
                        return "Thầy";
                case VocationEnum.Seminarist: //chủng sinh
                    if (gender == (int)GenderEnum.Female)
                        return "Dì";
                    else
                        return "Thầy";
                case VocationEnum.Deacon: // Phó tế
                    return "";
                case VocationEnum.Priest: //linh mục
                    return "Cha";
                case VocationEnum.Bishop: //Giám mục
                    return "Đức Cha";
                case VocationEnum.Fully:
                    return "Sơ";
                default:
                    return "";
            }
        }
    }
}
