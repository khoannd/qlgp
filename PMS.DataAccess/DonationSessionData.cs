using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class DonationSessionData
    {
        private readonly PMSDataContext _db;

        public DonationSessionData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public DonationSession GetSessionByDonationId(int id)
        {
            const string query = "SELECT * FROM Priest WHERE Id = {0}";
            return _db.ExecuteQuery<DonationSession>(query, id).SingleOrDefault();
        }

        public int AddSession(DonationSession session)
        {
            try
            {
                //var hdlmMember = new HDLMMember()
                //{
                //    PriestID = priestId,
                //    HdlmID = lastId,
                //    Role = 0
                //};
                //_db.HDLMMembers.InsertOnSubmit(hdlmMember);
                //_db.SubmitChanges();

                _db.DonationSessions.InsertOnSubmit(session);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

    }
}
