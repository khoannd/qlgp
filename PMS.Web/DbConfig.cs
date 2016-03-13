using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace PMS.Web
{
    public static class DbConfig
    {
        private static readonly string ConnectionString = WebConfigurationManager.ConnectionStrings["PMSConnectionString"].ConnectionString;

        public static string GetConnectionString()
        {
            return ConnectionString;
        }

    }
}