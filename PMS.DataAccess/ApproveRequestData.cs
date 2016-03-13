using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class ApproveRequestData
    {
        private readonly PMSDataContext _db;

        public ApproveRequestData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<ParishionerMigrationRequest> GetParishionerMigrationRequestByParishId(int id)
        {
            const string query = "SELECT * FROM ParishionerMigrationRequest " +
                                 "WHERE ToParishId = {0} AND Status = {1}";
            return _db.ExecuteQuery<ParishionerMigrationRequest>(query, id, (int)MigrationRequestStatusEnum.Waiting);
        }

        public IEnumerable<ParishionerMigrationRequest> GetParishionerMigrationRequestSendingByParishId(int id)
        {
            const string query = "SELECT PM.* FROM ParishionerMigrationRequest AS PM INNER JOIN (Community AS C INNER JOIN " +
                                 "Parish AS P ON C.ParishId = P.Id) ON PM.FromCommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND PM.Status = {1} AND PM.ToParishId IS NOT NULL";
            return _db.ExecuteQuery<ParishionerMigrationRequest>(query, id, (int)MigrationRequestStatusEnum.Waiting);
        }

        //public int CountParishionerMigrationRequestByParishId(int id)
        //{
        //    const string query = "SELECT COUNT(ToParishId) FROM ParishionerMigrationRequest " +
        //                         "WHERE ToParishId = {0} AND Status = {1}";
        //    return _db.ExecuteQuery<int>(query, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();
        //}

        //public int CountParishionerMigrationSendingRequestByParishId(int id)
        //{
        //    const string query = "SELECT COUNT(FromCommunityId) FROM ParishionerMigrationRequest AS PM INNER JOIN (Community AS C INNER JOIN " +
        //                         "Parish AS P ON C.ParishId = P.Id) ON PM.FromCommunityId = C.Id " +
        //                         "WHERE P.Id = {0} AND PM.Status = {1} AND PM.ToParishId IS NOT NULL";
        //    return _db.ExecuteQuery<int>(query, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();
        //}

        public int CountAll(int id, out int parishionerSendingRequest, out int familyReceivingRequest, out int familySendingRequest)
        {
            int parishionerReceived = 0;
            int parishionerSending = 0;
            int familyRecevied = 0;
            int familySending = 0;

            const string query = "SELECT COUNT(ToParishId) FROM ParishionerMigrationRequest " +
                                "WHERE ToParishId = {0} AND Status = {1}";
            parishionerReceived = _db.ExecuteQuery<int>(query, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();

            const string query2 = "SELECT COUNT(FromCommunityId) FROM ParishionerMigrationRequest AS PM INNER JOIN (Community AS C INNER JOIN " +
                                 "Parish AS P ON C.ParishId = P.Id) ON PM.FromCommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND PM.Status = {1} AND PM.ToParishId IS NOT NULL";
            parishionerSending =  _db.ExecuteQuery<int>(query2, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();

            const string query3 = "SELECT COUNT(ToParishId) FROM FamilyMigrationRequest " +
                                 "WHERE ToParishId = {0} AND Status = {1}";
            familyRecevied = _db.ExecuteQuery<int>(query3, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();

            const string query4 = "SELECT COUNT(FromCommunityId) FROM FamilyMigrationRequest AS PM INNER JOIN (Community AS C INNER JOIN " +
                                "Parish AS P ON C.ParishId = P.Id) ON PM.FromCommunityId = C.Id " +
                                "WHERE P.Id = {0} AND PM.Status = {1} AND PM.ToParishId IS NOT NULL";
            familySending = _db.ExecuteQuery<int>(query4, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();

            parishionerSendingRequest = parishionerSending;
            familyReceivingRequest = familyRecevied;
            familySendingRequest = familySending;
            return parishionerReceived;
        }

        public int ApproveParishionerMigrationRequest(int communityId, int[] ids, int accountId)
        {

            try
            {
                foreach (var item in ids)
                {
                    //int id = Int32.Parse(item);

                    var request = _db.ParishionerMigrationRequests.SingleOrDefault(pm => pm.Id == item);
                    if (request == null)
                    {
                        return 0;
                    }
                    var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == request.ParishionerId);
                    if (parishioner == null)
                    {
                        return 0;
                    }
                    //kiem tra xem giao dan co dang o gia dinh nao ko
                    var checkMain =
                        _db.FamilyMembers.SingleOrDefault(
                            fm => fm.ParishionerId == parishioner.Id && fm.Status == (int)FamilyMemberStatusEnum.Main);
                    if (checkMain != null)
                    {
                        checkMain.Status = (int)FamilyMemberStatusEnum.Sub;
                    }
                    //Kiem tra xem co ton tai request chuyen di luc truoc tu giao xu nay ko
                    var oldRequest =
                        _db.ParishionerMigrationRequests.SingleOrDefault(pm => (pm.ParishionerId == request.ParishionerId 
                        && pm.Community.ParishId == request.ToParishId));
                    if (oldRequest != null)
                    {
                        _db.ParishionerMigrationRequests.DeleteOnSubmit(oldRequest);
                    }                   

                    //Thay doi trang thai request
                    request.Status = (int)MigrationRequestStatusEnum.Approved;

                    //Thay doi trang thai tung nguoi
                    parishioner.DomicilePlace = request.Community.Parish.Name;
                    parishioner.DomicileStatus = (int)DomicileStatusEnum.TransferredFromAnotherParish;
                    parishioner.Status = (int)ParishionerStatusEnum.Available;
                    parishioner.CommunityId = communityId;

                    //Tao thu gui den giao xu cu
                    var message = new Message
                    {
                        AccountId = accountId,
                        ParishId = request.Community.ParishId,
                        CreatedDate = DateTime.Now,
                        Title = "Hệ thống: Thông tin chuyển xứ",
                        Content = "Thông tin yêu cầu chuyển xứ của giáo dân " + parishioner.ChristianName + " " + parishioner.Name + " vừa được duyệt. Xin cảm ơn sự giúp đỡ của quý cha!"
                    };
                    _db.Messages.InsertOnSubmit(message);
                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int DenyParishionerMigrationRequest(int id)
        {

            try
            {

                ParishionerMigrationRequest request = _db.ParishionerMigrationRequests.SingleOrDefault(pm => pm.Id == id);

                if (request == null)
                {
                    return 0;
                }
                //Thay doi trang thai request
                request.Status = (int)MigrationRequestStatusEnum.Reject;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int CancelParishionerMigrationRequestSending(int id)
        {
            try
            {
                ParishionerMigrationRequest request = _db.ParishionerMigrationRequests.SingleOrDefault(pm => pm.Id == id);
                
                if (request == null)
                {
                    return 0;
                }
                
                
                var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == request.ParishionerId);
                if (parishioner == null)
                {
                    return 0;
                }
                //thay doi thuoc tinh cua giao dan ve trang thai ban dau
                parishioner.DomicilePlace = "";
                parishioner.DomicileStatus = (int) DomicileStatusEnum.InParish;
                parishioner.Status = (int)ParishionerStatusEnum.Available;

                _db.ParishionerMigrationRequests.DeleteOnSubmit(request);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                
                return -1;
            }
           
        }
        //------------------------------------------------------------------------------------
        //Family
        public IEnumerable<FamilyMigrationRequest> GetFamilyMigrationRequestByParishId(int id)
        {
            const string query = "SELECT * FROM FamilyMigrationRequest " +
                                 "WHERE ToParishId = {0} AND Status = {1}";
            return _db.ExecuteQuery<FamilyMigrationRequest>(query, id, (int)MigrationRequestStatusEnum.Waiting);
        }

        public IEnumerable<FamilyMigrationRequest> GetFamilyrMigrationRequestSendingByParishId(int id)
        {
            const string query = "SELECT PM.* FROM FamilyMigrationRequest AS PM INNER JOIN (Community AS C INNER JOIN " +
                                 "Parish AS P ON C.ParishId = P.Id) ON PM.FromCommunityId = C.Id " +
                                 "WHERE P.Id = {0} AND PM.Status = {1} AND PM.ToParishId IS NOT NULL";
            return _db.ExecuteQuery<FamilyMigrationRequest>(query, id, (int)MigrationRequestStatusEnum.Waiting);
        }

        //public int CountFamilyMigrationRequestByParishId(int id)
        //{
        //    const string query = "SELECT COUNT(ToParishId) FROM FamilyMigrationRequest " +
        //                         "WHERE ToParishId = {0} AND Status = {1}";
        //    return _db.ExecuteQuery<int>(query, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();
        //}

        //public int CountFamilyMigrationSendingRequestByParishId(int id)
        //{
        //    const string query = "SELECT COUNT(FromCommunityId) FROM FamilyMigrationRequest AS PM INNER JOIN (Community AS C INNER JOIN " +
        //                         "Parish AS P ON C.ParishId = P.Id) ON PM.FromCommunityId = C.Id " +
        //                         "WHERE P.Id = {0} AND PM.Status = {1} AND PM.ToParishId IS NOT NULL";
        //    return _db.ExecuteQuery<int>(query, id, (int)MigrationRequestStatusEnum.Waiting).SingleOrDefault();
        //}

        public int ApproveFamilyMigrationRequest(int communityId, string[] ids, int accountId)
        {

            try
            {
                foreach (var item in ids)
                {
                    int id = Int32.Parse(item);

                    var fRequest = _db.FamilyMigrationRequests.SingleOrDefault(fm => fm.Id == id);
                    if (fRequest == null)
                    {
                        return 0;
                    }
                    var cfamilies = _db.Families.SingleOrDefault(f => f.Id == fRequest.FamilyId);
                    if (cfamilies == null)
                    {
                        return 0;
                    }
                    var member =
                      _db.FamilyMembers.Where(
                          fm => (fm.FamilyId == cfamilies.Id && fm.Status == (int)FamilyMemberStatusEnum.Main && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted)).Select(c => c.Parishioner);

                    //Thay doi trang thai tung giao dan trong gia dinh
                    foreach (var parishioner in member)
                    {
                        var pRequest =
                            _db.ParishionerMigrationRequests.SingleOrDefault(pm => pm.ParishionerId == parishioner.Id && pm.ToParishId == fRequest.ToParishId && pm.FromCommunityId == fRequest.FromCommunityId);
                        if (pRequest == null)
                        {
                            return 0;
                        }

                        //Kiem tra xem co ton tai request chuyen di luc truoc tu giao xu nay ko
                        var oldRequest =
                            _db.ParishionerMigrationRequests.SingleOrDefault(pm => pm.ParishionerId == pRequest.ParishionerId
                            && pm.Community.ParishId == pRequest.ToParishId);
                        if (oldRequest != null)
                        {
                            _db.ParishionerMigrationRequests.DeleteOnSubmit(oldRequest);
                        }   

                        //Thay doi trang thai request cua giao dan
                        pRequest.Status = (int)MigrationRequestStatusEnum.Approved;

                        //Thay doi trang thai tung giao dan
                        parishioner.DomicilePlace = pRequest.Community.Parish.Name; 
                        parishioner.DomicileStatus = (int)DomicileStatusEnum.TransferredFromAnotherParish;
                        parishioner.Status = (int)ParishionerStatusEnum.Available;
                        parishioner.CommunityId = communityId;
                    }

                    //----------------------------------------------------------------------------
                    //Gia dinh
                    //Kiem tra xem co ton tai request chuyen di luc truoc tu giao xu nay ko
                    var familyOldRequest =
                        _db.FamilyMigrationRequests.SingleOrDefault(pm => (pm.FamilyId == fRequest.FamilyId
                        && pm.Community.ParishId == fRequest.ToParishId));
                    if (familyOldRequest != null)
                    {
                        _db.FamilyMigrationRequests.DeleteOnSubmit(familyOldRequest);
                    }   
                    //Thay doi trang thai request cua gia dinh
                    fRequest.Status = (int) MigrationRequestStatusEnum.Approved;
                    //Thay doi thong tin gia dinh
                    cfamilies.DomicilePlace = fRequest.Community.Parish.Name; 
                    cfamilies.DomicileStatus = (int)DomicileStatusEnum.TransferredFromAnotherParish;
                    cfamilies.Status = (int)FamilyStatusEnum.Available;
                    cfamilies.CommunityId = communityId;

                    //Tao thu gui den giao xu cu
                    var message = new Message
                    {
                        AccountId = accountId,
                        ParishId = fRequest.Community.ParishId,
                        CreatedDate = DateTime.Now,
                        Title = "Hệ thống: Thông tin chuyển xứ",
                        Content = "Thông tin yêu cầu chuyển xứ của gia đình " + cfamilies.Name + " vừa được duyệt. Xin cảm ơn sự giúp đỡ của quý cha!"
                    };
                    _db.Messages.InsertOnSubmit(message);
                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }
        //----------------------------------------------------------------------------
        public int DenyFamilyMigrationRequest(int id)
        {

            try
            {

                FamilyMigrationRequest request = _db.FamilyMigrationRequests.SingleOrDefault(pm => pm.Id == id);
                if (request == null)
                {
                    return 0;
                }
                var member =
                      _db.FamilyMembers.Where(
                          fm => (fm.FamilyId == request.FamilyId && fm.Status == (int)FamilyMemberStatusEnum.Main && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted)).Select(c => c.Parishioner);
                foreach (var parishioner in member)
                {
                    var pRequest =
                        _db.ParishionerMigrationRequests.SingleOrDefault(pm => pm.ParishionerId == parishioner.Id);
                    if (pRequest == null)
                    {
                        return 0;
                    }
                    //Thay doi trang thai request cua giao dan
                    pRequest.Status = (int)MigrationRequestStatusEnum.Reject;

                }


                //Thay doi trang thai request cua gia dinh
                request.Status = (int)MigrationRequestStatusEnum.Reject;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }
        //----------------------------------------------------------------------------
        public int CancelFamilyMigrationRequestSending(int id)
        {
            try
            {
                FamilyMigrationRequest request = _db.FamilyMigrationRequests.SingleOrDefault(pm => pm.Id == id);
                if (request == null)
                {
                    return 0;
                }
                var cfamilies = _db.Families.SingleOrDefault(c => c.Id == request.FamilyId);
                if (cfamilies == null)
                {
                    return 0;
                }
                var member =
                      _db.FamilyMembers.Where(
                          fm => (fm.FamilyId == cfamilies.Id && fm.Status == (int)FamilyMemberStatusEnum.Main && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted)).Select(c => c.Parishioner);

                //Thay doi tung giao dan trong gia dinh ve trang thai ban dau
                foreach (var parishioner in member)
                {
                    var pRequest =
                        _db.ParishionerMigrationRequests.SingleOrDefault(pm => (pm.ParishionerId == parishioner.Id && pm.ToParishId == request.ToParishId));
                    if (pRequest == null)
                    {
                        return 0;
                    }
                    //Xoa request tung giao dan
                    _db.ParishionerMigrationRequests.DeleteOnSubmit(pRequest);

                    //Thay doi thong tin tung giao dan ve trang thai ban dau
                    parishioner.DomicilePlace = "";
                    parishioner.DomicileStatus = (int)DomicileStatusEnum.InParish;
                    parishioner.Status = (int)ParishionerStatusEnum.Available;
                }

                //Thay doi tung gia dinh ve trang thai ban dau
                //Xoa request cua gia dinh
                _db.FamilyMigrationRequests.DeleteOnSubmit(request);

                //Thay doi thong tin gia dinh ve trang thai ban dau
                cfamilies.DomicilePlace = "";
                cfamilies.DomicileStatus = (int)DomicileStatusEnum.InParish;
                cfamilies.Status = (int)FamilyStatusEnum.Available;
                
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }
    }
}
