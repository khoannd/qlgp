using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
     public class DioceseBusiness
     {
         private readonly DioceseData _dioceseData;

         public DioceseBusiness(string connection)
         {
             _dioceseData = new DioceseData(connection);
         }

         public Diocese GetDiocesesByDioceseId(int dioceseId)
         {
             return _dioceseData.GetDiocesesByDioceseId(dioceseId);
         }

        public Diocese GetDefaultDiocese()
        {
            return _dioceseData.GetDefaultDiocese();
        }

        public List<Diocese> GetAllDioceses()
        {
            return _dioceseData.GetAllDioceses();
        }

        public int UpdateDiocese(Diocese diocese)
         {
             return _dioceseData.UpdateDiocese(diocese);
         }

         public int CheckUniqueDiocese(string name, int id)
         {
             return _dioceseData.CheckUniqueDiocese(name, id);
         }

         public string GetImageUrlByDioceseId(int dioceseId)
         {
             return _dioceseData.GetImageUrlByDioceseId(dioceseId);
         }
     }
}
