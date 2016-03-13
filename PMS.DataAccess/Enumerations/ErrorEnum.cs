using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.Enumerations
{
    public enum CommonErrorEnum
    {
        Exception = -1,
        None = 0
    }

    public enum UserErrorEnum
    {       
        NotExisted = 1,
        Deactive = 2,
    }

}
