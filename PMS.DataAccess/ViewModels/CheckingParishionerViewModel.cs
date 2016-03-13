using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess.ViewModels
{
    public class CheckingParishionerViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public int Gender { get; set; }
        public string BirthDate { get; set; }
        public Community Community { get; set; }
        public string Error { get; set; }

        public int Status { get; set; }
    }
}
