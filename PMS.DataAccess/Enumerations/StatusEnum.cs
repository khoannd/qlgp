using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess.Enumerations
{
    public enum AccountStatusEnum
    {
        Deactive = 0,
        Active = 1
    }

    public enum GenderEnum
    {
        Female = 0,
        Male = 1
    }
    public enum ParishionerStatusEnum
    {
        AvailableAndSaved = -3,
        Waiting = -2,
        Deleted = -1,
        Saved = 0,
        Available = 1,
    }

    public enum FamilyStatusEnum
    {
        AvailableAndSaved = -3,
        Waiting = -2,
        Deleted = -1,
        Saved = 0,
        Available = 1,
    }

    public enum MatrimonyStatusEnum
    {
        None = 0,
        Legal = 1,
        Regularized = 2,
        Standard = 3,
        RuleBreak = 4,
        Removed = 5,
        Undefined = 6
    }

    public enum VocationEnum
    {
        None = 0,
        Cleric = 1,
        Seminarist = 2,
        Deacon = 3,
        Priest = 4,
        Bishop = 5,
        Fully = 6,
        Other = 7,
    }

    public enum ClassMemberPositionEnum
    {
        None = 0,
        Teacher = 1,
        Learner = 2,
    }

    public enum DomicileStatusEnum
    {
        InParish = 0,
        TransferredFromAnotherParish = 1,
        TransferredToAnotherParish = 2,
    }

    public enum AccountEnum
    {
        Admin = 1,
        Manager = 2,
        Staff = 3,
        Teacher = 4
    }

    public enum MigrationRequestStatusEnum
    {
        Waiting = 1,
        Approved = 2,
        Reject = 3,
        FamilyWaiting = 4
    }

    public enum FamilyEnum
    {
        Chuho = 1,
        Chong = 2,
        Vo = 3,
        Con = 4,
        Chau = 5,
        Cha = 6,
        Me = 7,
        Ong = 8,
        Ba = 9,
        Anh = 10,
        Chi = 11,
        Em = 12,
        Dau = 13,
        Re = 14,
        Co = 15,
        Chu = 16,
        Bac = 17,
        Cau = 18,
        Di = 19,
        Mo = 20,
        Thim = 21,
        Duong = 22,
        Undefined = 23
    }

    public enum FamilyMemberStatusEnum
    {
        Sub = 0,
        Main = 1
    }

    public enum TreeItemTypeEnum
    {
        Diocese = 0,
        Vicariate = 1,
        Parish = 2,
        Community = 3,
        ParishDivision = 4,
        Family = 5,
        Parishioner = 6
    }

    public enum DeaconRequisitionSessionStatus
    {
        WaitingForComment = 0,
        WaitingForOrdinationMass = 1,
        Completed = 2
    }

    public enum VocationDeaconRequisitionSessionStatus
    {
        Pending = 0,
        Approved = 1,
        Disapproved = -1
    }

    public enum BanHanhGiaoRoleEnum
    {
        ChuTich = 1,
        PhoChuTich = 2,
        ThuKy = 3,
        ThuQuy = 4,
        ThanhVien = 5
    }

    public enum ParishManagerStatusEnum
    {
        None = 0,
        DaGoiGiayMoi = 1,
        DaGoiQuyetDinh = 2,
        DaNhanNhiemVu = 3
    }
}
