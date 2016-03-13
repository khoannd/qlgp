using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;

namespace PMS.BusinessLogic
{
    public class ConfigurationBusiness
    {
        private readonly ConfigurationData _configurationData;

        public ConfigurationBusiness(string connection)
        {
            _configurationData = new ConfigurationData(connection);
        }

        public Configuration GetConfigurationByParishId(int parishId)
        {
            return _configurationData.GetConfigurationByParishId(parishId);
        }

        public int AddConfiguration(Configuration config)
        {
            return _configurationData.AddConfiguration(config);
        }

        public int CharacterAutoIncreasement(int parishId)
        {
            return _configurationData.CharacterAutoIncreasement(parishId);
        }

        public int UpdateConfiguration(Configuration config)
        {
            return _configurationData.UpdateConfiguration(config);
        }

    }
}
