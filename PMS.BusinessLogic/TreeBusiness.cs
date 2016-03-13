using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.ViewModels;

namespace PMS.BusinessLogic
{
    public class TreeBusiness
    {
        private readonly TreeData _treeData;
        public TreeBusiness(string connection)
        {
            _treeData = new TreeData(connection);
        }

        public List<TreeViewItem> GetItemTreeView(int dioceseId, int? parishId, int id, int itemType)
        {
            return _treeData.GetItemTreeView(dioceseId, parishId, id, itemType);
        }

    }
}
