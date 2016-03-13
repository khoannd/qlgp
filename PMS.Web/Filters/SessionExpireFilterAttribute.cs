using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace PMS.Web.Filters
{
    public class SessionExpireFilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpContext ctx = HttpContext.Current;

            if (ctx.Session["Username"] == null)
            {
                if (filterContext.HttpContext.Request.IsAjaxRequest())
                {
                    filterContext.Result = new JsonResult {Data = "_Logon_"};
                }
                else
                {
                    filterContext.Result = new RedirectToRouteResult(
                        new RouteValueDictionary
                        {
                            {"Controller", "Account"},
                            {"Action", "TimeoutRedirect"}
                        });
                }
            }
            else
            {
                var url = filterContext.HttpContext.Request.Url;

                var roleId = (int) ctx.Session["RoleId"];

                if (url != null)
                {
                    string path = url.AbsolutePath;
                    //Check phan quyen here
                    var ac = new AuthorizationChecking();

                    var result = ac.CheckValidUrl(url.AbsolutePath, roleId);

                    if (!result)
                    {
                        filterContext.Result = new RedirectToRouteResult(
                        new RouteValueDictionary
                        {
                            {"Controller", "Home"},
                            {"Action", "NotFound"}
                        });
                    }

                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}