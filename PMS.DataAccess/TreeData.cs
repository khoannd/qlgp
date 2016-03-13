using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;

namespace PMS.DataAccess
{
    public class TreeData
    {
        private readonly PMSDataContext _db;

        public TreeData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public List<TreeViewItem> GetItemTreeView(int dioceseId, int? parishId, int id, int itemType)
        {

            var result = new List<TreeViewItem>();

            if (itemType == (int) TreeItemTypeEnum.Diocese)
            {                
                var vicariates = _db.Vicariates.Where(c => c.DioceseId == dioceseId).OrderBy(c => c.Name);

                foreach (var i in vicariates)
                {
                    var parishionerCount =
                        _db.Parishioners.Count(p => ( (p.Community.Parish.VicariateId == i.Id) &&
                                                     p.Status == (int)ParishionerStatusEnum.Available &&
                                                     p.IsCounted));
                    var familyCount =
                        _db.Families.Count(f => ( (f.Community.Parish.VicariateId == i.Id) &&
                                                 f.Status == (int)FamilyStatusEnum.Available && f.IsCounted));

                    var parishCount = _db.Parishes.Count(p => p.VicariateId == i.Id);

                    var item = new TreeViewItem()
                    {
                        id = i.Id,
                        itemType = (int)TreeItemTypeEnum.Vicariate,
                        name =
                            "Giáo hạt " + i.Name + " (" + parishCount + " giáo xứ, " + familyCount + " gia đình, " + parishionerCount +
                            " giáo dân)",
                        type = "folder",
                        additionalParameters = new TreeViewItem()
                        {
                            id = i.Id,
                            itemType = (int)TreeItemTypeEnum.Vicariate,
                            additionalParameters = null
                        }
                    };

                    result.Add(item);
                }
            }
            else if (itemType == (int) TreeItemTypeEnum.Vicariate)
            {
                var parishes = _db.Parishes.Where(c => c.VicariateId == id).OrderBy(c => c.Name);

                foreach (var i in parishes)
                {
                    var parishionerCount =
                       _db.Parishioners.Count(p => ( (p.Community.ParishId == i.Id) &&
                                                    p.Status == (int)ParishionerStatusEnum.Available &&
                                                    p.IsCounted));
                    var familyCount =
                        _db.Families.Count(f => ( (f.Community.ParishId == i.Id) &&
                                                 f.Status == (int)FamilyStatusEnum.Available && f.IsCounted));

                    var communityCount = _db.Communities.Count(c => c.ParishId == i.Id && c.ParentId == null && !c.IsDefault);

                    var item = new TreeViewItem()
                    {
                        id = i.Id,
                        itemType = (int)TreeItemTypeEnum.Parish,
                        name =
                            "Giáo xứ " + i.Name + " (" + communityCount + " giáo họ, " + familyCount + " gia đình, " + parishionerCount +
                            " giáo dân)",
                        type = "folder",
                        additionalParameters = new TreeViewItem()
                        {
                            id = i.Id,
                            itemType = (int)TreeItemTypeEnum.Parish,
                            additionalParameters = null
                        }
                    };

                    result.Add(item);
                }

            } 
            else if (itemType == (int) TreeItemTypeEnum.Parish)
            {
                IEnumerable<Community> coms;

                //Nghia la khong phai admin
                if (parishId.HasValue)
                {
                    //Load ra giao ho xu minh va tru ngoai xu ra
                    coms =
                        _db.Communities.Where(c => c.ParishId == parishId && !c.IsDefault && c.ParentId == null)
                            .OrderBy(c => c.Name);
                }
                else
                {
                    coms =
                        _db.Communities.Where(c => c.ParishId == id && !c.IsDefault && c.ParentId == null)
                            .OrderBy(c => c.Name);
                }

                foreach (var i in coms)
                {
                    var parishionerCount =
                        _db.Parishioners.Count(p => ((p.CommunityId == i.Id || p.Community.ParentId == i.Id) &&
                                                     p.Status == (int)ParishionerStatusEnum.Available &&
                                                     p.IsCounted));
                    var familyCount =
                        _db.Families.Count(f => ((f.CommunityId == i.Id || f.Community.ParentId == i.Id) &&
                                                 f.Status == (int)FamilyStatusEnum.Available && f.IsCounted));

                    var item = new TreeViewItem()
                    {
                        id = i.Id,
                        itemType = (int)TreeItemTypeEnum.Community,
                        name =
                            "Giáo họ " + i.Name + " (" + familyCount + " gia đình, " + parishionerCount +
                            " giáo dân)",
                        type = "folder",
                        additionalParameters = new TreeViewItem()
                        {
                            id = i.Id,
                            itemType = (int)TreeItemTypeEnum.Community,
                            additionalParameters = null
                        }
                    };

                    result.Add(item);
                }

            }
            else if (itemType == (int) TreeItemTypeEnum.Community)
            {

                var parishDivision = _db.Communities.Where(c => c.ParentId == id).OrderBy(c => c.Name);
                //Load giao khu neu co
                
                if (parishDivision.Any())
                {
                    foreach (var i in parishDivision)
                    {
                        var parishionerCount =
                            _db.Parishioners.Count(p => (p.CommunityId == i.Id &&
                                                         p.Status == (int)ParishionerStatusEnum.Available &&
                                                         p.IsCounted));
                        var familyCount =
                            _db.Families.Count(f => (f.CommunityId == i.Id &&
                                                     f.Status == (int)FamilyStatusEnum.Available && f.IsCounted));

                        var item = new TreeViewItem()
                        {
                            id = i.Id,
                            itemType = (int)TreeItemTypeEnum.Community,
                            name =
                                "Giáo khu " + i.Name + " (" + familyCount + " gia đình, " + parishionerCount +
                                " giáo dân)",
                            type = "folder",
                            additionalParameters = new TreeViewItem()
                            {
                                id = i.Id,
                                itemType = (int)TreeItemTypeEnum.Community,
                                additionalParameters = null
                            }
                        };

                        result.Add(item);
                    }
                }

                //Load gia đình
                var families =
                            _db.Families.Where(p => (p.CommunityId == id &&
                                                         p.Status == (int)FamilyStatusEnum.Available &&
                                                         p.IsCounted)).OrderBy(c => c.Name);

                foreach (var i in families)
                {
                    var quantity = _db.FamilyMembers.Count(fm => (fm.FamilyId == i.Id && fm.Status == (int) FamilyMemberStatusEnum.Main &&
                                                                fm.Parishioner.Status != (int) ParishionerStatusEnum.Deleted));
                    var item = new TreeViewItem()
                    {
                        id = i.Id,
                        itemType = (int)TreeItemTypeEnum.Family,
                        name = "<i class='ace-icon fa fa-home'></i> " + i.Name + " (" + quantity + " thành viên)",
                        type = "folder",
                        additionalParameters = new TreeViewItem()
                        {
                            id = i.Id,
                            itemType = (int)TreeItemTypeEnum.Family,
                            additionalParameters = null
                        }
                    };

                    result.Add(item);
                }

                //Load giao dan
                var parishioners = _db.Parishioners.Where(p => (p.CommunityId == id &&
                                                         p.Status == (int)ParishionerStatusEnum.Available && p.IsCounted && 
                                                         p.FamilyMembers.Count(fm => fm.Status == (int) FamilyMemberStatusEnum.Main) == 0)).OrderBy(c => (c.ChristianName == null ?
                                                             c.Name : (c.ChristianName + " " + c.Name)));

                foreach (var i in parishioners)
                {
                    var item = new TreeViewItem()
                    {
                        id = i.Id,
                        itemType = (int)TreeItemTypeEnum.Parishioner,
                        name = "<i class='ace-icon fa fa-user'></i> " + (string.IsNullOrEmpty(i.ChristianName) ? i.Name : (i.ChristianName + " " + i.Name)),
                        type = "item",
                        additionalParameters = new TreeViewItem()
                        {
                            id = i.Id,
                            itemType = (int)TreeItemTypeEnum.Parishioner,
                            additionalParameters = null
                        }
                    };

                    result.Add(item);
                }
   

            }
            else if (itemType == (int) TreeItemTypeEnum.Family)
            {
                //O day nhung nguoi khong duoc thong ke co hien khong ?
                //Nguoi chet thi sao va khong duoc thong ke
                var members =
                    _db.FamilyMembers.Where(
                        fm => (fm.FamilyId == id && fm.Status == (int) FamilyMemberStatusEnum.Main &&
                               fm.Parishioner.Status != (int) ParishionerStatusEnum.Deleted)).OrderByDescending(c => c.IsHouseholder);


                foreach (var i in members)
                {
                    var p = i.Parishioner;
                    var item = new TreeViewItem()
                    {
                        id = p.Id,
                        itemType = (int)TreeItemTypeEnum.Parishioner,
                        name = "<i class='ace-icon fa fa-user'></i> " + 
                        (string.IsNullOrEmpty(p.ChristianName) ? p.Name : (p.ChristianName + " " + p.Name)) + " " + (i.IsHouseholder ? "(Chủ hộ)" : ""),
                        type = "item",
                        additionalParameters = new TreeViewItem()
                        {
                            id = p.Id,
                            itemType = (int)TreeItemTypeEnum.Parishioner,
                            additionalParameters = null
                        }
                    };

                    result.Add(item);
                }

            }



            return result;
        }

    }
}
