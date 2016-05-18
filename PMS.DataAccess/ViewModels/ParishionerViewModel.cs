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
        public string Address { get; set; }
        public string ImageURL { get; set; }
        public string ThumbnailURL { get; set; }
        public string Phone { get; set; }
        public int CommunityId { get; set; }
        public string CommunityName { get; set; }
        public string SacramentDate { get; set; }
        public string DioceseName { get; set; }
        public bool IsCatechumen { get; set; }

    }
}
