using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ChartBasicComponentViewModel
    {
        public string label { get; set; }
        public string fillColor { get; set; }
        public string strokeColor { get; set; }
        public string highlightFill { get; set; }
        public string hightlightStroke { get; set; }
        public string pointColor { get; set; }
        public string pointStrokeColor { get; set; }
        public string pointHighlightFill { get; set; }
        public string pointHighlightStroke { get; set; }
        public int[] data { get; set; }

        public ChartBasicComponentViewModel()
        {
           data = new int[]{};
        }
    }
}
