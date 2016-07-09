using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess.ViewModels
{
    public class BanHanhGiaoViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
        public int ParishId { get; set; }
        public string ParishName { get; set; }
        public string VicariateName { get; set; }
    }
}