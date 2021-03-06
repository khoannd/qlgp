﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.Utilities
{
    public class DateConverter
    {
        static DateConverter instance = null;
        public static DateConverter GetInstance()
        {
            if(instance == null) instance = new DateConverter();
            return instance;
        }
        public string ConvertStringToDate(string date)
        {
            if (date == null)
            {
                return "";
            }

            date = date.Trim();
            if (string.IsNullOrEmpty(date))
            {
                return "";
            }

            string year = date.Substring(0, 4);
            string month = date.Substring(4, 2);
            string day = date.Substring(6, 2);

            string result = "";

            if (!day.Equals("00"))
            {
                result += day + "/";
            }

            if (!month.Equals("00"))
            {
                result += month + "/";
            }

            result += year;

            return result;
        }

        public string ConvertStringToDate2(string date)
        {
            if (string.IsNullOrWhiteSpace(date))
            {
                return "";
            }

            date = date.Trim();

            string year = date.Substring(0, 4);
            string month = date.Substring(4, 2);
            string day = date.Substring(6, 2);

            string result = "";

            if (!day.Equals("00"))
            {
                result += day + ".";
            }

            if (!month.Equals("00"))
            {
                result += month + ".";
            }

            result += year;

            return result;
        }

        public DateTime ConvertStringToDateObject(string date)
        {
            string strDate = ConvertStringToDate(date);
            DateTime dateObject;
            DateTime.TryParseExact(strDate, new string[] { "yyyyMMdd", "yyyy0000", "yyyyMM00", "yyyyMM", "yyyy" }, CultureInfo.CurrentCulture, DateTimeStyles.None, out dateObject);

            return dateObject;
        }
        public DateTime? ConvertStringToDateObjectNullable(string date)
        {
            string strDate = ConvertStringToDate(date);
            DateTime dateObject;
            bool parsed = DateTime.TryParseExact(date, new string[] { "yyyyMMdd", "yyyy0000", "yyyyMM00", "yyyyMM", "yyyy" }, CultureInfo.CurrentCulture, DateTimeStyles.None, out dateObject);

            if (parsed)
            {
                return dateObject;
            }
            else
            {
                return null;
            }
        }

        public string ConvertDateToString(string date)
        {
            string day;
            string month;
            string year;

            if (string.IsNullOrEmpty(date))
            {
                return "";
            }

            string[] dateParts = date.Split('/', '-');

            if (dateParts.Count() == 3)
            {
                day = ConvertStringForDateAndMonth(dateParts[0]);
                month = ConvertStringForDateAndMonth(dateParts[1]);
                year = dateParts[2];
            }
            else if (dateParts.Count() == 2)
            {
                day = "00";
                month = ConvertStringForDateAndMonth(dateParts[0]);
                year = dateParts[1];
            }
            else if (dateParts.Count() == 1)
            {
                day = "00";
                month = "00";
                year = dateParts[0];
            }
            else
            {
                return "";
            }

            return year.Trim() + month.Trim() + day.Trim();
        }

        public string ConvertDateToString2(string date)
        {
            string day;
            string month;

            if (string.IsNullOrEmpty(date))
            {
                return "";
            }

            string[] dateParts = date.Split('/', '-');

            if (dateParts.Count() == 2)
            {
                day = ConvertStringForDateAndMonth(dateParts[0]);
                month = dateParts[1];
            }
            else if (dateParts.Count() == 1)
            {
                day = "00";
                month = dateParts[0];
            }
            else
            {
                return "";
            }

            return month.Trim() + day.Trim();
        }

        private string ConvertStringForDateAndMonth(string s)
        {
            string result;

            if (s.Length == 1)
            {
                result = "0" + s;
            }
            else
            {
                result = s;
            }

            return result;
        }

        public static string GetYear(string strDate)
        {
            if(string.IsNullOrEmpty(strDate) || strDate.Length < 4)
            {
                return "";
            }
            return strDate.Substring(0, 4);
        }

        public static int CalCulateAgeInt(string strDate) {
            string year = GetYear(strDate);
            if(year != "")
            {
                return DateTime.Now.Year - int.Parse(year);
            }
            return 0;
        }

    }
}
