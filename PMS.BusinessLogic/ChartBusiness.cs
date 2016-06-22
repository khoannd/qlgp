using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class ChartBusiness
    {
        private readonly ChartData _chartData;
        private string connectionString = "";
        private AccountBusiness account = null;

        public ChartBusiness(string connection)
        {
            connectionString = connection;
            _chartData = new ChartData(connection);
            account = new AccountBusiness(connectionString);
        }

        public int[] GetsumOfParishionerByYear(int roleId, int dioceseId, int vicariateId, int parishId, string[] years)
        {
            
            int[] result = new int[years.Length];
            
            if (vicariateId == 0 && parishId == 0 && account.IsDioceseRole(roleId))
            {
                result = _chartData.GetsumOfParishionerInDioceseByYear(dioceseId, years);
            }
            else
            {
                if (vicariateId == 0 && parishId > 0 && account.IsDioceseRole(roleId))
                {
                    result = _chartData.GetsumOfParishionerInParishByYear(parishId, years);
                }
                else
                {
                    if (vicariateId > 0 && parishId == 0 && account.IsDioceseRole(roleId))
                    {
                        result = _chartData.GetsumOfParishionerInVicariateByYear(vicariateId, years);
                    }
                    else
                    {
                        result = _chartData.GetsumOfParishionerInParishByYear(parishId, years);
                    }
                }
            }
            return result;
        }

        public int[] GetSumOfMatrimonyByYear(int roleId, int dioceseId, int vicariateId, int parishId, string[] years)
        {

            int[] result = new int[years.Length];

            if (vicariateId == 0 && parishId == 0 && account.IsDioceseRole(roleId))
            {
                result = _chartData.GetSumOfMatrimonyInDioceseByYear(dioceseId, years);
            }
            else
            {
                if (vicariateId == 0 && parishId > 0 && account.IsDioceseRole(roleId))
                {
                    result = _chartData.GetSumOfMatrimonyInParishByYear(parishId, years);
                }
                else
                {
                    if (vicariateId > 0 && parishId == 0 && account.IsDioceseRole(roleId))
                    {
                        result = _chartData.GetSumOfMatrimonyInVicariateByYear(vicariateId, years);
                    }
                    else
                    {
                        result = _chartData.GetSumOfMatrimonyInParishByYear(parishId, years);
                    }
                }
            }
            return result;
        }
        //thống kê theo tình hình bí tích
        public int GetSumOfSacramentByYear(int roleId, int dioceseId, int vicariateId, int parishId, string[] years, out int[] baptismResult, out int[] holyCommunionResult, out int[] confirmationResult)
        {

            baptismResult = new int[years.Length];
            holyCommunionResult = new int[years.Length];
            confirmationResult = new int[years.Length];
            if (vicariateId == 0 && parishId == 0 && account.IsDioceseRole(roleId))
            {
                return _chartData.GetSumOfSacramentInDioceseByYear(dioceseId, years, out baptismResult, out holyCommunionResult, out confirmationResult);
            }
            else
            {
                if (vicariateId == 0 && parishId > 0 && account.IsDioceseRole(roleId))
                {
                    return  _chartData.GetSumOfSacramentInParishByYear(parishId, years, out baptismResult, out holyCommunionResult, out confirmationResult);
                }
                else
                {
                    if (vicariateId > 0 && parishId == 0 && account.IsDioceseRole(roleId))
                    {
                        return  _chartData.GetSumOfSacramentInVicariateByYear(vicariateId, years, out baptismResult, out holyCommunionResult, out confirmationResult);
                    }
                    else
                    {
                        return _chartData.GetSumOfSacramentInParishByYear(parishId, years, out baptismResult, out holyCommunionResult, out confirmationResult);
                    }
                }
            }
        }

        //Thống kê giáo dân từng giáo họ trong giáo xứ
        public IEnumerable<ChartCommunityViewModel> GetSumOfParishionerByCommunity(int parishId)
        {
            return _chartData.GetSumOfParishionerByCommunity(parishId);
        }

        //Thống kê theo từng độ tuổi
        public int[] GetsumOfParishionerByAge(int roleId, int dioceseId, int vicariateId, int parishId)
        {
            int[] result = new int[7];

            if (vicariateId == 0 && parishId == 0 && account.IsDioceseRole(roleId))
            {
                result = _chartData.GetSumOfParishionerByAgeInDiocese(dioceseId);
            }
            else
            {
                if (vicariateId == 0 && parishId > 0 && account.IsDioceseRole(roleId))
                {
                    result = _chartData.GetSumOfParishionerByAgeInParish(parishId);
                }
                else
                {
                    if (vicariateId > 0 && parishId == 0 && account.IsDioceseRole(roleId))
                    {
                        result = _chartData.GetSumOfParishionerByAgeInVicariate(vicariateId);
                    }
                    else
                    {
                        result = _chartData.GetSumOfParishionerByAgeInParish(parishId);
                    }
                }
            }
            return result;
        }

        //Thống kê tổng số giáo dân được sinh ra theo từng năm
        public int[] GetsumOfParishionersWereBornByYear(int roleId, int dioceseId, int vicariateId, int parishId, string[] years)
        {
            int[] result = new int[years.Length];

            if (vicariateId == 0 && parishId == 0 && account.IsDioceseRole(roleId))
            {
                result = _chartData.GetSumOfParishionersWereBornInDioceseByYear(dioceseId, years);
            }
            else
            {
                if (vicariateId == 0 && parishId > 0 && account.IsDioceseRole(roleId))
                {
                    result = _chartData.GetSumOfParishionersWereBornInParishByYear(parishId, years);
                }
                else
                {
                    if (vicariateId > 0 && parishId == 0 && account.IsDioceseRole(roleId))
                    {
                        result = _chartData.GetSumOfParishionersWereBornInVicariateByYear(vicariateId, years);
                    }
                    else
                    {
                        result = _chartData.GetSumOfParishionersWereBornInParishByYear(parishId, years);
                    }
                }
            }
            return result;
        }
    }
}
