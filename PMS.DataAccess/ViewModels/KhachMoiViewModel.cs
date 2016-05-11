using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class KhachMoiViewModel
    {
        public int id { get; set; }
        public string HoTen { get; set; }
        public string ChucDanh { get; set; }
        public string DiaChi { get; set; }
        public string SoDienThoai { get; set; }
        public string Email { get; set; }
        public string GhiChu { get; set; }
        public int GiayMoiId { get; set; }
       
    }
}
