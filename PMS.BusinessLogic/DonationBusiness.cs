using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class DonationBusiness
    {
        private readonly DonationData _donationData;
        private readonly ParishionerData _parishionerData;
        public DonationBusiness(string connection)
        {
            _donationData = new DonationData(connection);
            _parishionerData = new ParishionerData(connection);
        }

        public IEnumerable<IConvertible[]> LoadAllDonation(jQueryDataTableParam param, out int totalRecords, out int totalDisplayRecords)
        {
            string searchValue = param.search["value"];
            int sortColumnIndex = Convert.ToInt32(param.order[0]["column"]);
            string sortDirection = param.order[0]["dir"];
            int displayStart = param.start;
            int displayLength = param.length;
            //Load Data
            IEnumerable<DonationViewModel> donation;
            donation = _donationData.getAllDonation((int)param.VicariateId, (int)param.ParishId, (int)param.CommunityId);
            IEnumerable<DonationViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                filteredListItems = donation.Where(c => (c.Name.ToLower().Contains(searchValue.ToLower())));
            }
            else
            {
                filteredListItems = donation;
            }
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            else
            {
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.ParishionerID,
                           c.DonationID,
                           c.ChristianName + " " + c.Name,
                           c.TotalValue,
                           c.DonationLevel,
                           c.CertificateID, //c.CertificateID != null ? c.CertificateID : -1,
                           c.DonationID + "-" + c.ParishionerID
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public IEnumerable<IConvertible[]> LoadDonationSession(int donationId)
        {
            var sessions = _donationData.LoadDonationSession(donationId);

            //Paging
            //var list = filteredListItems.ToList();
            //int records = list.Count;
            //var displayedList = list.Skip(displayStart).Take(displayLength);
            //var converter = new DateConverter();
            var result = from c in sessions
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Id,
                           String.Format("{0:dd/MM/yyyy}",c.DonationDate),
                           c.FinalValue.ToString("n0"),
                           c.InputValue == c.FinalValue ? "0" : c.InputValue.ToString("n0"),
                           c.ReceiptID,
                           c.Id,
                           c.Id
                       };

            return result;
        }

        public int AddDonation(Donation donation)
        {
            return _donationData.AddDonation(donation);
        }

        public int UpdateDonation(int donationId, int parishionerId)
        {
            return _donationData.UpdateDonation(donationId, parishionerId);
        }

        public int DeleteDonation(int donationId)
        {
            return _donationData.DeleteDonation(donationId);
        }

        public DonationSession GetSessionByID(int sessionId)
        {
            return _donationData.GetSessionByID(sessionId);
        }

        public DonorsViewModel GetDonationByID(int parishionerID)
        {
            //var donation = _donationData.GetDonationByID(donationId);
            //if(donation != null)                


            //return null;
            var donors = _parishionerData.GetDonorsById(parishionerID);
            //if (donors != null)
            //    donors.Gender = donors.Gender == "1" ? "Nam" : "Nữ";
            return donors;
        }
        //public List<string> getCurrenyByCode(string type)
        //{
        //    return _donationData.getCurrenyByCode(type).ToList();
        //}
        public string checkType(int type)
        {
            string currency = "";
            if (type == 1)
            {
                currency = "USD";
            }
            else if (type == 2)
            {
                currency = "VND";
            }
            return currency;
        }
    }
}
