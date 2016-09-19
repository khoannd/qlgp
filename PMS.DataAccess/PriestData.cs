using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using PMS.DataAccess.Utilities;

namespace PMS.DataAccess
{
    public class PriestData
    {
        private readonly PMSDataContext _db;

        public PriestData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<PriestViewModel> GetPriestByDioceseId(string conditionString, List<object> args, string orderBy, string orderDir)
        {
            string query = @"SELECT a.*
FROM (
	SELECT pr.*, pa.Code, pa.PatronDate, pa.Email,
    LEFT(pr.Name, LEN(pr.Name) - CHARINDEX(' ',REVERSE(pr.Name))) AS LastName, 
	IIF(CHARINDEX(' ', pr.Name) <> 0, RIGHT(pr.Name, CHARINDEX(' ', REVERSE(pr.Name)) - 1), '') AS FirstName,
	pa.Title, v.Seminary, v.TypeCode, vs1.Definition AS TypeName, IIF(v.IsRetired IS NULL, 0, v.IsRetired) AS IsRetired,
	p.Id AS ParishId, p.Name AS ParishName, p.Category AS ParishTypeCode, vs.Definition AS ParishType,
    v.ServedId AS ServedPlaceId, v.ServedPlace, v.ServedStartDate AS StartDate, v.ServedAddress, v.Phone AS ServedPhone, v.Email AS ServedEmail,
	vi.Name AS VicariateName, vi.Id AS VicariateId,
    IIF(LEN(pa.BirthDate) >= 4, YEAR(GETDATE()) - CAST(LEFT(pa.BirthDate, 4) AS INT), '') AS Age,
	IIF(LEN(pa.BirthDate) >= 4, LEFT(pa.BirthDate, 4), '') AS BirthYear,
	v.ServedRole AS RoleId, vt.Name AS Role, v.Note, v.Date8 AS OrdinationDate, v.Place8 AS OrdinationPlace, v.Giver8 AS OrdinationBy,
    sa.Date AS BaptismDate, sa.ReceivedPlace AS BaptismPlace
	FROM Priest pr
	LEFT JOIN Parishioner pa ON pr.ParishionerId = pa.Id
	LEFT JOIN Sacrament sa ON sa.ParishionerId = pa.Id AND sa.Type=1
	LEFT JOIN Vocation v ON pr.ParishionerId = v.ParishionerId
	LEFT JOIN ValueSet vs1 ON vs1.Code = v.TypeCode AND vs1.Category = 'SEMINARYTAG'
	LEFT JOIN VaiTro vt ON v.ServedRole = vt.Id
	LEFT JOIN Parish p ON v.ServedId = p.Id
    LEFT JOIN ValueSet vs ON CAST(vs.Code AS INT) = p.Category AND vs.Category = 'PARISHTYPE'
	LEFT JOIN Vicariate vi ON p.VicariateId = vi.Id
) AS a

WHERE 1=1 " + (!string.IsNullOrEmpty(conditionString) ? conditionString : "") + (orderBy != "" ? " ORDER BY " + orderBy + " " + orderDir : "")
;
            return _db.ExecuteQuery<PriestViewModel>(query, args.ToArray());
        }

        public IEnumerable<Priest> GetPriestForTCLM(int tclmId)
        {
            const string query = @" select Priest.*
                                    from Priest
                                    where Priest.Id not in (
						                                    select ParishManager.PriestId 
						                                    from ParishManager 
						                                    where ParishManager.PriestId is not null 
						                                    and ParishManager.IdThuyenChuyenLinhMuc = {0}
					                                    )";
            return _db.ExecuteQuery<Priest>(query, tclmId);
        }

        public Priest GetPriestByPriestId(int id)
        {
            const string query = "SELECT * FROM Priest WHERE Id = {0}";
            return _db.ExecuteQuery<Priest>(query, id).SingleOrDefault();
        }

        public Priest GetPriestByParishionerId(int id)
        {
            const string query = "SELECT * FROM Priest WHERE ParishionerId = {0}";
            return _db.ExecuteQuery<Priest>(query, id).SingleOrDefault();
        }

