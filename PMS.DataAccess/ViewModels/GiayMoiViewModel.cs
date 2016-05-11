using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class GiayMoiViewModel
    {
        public int id
        {
            get; set;

        }

        public string Ten
        {
            get; set;
        }
        public int Loai
        {
            get; set;
        }
        public string Mau
        {
            get; set;
        }
        public string NgayMoi
        {
            get; set;
        }
        public string NgaySuKien
        {
            get; set;
        }
        public string DiaDiem
        {
            get; set;
        }
        public int? NguoiGoi
        {
            get; set;
        }
       public string ThoiGian
        {
            get; set;
        }
        public int? MauId
        {
            get; set;
        }

        
    }
}
