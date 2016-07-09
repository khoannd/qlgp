using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ParishViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Ward { get; set; }
        public string District { get; set; }
        public string Province { get; set; }
        public string Website { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string ImageUrl { get; set; }
        public int VicariateId { get; set; }
        public int DioceseId { get; set; }
        public string VicariateName { get; set; }
        public int? PriestId { get; set; }
        public string Priest { get; set; }
        public string Patron { get; set; }
        public string PatronDate { get; set; }
        public string ChauLuot { get; set; }
    }
}
