using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class VocationBusiness
    {
        private readonly VocationData _vocationData;

        public VocationBusiness(string connection)
        {
            _vocationData = new VocationData(connection);    
        }
        public IEnumerable<ValueSet> GetTypeCodes()
        {
            return _vocationData.GetTypeCodes();
        }
        public Vocation GetVocationByParishionerId(int parishionerId)
        {
            var vocation = _vocationData.GetVocationByParishionerId(parishionerId);

            if (vocation == null)
            {
                return null;
            }

            var converter = new DateConverter();
            vocation.Date1 = converter.ConvertStringToDate(vocation.Date1);
            vocation.Date2 = converter.ConvertStringToDate(vocation.Date2);
            vocation.Date3 = converter.ConvertStringToDate(vocation.Date3);
            vocation.Date4 = converter.ConvertStringToDate(vocation.Date4);
            vocation.Date5 = converter.ConvertStringToDate(vocation.Date5);
            vocation.Date6 = converter.ConvertStringToDate(vocation.Date6);
            vocation.Date7 = converter.ConvertStringToDate(vocation.Date7);
            vocation.Date8 = converter.ConvertStringToDate(vocation.Date8);
            vocation.Date9 = converter.ConvertStringToDate(vocation.Date9);

            vocation.ServedStartDate = converter.ConvertStringToDate(vocation.ServedStartDate);

            return vocation;
        }

        public int AddVocation(Vocation vocation)
        {
            return _vocationData.AddVocation(vocation);
        }

        public int UpdateVocation(Vocation vocation)
        {
            return _vocationData.UpdateVocation(vocation);
        }

        public int DeleteVocation(int id)
        {
            return _vocationData.DeleteVocation(id);
        }
    }
}
