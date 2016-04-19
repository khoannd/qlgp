using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class ValueSetData
    {
        private const string categoryHDLM = "HDLM";
        private readonly PMSDataContext _db;
        public ValueSetData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public IEnumerable<ValueSet> getValueSetByCategory(string category)
        {
            const string query = "SELECT Id, Code, CAST(Definition AS NVARCHAR(100)) Definition, Note, Category FROM ValueSet WHERE Category LIKE {0} ORDER BY Definition";
            return _db.ExecuteQuery<ValueSet>(query, category);
        }

        public IEnumerable<ValueSet> getAllHDLMRole()
        {
            const string query = "SELECT * FROM ValueSet WHERE Category = {0}";
            return _db.ExecuteQuery<ValueSet>(query, categoryHDLM);
        }
    }
}
