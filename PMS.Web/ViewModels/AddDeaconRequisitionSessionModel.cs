using PMS.DataAccess.Enumerations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PMS.Web.ViewModels
{
    public class DeaconRequisitionSessionPostModel
    {
        public int? Id { get; set; }
        [Required]
        public string SessionName { get; set; }
        [Required]
        public string SessionCode { get; set; }
        [Required]
        public DateTime DeadlineForPriest { get; set; }
        [Required]
        public DateTime DeadlineForParish { get; set; }
        [Required]
        public DateTime Year { get; set; }
        public string DeaconOrdinationMassParish { get; set; }
        public DateTime? DeaconOrdinationMassTime { get; set; }
        [Required]
        public DeaconRequisitionSessionStatus Status { get; set; }
        [Required]
        public IEnumerable<VocationDeaconRequisitionSessionPostModel> VocationDeaconRequisitionSessions { get; set; }
    }

    public class VocationDeaconRequisitionSessionPostModel
    {
        [Required]
        public int SeminarianId { get; set; }
        [Required]
        public VocationDeaconRequisitionSessionStatus Status { get; set; }

    }
}