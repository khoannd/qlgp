using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PMS.BusinessLogic;
using PMS.DataAccess.Models;
using PMS.Web.Filters;

namespace PMS.Web.Controllers
{
    public class ConfigurationController : Controller
    {
        //
        // GET: /Configuration/

        private readonly ConfigurationBusiness _configurationBusiness;

        public ConfigurationController()
        {
            _configurationBusiness = new ConfigurationBusiness(DbConfig.GetConnectionString());
        }

        [SessionExpireFilter]
        public ActionResult Index()
        {
            int parishId = (int) Session["ParishId"];

            var config = _configurationBusiness.GetConfigurationByParishId(parishId);

            return View(config);
        }

        [SessionExpireFilter]
        public ActionResult PreviewTemplate()
        {
            return View();
        }

        [ValidateInput(false)]
        public int UpdateConfiguration(Configuration config)
        {
            int parishId = (int) Session["ParishId"];
            config.ParishId = parishId;

            return _configurationBusiness.UpdateConfiguration(config);
        }

	}
}