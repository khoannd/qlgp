using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.Enumerations
{
    public enum ActionEnum
    {
        View = 1,
        Create = 2,
        LoadForUpdate = 2,
        Update = 3,
        Delete = 4,
        Login = 5
    }

}
