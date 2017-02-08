using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class DonationData
    {
        private const string currencyCategory = "Currency";
        private readonly PMSDataContext _db;

        public DonationData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<DonationViewModel> getAllDonation(int vicariateId, int parishId, int communityId)
        {
            string query = @" SELECT p.Id AS ParishionerID, dp.DonationID, p.ChristianName, p.Name, dp.TotalValue, dp.DonationLevel, dp.CertificateID
                                    FROM Parishioner AS p
                                    JOIN
                                    (SELECT ParishionerID, d.ID as DonationID, TotalValue, CertificateID, DonationLevel
                                    FROM Donation AS d
                                    LEFT JOIN (SELECT donationID, SUM(FinalValue) AS TotalValue FROM DonationSession GROUP BY DonationID) AS ds
                                    ON ds.DonationID = d.Id) AS dp
                                    ON p.Id = dp.ParishionerID";

            string whereStr = string.Empty;
            if (vicariateId != 0 || parishId != 0 || communityId != 0)
            {
                if (parishId == 0 && communityId == 0)
                {
                    whereStr = " JOIN Community c ON P.CommunityId = c.Id JOIN Parish pr on pr.Id = c.ParishId and pr.VicariateId = {0}";
                    query += whereStr;
                    return _db.ExecuteQuery<DonationViewModel>(query, vicariateId);
                }
                else if (communityId == 0)
                {
                    whereStr = " JOIN Community c ON P.CommunityId = c.Id and c.ParishId = {0}";
                    query += whereStr;
                    return _db.ExecuteQuery<DonationViewModel>(query, parishId);
                }
                else
                {
                    whereStr = " where P.CommunityId = {0}";
                    query += whereStr;
                    return _db.ExecuteQuery<DonationViewModel>(query, communityId);
                }
            }

            return _db.ExecuteQuery<DonationViewModel>(query);
        }

        public IEnumerable<DonationViewModel> GetDonationsSearch(string giaoHat, string giaoXu, string giaoHo)
        {
            const string query = @" SELECT Id AS ParishionerID, dp.DonationID, ChristianName, Name, dp.TotalValue, dp.DonationLevel, dp.CertificateID
                                    FROM Parishioner AS p
                                    JOIN
                                    (SELECT ParishionerID, DonationID, TotalValue, CertificateID, DonationLevel
                                    FROM Donation AS d
                                    JOIN (SELECT donationID, SUM(FinalValue) AS TotalValue FROM DonationSession GROUP BY DonationID) AS ds
                                    ON ds.DonationID = d.Id) AS dp
                                    ON p.Id = dp.ParishionerID";
            return _db.ExecuteQuery<DonationViewModel>(query);
        }

        public List<DonationSession> LoadDonationSession(int donationId)
        {
            return _db.ExecuteQuery<DonationSession>("Select * from DonationSession where DonationID = {0}", donationId).ToList();
        }

        public int AddDonation(Donation donation)
        {
            try
            {
                _db.Donations.InsertOnSubmit(donation);
                _db.SubmitChanges();
                return donation.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateDonation(int donationId, int parishionerId)
        {
            try
            {
                if (donationId == 0)
                {
                    var item = new Donation
                    {
                        ParishionerID = parishionerId
                    };
                    _db.Donations.InsertOnSubmit(item);
                    _db.SubmitChanges();
                    return item.Id;
                }
                else
                {
                    Donation dn = _db.Donations.Where(item => item.Id == donationId).SingleOrDefault();
                    if (parishionerId != dn.ParishionerID)
                    {
                        dn.ParishionerID = parishionerId;
                        _db.SubmitChanges();
                    }
                    return dn.Id;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public Donation GetDonationByID(int donationId)
        {
            try
            {
                return _db.Donations.Where(item => item.Id == donationId).SingleOrDefault();
            }
            catch (Exception e)
            {
                return null;
            }
        }
        public DonationSession GetSessionByID(int sessionId)
        {
            try
            {
                return _db.DonationSessions.Where(item => item.Id == sessionId).SingleOrDefault();
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public int UpdateSessionDetail(int sessionId, DateTime donationDate, string note, string currency, double inputValue, double exchangeRate)
        {
            try
            {
                var session = _db.DonationSessions.Where(item => item.Id == sessionId).SingleOrDefault();
                if (session != null)
                {
                    session.DonationDate = donationDate;
                    session.Note = note;
                    session.Currency = currency;
                    session.InputValue = inputValue;
                    if (exchangeRate == 1)
                        session.FinalValue = inputValue;
                    else
                        session.FinalValue = inputValue * exchangeRate;
                    session.ExchangeRate = exchangeRate;

                    _db.SubmitChanges();
                    return sessionId;
                }
                return -1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteDonation(int donationId)
        {
            try
            {
                var donation = _db.Donations.Where(item => item.Id == donationId).SingleOrDefault();
                if (donation != null)
                {
                    _db.Donations.DeleteOnSubmit(donation);
                    _db.SubmitChanges();
                    return 1;
                }
                return -1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        //public IEnumerable<string> getCurrenyByCode(string type)
        //{
        //    const string query = "SELECT Definition FROM ValueSet WHERE Code = {0} AND Category = {1}";
        //    return _db.ExecuteQuery<string>(query, type, currencyCategory);

        //}

    }
}
