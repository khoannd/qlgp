using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
     public class ClassViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string RoomNo { get; set; }
        public int Year { get; set; }
        public string Note { get; set; }
        public int ClassGroupId { get; set; }
        public string ClassGroupName { get; set; }
    }
}
