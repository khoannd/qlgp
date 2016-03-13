using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ParishManagerViewModel
    {
        public int Id { get; set; }
        public int? ParishId { get; set; }
        public int PriestId { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public System.Nullable<int> Position { get; set; }
        public string PositionName { get; set; }
        public System.Nullable<int> IdThuyenChuyenLinhMuc { get; set; }
        public string Parish { get; set; }
        public string Priest { get; set; }
        public string ChristianName { get; set; }
        public string BirthDate { get; set; }
        public int? ParishIdCurrent { get; set; }
        public string ParishCurrent { get; set; }
        public string Code { get; set; }
        public int? StatusId { get; set; }
    }
}
