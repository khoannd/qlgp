using PMS.DataAccess;
using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class DeaconRequisitionCommentBusiness
    {
        private readonly DeaconRequisitionCommentData _deaconRequisitionCommentData;

        public DeaconRequisitionCommentBusiness(string connection)
        {
            _deaconRequisitionCommentData = new DeaconRequisitionCommentData(connection);
        }

        public IEnumerable<DeaconRequisitionComment> GetCommentsOfVocationDeaconRequisition(int vocationDeaconRequisitionId)
        {
            return _deaconRequisitionCommentData.GetCommentsOfVocationDeaconRequisition(vocationDeaconRequisitionId);
        }

        public DeaconRequisitionComment Get(int id)
        {
            return _deaconRequisitionCommentData.Get(id);
        }

        public int AddComment(DeaconRequisitionComment comment)
        {
            return _deaconRequisitionCommentData.AddComment(comment);
        }

        public int UpdateComment(DeaconRequisitionComment comment)
        {
            return _deaconRequisitionCommentData.UpdateComment(comment);
        }

        public int DeleteComment(int id)
        {
            return _deaconRequisitionCommentData.DeleteComment(id);
        }
    }
}
