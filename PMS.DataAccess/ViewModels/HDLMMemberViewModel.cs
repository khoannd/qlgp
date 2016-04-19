using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class HDLMMemberViewModel
    {
        public int Id { get; set; }
        public int HdlmId { get; set; }
        public string Phone { get; set; }
        public string BirthDate { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public int Position { get; set; }
        public string PositionName { get; set; }
    }
}
