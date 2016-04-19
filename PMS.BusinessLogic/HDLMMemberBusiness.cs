using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess;

namespace PMS.BusinessLogic
{
    public class HDLMMemberBusiness
    {
        private readonly HDLMMemberData _hdlmMemberData;
        private readonly HoiDongLinhMucData _hdlmData;
        public HDLMMemberBusiness(string connection)
        {
            _hdlmMemberData = new HDLMMemberData(connection);
            _hdlmData = new HoiDongLinhMucData(connection);
        }

        public int AddMember(HDLMMember member)
        {
            return _hdlmMemberData.AddMember(member);
        }

        public string getMemberRole(int role)
        {
            return _hdlmMemberData.getMemberRole(role);
        }

        public List<HDLMMember> GetMemberByHDLM(int id)
        {
            return _hdlmMemberData.getMemberByHDLM(id).ToList();
        }
    }
}
