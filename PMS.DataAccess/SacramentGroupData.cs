using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class SacramentGroupData
    {
        private readonly PMSDataContext _db;

        public SacramentGroupData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<SacramentGroup> GetSacramentGroupByType(int type, int parishId)
        {
            const string query = "SELECT * FROM SacramentGroup " +
                                 "WHERE Type = {0} AND ParishId = {1}";
            return _db.ExecuteQuery<SacramentGroup>(query, type, parishId);
        }

        public IEnumerable<SacramentGroup> GetSacramentGroupsById(int id)
        {
            const string query = "SELECT * FROM SacramentGroup WHERE Id = {0}";
            return _db.ExecuteQuery<SacramentGroup>(query, id);
        }

        public int AddSaracmentGroup(SacramentGroup sacramentGroup)
        {
            try
            {
                _db.SacramentGroups.InsertOnSubmit(sacramentGroup);
                _db.SubmitChanges();
                return sacramentGroup.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int UpdateSacramentGroup(SacramentGroup sacramentGroup)
        {
            try
            {
                var item = _db.SacramentGroups.SingleOrDefault(d => d.Id == sacramentGroup.Id);
                if (item == null)
                {
                    return 0;
                }

                //Lay ra thong tin nhung nguoi tham gia va thay doi
                var sacraments = _db.Sacraments.Where(s => s.SacramentGroupId == sacramentGroup.Id);

                foreach (var sacrament in sacraments)
                {
                    sacrament.Date = sacramentGroup.Date;
                    sacrament.Giver = sacramentGroup.Giver;
                    sacrament.ReceivedPlace = sacramentGroup.ReceivedPlace;
                }

                item.Date = sacramentGroup.Date;
                item.Type = sacramentGroup.Type;
                item.Description = sacramentGroup.Description;
                item.Giver = sacramentGroup.Giver;
                item.ReceivedPlace = sacramentGroup.ReceivedPlace;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int DeleteSacramentGroup(int id)
        {
            try
            {
                
                int count =
                    _db.Sacraments.Count(
                        s => s.SacramentGroupId == id && (s.Parishioner.Status != ((int) ParishionerStatusEnum.Deleted)));
                if (count == 0)
                {
                    var sacrament = _db.Sacraments.Where(s => s.SacramentGroupId == id);
                    foreach (var item in sacrament)
                    {
                        _db.Sacraments.DeleteOnSubmit(item);
                    }
                }

                SacramentGroup sacramentGroup = _db.SacramentGroups.SingleOrDefault(s => s.Id == id);
                if (sacramentGroup == null)
                {
                    return 0;
                }

                _db.SacramentGroups.DeleteOnSubmit(sacramentGroup);
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
