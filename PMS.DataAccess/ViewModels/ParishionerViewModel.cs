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
        public string GenderDef { get; set; }
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
        public string BirthPlace { get; set; }
        public string FatherName { get; set; }
        public string MotherName { get; set; }
        public int ParishId { get; set; }
        public int DioceseId { get; set; }
        public int VicariateId { get; set; }
        public string ParishName { get; set; }
        public string IDNo { get; set; }
        public string IDDate { get; set; }
        public string IDPlace { get; set; }
        public string Date8 { get; set; }

    }
}
