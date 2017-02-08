using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class DonorsViewModel
    {
        public int ParishionerID { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public string CommunityName { get; set; }
        public string BirthDate { get; set; }
        public string BirthPlace { get; set; }
        public string FatherName { get; set; }
        public string MotherName { get; set; }
        public int Gender { get; set; }
        public string Phone { get; set; }
    }
}
