using PMS.DataAccess;
using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class DonationSessionBusiness
    {
        private readonly DonationSessionData _donationSessionData;
        public DonationSessionBusiness(string connection)
        {
            _donationSessionData = new DonationSessionData(connection);
        }

        public int AddSession(DonationSession session)
        {
            return _donationSessionData.AddSession(session);
        }

    }

}
