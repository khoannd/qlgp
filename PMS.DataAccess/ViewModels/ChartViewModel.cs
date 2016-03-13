using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ChartViewModel
    {
        public string[] labels { get; set; }
        public ChartBasicComponentViewModel[] datasets { get; set; }

        public ChartViewModel()
        {
            labels = new string[]{};
            datasets = new ChartBasicComponentViewModel[]{};
        }

    }
}
