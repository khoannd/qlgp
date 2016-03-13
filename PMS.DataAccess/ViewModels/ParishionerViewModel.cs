using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class ParishionerViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public int Gender { get; set; }
        public string BirthDate { get; set; }
        public int CommunityId { get; set; }
        public string CommunityName { get; set; }
        public string SacramentDate { get; set; }

        public bool IsCatechumen { get; set; }

    }
}
