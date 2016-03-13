using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class SocietyViewModel
    {
        public int Id { get ; set; }
        public string Name { get; set; }
        public string EstablishedDate { get; set; }
        public int? ManagedBy { get; set; }
        public int ParishId { get; set; }
        public string Manager { get; set; }
    }
}
