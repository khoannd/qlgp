using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class LetterAndReportViewModel
    {
        public int Id { get; set; }
        public string Ten { get; set; }
        public int Loai { get; set; }
        public string MoTa { get; set; }
        public string Mau { get; set; }
        public string TenLoai { get; set; }
    }
}
