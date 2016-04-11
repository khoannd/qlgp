using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PMS.Web.ViewModels
{
    public class SeminarianPostModel
    {
        [Required]
        public PostSeminarianParishionerModel Parishioner { get; set; }
        [Required]
        public IEnumerable<PostSeminarianVocationSeminaryYearModel> VocationSeminaryYears { get; set; }
    }

    public class PostSeminarianParishionerModel
    {
        public int Id { get; set; }
    }

    public class PostSeminarianVocationSeminaryYearModel
    {
        [Required]
        public int SeminaryYearId { get; set; }
        [Required]
        public DateTime ActualStart { get; set; }
        [Required]
        public DateTime ActualEnd { get; set; }
        [Required]
        public int Status { get; set; }
    }
}