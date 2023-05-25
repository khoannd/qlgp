using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class DonationSessionData
    {
        private readonly PMSDataContext _db;

        public DonationSessionData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public DonationSession GetSessionByDonationId(int id)
        {
            const string query = "SELECT * FROM Priest WHERE Id = {0}";
            return _db.ExecuteQuery<DonationSession>(query, id).SingleOrDefault();
        }

        public int AddSession(DonationSession session)
        {
            try
            {
                _db.DonationSessions.InsertOnSubmit(session);
                _db.SubmitChanges();
                UpdateDonationRank(session.DonationID);
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteSession(int sessionId)
        {
            try
            {
                var item = _db.DonationSessions.Where(_ => _.Id == sessionId).SingleOrDefault();
                if (item != null)
                {
                    _db.DonationSessions.DeleteOnSubmit(item);
                    _db.SubmitChanges();
                    UpdateDonationRank(item.DonationID);
                    return 1;
                }
                return -1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateSession(DonationSession session)
        {
            try
            {
                var item = _db.DonationSessions.Where(_ => _.Id == session.Id).SingleOrDefault();
                if (item != null)
                {
                    item.DonationDate = session.DonationDate;
                    item.ReceiptDate = session.ReceiptDate;
                    item.Currency = session.Currency;
                    item.InputValue = session.InputValue;
                    item.FinalValue = session.FinalValue;
                    item.ExchangeRate = session.ExchangeRate;
                    item.Note = session.Note;
                    _db.SubmitChanges();
                    UpdateDonationRank(item.DonationID);
                    return item.Id;
                }
                return -1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        private void UpdateDonationRank(int donationId)
        {
            try
            {
                string updateQuery = @"Update Donation SET DonationLevel = (
                                            SELECT MAX(Level)from DonationRank WHERE
                                            (SELECT SUM(FinalValue) AS TotalValue FROM DonationSession
                                            WHERE DonationID = {0} GROUP BY DonationID) > [Value]) WHERE Id = {0}";
                _db.ExecuteCommand(updateQuery, donationId);
            }
            catch (Exception e)
            {

            }
        }

    }
}
