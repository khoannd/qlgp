using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;

namespace PMS.DataAccess.Utilities
{
    public class MessageConverter
    {
        public string CommonConverter(int code, int action)
        {
   
            if (code == (int) CommonErrorEnum.None)
            {
                if (action == (int) ActionEnum.Create)
                {
                    return "Thêm mới thành công";
                }
                else if (action == (int) ActionEnum.Update)
                {
                    return "Cập nhật thành công";
                }
                else if (action == (int) ActionEnum.Delete)
                {
                    return "Xóa thành công";
                }
            }

            if (code == (int) CommonErrorEnum.Exception)
            {
                if (action == (int)ActionEnum.Create)
                {
                    return "Thêm mới thất bại";
                }
                else if (action == (int)ActionEnum.Update)
                {
                    return "Cập nhật thất bại";
                }
                else if (action == (int)ActionEnum.Delete)
                {
                    return "Xóa thất bại";
                }
                else
                {
                    return "Có lỗi xảy ra, xin vui lòng thử lại sau";
                }           
            }

            return "";
        }

        public string LoginConverter(int code)
        {
            if (code == (int)CommonErrorEnum.None)
            {
                return "Đăng nhập thành công... Đang chuyển trang...";
            }
            else if (code == (int) UserErrorEnum.NotExisted)
            {
                return "Tên tài khoản hoặc mật khẩu không đúng";
            }
            else if (code == (int) UserErrorEnum.Deactive)
            {
                return "Tài khoản đã bị khóa";
            } else if (code == (int) CommonErrorEnum.Exception)
            {
                return "Đăng nhập thất bại, vui lòng thử lại sau";
            }
            return "";
        }

    }
}