        public int AddPriest(Priest priest)
        {
            try
            {
                _db.Priests.InsertOnSubmit(priest);
                _db.SubmitChanges();
                return priest.Id;
            }
            catch (Exception e)
            {
                return -1;
            }
        }
        public int UpdatePriest(Priest priest)
        {
            Priest item = null;
            try
            {
                item = _db.Priests.SingleOrDefault(d => d.Id == priest.Id);
                if (item == null)
                {
                    return 0;
                }
                //item.ChristianName = priest.ChristianName;
                //item.Name = priest.Name;
                //item.BirthDate = priest.BirthDate;
                //item.Phone = priest.Phone;

                Tools.CopyPropertiesTo(priest, item);

                _db.SubmitChanges();
                return priest.Id;
            }
            catch (Exception e)
            {
                if (item != null)
                {
                    _db.Refresh(System.Data.Linq.RefreshMode.OverwriteCurrentValues, item);
                }
                return -1;
            }
        }
        public int DeletePriest(int id)
        {
            try
            {
                Priest priest = _db.Priests.SingleOrDefault(p => p.Id == id);

                if (priest == null)
                {
                    return 0;
                }

                _db.Priests.DeleteOnSubmit(priest);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public IEnumerable<string> GetPriestNamesByName(int dioceseId, string name)
        {
            const string query = "SELECT (P.ChristianName + ' ' + P.Name) AS Name " +
                                 "FROM Priest AS P " +
                                 "WHERE P.DioceseId = {0} AND (P.ChristianName + ' ' + P.Name) LIKE {1} " +
                                 "ORDER BY P.ChristianName, P.Name";

            name = name.Trim();
            return _db.ExecuteQuery<string>(query, dioceseId, "%" + name + "%");
        }

        public IEnumerable<Priest> GetPriestsByName(int dioceseId, string name)
        {
            const string query = "SELECT P.* " +
                                 "FROM Priest AS P " +
                                 "WHERE P.DioceseId = {0} AND (P.ChristianName + ' ' + P.Name) LIKE {1} " +
                                 "ORDER BY P.ChristianName, P.Name";

            name = name.Trim();
            return _db.ExecuteQuery<Priest>(query, dioceseId, "%" + name + "%");
        }

        public IEnumerable<Priest> GetAllPriests()
        {
            string query = @"SELECT *, LEFT(Name, LEN(Name) - CHARINDEX(' ',REVERSE(Name))) AS LastName, 
IIF(CHARINDEX(' ', Name) <> 0, RIGHT(Name, CHARINDEX(' ',REVERSE(Name))-1), '') AS FirstName FROM Priest ORDER BY FirstName ASC";
            return _db.ExecuteQuery<Priest>(query, 0);
        }

        public IEnumerable<Priest> GetPriestForHDLM()
        {
            const string query = @" select * 
                                    from Priest as pr 
                                    where pr.Id not in (
						                                    select PriestID from HDLMMember
					                                    )";
            return _db.ExecuteQuery<Priest>(query);
        }

        public PriestViewModel GetPriestAndParishionerInfoByPriestId(int id)
        {
            const string query = "SELECT p.*, pa.Code, pa.ImageUrl " +
                "FROM Priest p " +
                "INNER JOIN Parishioner pa " +
                "ON p.ParishionerId = pa.Id " +
                "WHERE p.Id = {0}";
            return _db.ExecuteQuery<PriestViewModel>(query, id).SingleOrDefault();
        }
        public IEnumerable<PriestViewModel> getParishionerByDioceseId(int dioceseId)
        {
            const string query = @"SELECT p.*, pa.Code, pa.ImageUrl, LEFT(p.Name, LEN(p.Name) - CHARINDEX(' ',REVERSE(p.Name))) AS LastName, 
IIF(CHARINDEX(' ', p.Name) <> 0, RIGHT(p.Name, CHARINDEX(' ', REVERSE(p.Name)) - 1), '') AS FirstName " +
                "FROM Priest p " +
                "INNER JOIN Parishioner pa " +
                "ON p.ParishionerId = pa.Id " +
                "WHERE DioceseId = {0} " +
                "ORDER By Id DESC";
            return _db.ExecuteQuery<PriestViewModel>(query, dioceseId);
        }
        public IEnumerable<string> GetChristianList() {
            string query = @"SELECT DISTINCT ChristianName FROM Priest WHERE ChristianName IS NOT NULL AND ChristianName<>'' ORDER BY ChristianName ASC";
            return _db.ExecuteQuery<string>(query);
        }
        public IEnumerable<VaiTro> GetPositionList()
        {
            string query = @"SELECT * FROM VaiTro ";
            return _db.ExecuteQuery<VaiTro>(query);
        }
    }
}
