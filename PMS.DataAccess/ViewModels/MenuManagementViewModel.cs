using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class MenuManagementViewModel
    {
        public int Id { get; set; }
        public string ScreenId { get; set; }
        public string Text { get; set; }
        public bool NewWindow { get; set; }
        public string IconClass { get; set; }
        public int ParentId { get; set; }
        public string Parent { get; set; }
        public int Position { get; set; }
        public bool Visible { get; set; }
        public bool Enabled { get; set; }
        public int MenuType { get; set; }
        public string Link { get; set; }
    }
}
