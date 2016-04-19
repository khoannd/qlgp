using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class HDLMViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int totalMembers { get; set; }
        public string PriestName { get; set; }
        public string ChristianName { get; set; }
    }
}
