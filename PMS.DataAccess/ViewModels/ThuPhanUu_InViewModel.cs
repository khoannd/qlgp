using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess.ViewModels
{
    public class ThuPhanUu_InViewModel
    {
        public string NguoiMat { get; set; }
        public string NguoiNhanThu { get; set; }
        public int? Position { get; set; }
        public int Gender { get; set; }
        public string ChucDanhNguoiNhan { get; set; }
        public string ChucDanhNguoiMat { get; set; }
    }
}
