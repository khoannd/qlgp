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

        public IEnumerable<DonationViewModel> getAllDonation()
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

        //public IEnumerable<string> getCurrenyByCode(string type)
        //{
        //    const string query = "SELECT Definition FROM ValueSet WHERE Code = {0} AND Category = {1}";
        //    return _db.ExecuteQuery<string>(query, type, currencyCategory);

        //}

    }
}
