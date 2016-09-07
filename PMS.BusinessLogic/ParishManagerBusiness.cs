using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class ParishManagerBusiness
    {
        private readonly ParishManagerData _parishManagerData;

        public ParishManagerBusiness(string connection)
        {
            _parishManagerData = new ParishManagerData(connection);
        }

        public int AddParishManager(ParishManager parishManager)
        {
            return _parishManagerData.AddParishManager(parishManager);
        }

        public int UpdateParishManager(ParishManager parishManager)
        {
            return _parishManagerData.UpdateParishManager(parishManager);
        }

        public int DeleteParishManager(int id)
        {
            return _parishManagerData.DeleteParishManager(id);
        }
        public ParishManager GetParishManagerById(int Id)
        {
            return _parishManagerData.GetParishManagerById(Id);
        }
        public List<ParishManager> GetParishManagerByListId(string Ids)
        {
            return _parishManagerData.GetParishManagerByListId(Ids).ToList();
        }
        public List<ParishManager> GetParishManagerByTCLMId(int idTCLM)
        {
            return _parishManagerData.GetParishManagerByTCLM(idTCLM).ToList();
        }
        public List<ParishManager> GetParishManagerByPriestId(int priestId)
        {
            return _parishManagerData.GetParishManagerByPriestId(priestId).ToList();
        }
        public ParishManager GetParishManagerByPriestIdAndDate(int priestId, string startDate)
        {
            return _parishManagerData.GetParishManagerByPriestIdAndDate(priestId, startDate);
        }
        public bool CheckExistPriest(int idTCLM, int priestID)
        {
            return _parishManagerData.CheckExistPriest(idTCLM, priestID);
        }

        public int UpdateEndDateParishManager(ParishManager parishManager)
        {
            return _parishManagerData.UpdateEndDateParishManager(parishManager);
        }

        public int GetCurrentParishIdByParishManagerId(int parishManagerId)
        {
            return _parishManagerData.GetCurrentParishIdByParishManagerId(parishManagerId);
        }

        public string GetCurrentParishByParishManagerId(int parishManagerId)
        {
            return _parishManagerData.GetCurrentParishByParishManagerId(parishManagerId);
        }
        public int UpdateEditableCode(ParishManager parishManager)
        {
            return _parishManagerData.UpdateEditableCode(parishManager);
        }
    }
}
