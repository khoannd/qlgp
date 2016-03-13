using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.DataAccess
{
    public class SacramentData
    {
        private readonly PMSDataContext _db;

        public SacramentData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public int CountNumberofOeopleOfSacramentGroupId(int sacramentGroupId)
        {
            const string query = "SELECT Count(S.SacramentGroupId) FROM Sacrament AS S INNER JOIN Parishioner AS P ON S.ParishionerId = P.Id " +
                                 "WHERE S.SacramentGroupId = {0} AND P.Status != {1}";
            return _db.ExecuteQuery<int>(query, sacramentGroupId, (int)ParishionerStatusEnum.Deleted).SingleOrDefault();
        }

        public IEnumerable<Sacrament> GetSacramentsBySacramentGroupId(int sacramentGroupId)
        {
            const string query = "SELECT S.* FROM Parishioner AS P INNER JOIN (Sacrament AS S " +
                                 "INNER JOIN SacramentGroup AS SG ON S.SacramentGroupId = SG.Id) ON P.Id = S.ParishionerId " +
                                 "WHERE SG.Id = {0} AND  P.Status != {1}";
            return _db.ExecuteQuery<Sacrament>(query, sacramentGroupId, (int)ParishionerStatusEnum.Deleted);
        }

        public IEnumerable<Sacrament> GetSacramentsByParishionerId(int parishionerId)
        {
            const string query = "SELECT * " +
                                 "FROM Sacrament " +
                                 "WHERE ParishionerId = {0}";
            return _db.ExecuteQuery<Sacrament>(query, parishionerId);
        }

        public int CheckSacrament(int parishionerId, int type)
        {
            try
            {
                const string query = "SELECT * FROM Sacrament WHERE ParishionerId = {0} AND Type = {1}";
                string unique = _db.ExecuteQuery<string>(query, parishionerId, type).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
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

        public int CheckExistedSacramentGroup(string date, int type, int parishId, int sacramentGroupId)
        {
            try
            {
                var converter = new DateConverter();
                date = converter.ConvertDateToString(date);
                //int iDate = Int32.Parse(date);
                const string query = "SELECT Date " +
                                     "FROM SacramentGroup " +
                                     "WHERE ParishId = {0} AND Type = {1} AND Date = {2} AND Id != {3}";
                string exist = _db.ExecuteQuery<string>(query, parishId, type, date, sacramentGroupId).SingleOrDefault();
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

        public int AddSacrament(Sacrament sacrament)
        {
            try
            {
                _db.Sacraments.InsertOnSubmit(sacrament);
                _db.SubmitChanges();
                return sacrament.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateSacrament(Sacrament sacrament)
        {
            try
            {
                var item = _db.Sacraments.SingleOrDefault(d => d.Id == sacrament.Id);
                if (item == null)
                {
                    return 0;
                }

                // item.ParishionerId = sacrament.ParishionerId;
                item.Number = sacrament.Number;
                item.Patron = sacrament.Patron;
                //  item.Note = sacrament.Note;
                item.Date = sacrament.Date;
                item.Giver = sacrament.Giver;
                item.ReceivedPlace = sacrament.ReceivedPlace;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int DeleteSacrament(int id)
        {
            try
            {
                Sacrament sacrament = _db.Sacraments.SingleOrDefault(s => s.Id == id);

                if (sacrament == null)
                {
                    return 0;
                }

                _db.Sacraments.DeleteOnSubmit(sacrament);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteSacramentFromSacramentGroup(int id)
        {
            try
            {
                Sacrament sacrament = _db.Sacraments.SingleOrDefault(s => s.Id == id);

                if (sacrament == null)
                {
                    return 0;
                }
                //sacrament.SacramentGroupId = null;
                _db.Sacraments.DeleteOnSubmit(sacrament);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateEditableNumber(Sacrament sacrament)
        {
            try
            {
                var item = _db.Sacraments.SingleOrDefault(d => d.Id == sacrament.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Number = sacrament.Number;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int UpdateEditableNote(Sacrament sacrament)
        {
            try
            {
                var item = _db.Sacraments.SingleOrDefault(d => d.Id == sacrament.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Note = sacrament.Note;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
        public int UpdateEditablePatron(Sacrament sacrament)
        {
            try
            {
                var item = _db.Sacraments.SingleOrDefault(d => d.Id == sacrament.Id);
                if (item == null)
                {
                    return 0;
                }
                item.Patron = sacrament.Patron;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }


        public string CheckInvalidParticipants(int sacramentGroupId, string sacramentDate)
        {
            try
            {
                var item = _db.SacramentGroups.FirstOrDefault(s => s.Id == sacramentGroupId);

                if (item == null)
                {
                    return "0";
                }

                var converter = new DateConverter();
                var sDate = converter.ConvertDateToString(sacramentDate);

                if (string.IsNullOrEmpty(sDate))
                {
                    return "0";
                }

                string result = "";
                var sacraments = _db.Sacraments.Where(s => s.SacramentGroupId == sacramentGroupId);
                bool isError = false;

                foreach (var sacrament in sacraments)
                {
                    isError = false;
                    var p = sacrament.Parishioner;
                    var baptism = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);
                    var holy = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.HolyCommunion);
                    var confirmation = p.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Confirmation);

                    if (item.Type == (int)SacramentEnum.Baptism)
                    {
                        if ((!string.IsNullOrEmpty(p.BirthDate.Trim())) &&
                            (String.CompareOrdinal(p.BirthDate, sDate) > 0))
                        {
                            isError = true;
                        }
                        else if ((holy != null) && (!string.IsNullOrEmpty(holy.Date.Trim())) &&
                                 (String.CompareOrdinal(sDate, holy.Date) > 0))
                        {
                            isError = true;
                        }
                        else if ((confirmation != null) && (!string.IsNullOrEmpty(confirmation.Date.Trim())) &&
                                (String.CompareOrdinal(sDate, confirmation.Date) > 0))
                        {
                            isError = true;
                        }
                    }
                    else if (item.Type == (int)SacramentEnum.HolyCommunion)
                    {
                        if ((!string.IsNullOrEmpty(p.BirthDate.Trim())) &&
                            (String.CompareOrdinal(p.BirthDate, sDate) > 0))
                        {
                            isError = true;
                        }
                        else if ((baptism != null) && (!string.IsNullOrEmpty(baptism.Date.Trim())) &&
                                 (String.CompareOrdinal(baptism.Date, sDate) > 0))
                        {
                            isError = true;
                        }
                        else if ((confirmation != null) && (!string.IsNullOrEmpty(confirmation.Date.Trim())) &&
                                (String.CompareOrdinal(sDate, confirmation.Date) > 0))
                        {
                            isError = true;
                        }
                    }
                    else if (item.Type == (int)SacramentEnum.Confirmation)
                    {
                        if ((!string.IsNullOrEmpty(p.BirthDate.Trim())) &&
                          (String.CompareOrdinal(p.BirthDate, sDate) > 0))
                        {
                            isError = true;
                        }
                        else if ((baptism != null) && (!string.IsNullOrEmpty(baptism.Date.Trim())) &&
                                 (String.CompareOrdinal(baptism.Date, sDate) > 0))
                        {
                            isError = true;
                        }
                        else if ((holy != null) && (!string.IsNullOrEmpty(holy.Date.Trim())) &&
                                (String.CompareOrdinal(holy.Date, sDate) > 0))
                        {
                            isError = true;
                        }
                    }

                    if (isError)
                    {
                        if (result.Length == 0)
                        {
                            result += sacrament.Id + "";
                        }
                        else
                        {
                            result += "," + sacrament.Id;
                        }
                    }

                }

                return result;
            }
            catch (Exception)
            {
                return "0";
            }
        }

    }
}
