using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace PMS.DataAccess.Utilities
{
    public static class Tools
    {
        public static void CopyPropertiesTo<T, TU>(this T source, TU dest)
        {

            var sourceProps = typeof(T).GetProperties().Where(x => x.CanRead).ToList();
            var destProps = typeof(TU).GetProperties()
                    .Where(x => x.CanWrite)
                    .ToList();

            foreach (var sourceProp in sourceProps)
            {
                if(sourceProp.PropertyType.Namespace == "PMS.DataAccess.Models"
                    || sourceProp.PropertyType.IsGenericType &&
                        sourceProp.PropertyType.GetGenericTypeDefinition() == typeof(System.Data.Linq.EntitySet<>))
                {
                    continue;
                }
                if (destProps.Any(x => x.Name == sourceProp.Name))
                {
                    var p = destProps.First(x => x.Name == sourceProp.Name);
                    p.SetValue(dest, sourceProp.GetValue(source, null), null);
                }
            }
        }

        public static void CopyPropertiesTo<T, TU>(this IEnumerable<T> source, List<TU> dest) where TU : new()
        {
            foreach (var i in source)
            {
                var d = new TU();
                Tools.CopyPropertiesTo(i, d);
                dest.Add(d);
            }
        }

        public static bool IsInt(string n) {
            try
            {
                int o = 0;
                return int.TryParse(n, out o);
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool IsDouble(string n)
        {
            try
            {
                double o = 0;
                return double.TryParse(n, out o);
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool IsNumber(string n)
        {
            return IsDouble(n) || IsInt(n);
        }

        public static bool IsDate(string n)
        {
            Regex regex = new Regex("^([0-9]{1,2}[-|/])?([0-9]{1,2}[-|/])?([0-9]{4})$");
            return regex.IsMatch(n);
        }

        public static bool IsNullOrZero(int? i)
        {
            return (i == null || i == 0);
        }

        public static bool IsNullOrZero(double? i)
        {
            return (i == null || i == 0);
        }

        public static bool IsNullOrEmpty(object i)
        {
            return (i == null || i.ToString() == "");
        }

        public static string ConvertVnDateToDBString(string n)
        {
            Regex regex = new Regex("^([0-9]{1,2}[-|/])?([0-9]{1,2}[-|/])?([0-9]{4})$");
            string[] ss = regex.Split(n);
            string result = "";
            for(int i = ss.Length - 1; i >= 0; i--)
            {
                if(!string.IsNullOrEmpty(ss[i]))
                {
                    result = string.Concat(result, ss[i].Trim('/', '-'));
                }
            }
            return result.PadRight(8, '0');
        }
    }
}
