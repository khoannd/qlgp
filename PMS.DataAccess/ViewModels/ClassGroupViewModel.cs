using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ClassGroupViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Year { get; set; }
        public string Note { get; set; }
        public int ManagedBy { get; set; }
        public int ParishId { get; set; }
        public string ManagerName { get; set; }

    }
}
