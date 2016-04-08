using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class SeminarianData
    {
        private readonly PMSDataContext _db;

        public SeminarianData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Vocation> GetAll()
        {
            return _db.Vocations.Where(v => v.Date2 != null && v.Date2 != "").ToList();
        }

        public Vocation Get(int id)
        {
            return _db.Vocations.SingleOrDefault(v => v.ParishionerId == id && v.Date2 != null && v.Date2 != "");
        }

        public int Add(Vocation vocation)
        {
            try
            {
                _db.Vocations.InsertOnSubmit(vocation);
                _db.SubmitChanges();
                return vocation.ParishionerId;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Update(Vocation vocation)
        {
            try
            {
                var exist = _db.Vocations.SingleOrDefault(v => v.ParishionerId == vocation.ParishionerId && v.Date2 != null && v.Date2 != "");

                if (exist == null)
                {
                    return 0;
                }

                exist.Date2 = vocation.Date2;
                exist.Date7 = vocation.Date7;
                exist.Date8 = vocation.Date8;

                exist.Email = vocation.Email;
                exist.IsLeft = vocation.IsLeft;
                exist.Note = vocation.Note;
                exist.Phone = vocation.Phone;
                exist.Position = vocation.Position;

                exist.Seminary = vocation.Seminary;
                exist.SeminaryAddress = vocation.SeminaryAddress;
                exist.ServedAddress = vocation.ServedAddress;
                exist.ServedPlace = vocation.ServedPlace;
                
                _db.SubmitChanges();

                return exist.ParishionerId;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Delete(int id)
        {
            try
            {
                Vocation vocation = _db.Vocations.SingleOrDefault(v => v.ParishionerId == id && v.Date2 != null && v.Date2 != "");

                if (vocation == null)
                {
                    return 0;
                }

                _db.VocationSeminaryYears.DeleteAllOnSubmit(vocation.VocationSeminaryYears);
                _db.VocationDeaconRequisitionSessions.DeleteAllOnSubmit(vocation.VocationDeaconRequisitionSessions);
                _db.LeaveVocationRequisitions.DeleteAllOnSubmit(vocation.LeaveVocationRequisitions);

                _db.Vocations.DeleteOnSubmit(vocation);
               
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

    }
}
