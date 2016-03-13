using System.Web;
using System.Web.Mvc;
using PMS.Web.Filters;

namespace PMS.Web
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());          
        }
    }
}
