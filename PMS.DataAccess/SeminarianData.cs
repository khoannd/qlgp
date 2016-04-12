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

                var seminaryYearIds = vocation.VocationSeminaryYears.Select(v => v.SeminaryYearId);

                var deleteSeminaryYears = exist.VocationSeminaryYears.Where(v => !seminaryYearIds.Contains(v.SeminaryYearId));
                var updateSeminaryYears = exist.VocationSeminaryYears.Where(v => seminaryYearIds.Contains(v.SeminaryYearId));
                var insertSeminaryYears = vocation.VocationSeminaryYears.Where(v => !updateSeminaryYears.Any(d => d.SeminaryYearId == v.SeminaryYearId)).Select(v => new VocationSeminaryYear
                {
                    ActualEnd = v.ActualEnd,
                    ActualStart = v.ActualStart,
                    Status = v.Status,
                    SeminaryYearId = v.SeminaryYearId,
                    Vocation = exist
                });

                _db.VocationSeminaryYears.DeleteAllOnSubmit(deleteSeminaryYears);

                foreach (var item in updateSeminaryYears)
                {
                    var updateInfo = vocation.VocationSeminaryYears.FirstOrDefault(v => v.SeminaryYearId == item.SeminaryYearId);
                    item.ActualEnd = updateInfo.ActualEnd;
                    item.ActualStart = updateInfo.ActualStart;
                    item.Status = updateInfo.Status;
                }

                if (insertSeminaryYears.Count() > 0)
                {
                    exist.VocationSeminaryYears.AddRange(insertSeminaryYears);
                }

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
                _db.DeaconRequisitionComments.DeleteAllOnSubmit(vocation.VocationDeaconRequisitionSessions.SelectMany(v => v.DeaconRequisitionComments));
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

        public IEnumerable<Vocation> SearchSeminarianByKeyword(string keyword, int start = 0, int length = 10, int[] ignore = null)
        {
            keyword = keyword.Trim().ToLower();
            if (ignore == null)
            {
                ignore = new int[] { };
            }
            var query = _db.Vocations.Where(v => !ignore.Contains(v.Parishioner.Id) && v.Date2 != null && v.Date2.Trim() != "" && (v.Date7 == null || v.Date7.Trim() == "") && (v.Parishioner.Name.Contains(keyword) || v.Parishioner.ChristianName.Contains(keyword)
                || v.Parishioner.Address.ToLower().Contains(keyword) || v.Parishioner.MobilePhone.Contains(keyword) || v.Parishioner.Phone.Contains(keyword)
                || v.Parishioner.BirthDate.Contains(keyword) || v.Parishioner.Code.ToLower().Contains(keyword) || v.Parishioner.Email.ToLower().Contains(keyword)));
            query = query.OrderBy(p => p.Parishioner.Name).Skip(start);
            if (length <= 0)
            {
                return query.ToList();
            }
            else
            {
                return query.Take(length).ToList();
            }
        }

    }
}
