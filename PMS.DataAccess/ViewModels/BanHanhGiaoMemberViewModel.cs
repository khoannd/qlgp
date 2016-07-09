using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class BanHanhGiaoMemberViewModel
    {
        public int BanHanhGiaoId { get; set; }
        public int ParishionerId { get; set; }
        public int? RoleId { get; set; }
        public string RoleName { get; set; }
        public string ParishionerName { get; set; }
        public string BirthDate { get; set; }
        public string Title { get; set; }
    }
}
