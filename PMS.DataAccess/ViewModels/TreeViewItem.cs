using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class TreeViewItem
    {
        public TreeViewItem()
        {
            itemSelected = false;
        }
        public int id { get; set; }
        public string name { get; set; }
        public string type { get; set; }
        public TreeViewItem additionalParameters { get; set; }
        public int itemType { get; set; }
        public bool children { get; set; }

        public bool itemSelected { get; set; }
    }

}
