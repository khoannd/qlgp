using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class ConfigurationData
    {
        private readonly PMSDataContext _db;

        public ConfigurationData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public Configuration GetConfigurationByParishId(int parishId)
        {
            const string query = "SELECT * FROM Configuration WHERE ParishId = {0}";
            return _db.ExecuteQuery<Configuration>(query, parishId).SingleOrDefault();
        }

        public int AddConfiguration(Configuration config)
        {
            try
            {
                _db.Configurations.InsertOnSubmit(config);
                _db.SubmitChanges();
                return config.ParishId;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int CharacterAutoIncreasement(int parishId)
        {
            try
            {
                const string query = "UPDATE Configuration SET ParishionerCharacterNumber = ParishionerCharacterNumber + 1 WHERE ParishId = {0}";
                return _db.ExecuteCommand(query, parishId);
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateConfiguration(Configuration config)
        {
            try
            {
                var item = _db.Configurations.FirstOrDefault(c => c.ParishId == config.ParishId);

                if (item == null)
                {
                    return 0;
                }

                item.MultipleParishionerAdding = config.MultipleParishionerAdding;
                item.ParishionerCodeGeneration = config.ParishionerCodeGeneration;
                item.ParishionerPrefix = config.ParishionerPrefix;
                item.ParishionerCharacterNumber = config.ParishionerCharacterNumber;
                item.FamilyCodeGeneration = config.FamilyCodeGeneration;
                item.FamilyPrefix = config.FamilyPrefix;
                item.FamilyCharacterNumber = config.FamilyCharacterNumber;

                //Template
                item.SacramentTemplate = config.SacramentTemplate;
                item.BaptismTemplate = config.BaptismTemplate;
                item.HolyCommunionTemplate = config.HolyCommunionTemplate;
                item.ConfirmationTemplate = config.ConfirmationTemplate;
                item.MatrimonyTemplate = config.MatrimonyTemplate;


                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

    }
}
