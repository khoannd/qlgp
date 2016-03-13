using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ThuyenChuyenLinhMucViewModel
    {
        public int Id { get; set; }

        public string NgayQuyetDinh { get; set; }

        public string NgayHieuLuc { get; set; }

        public int NguoiQuyetDinh { get; set; }

        public string MoTa { get; set; }
        public int NumberPriest { get; set; }
    }
}
