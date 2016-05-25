using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess.ViewModels
{
    public class ThuPhanUuViewModel
    {
        public int Id { get; set; }

        public string ChucVu { get; set; }

        public string TenThanh { get; set; }

        public int IdNguoiMat { get; set; }

        public string NguoiMat { get; set; }

        public System.Nullable<System.DateTime> NgayMat { get; set; }

        public List<ThuPhanUu_NguoiNhanViewModel> ThuPhanUu_NguoiNhanList { get; set; }        

    }
}
