using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.Web
{
    public class AuthorizationChecking
    {
        private readonly string _urlForAdmin;
        private readonly string _urlForManager;
        private readonly string _urlForStaff;
        private readonly string _urlForTeacher;

        public AuthorizationChecking()
        {
            _urlForAdmin = @"/Account/AccountManagement, /Account/ChangePassword, /Diocese/Index, /Priest/Index, /Vicariate/Index, /Parish/Index,
                            /Search/Parishioner, /SearchFamily/Family, /Statistic/Index, /Chart/Index, /Message/CreateMessage,
                            /ThuyenChuyenLinhMuc/Index, /Seminary/Index, /Seminarian/Index, /Seminary/DeaconRequisitionSession";

            _urlForManager = "/Account/ChangePassword, /ApproveRequest/Family, /ApproveRequest/ViewFamilyRequest, /ApproveRequest/Parishioner, /ApproveRequest/ViewParishionerRequest, /Configuration/Index, /Configuration/PreviewTemplate, " +
                             "/ParishHome/Index, /Community/Index, /Society/Index, " +
                             "/Parishioner/Index, /Family/Index, /Parishioner/SaveStorage, /Parishioner/PrintPage, /Family/SaveStorage, " +
                             "/Sacrament/Index?type=1, /Sacrament/Index?type=2, /Sacrament/Index?type=3, /Sacrament/Index?type=4, " +
                             "/DoctrineCourse/Index, /DoctrineCourse/ManageClass, /ChangeCommunity/Parishioner, /ChangeCommunity/Family, " +
                             "/ChangeParish/Parishioner, /ChangeParish/Family, /SacramentCreation/Index, " +
                             "/Search/Parishioner, /SearchFamily/Family, /Statistic/Index, /Chart/Index, /DataChecking/Parishioner, /Message/CreateMessage ";

            _urlForStaff = "/Account/ChangePassword, /ParishHome/Index, /Community/Index, /Society/Index, " +
                             "/Parishioner/Index, /Family/Index, /Parishioner/SaveStorage, /Parishioner/PrintPage, /Family/SaveStorage, " +
                             "/Sacrament/Index?type=1, /Sacrament/Index?type=2, /Sacrament/Index?type=3, /Sacrament/Index?type=4, " +
                             "/DoctrineCourse/Index, /DoctrineCourse/ManageClass, /ChangeCommunity/Parishioner, /ChangeCommunity/Family, " +
                             "/ChangeParish/Parishioner, /ChangeParish/Family, /SacramentCreation/Index, ";

            _urlForTeacher = "/Account/ChangePassword, /DoctrineCourse/ManageClass";
        }

        public bool CheckValidUrl(string url, int roleId)
        {
            if (roleId == (int) AccountEnum.Admin)
            {
                return _urlForAdmin.Contains(url);
            }

            if (roleId == (int)AccountEnum.Manager)
            {
                return _urlForManager.Contains(url);
            }

            if (roleId == (int)AccountEnum.Staff)
            {
                return _urlForStaff.Contains(url);
            }
            else
            {
                return _urlForTeacher.Contains(url);
            }
        }


    }
}