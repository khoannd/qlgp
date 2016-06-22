using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class RolePermissionViewModel
    {
        public string ScreenId { get; set; }
        public int RoleId { get; set; }
        public int? Permission { get; set; }
        public string ScreenName { get; set; }
    }
}
