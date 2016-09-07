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
    public class SacramentBusiness
    {
        private readonly SacramentData _sacramentData;

        public SacramentBusiness(string connection)
        {
            _sacramentData = new SacramentData(connection);
        }

        public int AddSacrament(Sacrament sacrament)
        {
            return _sacramentData.AddSacrament(sacrament);
        }

        public int UpdateSacrament(Sacrament sacramemnt)
        {
            return _sacramentData.UpdateSacrament(sacramemnt);
        }

        public int DeleteSacramentFromSacramentGroup(int id)
        {
            return _sacramentData.DeleteSacramentFromSacramentGroup(id);
        }

        public int DeleteSacrament(int id)
        {
            return _sacramentData.DeleteSacrament(id);
        }

        public int CheckSacrament(int parishionerId, int type)
        {
            return _sacramentData.CheckSacrament(parishionerId, type);
        }

        public List<Sacrament> GetSacramentsBySacramentGroupId(int sacramentGroupId)
        {
            return _sacramentData.GetSacramentsBySacramentGroupId(sacramentGroupId).ToList();
        }

        public List<Sacrament> GetSacramentsByParishionerId(int parishionerId)
        {
            var sacraments = _sacramentData.GetSacramentsByParishionerId(parishionerId).ToList();

            var converter = new DateConverter();

            foreach (var item in sacraments)
            {
                item.Date = converter.ConvertStringToDate(item.Date);
            }

            return sacraments;
        }

        public Sacrament GetSacramentsByParishionerIdAndType(int parishionerId, int type)
        {
            return _sacramentData.GetSacramentsByParishionerIdAndType(parishionerId, type);
        }

        public int UpdateEditableNumber(Sacrament sacrament)
        {
            return _sacramentData.UpdateEditableNumber(sacrament);
        }
        public int UpdateEditableNote(Sacrament sacrament)
        {
            return _sacramentData.UpdateEditableNote(sacrament);
        }
        public int UpdateEditablePatron(Sacrament sacrament)
        {
            return _sacramentData.UpdateEditablePatron(sacrament);
        }

        public string CheckInvalidParticipants(int sacramentGroupId, string sacramentDate)
        {
            return _sacramentData.CheckInvalidParticipants(sacramentGroupId, sacramentDate);
        }

    }
}
