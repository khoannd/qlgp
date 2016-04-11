using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ConstructionPermitViewModel
    {
        public int Id { get; set; }
        public int PermitType { get; set; }
        public int ParishId { get; set; }
        public string Description { get; set; }
        public string FilePath { get; set; }
        public int PermitStatus { get; set; }
        public string Note { get; set; }

        public string TypeName { get; set; }
        public string ParishName { get; set; }
        public string StatusName { get; set; }
    }
}
