using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class PrintParishManagerViewModel
    {
        public int Id { get; set; }
        public int? ParishId { get; set; }
        public int PriestId { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public System.Nullable<int> Position { get; set; }
        public string PositionName { get; set; }
        public System.Nullable<int> IdThuyenChuyenLinhMuc { get; set; }
        public string Priest { get; set; }
        public string Parish { get; set; }       
        public string ParishAddress { get; set; }
        public string ParishWard { get; set; }
        public string ParishDistrict { get; set; }
        public string ParishProvince { get; set; }
        public string ChristianName { get; set; }
        public string BirthDate { get; set; }
        public int? ParishIdCurrent { get; set; }
        public string ParishCurrent { get; set; }
        public string ParishCurrentAddress { get; set; }
        public string ParishCurrentWard { get; set; }
        public string ParishCurrentDistrict { get; set; }
        public string ParishCurrentProvince { get; set; }
        public string Code { get; set; }
        public string VicariateName { get; set; }
        public string NguoiQuyetDinh { get; set; }
    }
}
