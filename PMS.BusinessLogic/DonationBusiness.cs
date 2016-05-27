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
        public DonationBusiness(string connection)
        {
            _donationData = new DonationData(connection);
        }

        public IEnumerable<IConvertible[]> LoadAllDonation(string searchValue, int sortColumnIndex
                                                                                    , string sortDirection, int displayStart, int displayLength
                                                                                    , out int totalRecords, out int totalDisplayRecords)
        {
            //Load Data
            IEnumerable<DonationViewModel> donation;
            donation = _donationData.getAllDonation();
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
                           c.DonationID
                       };

            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int AddDonation(Donation donation)
        {
            return _donationData.AddDonation(donation);
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
