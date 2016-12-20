using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class BanHanhGiaoBusiness
    {
        private readonly BanHanhGiaoData _banHanhGiaoData;

        public BanHanhGiaoBusiness(string connection)
        {
            _banHanhGiaoData = new BanHanhGiaoData(connection);
        }

        public List<BanHanhGiaoViewModel> GetOrderedBanHanhGiaoByParamsAndPaging(jQueryDataTableParam param, out int totalRecords, out int totalDisplayRecords)
        {
            // get parameters
            string searchValue = param.search["value"];
            int sortColumnIndex = Convert.ToInt32(param.order[0]["column"]);
            string sortDirection = param.order[0]["dir"];
            int displayStart = param.start;
            int displayLength = param.length;
            IEnumerable<BanHanhGiaoViewModel> banHanhGiao = null;
            if (param.ParishId != null && param.ParishId != 0)
            {
                banHanhGiao = _banHanhGiaoData.GetBanHanhGiaoByParishId((int)param.ParishId);
            }
            else
            {
                banHanhGiao = _banHanhGiaoData.GetAllBanHanhGiao();
            }

            IEnumerable<BanHanhGiaoViewModel> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = banHanhGiao.Where(c => (c.Name.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = banHanhGiao;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Name) : filteredListItems.OrderByDescending(p => p.Name);
            }
            
            //Paging
            var list = filteredListItems.ToList();

            totalRecords = list.Count;

            list = list.Skip(displayStart).Take(displayLength).ToList();


            totalDisplayRecords = totalRecords;

            return list;
        }

        public int CheckUniqueBanHanhGiao(string name, int banHanhGiaoId)
        {
            return _banHanhGiaoData.CheckUniqueBanHanhGiao(name, banHanhGiaoId);
        }

		public int CheckUniqueBanHanhGiaoMember(int banHanhGiaoId, int parishionerId) 
		{
			return _banHanhGiaoData.CheckUniqueBanHanhGiaoMember(banHanhGiaoId, parishionerId);
		}

        public int AddBanHanhGiao(BanHanhGiao banHanhGiao)
        {
            return _banHanhGiaoData.AddBanHanhGiao(banHanhGiao);
        }

        public int UpdateBanHanhGiao(BanHanhGiao banHanhGiao, List<BanHanhGiaoMember> banHanhGiaoMembers, bool useTransaction)
        {
            return _banHanhGiaoData.UpdateBanHanhGiao(banHanhGiao, banHanhGiaoMembers, useTransaction);
        }

        public int DeleteBanHanhGiao(int id)
        {
            return _banHanhGiaoData.DeleteBanHanhGiao(id);
        }

        public BanHanhGiao GetBanHanhGiaoById(int id)
        {
            return _banHanhGiaoData.GetBanHanhGiaoById(id);
        }

        public IEnumerable<BanHanhGiaoViewModel> GetAllBanHanhGiao()
        {
            return _banHanhGiaoData.GetAllBanHanhGiao();
        }

		public int AddBanHanhGiaoMember(BanHanhGiaoMember banHanhGiaoMember)
        {
            return _banHanhGiaoData.AddBanHanhGiaoMember(banHanhGiaoMember);
        }

        public int UpdateBanHanhGiaoMember(BanHanhGiaoMember banHanhGiaoMember)
        {
            return _banHanhGiaoData.UpdateBanHanhGiaoMember(banHanhGiaoMember);
        }

        public int DeleteBanHanhGiaoMember(int id, int parishionerId)
        {
            return _banHanhGiaoData.DeleteBanHanhGiaoMember(id, parishionerId);
        }
		public List<BanHanhGiaoMemberViewModel> LoadBanHanhGiaoMemberList(string Id)
        {
			var list = _banHanhGiaoData.LoadBanHanhGiaoMemberList(Id);

			return (list != null ? list.ToList() : null);
        }

        public List<ValueSet> GetMemberRoleData()
        {
            return _banHanhGiaoData.GetMemberRoleData();
        }

    }
}

