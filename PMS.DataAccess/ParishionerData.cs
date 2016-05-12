using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class ParishionerData
    {
        private readonly PMSDataContext _db;

        public ParishionerData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersByParishId(int parishId, bool? isCounted,
            int status, int gender)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND Pa.IsCounted = {1}";

                    return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {3}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, status, gender);
                    }


                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND Pa.IsCounted = {1}";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                 "WHERE P.Id = {0} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0}";

                    return _db.ExecuteQuery<Parishioner>(query, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {0} AND Pa.Gender = {2}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, parishId, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                             "SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                             "ON PMR.FromCommunityId = C.Id " +
                             "WHERE C.ParishId = {0}";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, status);
                }
            }

        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersByCommunityId(int communityId, bool? isCounted,
            int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                                     "FROM Parishioner AS Pa INNER JOIN Community AS C " +
                                     "ON Pa.CommunityId = C.Id " +
                                     "WHERE (Pa.CommunityId = {0} OR C.ParentId = {0}) AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0}) AND Pa.IsCounted = {1} AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0}) AND Pa.IsCounted = {1}";

                    return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        //
                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0}) AND Pa.IsCounted = {1} AND Pa.Gender = {3}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0}) AND Pa.IsCounted = {1}";
                    }
                    return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                                     "FROM Parishioner AS Pa INNER JOIN Community AS C " +
                                     "ON Pa.CommunityId = C.Id " +
                                     "WHERE (Pa.CommunityId = {0} OR C.ParentId = {0}) ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0}) AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0})";

                    return _db.ExecuteQuery<Parishioner>(query, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0}) AND Pa.Gender = {2}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, communityId, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                             "SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                             "ON PMR.FromCommunityId = C.Id " +
                             "WHERE (PMR.FromCommunityId = {0} OR C.ParentId = {0})";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, communityId, status);
                }
            }
        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersByParishDivisionId(int parishDivisionId, bool? isCounted,
            int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                                    "FROM Parishioner AS Pa " +
                                    "WHERE Pa.CommunityId = {0} AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        //Lay them nguoi da chuyen di
                        query += " UNION " +
                                 " SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId " +
                                 "WHERE PMR.FromCommunityId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {4}";
                        //---------------------------

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    //Lay them nguoi da chuyen di
                    query += " UNION " +
                                 " SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId " +
                                 "WHERE PMR.FromCommunityId = {0} AND Pa.IsCounted = {1}";
                    //---------------------------

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            //Lay them nguoi da chuyen di
                            query += " UNION " +
                                 " SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId " +
                                 "WHERE PMR.FromCommunityId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {3}";
                            //---------------------------
                        }

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        //Lay them nguoi da chuyen di
                        query += " UNION " +
                             " SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId " +
                             "WHERE PMR.FromCommunityId = {0} AND Pa.IsCounted = {1}";
                        //---------------------------
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                                    "FROM Parishioner AS Pa " +
                                    "WHERE Pa.CommunityId = {0} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        //Lay them nguoi da chuyen di
                        query += " UNION " +
                                 " SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId " +
                                 "WHERE PMR.FromCommunityId = {0} AND Pa.Gender = {3}";
                        //---------------------------

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    //Lay them nguoi da chuyen di
                    query += " UNION " +
                             " SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId " +
                             "WHERE PMR.FromCommunityId = {0}";
                    //---------------------------

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            //Lay them nguoi da chuyen di
                            query += " UNION " +
                                 " SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId " +
                                 "WHERE PMR.FromCommunityId = {0} AND Pa.Gender = {2}";
                            //---------------------------
                        }

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        //Lay them nguoi da chuyen di
                        query += " UNION " +
                             " SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId " +
                             "WHERE PMR.FromCommunityId = {0}";
                        //---------------------------
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, status);
                }
            }

        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersByVicariateId(int vicariateId, bool? isCounted,
            int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                               "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) " +
                               "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                               "WHERE V.Id = {0} AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, vicariateId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND Pa.IsCounted = {1}";

                    return _db.ExecuteQuery<Parishioner>(query, vicariateId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {3}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, vicariateId, isCounted, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND Pa.IsCounted = {1}";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, vicariateId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                               "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) " +
                               "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                               "WHERE V.Id = {0} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0} AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, vicariateId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "WHERE P.VicariateId = {0}";

                    return _db.ExecuteQuery<Parishioner>(query, vicariateId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                "SELECT Pa.* " +
                                "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                "WHERE P.VicariateId = {0} AND Pa.Gender = {2}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, vicariateId, status, gender);
                    }


                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                                "SELECT Pa.* " +
                                "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                "WHERE P.VicariateId = {0}";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, vicariateId, status);
                }
            }

        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersByDioceseId(int dioceseId, bool? isCounted,
            int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                           "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN " +
                           "(Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id) " +
                           "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                           "WHERE D.Id = {0} AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, dioceseId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND Pa.IsCounted = {1}";

                    return _db.ExecuteQuery<Parishioner>(query, dioceseId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND Pa.IsCounted = {1} AND Pa.Gender = {3}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, dioceseId, isCounted, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND Pa.IsCounted = {1}";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, dioceseId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                           "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN " +
                           "(Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id) " +
                           "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                           "WHERE D.Id = {0} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, dioceseId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0}";

                    return _db.ExecuteQuery<Parishioner>(query, dioceseId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        if (status == (int)ParishionerStatusEnum.Saved)
                        {
                            query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                                 "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                                 "WHERE V.DioceseId = {0} AND Pa.Gender = {2}";
                        }

                        return _db.ExecuteQuery<Parishioner>(query, dioceseId, status, gender);
                    }

                    if (status == (int)ParishionerStatusEnum.Saved)
                    {
                        query += " UNION " +
                             "SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                             "ON PMR.FromCommunityId = C.Id INNER JOIN Parish AS P ON C.ParishId = P.Id " +
                             "INNER JOIN Vicariate AS V ON P.VicariateId = V.Id " +
                             "WHERE V.DioceseId = {0}";
                    }

                    return _db.ExecuteQuery<Parishioner>(query, dioceseId, status);
                }
            }

        }

        //------------------
        public IEnumerable<Parishioner> GetCheckingParishionersByParishDivisionId(int parishDivisionId, bool? isCounted,
            int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                                    "FROM Parishioner AS Pa " +
                                    "WHERE Pa.CommunityId = {0} AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                                    "FROM Parishioner AS Pa " +
                                    "WHERE Pa.CommunityId = {0} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishDivisionId, status);
                }
            }

        }

        public IEnumerable<Parishioner> GetCheckingParishionersByCommunityId(int communityId, bool? isCounted,
            int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                                     "FROM Parishioner AS Pa INNER JOIN Community AS C " +
                                     "ON Pa.CommunityId = C.Id " +
                                     "WHERE (Pa.CommunityId = {0} OR C.ParentId = {0}) AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, communityId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                                     "FROM Parishioner AS Pa INNER JOIN Community AS C " +
                                     "ON Pa.CommunityId = C.Id " +
                                     "WHERE (Pa.CommunityId = {0} OR C.ParentId = {0}) ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        return _db.ExecuteQuery<Parishioner>(query, communityId, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, communityId, status);
                }
            }
        }

        public IEnumerable<Parishioner> GetCheckingParishionersByParishId(int parishId, bool? isCounted,
            int status, int gender)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND Pa.IsCounted = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                 "WHERE P.Id = {0} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {1} OR Pa.Status = {2}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {1} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {2}";

                        return _db.ExecuteQuery<Parishioner>(query, parishId, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, status);
                }
            }

        }

        public string GetErrorByParishionerId(int parishionerId,
            bool noBirthDate, bool wrongDate, bool earlyCommunion, bool manyMatrimony,
            bool enoughMatrimony, bool noMatrimonyDate, bool noFamily, bool manyFamily)
        {

            string error = "";
            var parishioner = _db.Parishioners.FirstOrDefault(p => p.Id == parishionerId);
            int delimeter = 0;

            if (parishioner == null)
            {
                return "";
            }

            if (noBirthDate)
            {
                var birthDate = parishioner.BirthDate.Trim();

                if (string.IsNullOrEmpty(birthDate))
                {
                    error += "Không có ngày sinh";
                    delimeter = 1;
                }
            }

            if (wrongDate)
            {
                var birthDate = parishioner.BirthDate.Trim();
                var baptism = parishioner.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);
                var communion = parishioner.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.HolyCommunion);
                var confirmation = parishioner.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Confirmation);

                if (baptism != null)
                {
                    var baptismDate = baptism.Date.Trim();

                    if (!string.IsNullOrEmpty(baptismDate))
                    {

                        //Baptism Date
                        int bDate = Int32.Parse(baptismDate);

                        if (!string.IsNullOrEmpty(birthDate))
                        {
                            int biDate = Int32.Parse(birthDate);

                            if (biDate > bDate)
                            {
                                if (delimeter == 1)
                                {
                                    error += " - ";
                                }

                                error += "Ngày sinh lớn hơn ngày rửa tội";
                                delimeter = 1;
                            }
                        }

                        if (communion != null)
                        {
                            var communionDate = communion.Date.Trim();

                            if (!string.IsNullOrEmpty(communionDate))
                            {
                                //Communion Date
                                int cDate = Int32.Parse(communionDate);

                                if (bDate > cDate)
                                {
                                    if (delimeter == 1)
                                    {
                                        error += " - ";
                                    }

                                    error += "Ngày rửa tội lớn hơn ngày xưng tội rước lễ";
                                    delimeter = 1;
                                }
                            }
                        }

                        if (confirmation != null)
                        {
                            var confirmationDate = confirmation.Date.Trim();

                            if (!string.IsNullOrEmpty(confirmationDate))
                            {
                                //Confirmation Date
                                int coDate = Int32.Parse(confirmationDate);

                                if (bDate > coDate)
                                {
                                    if (delimeter == 1)
                                    {
                                        error += " - ";
                                    }

                                    error += "Ngày rửa tội lớn hơn ngày thêm sức";
                                    delimeter = 1;
                                }
                            }
                        }


                    }
                }

                //---------------
                if (communion != null)
                {
                    var communionDate = communion.Date.Trim();

                    if (!string.IsNullOrEmpty(communionDate))
                    {

                        //Communion Date
                        int cDate = Int32.Parse(communionDate);

                        if (!string.IsNullOrEmpty(birthDate))
                        {
                            int biDate = Int32.Parse(birthDate);

                            if (biDate > cDate)
                            {
                                if (delimeter == 1)
                                {
                                    error += " - ";
                                }

                                error += "Ngày sinh lớn hơn ngày xưng tội rước lễ";
                                delimeter = 1;
                            }
                        }

                        if (confirmation != null)
                        {
                            var confirmationDate = confirmation.Date.Trim();

                            if (!string.IsNullOrEmpty(confirmationDate))
                            {
                                //Confirmation Date
                                int coDate = Int32.Parse(confirmationDate);

                                if (cDate > coDate)
                                {
                                    if (delimeter == 1)
                                    {
                                        error += " - ";
                                    }

                                    error += "Ngày xưng tội rước lễ lớn hơn ngày thêm sức";
                                    delimeter = 1;
                                }
                            }
                        }
                    }
                }

                //-------------
                if (confirmation != null)
                {
                    var confirmationDate = confirmation.Date.Trim();

                    if (!string.IsNullOrEmpty(confirmationDate))
                    {
                        //Confirmation Date
                        int coDate = Int32.Parse(confirmationDate);

                        if (!string.IsNullOrEmpty(birthDate))
                        {
                            int biDate = Int32.Parse(birthDate);

                            if (biDate > coDate)
                            {
                                if (delimeter == 1)
                                {
                                    error += " - ";
                                }

                                error += "Ngày sinh lớn hơn ngày thêm sức";
                                delimeter = 1;
                            }
                        }

                    }
                }
            }

            if (earlyCommunion)
            {
                var birthDate = parishioner.BirthDate.Trim();

                if (!string.IsNullOrEmpty(birthDate))
                {
                    var communion = parishioner.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.HolyCommunion);
                    if (communion != null)
                    {
                        var communionDate = communion.Date.Trim();

                        if (!string.IsNullOrEmpty(communionDate))
                        {

                            //Communion Date
                            int cDate = Int32.Parse(communionDate);

                            int biDate = Int32.Parse(birthDate);

                            var time = cDate - biDate;

                            if (time < 70000)
                            {
                                if (delimeter == 1)
                                {
                                    error += " - ";
                                }

                                error += "Rước lễ trước 7 tuổi";
                                delimeter = 1;
                            }
                        }
                    }
                }

            }

            if (manyMatrimony)
            {
                int count = 0;

                if (parishioner.Gender == 0)
                {
                    count = _db.Matrimonies.Count(m => (m.WifeId == parishioner.Id &&
                                                                         ((!m.Parishioner.IsDead) &&
                                                                         m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted &&
                                                                         m.Status != (int)MatrimonyStatusEnum.Removed)));
                }
                else
                {
                    count = _db.Matrimonies.Count(m => (m.HusbandId == parishioner.Id &&
                                                                         ((!m.Parishioner1.IsDead) &&
                                                                         m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted &&
                                                                         m.Status != (int)MatrimonyStatusEnum.Removed)));
                }

                if (count > 1)
                {
                    if (delimeter == 1)
                    {
                        error += " - ";
                    }

                    error += "Có nhiều thông tin hôn phối";
                    delimeter = 1;
                }
            }

            if (enoughMatrimony)
            {
                var birthDate = parishioner.BirthDate.Trim();
                //Co xet isMarried ko ?
                if (!string.IsNullOrEmpty(birthDate))
                {
                    var item = _db.Matrimonies.FirstOrDefault(m => (m.HusbandId == parishionerId || m.WifeId == parishionerId));

                    if (item != null)
                    {
                        var now = Int32.Parse(DateTime.Now.ToString("yyyyMMdd"));
                        int biDate = Int32.Parse(birthDate);

                        var time = now - biDate;

                        if (parishioner.Gender == 0 && time < 180000)
                        {
                            if (delimeter == 1)
                            {
                                error += " - ";
                            }

                            error += "Hôn phối trước 18 tuổi";
                            delimeter = 1;
                        }
                        else if (parishioner.Gender == 1 && time < 200000)
                        {
                            if (delimeter == 1)
                            {
                                error += " - ";
                            }

                            error += "Hôn phối trước 20 tuổi";
                            delimeter = 1;
                        }
                    }
                }
            }

            if (noMatrimonyDate)
            {
                var item = _db.Matrimonies.FirstOrDefault(m => ((m.HusbandId == parishionerId || m.WifeId == parishionerId) && m.Date.Trim() == ""));

                if (item != null)
                {
                    if (delimeter == 1)
                    {
                        error += " - ";
                    }

                    error += "Không có ngày hôn phối";
                    delimeter = 1;
                }
            }

            if (noFamily)
            {
                //Chua tung thuoc gia dinh nao
                var item =
                    _db.FamilyMembers.FirstOrDefault(
                        fm => (fm.ParishionerId == parishionerId));

                if (item == null)
                {
                    if (delimeter == 1)
                    {
                        error += " - ";
                    }

                    error += "Không thuộc gia đình nào";
                    delimeter = 1;
                }

            }

            if (manyFamily)
            {
                var count =
                   _db.FamilyMembers.Count(fm => fm.ParishionerId == parishionerId);

                if (count > 1)
                {
                    if (delimeter == 1)
                    {
                        error += " - ";
                    }

                    error += "Có nhiều thông tin gia đình";
                    delimeter = 1;
                }
            }

            return error;
        }
        //------------------

        public IEnumerable<Parishioner> GetNotSacramentParishionersByParishDivisionId(int sacramentType, int parishDivisionId,
            bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                     "FROM Parishioner AS Pa LEFT JOIN " +
                     "(SELECT Pa.Id, S.Type " +
                     "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                     "ON Pa.Id = S.ParishionerId " +
                     "WHERE S.Type = {0}) AS R " +
                     "ON Pa.Id = R.Id " +
                     "WHERE R.Type IS NULL AND Pa.CommunityId = {1} AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                     "FROM Parishioner AS Pa LEFT JOIN " +
                     "(SELECT Pa.Id, S.Type " +
                     "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                     "ON Pa.Id = S.ParishionerId " +
                     "WHERE S.Type = {0}) AS R " +
                     "ON Pa.Id = R.Id " +
                     "WHERE R.Type IS NULL AND Pa.CommunityId = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";


                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishDivisionId, status);
                }

            }

        }

        public IEnumerable<Parishioner> GetNotSacramentParishionersByCommunityId(int sacramentType, int communityId,
           bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id LEFT JOIN " +
                    "(SELECT Pa.Id, S.Type " +
                    "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0}) AS R " +
                    "ON Pa.Id = R.Id " +
                    "WHERE R.Type IS NULL AND (Pa.CommunityId = {1} OR C.ParentId = {1}) AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.* " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id LEFT JOIN " +
                    "(SELECT Pa.Id, S.Type " +
                    "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0}) AS R " +
                    "ON Pa.Id = R.Id " +
                    "WHERE R.Type IS NULL AND (Pa.CommunityId = {1} OR C.ParentId = {1}) ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, communityId, status);
                }

            }

        }

        public IEnumerable<Parishioner> GetNotSacramentParishionersByParishId(int sacramentType, int parishId,
           bool? isCounted, int status, int gender)
        {

            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.* " +
                    "FROM Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id LEFT JOIN " +
                    "(SELECT Pa.Id, S.Type " +
                    "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0}) AS R " +
                    "ON Pa.Id = R.Id " +
                    "WHERE R.Type IS NULL AND P.Id = {1} AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";

                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, isCounted, status);
                }

            }
            else
            {
                string query = "SELECT Pa.* " +
                    "FROM Parishioner AS Pa INNER JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id LEFT JOIN " +
                    "(SELECT Pa.Id, S.Type " +
                    "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0}) AS R " +
                    "ON Pa.Id = R.Id " +
                    "WHERE R.Type IS NULL AND P.Id = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, sacramentType, parishId, status);
                }

            }

        }

        public IEnumerable<Parishioner> GetInsideParishionersByName(int parishId, string name, int gender, bool? isCounted, int status)
        {

            name = name.Trim();

            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.Id, Pa.ChristianName, Pa.Name, Pa.BirthDate " +
                                 "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND Pa.IsCounted = {1} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";
                        return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, "%" + name + "%",
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, "%" + name + "%",
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, "%" + name + "%", status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, isCounted, "%" + name + "%", status);
                }
            }
            else
            {
                string query = "SELECT Pa.Id, Pa.ChristianName, Pa.Name, Pa.BirthDate " +
                                 "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND (Pa.ChristianName + ' ' + Pa.Name) LIKE {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<Parishioner>(query, parishId, "%" + name + "%",
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, "%" + name + "%",
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<Parishioner>(query, parishId, "%" + name + "%", status, gender);
                    }

                    return _db.ExecuteQuery<Parishioner>(query, parishId, "%" + name + "%", status);
                }
            }

        }

        public IEnumerable<ParishionerViewModel> GetParishionerViewModelsBySacramentTypeAndParishDivisionId(int parishDivisionId,
            int sacramentType, bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id " +
                    "INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0} AND Pa.CommunityId = {1} AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);

                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id " +
                    "INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0} AND Pa.CommunityId = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishDivisionId, status);
                }
            }
        }

        public IEnumerable<ParishionerViewModel> GetParishionerViewModelsBySacramentTypeAndCommunityId(int communityId,
            int sacramentType, bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id " +
                    "INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0} AND (Pa.CommunityId = {1} OR C.ParentId = {1}) AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);

                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id " +
                    "INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0} AND (Pa.CommunityId = {1} OR C.ParentId = {1}) ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, communityId, status);
                }
            }
        }

        public IEnumerable<ParishionerViewModel> GetParishionerViewModelsBySacramentTypeAndParishId(int parishId,
            int sacramentType, bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                    "WHERE S.Type = {0} AND P.Id = {1} AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);

                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                   "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                   "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                   "WHERE S.Type = {0} AND P.Id = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, parishId, status);
                }
            }

        }

        public IEnumerable<ParishionerViewModel> GetParishionerViewModelsBySacramentTypeAndVicairateId(int vicariateId,
        int sacramentType, bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) " +
                    "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                    "WHERE S.Type = {0} AND V.Id = {1} AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);

                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN Vicariate AS V ON P.VicariateId = V.Id) " +
                    "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                    "WHERE S.Type = {0} AND V.Id = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, vicariateId, status);
                }
            }

        }

        public IEnumerable<ParishionerViewModel> GetParishionerViewModelsBySacramentTypeAndDioceseId(int dioceseId,
       int sacramentType, bool? isCounted, int status, int gender)
        {
            if (isCounted.HasValue)
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN " +
                    "(Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) " +
                    "ON P.VicariateId = V.Id) " +
                    "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                    "WHERE S.Type = {0} AND D.Id = {1} AND Pa.IsCounted = {2} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {3} OR Pa.Status = {4}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {5}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, isCounted,
                            (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, isCounted,
                        (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);

                }
                else
                {
                    query += "AND Pa.Status = {3} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, isCounted, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, isCounted, status);
                }
            }
            else
            {
                string query = "SELECT Pa.*, S.Date AS SacramentDate, C.Name AS CommunityName " +
                    "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN (Parish AS P INNER JOIN " +
                    "(Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) " +
                    "ON P.VicariateId = V.Id) " +
                    "ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                    "WHERE S.Type = {0} AND D.Id = {1} ";

                if (status == (int)ParishionerStatusEnum.AvailableAndSaved)
                {
                    query += "AND (Pa.Status = {2} OR Pa.Status = {3}) ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {4}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved);
                }
                else
                {
                    query += "AND Pa.Status = {2} ";

                    if (gender >= 0)
                    {
                        query += " AND Pa.Gender = {3}";
                        return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, status, gender);
                    }

                    return _db.ExecuteQuery<ParishionerViewModel>(query, sacramentType, dioceseId, status);
                }
            }

        }

        //Only For View Parishioners Management

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersBySacramentTypeAndParishId(int parishId, int sacramentType,
            bool isCounted, int status)
        {
            string query = "";

            if (sacramentType == (int)SacramentEnum.Matrimony)
            {
                query = "SELECT Pa.* " +
                        "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                        "WHERE Pa.IsMarried = {0} AND Pa.IsSingle = {1} AND Pa.IsCounted = {2} AND Pa.Status = {3} AND P.Id = {4}";

                if (status == (int)ParishionerStatusEnum.Saved)
                {
                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE C.ParishId = {4} AND Pa.IsMarried = {0} AND Pa.IsSingle = {1} AND Pa.IsCounted = {2}";
                }

                return _db.ExecuteQuery<Parishioner>(query, true, false, isCounted, status, parishId);
            }

            if (sacramentType == (int)SacramentEnum.Vocation)
            {
                query = "SELECT Pa.* " +
                        "FROM (Parishioner AS Pa INNER JOIN Vocation AS V " +
                        "ON Pa.Id = V.ParishionerId) LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                        "WHERE Pa.IsCounted = {0} AND Pa.Status = {1} AND P.Id = {2}";

                if (status == (int)ParishionerStatusEnum.Saved)
                {
                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Vocation AS V ON Pa.Id = V.ParishionerId " +
                                 "WHERE C.ParishId = {2} AND Pa.IsCounted = {0}";
                }

                return _db.ExecuteQuery<Parishioner>(query, isCounted, status, parishId);
            }

            query = "SELECT Pa.* " +
                    "FROM (Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId) LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                    "WHERE S.Type = {0} AND Pa.IsCounted = {1} AND Pa.Status = {2} AND P.Id = {3}";

            if (status == (int)ParishionerStatusEnum.Saved)
            {
                query += " UNION " +
                             "SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                             "ON PMR.FromCommunityId = C.Id INNER JOIN Sacrament AS S ON Pa.Id = S.ParishionerId " +
                             "WHERE C.ParishId = {3} AND S.Type = {0} AND Pa.IsCounted = {1}";
            }

            return _db.ExecuteQuery<Parishioner>(query, sacramentType, isCounted, status, parishId);
        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersBySacramentTypeAndCommunityId(int communityId, int sacramentType,
            bool isCounted, int status)
        {
            string query = "";
            if (sacramentType == (int)SacramentEnum.Matrimony)
            {
                query = "SELECT Pa.* " +
                        "FROM Parishioner AS Pa INNER JOIN Community AS C " +
                        "ON Pa.CommunityId = C.Id " +
                        "WHERE Pa.IsMarried = {0} AND Pa.IsSingle = {1} AND Pa.IsCounted = {2} AND Pa.Status = {3} " +
                        "AND (Pa.CommunityId = {4} OR C.ParentId = {4})";

                if (status == (int)ParishionerStatusEnum.Saved)
                {
                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id " +
                                 "WHERE (PMR.FromCommunityId = {4} OR C.ParentId = {4}) AND Pa.IsMarried = {0} AND Pa.IsSingle = {1} AND Pa.IsCounted = {2}";
                }

                return _db.ExecuteQuery<Parishioner>(query, true, false, isCounted, status, communityId);
            }

            if (sacramentType == (int)SacramentEnum.Vocation)
            {
                query = "SELECT Pa.* " +
                        "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id " +
                        "INNER JOIN Vocation AS V " +
                        "ON Pa.Id = V.ParishionerId " +
                        "WHERE Pa.IsCounted = {0} AND Pa.Status = {1} AND (Pa.CommunityId = {2} OR C.ParentId = {2})";

                if (status == (int)ParishionerStatusEnum.Saved)
                {
                    query += " UNION " +
                                 "SELECT Pa.* " +
                                 "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                                 "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                                 "ON PMR.FromCommunityId = C.Id INNER JOIN Vocation AS V ON Pa.Id = V.ParishionerId " +
                                 "WHERE (PMR.FromCommunityId = {2} OR C.ParentId = {2}) AND Pa.IsCounted = {0}";
                }

                return _db.ExecuteQuery<Parishioner>(query, isCounted, status, communityId);
            }

            query = "SELECT Pa.* " +
                    "FROM Parishioner AS Pa INNER JOIN Community AS C ON Pa.CommunityId = C.Id " +
                    "INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0} AND Pa.IsCounted = {1} AND Pa.Status = {2} AND (Pa.CommunityId = {3} OR C.ParentId = {3})";

            if (status == (int)ParishionerStatusEnum.Saved)
            {
                query += " UNION " +
                             "SELECT Pa.* " +
                             "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                             "ON Pa.Id = PMR.ParishionerId INNER JOIN Community AS C " +
                             "ON PMR.FromCommunityId = C.Id INNER JOIN Sacrament AS S ON Pa.Id = S.ParishionerId " +
                             "WHERE (PMR.FromCommunityId = {3} OR C.ParentId = {3}) AND S.Type = {0} AND Pa.IsCounted = {1}";
            }

            return _db.ExecuteQuery<Parishioner>(query, sacramentType, isCounted, status, communityId);
        }

        //Them chuyen xu
        public IEnumerable<Parishioner> GetParishionersBySacramentTypeAndParishDivisionId(int parishDivisionId, int sacramentType,
            bool isCounted, int status)
        {
            string query = "";
            if (sacramentType == (int)SacramentEnum.Matrimony)
            {
                query = "SELECT Pa.* " +
                        "FROM Parishioner AS Pa " +
                        "WHERE Pa.IsMarried = {0} AND Pa.IsSingle = {1} AND Pa.IsCounted = {2} AND Pa.Status = {3} AND Pa.CommunityId = {4}";

                if (status == (int)ParishionerStatusEnum.Saved)
                {
                    query += " UNION " +
                               " SELECT Pa.* " +
                               "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                               "ON Pa.Id = PMR.ParishionerId " +
                               "WHERE PMR.FromCommunityId = {4} AND Pa.IsMarried = {0} AND Pa.IsSingle = {1} AND Pa.IsCounted = {2}";
                }

                return _db.ExecuteQuery<Parishioner>(query, true, false, isCounted, status, parishDivisionId);
            }

            if (sacramentType == (int)SacramentEnum.Vocation)
            {
                query = "SELECT Pa.* " +
                        "FROM Parishioner AS Pa INNER JOIN Vocation AS V " +
                        "ON Pa.Id = V.ParishionerId " +
                        "WHERE Pa.IsCounted = {0} AND Pa.Status = {1} AND Pa.CommunityId = {2}";

                if (status == (int)ParishionerStatusEnum.Saved)
                {
                    query += " UNION " +
                              " SELECT Pa.* " +
                              "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                              "ON Pa.Id = PMR.ParishionerId INNER JOIN Vocation AS V ON Pa.Id = V.ParishionerId " +
                              "WHERE PMR.FromCommunityId = {2} AND Pa.IsCounted = {0}";
                }

                return _db.ExecuteQuery<Parishioner>(query, isCounted, status, parishDivisionId);
            }

            query = "SELECT Pa.* " +
                    "FROM Parishioner AS Pa INNER JOIN Sacrament AS S " +
                    "ON Pa.Id = S.ParishionerId " +
                    "WHERE S.Type = {0} AND Pa.IsCounted = {1} AND Pa.Status = {2} AND Pa.CommunityId = {3}";

            if (status == (int)ParishionerStatusEnum.Saved)
            {
                query += " UNION " +
                               " SELECT Pa.* " +
                               "FROM Parishioner AS Pa INNER JOIN ParishionerMigrationRequest AS PMR " +
                               "ON Pa.Id = PMR.ParishionerId INNER JOIN Sacrament AS S ON Pa.Id = S.ParishionerId " +
                               "WHERE PMR.FromCommunityId = {3} AND S.Type = {0} AND Pa.IsCounted = {1}";
            }

            return _db.ExecuteQuery<Parishioner>(query, sacramentType, isCounted, status, parishDivisionId);
        }
        //----   

        public int AddParishioner(Parishioner parishioner)
        {
            try
            {
                _db.Parishioners.InsertOnSubmit(parishioner);
                _db.SubmitChanges();
                return parishioner.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public Parishioner LoadParishionerById(int id)
        {
            try
            {
                return _db.Parishioners.SingleOrDefault(p => p.Id == id);
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public int UpdateParishioner(Parishioner updatedParishioner)
        {
            try
            {
                Parishioner parishioner = _db.Parishioners.FirstOrDefault(p => p.Id == updatedParishioner.Id);

                if (parishioner == null)
                {
                    return 0;
                }

                //Kiem tra coi co don nao khong
                if (parishioner.ParishionerMigrationRequests.Count > 0)
                {
                    var request =
                        parishioner.ParishionerMigrationRequests.FirstOrDefault(
                            pmr => pmr.FromCommunityId == parishioner.CommunityId);

                    if (request != null)
                    {
                        request.FromCommunityId = updatedParishioner.CommunityId;
                    }
                }

                //parishioner.Code = updatedParishioner.Code;
                parishioner.ChristianName = updatedParishioner.ChristianName;
                parishioner.Name = updatedParishioner.Name;
                parishioner.Gender = updatedParishioner.Gender;
                parishioner.BirthDate = updatedParishioner.BirthDate;
                parishioner.BirthPlace = updatedParishioner.BirthPlace;
                parishioner.FatherName = updatedParishioner.FatherName;
                parishioner.MotherName = updatedParishioner.MotherName;
                parishioner.IsCounted = updatedParishioner.IsCounted;
                parishioner.DomicileStatus = updatedParishioner.DomicileStatus;

                if (updatedParishioner.DomicileStatus != 0)
                {
                    parishioner.DomicilePlace = updatedParishioner.DomicilePlace;
                }
                else
                {
                    parishioner.DomicilePlace = "";
                }

                parishioner.Education = updatedParishioner.Education;
                parishioner.IsStudying = updatedParishioner.IsStudying;
                parishioner.Career = updatedParishioner.Career;
                parishioner.Address = updatedParishioner.Address;
                parishioner.Phone = updatedParishioner.Phone;
                parishioner.MobilePhone = updatedParishioner.MobilePhone;
                parishioner.Email = updatedParishioner.Email;
                parishioner.Note = updatedParishioner.Note;
                parishioner.IsCatechumen = updatedParishioner.IsCatechumen;
                parishioner.IsDead = updatedParishioner.IsDead;

                var member =
                        parishioner.FamilyMembers.FirstOrDefault(fm => fm.Status == (int)FamilyMemberStatusEnum.Main);

                if (updatedParishioner.IsDead)
                {
                    parishioner.DeadDate = updatedParishioner.DeadDate;

                    if (member != null)
                    {
                        member.Status = (int)FamilyMemberStatusEnum.Sub;
                    }
                }
                else
                {
                    parishioner.DeadDate = "";
                }

                //Kiem tra xem coi giao ho cua giao dan vs gia dinh co giong nhau khong ? Khong thi loai nguoi do ra khoi gia dinh
                if (member != null)
                {
                    if (updatedParishioner.CommunityId != member.Family.CommunityId)
                    {
                        member.Status = (int)FamilyMemberStatusEnum.Sub;
                    }
                }

                parishioner.IsMarried = updatedParishioner.IsMarried;
                parishioner.IsSingle = updatedParishioner.IsSingle;
                parishioner.CommunityId = updatedParishioner.CommunityId;

                parishioner.LastUpdatedBy = updatedParishioner.LastUpdatedBy;
                parishioner.Status = updatedParishioner.Status;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int DeleteParishioner(int id)
        {
            try
            {
                Parishioner parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == id);

                if (parishioner == null)
                {
                    return 0;
                }

                _db.Parishioners.DeleteOnSubmit(parishioner);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public string LoadParishionerCode(int parishId, string prefix, int characterNumber)
        {
            try
            {
                const string query = "SELECT MAX(Code) " +
                                      "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) ON Pa.CommunityId = C.Id " +
                                      "WHERE P.Id = {0} AND Pa.Code LIKE {1} ";

                string underline = "";
                for (int i = 0; i < characterNumber; i++)
                {
                    underline += "_";
                }

                string suffixParam = prefix + underline;

                string code = _db.ExecuteQuery<string>(query, parishId, suffixParam).SingleOrDefault();

                CodeConverter converter = new CodeConverter();
                string s = code;
                int result = 0;
                int count = 0;

                while (true)
                {
                    result = 0;
                    s = converter.GenerateCode(s, prefix, characterNumber);
                    result = CheckParishionerCode(s, parishId);
                    //Neu ko trung
                    if (result == 1)
                    {
                        break;
                    }
                    //Neu bi exception thi dem 3 lan roi cho out
                    if (result == -1)
                    {
                        count++;
                        if (count > 3)
                        {
                            return "";
                        }
                    }

                }
                return s;
            }
            catch (Exception e)
            {
                return "";
            }
        }

        public int CheckParishionerCode(string code, int parishId)
        {
            try
            {
                const string query = "SELECT Pa.Code " +
                                     "FROM Parishioner AS Pa LEFT JOIN (Community AS C INNER JOIN Parish AS P ON C.ParishId = P.Id) " +
                                     "ON Pa.CommunityId = C.Id " +
                                     "WHERE P.Id = {0} AND Pa.Code = {1}";
                string result = _db.ExecuteQuery<string>(query, parishId, code).SingleOrDefault();

                if (string.IsNullOrEmpty(result))
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

        public int ChangeParishionerStatus(int id, int status, string username, bool isForced)
        {
            try
            {
                var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == id);

                if (parishioner == null)
                {
                    return 0;
                }

                //Neu khong bi bat buoc thay doi trang thai thi kiem tra
                if (!isForced)
                {
                    if (status == (int)ParishionerStatusEnum.Deleted)
                    {

                        var request =
                            parishioner.ParishionerMigrationRequests.SingleOrDefault(
                                pmr => (pmr.FromCommunityId == parishioner.CommunityId && pmr.ToParishId.HasValue &&
                                        pmr.Status == (int)MigrationRequestStatusEnum.Waiting));

                        if (request != null)
                        {
                            return -5;
                        }

                        if (parishioner.ClassGroups.Count != 0 || parishioner.ClassMembers.Count != 0 ||
                            parishioner.FamilyMembers.Count != 0 || parishioner.Matrimonies.Count != 0
                            || parishioner.Matrimonies1.Count != 0 || parishioner.Societies.Count != 0 || parishioner.SocietyMembers.Count != 0)
                        {
                            return -3;
                        }

                    }
                }

                if (!isForced)
                {
                    if (status == (int)ParishionerStatusEnum.Available)
                    {
                        //Kiem tra xem nguoi do co qua doi khong ?
                        if (parishioner.IsDead)
                        {
                            return -2;
                        }

                        //Kiem tra xem coi co dang yeu cau chuyen xu khong ?
                        var request =
                            parishioner.ParishionerMigrationRequests.SingleOrDefault(
                                pmr => (pmr.FromCommunityId == parishioner.CommunityId &&
                                    pmr.Status != (int)MigrationRequestStatusEnum.Approved));

                        if (request != null)
                        {
                            if (request.Status != (int)MigrationRequestStatusEnum.Reject && request.ToParishId.HasValue)
                            {
                                return -4;
                            }

                            //Neu nhu yeu cau chuyen xu nay bi tu choi roi
                            //Thuc hien xoa di cai request truoc khi doi status
                            parishioner.DomicilePlace = "";
                            parishioner.DomicileStatus = (int)DomicileStatusEnum.InParish;
                            _db.ParishionerMigrationRequests.DeleteOnSubmit(request);
                        }
                    }
                }

                //Co bien trang thai giao dan da xoa thanh sub ko ?
                if (status == (int)ParishionerStatusEnum.Deleted)
                {
                    //Cho no thanh sub luon
                    var member =
                        parishioner.FamilyMembers.SingleOrDefault(fm => fm.Status == (int)FamilyMemberStatusEnum.Main);

                    if (member != null)
                    {
                        member.Status = (int)FamilyMemberStatusEnum.Sub;
                    }

                    var request =
                            parishioner.ParishionerMigrationRequests.SingleOrDefault(
                                pmr => (pmr.FromCommunityId == parishioner.CommunityId &&
                                        pmr.Status == (int)MigrationRequestStatusEnum.Waiting));

                    if (request != null)
                    {
                        _db.ParishionerMigrationRequests.DeleteOnSubmit(request);
                    }

                }

                if (status == (int)ParishionerStatusEnum.Available)
                {
                    parishioner.IsDead = false;
                    parishioner.DeadDate = "";
                }

                parishioner.Status = status;
                parishioner.LastUpdatedBy = username;
                _db.SubmitChanges();
                return 1;

            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int ChangeParishionerGender(int parishionerId, int gender, string username)
        {
            try
            {
                var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == parishionerId);

                if (parishioner == null)
                {
                    return 0;
                }

                parishioner.Gender = gender;
                parishioner.LastUpdatedBy = username;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int ChangeParishionerMarriedStatus(int parishionerId, bool isMarried, string username)
        {
            try
            {
                var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == parishionerId);

                if (parishioner == null)
                {
                    return 0;
                }

                parishioner.IsMarried = isMarried;
                parishioner.LastUpdatedBy = username;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public string CheckValidMatrimony(int parishionerId, int parishId)
        {
            try
            {
                string result = "";
                var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == parishionerId);

                if (parishioner == null)
                {
                    return "0";
                }

                //Check 18t vs nu va 20t vs nam
                if (!string.IsNullOrEmpty(parishioner.BirthDate.Trim()))
                {
                    string currentTime = DateTime.Now.ToString("yyyyMMdd");
                    int current = Int32.Parse(currentTime);
                    int birthDate = Int32.Parse(parishioner.BirthDate);
                    int year = current - birthDate;

                    if (parishioner.Gender == 0 && year < 180000)
                    {
                        result += "1";
                    }
                    else if (parishioner.Gender == 1 && year < 200000)
                    {
                        result += "2";
                    }
                }
                else
                {
                    result += "5";
                }

                //Xem coi nguoi nay co da co hon phoi chua
                if (parishioner.Gender == 0)
                { //Neu la nu
                    var matrimony = _db.Matrimonies.FirstOrDefault(m => (m.WifeId == parishioner.Id &&
                                                                         ((!m.Parishioner.IsDead) &&
                                                                         m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted &&
                                                                         m.Status != (int)MatrimonyStatusEnum.Removed)));

                    if (matrimony != null)
                    {
                        //Neu co hon phoi thi xem coi nguoi do co trong xu ko
                        //Trong xu thi cam luon
                        //if (parishioner.Community.ParishId == parishId)
                        //{
                        //    return "-3";
                        //}
                        //else
                        //{
                        //    result += "3";
                        //}
                        return "-3";
                    }
                    else
                    {
                        //Neu nhu khong co hon phoi ma co da tung ket hon thi cam
                        var count = _db.Matrimonies.Count(m => (m.WifeId == parishioner.Id &&
                            m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted));

                        if (count == 0)
                        {
                            if (parishioner.IsMarried && !parishioner.IsSingle)
                            {
                                //if (parishioner.Community.ParishId == parishId)
                                //{
                                //    return "-4";
                                //}
                                //else
                                //{
                                //    result += "5";
                                //}
                                return "-4";
                            }
                        }

                    }

                }
                else
                {
                    var matrimony = _db.Matrimonies.FirstOrDefault(m => (m.HusbandId == parishioner.Id &&
                                                                         ((!m.Parishioner1.IsDead) &&
                                                                         m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted &&
                                                                         m.Status != (int)MatrimonyStatusEnum.Removed)));

                    if (matrimony != null)
                    {
                        //Neu co hon phoi thi xem coi nguoi do co trong xu ko
                        //Trong xu thi cam luon
                        //if (parishioner.Community.ParishId == parishId)
                        //{
                        //    return "-3";
                        //}
                        //else
                        //{
                        //    result += "3";
                        //}
                        return "-3";
                    }
                    else
                    {
                        //Neu nhu khong co hon phoi ma co da tung ket hon thi cam
                        var count = _db.Matrimonies.Count(m => (m.HusbandId == parishioner.Id &&
                            m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted));

                        if (count == 0)
                        {
                            if (parishioner.IsMarried && !parishioner.IsSingle)
                            {
                                //if (parishioner.Community.ParishId == parishId)
                                //{
                                //    return "-4";
                                //}
                                //else
                                //{
                                //    result += "5";
                                //}
                                return "-4";
                            }
                        }

                    }

                }

                //Check vocation
                var hasVocation = _db.Vocations.Any(v => v.ParishionerId == parishionerId && v.IsLeft == false);

                if (hasVocation)
                {
                    result += "4";
                }

                if (string.IsNullOrEmpty(result))
                {
                    return "-2";
                }

                return result;
            }
            catch (Exception e)
            {
                return "0";
            }

        }

        public string GetCodeByParishionerId(int id)
        {
            try
            {
                var item = _db.Parishioners.SingleOrDefault(p => p.Id == id);

                if (item == null)
                {
                    return "";
                }

                return item.Code;
            }
            catch (Exception e)
            {
                return "";
            }

        }

		//get all parishioner
        public IEnumerable<Parishioner> GetAllParishioner()
        {
            string query = "SELECT * FROM Parishioner ORDER BY Name";
            return _db.ExecuteQuery<Parishioner>(query, 0);
        }
        public List<ParishionerSacramentViewModel> PrintSacrament(int parishId, string[] ids, int type)
        {
            var result = new List<ParishionerSacramentViewModel>();
            var converter = new DateConverter();

            var parish = _db.Parishes.FirstOrDefault(p => p.Id == parishId);

            if (parish == null)
            {
                return null;
            }

            var vicariate = parish.Vicariate;
            var diocese = vicariate.Diocese;

            foreach (var i in ids)
            {
                int id = Int32.Parse(i);
                var item = _db.Parishioners.FirstOrDefault(p => p.Id == id);

                if (item == null)
                {
                    return null;
                }

                var parishioner = new ParishionerSacramentViewModel()
                {
                    BirthDate = converter.ConvertStringToDate(item.BirthDate),
                    ChristianName = item.ChristianName,
                    Name = item.Name,
                    FatherName = item.FatherName,
                    MotherName = item.MotherName,
                    BirthPlace = item.BirthPlace,
                };

                parishioner.ParishName = parish.Name;
                parishioner.VicariateName = vicariate.Name;
                parishioner.DioceseName = diocese.Name;
                parishioner.Priest = parish.Priest;

                if (type == 0 || type == 1)
                {
                    var baptism = item.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);

                    if (baptism != null)
                    {
                        parishioner.BaptismDate = converter.ConvertStringToDate(baptism.Date);
                        parishioner.BaptismNumber = baptism.Number;
                        parishioner.BaptismPatron = baptism.Patron;
                        parishioner.BaptismPlace = baptism.ReceivedPlace;
                        parishioner.BaptismPriest = baptism.Giver;
                    }
                }

                if (type == 0 || type == 2)
                {
                    var holy = item.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.HolyCommunion);

                    if (holy != null)
                    {
                        parishioner.HolyDate = converter.ConvertStringToDate(holy.Date);
                        parishioner.HolyNumber = holy.Number;
                        parishioner.HolyPlace = holy.ReceivedPlace;
                        parishioner.HolyPriest = holy.Giver;
                    }
                }

                if (type == 0 || type == 3)
                {
                    var confirm = item.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Confirmation);

                    if (confirm != null)
                    {
                        parishioner.ConfirmDate = converter.ConvertStringToDate(confirm.Date);
                        parishioner.ConfirmNumber = confirm.Number;
                        parishioner.ConfirmPatron = confirm.Patron;
                        parishioner.ConfirmPlace = confirm.ReceivedPlace;
                        parishioner.ConfirmPriest = confirm.Giver;
                    }
                }

                result.Add(parishioner);
            }

            return result;
        }

        public List<ParishionerSacramentViewModel> PrintMatrimony(int parishId, string[] ids)
        {
            var result = new List<ParishionerSacramentViewModel>();
            var converter = new DateConverter();

            var parish = _db.Parishes.FirstOrDefault(p => p.Id == parishId);

            if (parish == null)
            {
                return null;
            }

            var vicariate = parish.Vicariate;
            var diocese = vicariate.Diocese;

            foreach (var i in ids)
            {
                int id = Int32.Parse(i);
                Matrimony item;
                var parishioner = _db.Parishioners.FirstOrDefault(p => p.Id == id);

                if (parishioner == null)
                {
                    return null;
                }

                var matrimony = new ParishionerSacramentViewModel();

                matrimony.ParishName = parish.Name;
                matrimony.VicariateName = vicariate.Name;
                matrimony.DioceseName = diocese.Name;
                matrimony.Priest = parish.Priest;

                if (parishioner.Gender == 0)
                {
                    item = parishioner.Matrimonies1.FirstOrDefault(m => (m.Status != (int)MatrimonyStatusEnum.Removed
                                                                && !m.Parishioner.IsDead && m.Parishioner.Status != (int)ParishionerStatusEnum.Deleted));

                    var wifeBaptism = parishioner.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);

                    if (wifeBaptism != null)
                    {
                        matrimony.WifeBaptism = converter.ConvertStringToDate(wifeBaptism.Date);
                        matrimony.WifeBaptismNumber = wifeBaptism.Number;
                        matrimony.WifeParishName = parish.Name;
                    }

                    matrimony.WifeBirthDate = converter.ConvertStringToDate(parishioner.BirthDate);
                    matrimony.WifeBirthPlace = parishioner.BirthPlace;
                    matrimony.WifeFatherName = parishioner.FatherName;
                    matrimony.WifeMotherName = parishioner.MotherName;
                    matrimony.WifeName = parishioner.ChristianName + " " + parishioner.Name;

                    if (item != null)
                    {
                        var husband = item.Parishioner;

                        var husbandBaptism =
                            husband.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);

                        if (husbandBaptism != null)
                        {
                            matrimony.HusbandBaptism = converter.ConvertStringToDate(husbandBaptism.Date);
                            matrimony.HusbandBaptismNumber = husbandBaptism.Number;
                            matrimony.HusbandParishName = husband.Community.Parish.Name;
                        }

                        matrimony.HusbandBirthDate = converter.ConvertStringToDate(husband.BirthDate);
                        matrimony.HusbandBirthPlace = husband.BirthPlace;
                        matrimony.HusbandFatherName = husband.FatherName;
                        matrimony.HusbandMotherName = husband.MotherName;
                        matrimony.HusbandName = husband.ChristianName + " " + husband.Name;

                        matrimony.MatrimonyDate = converter.ConvertStringToDate(item.Date);
                        matrimony.MatrimonyFirstWitness = item.FirstWitness;
                        matrimony.MatrimonySecondWitness = item.SecondWitness;
                        matrimony.MatrimonyNumber = item.Number;
                        matrimony.MatrimonyPlace = item.Place;
                        matrimony.MatrimonyPriest = item.Priest;
                    }

                }
                else
                {
                    item = parishioner.Matrimonies.FirstOrDefault(m => (m.Status != (int)MatrimonyStatusEnum.Removed
                                                                && !m.Parishioner1.IsDead && m.Parishioner1.Status != (int)ParishionerStatusEnum.Deleted));

                    var husbandBaptism = parishioner.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);

                    if (husbandBaptism != null)
                    {
                        matrimony.HusbandBaptism = converter.ConvertStringToDate(husbandBaptism.Date);
                        matrimony.HusbandBaptismNumber = husbandBaptism.Number;
                        matrimony.HusbandParishName = parish.Name;
                    }

                    matrimony.HusbandBirthDate = converter.ConvertStringToDate(parishioner.BirthDate);
                    matrimony.HusbandBirthPlace = parishioner.BirthPlace;
                    matrimony.HusbandFatherName = parishioner.FatherName;
                    matrimony.HusbandMotherName = parishioner.MotherName;
                    matrimony.HusbandName = parishioner.ChristianName + " " + parishioner.Name;

                    if (item != null)
                    {
                        var wife = item.Parishioner1;

                        var wifeBaptism =
                            wife.Sacraments.FirstOrDefault(s => s.Type == (int)SacramentEnum.Baptism);

                        if (wifeBaptism != null)
                        {
                            matrimony.WifeBaptism = converter.ConvertStringToDate(wifeBaptism.Date);
                            matrimony.WifeBaptismNumber = wifeBaptism.Number;
                            matrimony.WifeParishName = wife.Community.Parish.Name;
                        }

                        matrimony.WifeBirthDate = converter.ConvertStringToDate(wife.BirthDate);
                        matrimony.WifeBirthPlace = wife.BirthPlace;
                        matrimony.WifeFatherName = wife.FatherName;
                        matrimony.WifeMotherName = wife.MotherName;
                        matrimony.WifeName = wife.ChristianName + " " + wife.Name;

                        matrimony.MatrimonyDate = converter.ConvertStringToDate(item.Date);
                        matrimony.MatrimonyFirstWitness = item.FirstWitness;
                        matrimony.MatrimonySecondWitness = item.SecondWitness;
                        matrimony.MatrimonyNumber = item.Number;
                        matrimony.MatrimonyPlace = item.Place;
                        matrimony.MatrimonyPriest = item.Priest;
                    }

                }


                result.Add(matrimony);
            }

            return result;
        }

        public IEnumerable<Parishioner> SearchParishionersByKeyword(string keyword, int start, int length)
        {
            keyword = keyword.Trim().ToLower();
            var query = _db.Parishioners.Where(p => p.Name.ToLower().Contains(keyword) || p.ChristianName.ToLower().Contains(keyword) || (p.ChristianName.ToLower() + " " + p.Name.ToLower()).Contains(keyword)
                || p.Address.ToLower().Contains(keyword)
                || p.BirthDate.Contains(keyword) || p.Code.ToLower().Contains(keyword) || p.Email.ToLower().Contains(keyword) || p.Phone.Contains(keyword));
            query = query.OrderBy(p => p.Id).Skip(start);
            if (length <= 0)
            {
                return query.ToList();
            }
            else
            {
                return query.Take(length).ToList();
            }
        }

        //Get Parishioner Name to Auto Complete
        public IEnumerable<ParishionerViewModel> getAllParishionerByName(string name)
        {
            const string query = "SELECT * " +
                "FROM Parishioner " +
                "WHERE Name LIKE {0} " +
                "AND Gender = 1 " +
                "AND Id NOT IN " +
                "(SELECT ParishionerId FROM Priest) " +
                "ORDER BY Name ";
            return _db.ExecuteQuery<ParishionerViewModel>(query, "%" + name + "%");
        }

        public IEnumerable<string> getMaxCode(string code)
        {
            const string query = "SELECT Max(Code) " +
                "FROM Parishioner " +
                "WHERE Code LIKE {0}";
            return _db.ExecuteQuery<string>(query, "%" + code + "%");
        }

        public Parishioner getParishionerById(int id)
        {
            const string query = "SELECT * " +
                "FROM Parishioner " +
                "WHERE Id = {0} ";
            return _db.ExecuteQuery<Parishioner>(query, id).SingleOrDefault();
        }

    }
}
