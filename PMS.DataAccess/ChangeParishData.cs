using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.DataAccess
{
    public class ChangeParishData
    {
        private readonly PMSDataContext _db;

        public ChangeParishData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public int ChangeParishForParishioner(string[] parishioners, int toParishId, string toParishName)
        {

            try
            {
                foreach (var item in parishioners)
                {
                    int id = Int32.Parse(item);

                    var parishioner = _db.Parishioners.SingleOrDefault(p => p.Id == id);
                    

                    if (parishioner == null)
                    {
                        return 0;
                    }

                    //Thay doi trang thai tung nguoi

                    //kiem tra xem giao dan co dang o gia dinh nao ko
                    var checkMain =
                        _db.FamilyMembers.SingleOrDefault(
                            fm => fm.ParishionerId == parishioner.Id && fm.Status == (int)FamilyMemberStatusEnum.Main);
                    //neu co thi chuyen thanh sub
                    if (checkMain != null)
                    {
                        checkMain.Status = (int)FamilyMemberStatusEnum.Sub;
                    }
                    //-----------------------------------
                    if (toParishId == -1)
                    {
                        parishioner.DomicilePlace = toParishName;
                    }
                    else
                    {
                        var toParish = _db.Parishes.SingleOrDefault(pa => pa.Id == toParishId);
                        if (toParish == null)
                        {
                            return 0;
                        }
                        parishioner.DomicilePlace = toParish.Name;
                    }              
                    parishioner.DomicileStatus = (int)DomicileStatusEnum.TransferredToAnotherParish;                   
                    parishioner.Status = (int)ParishionerStatusEnum.Saved;

                    
                    //Tao request
                    if (toParishId == -1)
                    {
                        var request = new ParishionerMigrationRequest()
                        {

                            ParishionerId = id,
                            ToParishId = null,
                            CreatedDate = DateTime.Now,
                            FromCommunityId = parishioner.CommunityId,
                            Status = (int)MigrationRequestStatusEnum.Waiting
                        };
                        _db.ParishionerMigrationRequests.InsertOnSubmit(request);
                    }
                    else
                    {
                        var request = new ParishionerMigrationRequest()
                        {

                            ParishionerId = id,
                            ToParishId = toParishId,
                            CreatedDate = DateTime.Now,
                            FromCommunityId = parishioner.CommunityId,
                            Status = (int)MigrationRequestStatusEnum.Waiting
                        };
                        _db.ParishionerMigrationRequests.InsertOnSubmit(request);
                    }
                    
                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int ChangeParishForFamily(string[] families, int toParishId, string toParishName)
        {

            try
            {
                foreach (var item in families)
                {
                    int id = Int32.Parse(item);
                    var cfamilies = _db.Families.SingleOrDefault(c => c.Id == id);
                    if (cfamilies == null)
                    {
                        return 0;
                    }
                    var toParish = _db.Parishes.SingleOrDefault(pa => pa.Id == toParishId);

                    var member =
                      _db.FamilyMembers.Where(
                          fm => (fm.FamilyId == id && fm.Status == (int)FamilyMemberStatusEnum.Main && fm.Parishioner.Status != (int)ParishionerStatusEnum.Deleted)).Select(c => c.Parishioner);
                    //-----------------------------------------------------------------------------------------------------------
                    //Thay doi trang thai tung giao dan trong gia dinh
                    foreach (var parishioner in member)
                    {
                        //Kiem tra request co hay chua
                        ParishionerMigrationRequest fRequest = _db.ParishionerMigrationRequests.SingleOrDefault(pm => (pm.ParishionerId == parishioner.Id 
                                                                && pm.Community.ParishId == parishioner.Community.ParishId));

                        if (fRequest == null)
                        {
                            //Tao moi                           
                            var nRequest = new ParishionerMigrationRequest()
                            {
                                ParishionerId = parishioner.Id,
                                CreatedDate = DateTime.Now,
                                FromCommunityId = parishioner.CommunityId,
                                Status = (int)MigrationRequestStatusEnum.FamilyWaiting
                            };

                            if (toParishId == -1)
                            {
                                nRequest.ToParishId = null;
                            }
                            else
                            {
                                nRequest.ToParishId = toParishId;
                            }

                            _db.ParishionerMigrationRequests.InsertOnSubmit(nRequest);
                        }
                        else
                        {
                            //Cap nhat
                            if (toParishId == -1)
                            {
                                fRequest.ToParishId = null;
                            }
                            else
                            {
                                fRequest.ToParishId = toParishId;
                            }
                            fRequest.Status = (int) MigrationRequestStatusEnum.FamilyWaiting;
                        }

                        //Thay doi trang thai tung giao dan
                        parishioner.DomicilePlace = toParishId == -1 ? toParishName : toParish.Name;
                        parishioner.DomicileStatus = (int)DomicileStatusEnum.TransferredToAnotherParish;
                        parishioner.Status = (int)ParishionerStatusEnum.Saved;
                    }
                    
                    //----------------------------------------------------------------------------

                    //Kiem tra xem da ton tai family migration request hay chua
                    FamilyMigrationRequest familyRequest = _db.FamilyMigrationRequests.SingleOrDefault(fm => (fm.FamilyId == cfamilies.Id
                                                                && fm.Community.ParishId == cfamilies.Community.ParishId));
                    if (familyRequest == null)
                    {
                        //Tao moi                           
                        var request = new FamilyMigrationRequest()
                        {
                            FamilyId = cfamilies.Id,
                            CreatedDate = DateTime.Now,
                            FromCommunityId = cfamilies.CommunityId,
                            Status = (int)MigrationRequestStatusEnum.Waiting
                        };

                        if (toParishId == -1)
                        {
                            request.ToParishId = null;
                        }
                        else
                        {
                            request.ToParishId = toParishId;
                        }

                        _db.FamilyMigrationRequests.InsertOnSubmit(request);
                    }
                    else
                    {
                        //Cap nhat
                        if (toParishId == -1)
                        {
                            familyRequest.ToParishId = null;
                        }
                        else
                        {
                            familyRequest.ToParishId = toParishId;
                        }
                        familyRequest.Status = (int)MigrationRequestStatusEnum.Waiting;

                        _db.FamilyMigrationRequests.InsertOnSubmit(familyRequest);
                    }

                    //Thay doi trang thai tung gia dinh
                    
                    cfamilies.DomicilePlace = toParishId == -1 ? toParishName : toParish.Name;
                    cfamilies.DomicileStatus = (int)DomicileStatusEnum.TransferredToAnotherParish;
                    cfamilies.Status = (int)ParishionerStatusEnum.Saved;

                }

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }

        }

        public int CheckOtherParish(string name, int parishId, int dioceseId)
        {
            try
            {
                name = name.Trim().ToLower();
                const string query = "SELECT P.Id " +
                                     "FROM Parish AS P LEFT JOIN (Vicariate AS V INNER JOIN Diocese AS D ON V.DioceseId = D.Id) ON P.VicariateId = V.Id " +
                                     "WHERE LOWER(RTRIM(LTRIM((P.Name)))) = {0} AND D.Id = {1}";
                int unique = _db.ExecuteQuery<int>(query, name, dioceseId).SingleOrDefault();
                if (unique > 0)
                {
                    return unique;
                }
                return 0;
            }
            catch (Exception e)
            {

                return -1;
            }
        }
    }
}
