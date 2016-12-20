using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Enumerations;
using System.Transactions;

namespace PMS.DataAccess
{
    public class BanHanhGiaoData
    {
        private readonly PMSDataContext _db;
		public string ConnectionString = "";

        public BanHanhGiaoData(string connection)
        {
			ConnectionString = connection;
            _db = new PMSDataContext(connection);
        }

        public BanHanhGiao GetBanHanhGiaoById(int id)
        {
            const string query = "SELECT * FROM BanHanhGiao  WHERE Id = {0}";
            return _db.ExecuteQuery<BanHanhGiao>(query, id).SingleOrDefault();
        }

        public IEnumerable<BanHanhGiaoViewModel> GetAllBanHanhGiao()
        {
            string query = @"SELECT a.*, p.Name As ParishName, v.Name As VicariateName 
FROM BanHanhGiao a INNER JOIN Parish p ON a.ParishId = p.Id 
INNER JOIN Vicariate v ON p.VicariateId = v.Id ";
            return _db.ExecuteQuery<BanHanhGiaoViewModel>(query);
        }

        public IEnumerable<BanHanhGiaoViewModel> GetBanHanhGiaoByParishId(int parishId)
        {
            string query = @"SELECT a.*, p.Name As ParishName, v.Name As VicariateName 
FROM BanHanhGiao a INNER JOIN Parish p ON a.ParishId = p.Id 
INNER JOIN Vicariate v ON p.VicariateId = v.Id WHERE p.Id={0}";
            return _db.ExecuteQuery<BanHanhGiaoViewModel>(query, parishId);
        }

        public int AddBanHanhGiao(BanHanhGiao banHanhGiao)
        {
            try
            {
                _db.BanHanhGiaos.InsertOnSubmit(banHanhGiao);
                _db.SubmitChanges();
                return banHanhGiao.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int UpdateBanHanhGiao(BanHanhGiao banHanhGiao, List<BanHanhGiaoMember> banHanhGiaoMembers, bool useTransaction)
        {
            try
            {
                using (var scope = new TransactionScope((useTransaction ? TransactionScopeOption.Required : TransactionScopeOption.Suppress)))
                {
                    var item = _db.BanHanhGiaos.SingleOrDefault(d => d.Id == banHanhGiao.Id);
                    if (item == null)
                    {
                        return 0;
                    }

                    item.Name = banHanhGiao.Name;
                    item.FromDate = banHanhGiao.FromDate;
                    item.ToDate = banHanhGiao.ToDate;
                    item.ParishId = banHanhGiao.ParishId;

                    if (banHanhGiaoMembers != null && banHanhGiaoMembers.Count > 0)
                    {
                        foreach (var child in banHanhGiaoMembers)
                        {
                            this.UpdateBanHanhGiaoMember(child);
                        }
                    }

                    _db.SubmitChanges();

                    scope.Complete();
                    return banHanhGiao.Id;
                }
            }
            catch (Exception e)
            {

                return -1;
            }
        }

        public int DeleteBanHanhGiao(int Id)
        {
            try
            {
                BanHanhGiao banHanhGiao = _db.BanHanhGiaos.SingleOrDefault(c => c.Id == Id);
                var item = _db.BanHanhGiaoMembers.Where(d => d.BanHanhGiaoId == banHanhGiao.Id);
                _db.BanHanhGiaoMembers.DeleteAllOnSubmit(item);
                _db.BanHanhGiaos.DeleteOnSubmit(banHanhGiao);                
                
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int CheckUniqueBanHanhGiao(string name, int banHanhGiaoId)
        {
            try
            {
                name = name.Trim().ToLower();
                string query = "SELECT a.Name " +
                                     "FROM BanHanhGiao a " +
                                     "WHERE LOWER(RTRIM(LTRIM((a.Name)))) = {0} AND a.Id != {1} ";
                string unique = _db.ExecuteQuery<string>(query, name, banHanhGiaoId).SingleOrDefault();
                if (string.IsNullOrEmpty(unique))
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

		public int CheckUniqueBanHanhGiaoMember(int banHanhGiaoId, int parishionerId)
        {
            try
            {
                string query = "SELECT 1 " +
                                     "FROM BanHanhGiaoMember " +
                                     "WHERE BanHanhGiaoId = {0} AND ParishionerId = {1} ";
                int? unique = _db.ExecuteQuery<int?>(query, banHanhGiaoId, parishionerId).SingleOrDefault();
                if (unique == null)
                {
                    return 1;
                }
                return 0;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

		public List<BanHanhGiaoMemberViewModel> LoadBanHanhGiaoMemberList(string Id)
        {
            string query = @"select NN.BanHanhGiaoId, NN.ParishionerId, P.BirthDate, NN.RoleId, IIF(P.Gender = 0, 'Bà', 'Ông') Title, concat(P.ChristianName,' ',P.Name) as ParishionerName
                            from BanHanhGiaoMember NN
                            left join Parishioner P on NN.ParishionerId = P.Id
                            where NN.BanHanhGiaoId={0} ORDER BY NN.RoleId ASC ";
            List<BanHanhGiaoMemberViewModel> ce = _db.ExecuteQuery<BanHanhGiaoMemberViewModel>(query, Id).ToList();
            return ce;
        }

		public int AddBanHanhGiaoMember(BanHanhGiaoMember banHanhGiaoMember)
        {
            try
            {
                if (banHanhGiaoMember.RoleId == null)
                {
                    banHanhGiaoMember.RoleId = (int)BanHanhGiaoRoleEnum.ThanhVien;//Thành viên
                }
                _db.BanHanhGiaoMembers.InsertOnSubmit(banHanhGiaoMember);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

		public int UpdateBanHanhGiaoMember(BanHanhGiaoMember banHanhGiaoMember)
        {
            try
            {
                var item = _db.BanHanhGiaoMembers.SingleOrDefault(d => d.BanHanhGiaoId == banHanhGiaoMember.BanHanhGiaoId && d.ParishionerId == banHanhGiaoMember.ParishionerId);
                if (item == null)
                {
                    return 0;
                }

                item.BanHanhGiaoId = banHanhGiaoMember.BanHanhGiaoId;
                item.ParishionerId = banHanhGiaoMember.ParishionerId;
                if(banHanhGiaoMember.RoleId == null)
                {
                    banHanhGiaoMember.RoleId = (int)BanHanhGiaoRoleEnum.ThanhVien;//Thành viên
                }
                item.RoleId = banHanhGiaoMember.RoleId;

                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {

                return -1;
            }
        }

		public int DeleteBanHanhGiaoMember(int Id, int parishionerId)
        {
            try
            {
                BanHanhGiaoMember BanHanhGiaoMember = _db.BanHanhGiaoMembers.SingleOrDefault(c => c.BanHanhGiaoId == Id && c.ParishionerId == parishionerId);
                _db.BanHanhGiaoMembers.DeleteOnSubmit(BanHanhGiaoMember);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public List<ValueSet> GetMemberRoleData()
        {
            try
            {
                string query = @"select * FROM ValueSet
                            WHERE [Category]='BHG_Role'";
                List<ValueSet> ce = _db.ExecuteQuery<ValueSet>(query).ToList();
                return ce;
            }
            catch (Exception e)
            {
                return null;
            }
        }
    }
}

