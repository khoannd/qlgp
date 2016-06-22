using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.BusinessLogic;

namespace PMS.Web
{
    public class AuthorizationChecking
    {
        private readonly string _urlForAdmin;
        private readonly string _urlWithIdForAdmin;
        private readonly string _urlForManager;
        private readonly string _urlForStaff;
        private readonly string _urlForTeacher;
        private readonly RolePermissionBusiness _rolePermissionBusiness;

        public AuthorizationChecking()
        {
            _rolePermissionBusiness = new RolePermissionBusiness(DbConfig.GetConnectionString());

            _urlForAdmin = @"/Account/AccountManagement, /Account/ChangePassword, /Diocese/Index, /Priest/Index, /Vicariate/Index, /Parish/Index,
                            /Search/Parishioner, /SearchFamily/Family, /Statistic/Index, /Chart/Index, /Message/CreateMessage,
                            /ParishHome/Index, /Community/Index, /Society/Index,
                            /Parishioner/Index, /Family/Index, /Parishioner/SaveStorage, /Parishioner/PrintPage, /Family/SaveStorage,
                            /ThuyenChuyenLinhMuc/Index, /ConstructionPermit/Index, /Seminary/Index, /Seminarian/Index, /DeaconRequisition/Index, /Priest/PrintPage";

            _urlWithIdForAdmin = @"/DeaconRequisitionComment/Index/{Id}";

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
            //if (roleId == (int)AccountEnum.Admin)
            //{
            //    var fragments = url.Split('/');
            //    var urlWithId = string.Join("/", fragments.Take(fragments.Length - 1)) + "/{Id}";
            //    return _urlForAdmin.Contains(url) || _urlWithIdForAdmin.Contains(urlWithId);
            //}

            //if (roleId == (int)AccountEnum.Manager)
            //{
            //    return _urlForManager.Contains(url);
            //}

            //if (roleId == (int)AccountEnum.Staff)
            //{
            //    return _urlForStaff.Contains(url);
            //}
            //else
            //{
            //    return _urlForTeacher.Contains(url);
            //}
            if(roleId == 1)
            {
                return true;
            }
            if (url.Contains("?")) url = url.Substring(0, url.IndexOf('?'));
            RolePermission rolePermission = _rolePermissionBusiness.GetScreenPermissionByRoleScreen(roleId, url);
            return rolePermission != null;
        }

    }
}