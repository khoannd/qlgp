using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class PriestViewModel
    {
        public int Id { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public string BirthDate { get; set; }
        public int DioceseId { get; set; }
        public string Phone { get; set; }
        public int ParishionerId { get; set; }
    }
}
