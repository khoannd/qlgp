using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PMS.Web.ViewModels
{
    public class AddDeaconRequisitionCommentModel
    {
        public int? Id { get; set; }
        [Required]
        public string Comment { get; set; }
        [Required]
        public DateTime CreatedAt { get; set; }
        public int? PriestId { get; set; }
        public int? ParishionerId { get; set; }
        public int? ParishId { get; set; }
        [Required]
        public int VocationDeaconRequisitionId { get; set; }
    }
}