using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class VicariateViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int DioceseId { get; set; }
        public int? ParishId { get; set; }
        public string ParishName { get; set; }
    }
}
