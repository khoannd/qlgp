using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class DonationViewModel
    {
        public int ParishionerID { get; set; }
        public int DonationID { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public double TotalValue { get; set; }
        public int? CertificateID { get; set; }
        public string DonationLevel { get; set; }
    }
}