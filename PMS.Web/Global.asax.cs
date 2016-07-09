using PMS.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace PMS.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // Don't allow referral some pages from outside
            if (Request.ServerVariables["HTTP_REFERER"] != null)
            {
                Uri uri = new Uri(Request.ServerVariables["HTTP_REFERER"]);
                if (uri.Host != Request.Url.Host)
                {
                    Response.End();
                }
            }
        }
        protected void Application_PreRequestHandlerExecute(object sender, EventArgs e)
        {
            if (Request.QueryString["logout"] != null)
            {
                Session.Clear();
                Session.Abandon();
                Session.RemoveAll();

                if (Request.Cookies["ASP.NET_SessionId"] != null)
                {
                    Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                    Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
                }
                Response.Redirect("/", false);
            }
            if(!isUnauthorizePage() && (Session["AccountId"] == null || string.IsNullOrEmpty(Session["AccountId"].ToString())))
            {
                if ((new HttpRequestWrapper(Request)).IsAjaxRequest())
                {
                    Response.StatusCode = 401;
                    Response.End();
                }
                else
                {
                    Response.Redirect("/", false);
                    Response.End();
                }
            }
        }
        private bool isUnauthorizePage()
        {
            string path = HttpContext.Current.Request.CurrentExecutionFilePath.TrimEnd('/');
            if(path != "")
            {
                Regex regex = new Regex("^(/Account/)(.*)$");
                return regex.IsMatch(path);
            }

            return true;
        }
        protected void Application_PostRequestHandlerExecute(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.Session != null)
            {
                // createa a new GUID and save into the session
                string guid = Guid.NewGuid().ToString();
                HttpContext.Current.Session["SECUREID"] = guid;
                // now create a new cookie with this guid value
                var authCookie = new HttpCookie("SECUREID", guid);
                authCookie.Expires = DateTime.Now.AddDays(365d);
                Response.Cookies.Add(authCookie);
            }
            Response.Headers.Add("X-Frame-Options", "SAMEORIGIN");
        }
    }
}
