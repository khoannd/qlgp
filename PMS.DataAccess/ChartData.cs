using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class ChartData
    {
        private readonly PMSDataContext _db;

        public ChartData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        //Thống kê tổng giáo dân theo năm
        public int[] GetsumOfParishionerInDioceseByYear(int dioceseId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i]) + 1) * 10000;
                const string query = "SELECT COUNT(pa.name) from ((Parishioner AS pa INNER JOIN Community AS co On pa.CommunityId = co.Id) " +
                                     "INNER JOIN Parish AS p On co.ParishId = p.Id) INNER JOIN Vicariate AS v On p.VicariateId = v.Id " +
                                     "WHERE v.DioceseId = {0} AND pa.IsCounted = 'true' AND (pa.Status = {1} OR pa.Status = {2})" +
                                     "AND (CONVERT(int, pa.BirthDate) < {3} OR LTRIM(RTRIM(pa.BirthDate)) = '')" +
                                     "AND (pa.IsDead = 'false' OR (pa.IsDead = 'True' AND CONVERT(int, pa.DeadDate) >= {4})) ";
                result[i] = _db.ExecuteQuery<int>(query, dioceseId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, year, year).SingleOrDefault();
            }
            return result;
        }
        public int[] GetsumOfParishionerInVicariateByYear(int vicariateId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i]) + 1) * 10000;
                const string query = "SELECT COUNT(pa.name) from (Parishioner AS pa INNER JOIN Community AS co On pa.CommunityId = co.Id) " +
                                     "INNER JOIN Parish AS p On co.ParishId = p.Id " +
                                     "WHERE p.VicariateId = {0} AND pa.IsCounted = 'true' AND (pa.Status = {1} OR pa.Status = {2})" +
                                     "AND (CONVERT(int, pa.BirthDate) < {3} OR LTRIM(RTRIM(pa.BirthDate)) = '')" +
                                     "AND (pa.IsDead = 'false' OR (pa.IsDead = 'True' AND CONVERT(int, pa.DeadDate) >= {4})) ";
                result[i] = _db.ExecuteQuery<int>(query, vicariateId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, year, year).SingleOrDefault();
            }
            return result;
        }
        public int[] GetsumOfParishionerInParishByYear(int parishId, string[] years)
        {
            int[]result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i]) + 1) * 10000;
                const string query = "SELECT COUNT(pa.name) from Parishioner AS pa INNER JOIN Community AS co On pa.CommunityId = co.Id " +
                                     "WHERE co.ParishId = {0} AND pa.IsCounted = 'true' AND (pa.Status = {1} OR pa.Status = {2})" +
                                     "AND (CONVERT(int, pa.BirthDate) < {3} OR LTRIM(RTRIM(pa.BirthDate)) = '')" +
                                     "AND (pa.IsDead = 'false' OR (pa.IsDead = 'True' AND CONVERT(int, pa.DeadDate) >= {4})) ";
                result[i] = _db.ExecuteQuery<int>(query, parishId, (int)ParishionerStatusEnum.Available, (int)ParishionerStatusEnum.Saved, year, year).SingleOrDefault();
            }
            return result;
        }
        //Thống kê tổng giáo dân theo tháng


        //------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //Thống kê hôn phối theo năm
        public int[] GetSumOfMatrimonyInDioceseByYear(int dioceseId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i])) * 10000;
                const string query = "SELECT COUNT(DISTINCT(m.Id)) FROM (((Matrimony AS m INNER JOIN Parishioner AS pa On m.HusbandId = pa.Id OR m.WifeId = pa.Id) " +
                                        "INNER JOIN Community AS co On pa.CommunityId = co.Id) INNER JOIN Parish AS p On co.ParishId = p.Id) INNER JOIN Vicariate AS v On p.VicariateId = v.Id " +
                                        "WHERE v.DioceseId = {0} AND CONVERT(int, m.Date) < {1} AND CONVERT(int, m.Date) > {2}";
                result[i] = _db.ExecuteQuery<int>(query, dioceseId, year + 10000, year).SingleOrDefault();
            }
            return result;
        }
        public int[] GetSumOfMatrimonyInVicariateByYear(int vicariateId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i])) * 10000;
                const string query = "SELECT COUNT(DISTINCT(m.Id)) FROM ((Matrimony AS m INNER JOIN Parishioner AS pa On m.HusbandId = pa.Id OR m.WifeId = pa.Id) " +
                                        "INNER JOIN Community AS co On pa.CommunityId = co.Id) INNER JOIN Parish AS p On co.ParishId = p.Id " +
                                        "WHERE p.VicariateId = {0} AND CONVERT(int, m.Date) < {1} AND CONVERT(int, m.Date) > {2}";
                result[i] = _db.ExecuteQuery<int>(query, vicariateId, year + 10000, year).SingleOrDefault();
            }
            return result;
        }
        public int[] GetSumOfMatrimonyInParishByYear(int parishId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i])) * 10000;
                const string query = "SELECT COUNT(DISTINCT(m.Id)) FROM (Matrimony AS m INNER JOIN Parishioner AS pa On m.HusbandId = pa.Id OR m.WifeId = pa.Id) " +
                                        "INNER JOIN Community AS co On pa.CommunityId = co.Id " +
                                        "WHERE co.ParishId = {0} AND CONVERT(int, m.Date) < {1} AND CONVERT(int, m.Date) > {2} ";
                result[i] = _db.ExecuteQuery<int>(query, parishId, year + 10000, year).SingleOrDefault();
            }
            return result;
        }
        //THống kê hôn phối theo tháng
        //public int[] GetSumOfMatrimonyInDioceseByMonths(int dioceseId, int year)
        //{
        //    int[] result = new int[12];

        //    int month1 = (year*10000) + 101;
        //        const string query = "SELECT COUNT(DISTINCT(m.Id)) FROM (((Matrimony AS m INNER JOIN Parishioner AS pa On m.HusbandId = pa.Id OR m.WifeId = pa.Id) " +
        //                                "INNER JOIN Community AS co On pa.CommunityId = co.Id) INNER JOIN Parish AS p On co.ParishId = p.Id) INNER JOIN Vicariate AS v On p.VicariateId = v.Id " +
        //                                "WHERE v.DioceseId = {0} AND CONVERT(int, m.Date) < {1} AND CONVERT(int, m.Date) > {2}";
        //        result[0] = _db.ExecuteQuery<int>(query, dioceseId, (year*10000), year).SingleOrDefault();
        //    return result;
        //}
        //public int[] GetSumOfMatrimonyInVicariateByMonths(int vicariateId, int year)
        //{
        //    int[] result = new int[12];
        //        const string query = "SELECT COUNT(DISTINCT(m.Id)) FROM ((Matrimony AS m INNER JOIN Parishioner AS pa On m.HusbandId = pa.Id OR m.WifeId = pa.Id) " +
        //                                "INNER JOIN Community AS co On pa.CommunityId = co.Id) INNER JOIN Parish AS p On co.ParishId = p.Id " +
        //                                "WHERE p.VicariateId = {0} AND CONVERT(int, m.Date) < {1} AND CONVERT(int, m.Date) > {2}";
        //        result[i] = _db.ExecuteQuery<int>(query, vicariateId, year + 10000, year).SingleOrDefault();
        //}
        //public int[] GetSumOfMatrimonyInParishByMonths(int parishId, int year)
        //{
        //    int[] result = new int[12];
        //        const string query = "SELECT COUNT(DISTINCT(m.Id)) FROM (Matrimony AS m INNER JOIN Parishioner AS pa On m.HusbandId = pa.Id OR m.WifeId = pa.Id) " +
        //                                "INNER JOIN Community AS co On pa.CommunityId = co.Id " +
        //                                "WHERE co.ParishId = {0} AND CONVERT(int, m.Date) < {1} AND CONVERT(int, m.Date) > {2} ";
        //        result[i] = _db.ExecuteQuery<int>(query, parishId, year + 10000, year).SingleOrDefault();
        //    }
        //    return result;
        //}
        //----------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //Thống kê tình hình bí tích
        public int GetSumOfSacramentInDioceseByYear(int dioceseId, string[] years, out int[] baptismResult, out int[] holyCommunionResult, out int[] confirmationResult)
        {
            baptismResult = new int[years.Length];
            holyCommunionResult = new int[years.Length];
            confirmationResult = new int[years.Length];

            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i])) * 10000;
                const string query1 = "SELECT COUNT(sa.Id) FROM (((Sacrament AS sa INNER JOIN Parishioner AS pa ON sa.ParishionerId = pa.Id) " +
                                     "INNER JOIN Community AS co ON pa.CommunityId = co.Id) INNER JOIN Parish AS p ON co.ParishId = p.Id) " +
                                     "INNER JOIN Vicariate AS v ON p.VicariateId = v.Id " +
                                     "WHERE v.DioceseId = {0} AND CONVERT(int, sa.Date) < {1} AND CONVERT(int, sa.Date) > {2} AND sa.Type = {3} ";
                baptismResult[i] = _db.ExecuteQuery<int>(query1, dioceseId, year + 10000, year, (int)SacramentEnum.Baptism).SingleOrDefault();
                holyCommunionResult[i] = _db.ExecuteQuery<int>(query1, dioceseId, year + 10000, year, (int)SacramentEnum.HolyCommunion).SingleOrDefault();
                confirmationResult[i] = _db.ExecuteQuery<int>(query1, dioceseId, year + 10000, year, (int)SacramentEnum.Confirmation).SingleOrDefault();
            }
            return 1;
        }
        public int GetSumOfSacramentInVicariateByYear(int vicariateId, string[] years, out int[] baptismResult, out int[] holyCommunionResult, out int[] confirmationResult)
        {
            baptismResult = new int[years.Length];
            holyCommunionResult = new int[years.Length];
            confirmationResult = new int[years.Length];

            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i])) * 10000;
                const string query1 = "SELECT COUNT(sa.Id) FROM ((Sacrament AS sa INNER JOIN Parishioner AS pa ON sa.ParishionerId = pa.Id) " +
                                     "INNER JOIN Community AS co ON pa.CommunityId = co.Id) INNER JOIN Parish AS p ON co.ParishId = p.Id " +
                                     "WHERE p.VicariateId = {0} AND CONVERT(int, sa.Date) < {1} AND CONVERT(int, sa.Date) > {2} AND sa.Type = {3} ";
                baptismResult[i] = _db.ExecuteQuery<int>(query1, vicariateId, year + 10000, year, (int)SacramentEnum.Baptism).SingleOrDefault();
                holyCommunionResult[i] = _db.ExecuteQuery<int>(query1, vicariateId, year + 10000, year, (int)SacramentEnum.HolyCommunion).SingleOrDefault();
                confirmationResult[i] = _db.ExecuteQuery<int>(query1, vicariateId, year + 10000, year, (int)SacramentEnum.Confirmation).SingleOrDefault();
            }
            return 1;
        }
        public int GetSumOfSacramentInParishByYear(int parishId, string[] years, out int[] baptismResult, out int[] holyCommunionResult, out int[] confirmationResult)
        {
            baptismResult = new int[years.Length];
            holyCommunionResult = new int[years.Length];
            confirmationResult = new int[years.Length];

            for (int i = 0; i < years.Length; i++)
            {
                int year = (Int32.Parse(years[i])) * 10000;
                const string query1 = "SELECT COUNT(sa.Id) FROM (Sacrament AS sa INNER JOIN Parishioner AS pa ON sa.ParishionerId = pa.Id) " +
                                     "INNER JOIN Community AS co ON pa.CommunityId = co.Id " +
                                     "WHERE co.ParishId = {0} AND CONVERT(int, sa.Date) < {1} AND CONVERT(int, sa.Date) > {2} AND sa.Type = {3} ";
                baptismResult[i] = _db.ExecuteQuery<int>(query1, parishId, year + 10000, year, (int)SacramentEnum.Baptism).SingleOrDefault();
                holyCommunionResult[i] = _db.ExecuteQuery<int>(query1, parishId, year + 10000, year, (int)SacramentEnum.HolyCommunion).SingleOrDefault();
                confirmationResult[i] = _db.ExecuteQuery<int>(query1, parishId, year + 10000, year, (int)SacramentEnum.Confirmation).SingleOrDefault();
            }
            return 1;
        }

        //Thống kê số giáo dân từng giáo họ trong giáo xứ
        public IEnumerable<ChartCommunityViewModel> GetSumOfParishionerByCommunity(int parishId)
        {

            const string query = "SELECT Co.Name AS CommunityName, SUM(R.Quantity) AS SumOfParishioner " +
                                 "FROM (SELECT C.Id, COUNT(Pa.CommunityId) AS Quantity " +
                                 "FROM Community AS C LEFT JOIN Parishioner AS Pa ON C.Id = Pa.CommunityId " +
                                 "WHERE C.ParentId IS NULL GROUP BY C.Id " +
                                 "UNION ALL " +
                                 "SELECT C.ParentId, COUNT(C.Id) AS Quantity " +
                                 "FROM Community AS C INNER JOIN Parishioner AS Pa ON C.Id = Pa.CommunityId " +
                                 "WHERE C.ParentId IS NOT NULL " +
                                 "GROUP BY C.ParentId) AS R " +
                                 "INNER JOIN Community AS Co ON Co.Id = R.Id " +
                                 "WHERE Co.IsDefault = 'false' AND Co.ParishId = {0} " +
                                 "GROUP BY R.Id, Co.Name ";
            return _db.ExecuteQuery<ChartCommunityViewModel>(query, parishId);

        }

        //Thống kê theo độ tuổi

        public int[] GetSumOfParishionerByAgeInDiocese(int dioceseId)
        {
            int[] result = new int[7];
            const string query = "SELECT COUNT(pa.Id) " +
                                 "FROM ((Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id) " +
                                 "INNER JOIN Parish AS p ON co.ParishId = p.Id) " +
                                 "INNER JOIN Vicariate  AS v ON p.VicariateId = v.Id " +
                                 "WHERE v.DioceseId = {0} And Convert(int,CONVERT(nvarchar,GETDATE(),112),112)- CONVERT(int, pa.BirthDate,112) > {1} " +
                                 "AND CONVERT(int,CONVERT(nvarchar,GETDATE(),112),112)- CONVERT(int, pa.BirthDate,112) < {2} AND pa.IsCounted = {3} ";
            result[0] = _db.ExecuteQuery<int>(query, dioceseId, 0, 70000, true).SingleOrDefault();
            result[1] = _db.ExecuteQuery<int>(query, dioceseId, 69999, 130000, true).SingleOrDefault();
            result[2] = _db.ExecuteQuery<int>(query, dioceseId, 129999, 170000, true).SingleOrDefault();
            result[3] = _db.ExecuteQuery<int>(query, dioceseId, 169999, 260000, true).SingleOrDefault();
            result[4] = _db.ExecuteQuery<int>(query, dioceseId, 259999, 310000, true).SingleOrDefault();
            result[5] = _db.ExecuteQuery<int>(query, dioceseId, 309999, 510000, true).SingleOrDefault();
            result[6] = _db.ExecuteQuery<int>(query, dioceseId, 509999, 2000000, true).SingleOrDefault();

            return result;
        }
        public int[] GetSumOfParishionerByAgeInVicariate(int vicariateId)
        {
            int[] result = new int[7];
            const string query = "SELECT COUNT(pa.Id) " +
                                 "FROM (Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id) " +
                                 "INNER JOIN Parish AS p ON co.ParishId = p.Id " +
                                 "WHERE p.VicariateId = {0} And Convert(int,CONVERT(nvarchar,GETDATE(),112),112)- CONVERT(int, pa.BirthDate,112) > {1} " +
                                 "AND CONVERT(int,CONVERT(nvarchar,GETDATE(),112),112)- CONVERT(int, pa.BirthDate,112) < {2} AND pa.IsCounted = {3} ";
            result[0] = _db.ExecuteQuery<int>(query, vicariateId, 0, 70000, true).SingleOrDefault();
            result[1] = _db.ExecuteQuery<int>(query, vicariateId, 69999, 130000, true).SingleOrDefault();
            result[2] = _db.ExecuteQuery<int>(query, vicariateId, 129999, 170000, true).SingleOrDefault();
            result[3] = _db.ExecuteQuery<int>(query, vicariateId, 169999, 260000, true).SingleOrDefault();
            result[4] = _db.ExecuteQuery<int>(query, vicariateId, 259999, 310000, true).SingleOrDefault();
            result[5] = _db.ExecuteQuery<int>(query, vicariateId, 309999, 510000, true).SingleOrDefault();
            result[6] = _db.ExecuteQuery<int>(query, vicariateId, 509999, 2000000, true).SingleOrDefault();

            return result;
        }
        public int[] GetSumOfParishionerByAgeInParish(int parishId)
        {
            int[] result = new int[7];
            const string query = "SELECT COUNT(pa.Id ) " +
                                 "FROM Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id " +
                                 "WHERE co.ParishId ={0} AND (CONVERT(int,CONVERT(nvarchar,GETDATE(),112),112)- CONVERT(int, BirthDate,112)) > {1} " +
                                 "AND (CONVERT(int,CONVERT(nvarchar,GETDATE(),112),112)- CONVERT(int, BirthDate,112)) < {2} AND pa.IsCounted = {3} ";
                result[0] = _db.ExecuteQuery<int>(query, parishId, 0, 70000, true).SingleOrDefault();
                result[1] = _db.ExecuteQuery<int>(query, parishId, 69999, 130000, true).SingleOrDefault();
                result[2] = _db.ExecuteQuery<int>(query, parishId, 129999, 170000, true).SingleOrDefault();
                result[3] = _db.ExecuteQuery<int>(query, parishId, 169999, 260000, true).SingleOrDefault();
                result[4] = _db.ExecuteQuery<int>(query, parishId, 259999, 310000, true).SingleOrDefault();
                result[5] = _db.ExecuteQuery<int>(query, parishId, 309999, 510000, true).SingleOrDefault();
                result[6] = _db.ExecuteQuery<int>(query, parishId, 509999, 2000000, true).SingleOrDefault();

            return result;
        }

        //Thống kê số giáo dân được sinh ra
        public int[] GetSumOfParishionersWereBornInDioceseByYear(int dioceseId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = ((Int32.Parse(years[i])) * 10000);
                const string query = "SELECT COUNT(pa.Id) " +
                                     "FROM ((Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id) " +
                                     "INNER JOIN Parish AS p ON co.ParishId = p.Id) " +
                                     "INNER JOIN Vicariate AS v ON p.VicariateId = v.Id " +
                                     "WHERE v.DioceseId = {0} AND {1} <= CONVERT(int, pa.BirthDate,112) AND CONVERT(int, pa.BirthDate,112) < {2} AND pa.IsCounted = {3} ";
                result[i] = _db.ExecuteQuery<int>(query, dioceseId, year, year + 10000, true).SingleOrDefault();
            }
            return result;
        }
        public int[] GetSumOfParishionersWereBornInVicariateByYear(int vicariateId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = ((Int32.Parse(years[i])) * 10000);
                const string query = "SELECT COUNT(pa.Id) " +
                                     "FROM (Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id) " +
                                     "INNER JOIN Parish AS p ON co.ParishId = p.Id " +
                                     "WHERE p.VicariateId = {0} AND {1} <= CONVERT(int, pa.BirthDate,112) AND CONVERT(int, pa.BirthDate,112) < {2} AND pa.IsCounted = {3} ";
                result[i] = _db.ExecuteQuery<int>(query, vicariateId, year, year + 10000, true).SingleOrDefault();
            }
            return result;
        }
        public int[] GetSumOfParishionersWereBornInParishByYear(int parishId, string[] years)
        {
            int[] result = new int[years.Length];
            for (int i = 0; i < years.Length; i++)
            {
                int year = ((Int32.Parse(years[i])) * 10000);
                const string query = "SELECT COUNT(pa.Id) " +
                                     "FROM Parishioner AS pa INNER JOIN Community AS co ON pa.CommunityId = co.Id " +
                                     "WHERE co.ParishId = {0} AND {1} <= CONVERT(int, pa.BirthDate,112) AND CONVERT(int, pa.BirthDate,112) < {2} AND pa.IsCounted = {3} ";
                result[i] = _db.ExecuteQuery<int>(query, parishId, year, year + 10000, true).SingleOrDefault();
            }
            return result;
        }
    }
}
