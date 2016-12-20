/*
Author: Khoan
Date: 2016/05/29
*/
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.Mvc;

namespace PMS.Web.Utilities
{
    public class PMSCommon
    {
        public static string RenderViewToString(ControllerContext context, string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = context.RouteData.GetRequiredString("action");

            var viewData = new ViewDataDictionary(model);

            using (var sw = new StringWriter())
            {
                var viewResult = ViewEngines.Engines.FindPartialView(context, viewName);
                var viewContext = new ViewContext(context, viewResult.View, viewData, new TempDataDictionary(), sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }
        public static string GetSetting(string key)
        {
            return System.Configuration.ConfigurationManager.AppSettings[key];
        }
        public static bool AllowTransaction()
        {
            string value = GetSetting("AllowTransaction");
            return (value != null && value.Trim().ToLower() == "true");
        }
        public static TransactionScopeOption GetTransactionOption()
        {
            return (AllowTransaction() ? TransactionScopeOption.Required : TransactionScopeOption.Suppress);
        }
    }
}