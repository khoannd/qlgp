using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class MatrimonyBusiness
    {
        private readonly MatrimonyData _matrimonyData;

        public MatrimonyBusiness(string connection)
        {
            _matrimonyData = new MatrimonyData(connection);
        }

        public List<Matrimony> GetMatrimoniesByParishionerId(int parishionerId)
        {
            return _matrimonyData.GetMatrimoniesByParishionerId(parishionerId).ToList();
        }

        public List<Matrimony> GetMatrimonyBySacramentGroupId(int sacramentGroupId)
        {
            return _matrimonyData.GetMatrimonyBySacramentGroupId(sacramentGroupId).ToList();
        }

        public int AddMatrimony(Matrimony matrimony, string username)
        {
            var converter = new DateConverter();
            matrimony.Date = converter.ConvertDateToString(matrimony.Date);

            return _matrimonyData.AddMatrimony(matrimony, username);
        }

        public int UpdateMatrimony(Matrimony matrimony, string username)
        {
            var converter = new DateConverter();
            matrimony.Date = converter.ConvertDateToString(matrimony.Date);

            return _matrimonyData.UpdateMatrimony(matrimony, username);
        }

        public int DeleteMatrimony(int id, string username)
        {
            return _matrimonyData.DeleteMatrimony(id, username);
        }

        public Matrimony GetMatrimonyById(int id)
        {
            var matrimony = _matrimonyData.GetMatrimonyById(id);
            if (matrimony != null)
            {
                var converter = new DateConverter();
                matrimony.Date = converter.ConvertStringToDate(matrimony.Date);
            }
            return matrimony;
        }

        public int CheckExistedMatrimony(int parishionerId1, int parishionerId2)
        {
            return _matrimonyData.CheckExistedMatrimony(parishionerId1, parishionerId2);
        }

        public int UpdateEditableNumber(Matrimony matrimony)
        {
            return _matrimonyData.UpdateEditableNumber(matrimony);
        }

        public int UpdateEditableFirstWitness(Matrimony matrimony)
        {
            return _matrimonyData.UpdateEditableFirstWitness(matrimony);
        }

        public int UpdateEditableSecondWitness(Matrimony matrimony)
        {
            return _matrimonyData.UpdateEditableSecondWitness(matrimony);
        }

        public int AddSacramentGroupIdForMatrimony(int id, int sacramentGroupId)
        {
            return _matrimonyData.AddSacramentGroupIdForMatrimony(id, sacramentGroupId);
        }

        public int RemoveMatrimonyFromSacramentGroup(int id)
        {
            return _matrimonyData.RemoveMatrimonyFromSacramentGroup(id);
        }
    }
}
