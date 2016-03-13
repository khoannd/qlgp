using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess.ViewModels
{
    public class CommunityTreeViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public List<Community> ParishDivisions { get; set; }

        public CommunityTreeViewModel()
        {
            ParishDivisions = new List<Community>();
        }

    }
}
