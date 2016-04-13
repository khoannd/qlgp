using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class DeaconRequisitionCommentData
    {
        private readonly PMSDataContext _db;

        public DeaconRequisitionCommentData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<DeaconRequisitionComment> GetCommentsOfVocationDeaconRequisition(int vocationDeaconRequisitionId)
        {
            return _db.DeaconRequisitionComments.Where(d => d.VocationDeaconRequisitionId == vocationDeaconRequisitionId).ToList();
        }

        public DeaconRequisitionComment Get(int id)
        {
            return _db.DeaconRequisitionComments.SingleOrDefault(c => c.Id == id);
        }

        public int AddComment(DeaconRequisitionComment comment)
        {
            try
            {
                _db.DeaconRequisitionComments.InsertOnSubmit(comment);
                _db.SubmitChanges();
                return comment.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int UpdateComment(DeaconRequisitionComment comment)
        {
            try
            {
                var exist = _db.DeaconRequisitionComments.SingleOrDefault(c => c.Id == comment.Id);
                if (exist == null)
                {
                    return 0;
                }

                exist.Comment = comment.Comment;
                exist.CreatedAt = comment.CreatedAt;

                exist.ParishId = comment.ParishId;
                exist.ParishionerId = comment.ParishionerId;
                exist.PriestId = comment.PriestId;

                _db.SubmitChanges();

                return exist.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int DeleteComment(int id)
        {
            try
            {
                var exist = _db.DeaconRequisitionComments.SingleOrDefault(c => c.Id == id);
                if (exist == null)
                {
                    return 0;
                }

                _db.DeaconRequisitionComments.DeleteOnSubmit(exist);
                _db.SubmitChanges();

                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

    }
}
