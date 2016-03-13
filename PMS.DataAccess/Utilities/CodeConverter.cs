 using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.Utilities
{
    public class CodeConverter
    {
        public string GenerateCode(string oldCode, string prefix, int characterNumber)
        {
            string codeValue = "";
            string remain = "";

            if (!string.IsNullOrEmpty(oldCode))
            {
                if (string.IsNullOrEmpty(prefix))
                {
                    codeValue = oldCode;
                }
                else
                {
                    codeValue = oldCode.Replace(prefix, "");
                }
              
                int value = Int32.Parse(codeValue);
                value = value + 1;
                codeValue = value.ToString();

                

                for (int i = 0; i < characterNumber - (codeValue.Length); i++)
                {
                    remain += "0";
                }

                return prefix + remain + codeValue;
            }

            codeValue = "1";
            for (int i = 0; i < characterNumber - (codeValue.Length); i++)
            {
                remain += "0";
            }

            return prefix + remain + codeValue;

        }

    }
}
