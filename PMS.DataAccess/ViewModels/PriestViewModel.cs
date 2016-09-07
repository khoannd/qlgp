using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.ViewModels
{
    public class PriestViewModel
    {
        public int Id { get; set; }
        public string ChristianName { get; set; }
        public string Name { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string BirthDate { get; set; }
        public string BirthPlace { get; set; }
        public int DioceseId { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string BaptismDate { get; set; }
        public string BaptismPlace { get; set; }
        public string BaptismPriest { get; set; }
        public int? ParishionerId { get; set; }
        public string Code { get; set; }
        public string ImageURL { get; set; }
        public string ThumbnailURL { get; set; }
        public string BirthYear { get; set; }
        public int? Age { get; set; }
        public string Role { get; set; }
        public int? RoleId { get; set; }
        public int? ParishId { get; set; }
        public int? ParishTypeCode { get; set; }
        public string ParishTypeName { get; set; }
        public string ParishName { get; set; }
        public string PatronDate { get; set; }
        public string Title { get; set; }
        public string Seminary { get; set; } //nhà dòng, tu viện, chủng viện
        public int? VicariateId { get; set; }
        public string VicariateName { get; set; }
        public string TypeCode { get; set; }
        public string TypeName { get; set; }
        public int IsRetired { get; set; }
        public bool? Diocesan { get; set; }//cha trieu khong phai cha dong
        public int? ServedPlaceId { get; set; }
        public string ServedPlace { get; set; }
        public string ServedAddress { get; set; }
        public string ServedPhone { get; set; }
        public string ServedEmail { get; set; }
        public string StartDate { get; set; }

        public string OrdinationDate { get; set; } //ngay thu phong LM
        public string OrdinationPlace { get; set; } //noi thu phong LM
        public string OrdinationBy { get; set; }//DGM ban phep thu phong

        public string Note { get; set; }

        public object Additional { get; set; }
    }
}
