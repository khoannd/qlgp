using PMS.DataAccess;
using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.BusinessLogic
{
    public class ValueSetBusiness
    {
        private readonly ValueSetData _valueSetData;
        public ValueSetBusiness(string connection)
        {
            _valueSetData = new ValueSetData(connection);
        }

        public IEnumerable<ValueSet> getValueByCategory(string category)
        {
            return _valueSetData.getValueSetByCategory(category);
        }

        public IEnumerable<ValueSet> getAllHDLMRole()
        {
           return _valueSetData.getAllHDLMRole();
        }
    }
}
