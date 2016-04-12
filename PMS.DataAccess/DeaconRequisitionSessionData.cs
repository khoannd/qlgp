using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class DeaconRequisitionSessionData
    {
        private readonly PMSDataContext _db;

        public DeaconRequisitionSessionData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<DeaconRequisitionSession> GetAll()
        {
            return _db.DeaconRequisitionSessions.ToList();
        }

        public DeaconRequisitionSession Get(int id)
        {
            return _db.DeaconRequisitionSessions.SingleOrDefault(v => v.Id == id);
        }

        public int Add(DeaconRequisitionSession session)
        {
            try
            {
                _db.DeaconRequisitionSessions.InsertOnSubmit(session);
                _db.SubmitChanges();
                return session.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Update(DeaconRequisitionSession session)
        {
            try
            {
                var exist = _db.DeaconRequisitionSessions.SingleOrDefault(v => v.Id == session.Id);

                if (exist == null)
                {
                    return 0;
                }

                exist.DeaconOrdinationMassParish = session.DeaconOrdinationMassParish;
                exist.DeaconOrdinationMassTime = session.DeaconOrdinationMassTime;
                exist.DeadlineForParish = session.DeadlineForParish;
                exist.DeadlineForPriest = session.DeadlineForPriest;
                exist.SessionCode = session.SessionCode;
                exist.SessionName = session.SessionName;
                exist.Status = session.Status;
                exist.Year = session.Year;

                var seminarianIds = session.VocationDeaconRequisitionSessions.Select(v => v.VocationId);

                var deleteVocationDeaconRequisitionSessions = exist.VocationDeaconRequisitionSessions.Where(v => !seminarianIds.Contains(v.VocationId));
                var updateVocationDeaconRequisitionSessions = exist.VocationDeaconRequisitionSessions.Where(v => seminarianIds.Contains(v.VocationId));
                var insertVocationDeaconRequisitionSessions = session.VocationDeaconRequisitionSessions.Where(v => !updateVocationDeaconRequisitionSessions.Any(d => d.VocationId == v.VocationId)).Select(v => new VocationDeaconRequisitionSession
                {
                     Status = v.Status,
                     VocationId = v.VocationId,
                     
                });

                _db.DeaconRequisitionComments.DeleteAllOnSubmit(deleteVocationDeaconRequisitionSessions.SelectMany(s => s.DeaconRequisitionComments));
                _db.VocationDeaconRequisitionSessions.DeleteAllOnSubmit(deleteVocationDeaconRequisitionSessions);

                foreach (var item in updateVocationDeaconRequisitionSessions)
                {
                    var updateInfo = session.VocationDeaconRequisitionSessions.FirstOrDefault(v => v.VocationId == item.VocationId);
                    item.Status = updateInfo.Status;
                }

                if (insertVocationDeaconRequisitionSessions.Count() > 0)
                {
                    exist.VocationDeaconRequisitionSessions.AddRange(insertVocationDeaconRequisitionSessions);
                }

                _db.SubmitChanges();

                return exist.Id;
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
                DeaconRequisitionSession session = _db.DeaconRequisitionSessions.SingleOrDefault(v => v.Id == id);

                if (session == null)
                {
                    return 0;
                }

                _db.DeaconRequisitionComments.DeleteAllOnSubmit(session.VocationDeaconRequisitionSessions.SelectMany(v => v.DeaconRequisitionComments));
                _db.VocationDeaconRequisitionSessions.DeleteAllOnSubmit(session.VocationDeaconRequisitionSessions);
                _db.DeaconRequisitionSessions.DeleteOnSubmit(session);

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
