using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class HDLMMemberData
    {
        private readonly PMSDataContext _db;

        public HDLMMemberData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<HDLMMember> GetAllHDLM()
        {
            const string query = "SELECT * FROM HDLMMember WHERE Role = 1";
            return _db.ExecuteQuery<HDLMMember>(query);
        }

        public int AddMember(HDLMMember member)
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

                _db.HDLMMembers.InsertOnSubmit(member);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public string getMemberRole(int Role)
        {
            string hdlmCate = "HDLM";
            const string query = "SELECT Definition FROM ValueSet WHERE Category = {0} and Code = {1}";
            return _db.ExecuteQuery<string>(query, hdlmCate, Role).FirstOrDefault();

        }

        public IEnumerable<HDLMMember> getMemberByHDLM(int id)
        {
            const string query = @"SELECT * FROM HDLMMember WHERE HdlmID = {0}";
            return _db.ExecuteQuery<HDLMMember>(query, id);
        }


    }
}
