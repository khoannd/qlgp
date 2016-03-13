using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;

namespace PMS.BusinessLogic
{
    public class PlaceBusiness
    {
        private readonly PlaceData _placeData;

        public PlaceBusiness(string connection)
        {
            _placeData = new PlaceData(connection);
        }

        public List<string> GetPlacesByName(string name)
        {
            return _placeData.GetPlacesByName(name).ToList();
        }
    }
}
