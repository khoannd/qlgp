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
        private string connectionString = "";

        public ConfigurationBusiness(string connection)
        {
            _configurationData = new ConfigurationData(connection);
            connectionString = connection;
        }
        public Configuration GetConfigurationByParishId(int parishId)
        {
            return GetConfigurationByParishId(parishId, -1);
        }
        public Configuration GetConfigurationByParishId(int parishId, int roleId)
        {
            var configuration = _configurationData.GetConfigurationByParishId(parishId);
            if(roleId != -1)
            {
                AccountBusiness accountBusiness = new AccountBusiness(connectionString);
                if (accountBusiness.IsDioceseRole(roleId))
                {
                    configuration.ParishionerCodeGeneration = 0;
                }
            }
            
            return configuration;
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
