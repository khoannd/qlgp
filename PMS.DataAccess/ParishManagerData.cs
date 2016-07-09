using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class ParishManagerData
    {
        private readonly PMSDataContext _db;

        public ParishManagerData(string connection)
        {
            _db = new PMSDataContext(connection);
        }
        public ParishManager GetParishManagerById(int Id)
        {
            const string query = @" select ParishManager.*
                                    from ParishManager
                                    where ParishManager.Id = {0}
                                ";
            return _db.ExecuteQuery<ParishManager>(query, Id).SingleOrDefault();
        }
        public IEnumerable<ParishManager> GetParishManagerByListId(string Ids)
        {
            try
            {
                string query = @"   select ParishManager.*
                                from ParishManager
                                where ',{0},' like '%,'+convert(varchar,ParishManager.Id)+',%'
                            ";
                query = string.Format(query, Ids);
                return _db.ExecuteQuery<ParishManager>(query);
            }
            catch
            {
                return null;
            }
        }
        public IEnumerable<ParishManager> GetParishManagerByTCLM(int idTCLM)
        {
            const string query = @" select ParishManager.*,
                                    case
                                        when Position is null then 3
                                        else Position
                                    end PositionSort
                                    from ParishManager
                                        join ThuyenChuyenLinhMuc on ThuyenChuyenLinhMuc.Id = ParishManager.IdThuyenChuyenLinhMuc
                                        left join Parish on Parish.Id = ParishManager.ParishId
                                    where ThuyenChuyenLinhMuc.Id = {0}
                                    order by Parish.Name, PositionSort
                                ";
            return _db.ExecuteQuery<ParishManager>(query, idTCLM);
        }
        public IEnumerable<ParishManager> GetParishManagerByPriestId(int priestId)
        {
            const string query = @" select ParishManager.*
                                    from ParishManager
                                    where ParishManager.PriestId = {0}
                                    order by ParishManager.StartDate
                                ";
            return _db.ExecuteQuery<ParishManager>(query, priestId);
        } 
        public int CheckExistedParishManager(string date, int parishId, int priestId, int idTCLM)
        {
            try
            {
                var converter = new DateConverter();
                date = converter.ConvertDateToString(date);
                //int iDate = Int32.Parse(date);
                const string query = @"SELECT *
                                     FROM ParishManager
                                     WHERE ParishId = {0} AND PriestId = {1} AND Date = {2} AND Id != {3}";
                string exist = _db.ExecuteQuery<string>(query, parishId, priestId, date, idTCLM).SingleOrDefault();
                if (string.IsNullOrEmpty(exist))
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int AddParishManager(ParishManager parishManager)
        {
            try
            {
                _db.ParishManagers.InsertOnSubmit(parishManager);
                _db.SubmitChanges();
                UpdateEndDateParishManager(parishManager);
                return parishManager.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public void UpdateEndDateParishManager(ParishManager parishManager)
        {
            try
            {                
                ParishManager prePM = _db.ExecuteQuery<ParishManager>("select top 1 * from ParishManager where Id <> {0} and PriestId = {1} order by StartDate, Id desc", parishManager.Id, parishManager.PriestId).FirstOrDefault();
                if (prePM != null)
                {
                    prePM.EndDate = parishManager.StartDate;
                    _db.SubmitChanges();
                }
            }
            catch (Exception e)
            {
            }
        }

        public int UpdateParishManager(ParishManager parishManager)
        {
            try
            {
                var item = _db.ParishManagers.SingleOrDefault(d => d.Id == parishManager.Id);
                if (item == null)
                {
                    return 0;
                }

                item.ParishId = parishManager.ParishId;
                item.PriestId = parishManager.PriestId;
                item.StartDate = parishManager.StartDate;
                item.EndDate = parishManager.EndDate;
                item.Position = parishManager.Position;
                item.PositionName = parishManager.PositionName;
                item.IdThuyenChuyenLinhMuc = parishManager.IdThuyenChuyenLinhMuc;

                if(parishManager.ParishId != null && parishManager.ParishId != 0 
                    && parishManager.Position == 1
                    && parishManager.StatusId == (int)ParishManagerStatusEnum.DaNhanNhiemVu)
                {
                    var parishOld = _db.Parishes.SingleOrDefault(d => d.PriestId == parishManager.PriestId && d.Id != parishManager.ParishId);
                    if(parishOld!=null)
                    {
                        parishOld.PriestId = null;
                        parishOld.Priest = "";
                    }

                    var parish = _db.Parishes.SingleOrDefault(d => d.Id == parishManager.ParishId);
                    if (parish == null)
                    {
                        return 0;
                    }

                    parish.Priest = item.Priest.ChristianName + " " + item.Priest.Name;
                    parish.PriestId = item.PriestId;
                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int DeleteParishManager(int id)
        {
            try
            {
                ParishManager parishManager = _db.ParishManagers.SingleOrDefault(s => s.Id == id);

                if (parishManager == null)
                {
                    return 0;
                }

                _db.ParishManagers.DeleteOnSubmit(parishManager);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public bool CheckExistPriest(int idTCLM, int priestID)
        {
            try
            {
                ParishManager parishManager = _db.ParishManagers.SingleOrDefault(s => s.IdThuyenChuyenLinhMuc == idTCLM && s.PriestId == priestID);
                if (parishManager == null)
                {
                    return false;
                }
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public int GetCurrentParishIdByParishManagerId(int parishManagerId)
        {
            try
            {
                string query = @"
                                    select  top 1 Parish.* 
                                    from    ParishManager
                                        join Parish on Parish.Id = ParishManager.ParishId
                                        join ParishManager PM on PM.PriestId = ParishManager.PriestId                                        
                                    where   PM.Id = {0}
                                    and		ParishManager.Id <> {0}
                                    and     isnull(ParishManager.ParishId,'') <> ''
                                    and     ParishManager.StartDate < PM.StartDate
                                    order by ParishManager.Id desc
                                ";
                Parish parish = _db.ExecuteQuery<Parish>(query, parishManagerId).FirstOrDefault();
                if (parish != null)
                {
                    return parish.Id;
                }
                return 0;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public string GetCurrentParishByParishManagerId(int parishManagerId)
        {
            try
            {
                string query = @"
                                    select  top 1 Parish.* 
                                    from    ParishManager
                                        join Parish on Parish.Id = ParishManager.ParishId
										join ParishManager PM on PM.PriestId = ParishManager.PriestId
                                    where   PM.Id = {0}
                                    and		ParishManager.Id <> {0}
                                    and     isnull(ParishManager.ParishId,'') <> ''
                                    and     ParishManager.StartDate < PM.StartDate
                                    order by ParishManager.Id desc
                                ";
                Parish parish = _db.ExecuteQuery<Parish>(query, parishManagerId).FirstOrDefault();
                if (parish != null)
                {
                    return parish.Name;
                }
                return string.Empty;
            }
            catch (Exception e)
            {
                return string.Empty;
            }
        }

        public int UpdateEditableCode(ParishManager parishManager)
        {
            try
            {
                var item = _db.ParishManagers.SingleOrDefault(d => d.Id == parishManager.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Code = parishManager.Code;
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
