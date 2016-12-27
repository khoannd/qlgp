using PMS.DataAccess.Models;
using PMS.DataAccess.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class VocationFilterData
    {
        private readonly PMSDataContext _db;

        public VocationFilterData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<VocationFilterViewModel> GetParishionersByDioceseId(string conditionString, List<object> args, string orderBy, string orderDir)
        {
            string query = @"SELECT a.*
FROM (
	SELECT pa.Id, pa.Title, pa.ChristianName, pa.Name, pa.BirthDate, pa.MobilePhone AS Phone, pa.Id AS ParishionerId, pa.Code, pa.PatronDate, pa.Email, pa.ImageUrl,
    LEFT(pa.Name, LEN(pa.Name) - CHARINDEX(' ',REVERSE(pa.Name))) AS LastName, 
	IIF(CHARINDEX(' ', pa.Name) <> 0, RIGHT(pa.Name, CHARINDEX(' ', REVERSE(pa.Name)) - 1), '') AS FirstName,
	v.Seminary, v.TypeCode, vs1.Definition AS TypeName, IIF(v.IsRetired IS NULL, 0, v.IsRetired) AS IsRetired,
	pa.ParishId, p.Name AS ParishName, p.Category AS ParishTypeCode, vs.Definition AS ParishType,
    v.ServedId AS ServedPlaceId, v.ServedPlace, v.ServedStartDate AS StartDate, v.ServedAddress, v.Phone AS ServedPhone, v.Email AS ServedEmail,
	vi.Name AS VicariateName, vi.Id AS VicariateId,
    IIF(LEN(pa.BirthDate) >= 4, YEAR(GETDATE()) - CAST(LEFT(pa.BirthDate, 4) AS INT), '') AS Age,
	IIF(LEN(pa.BirthDate) >= 4, LEFT(pa.BirthDate, 4), '') AS BirthYear,
	v.ServedRole AS RoleId, v.Position, vt.Name AS Role, v.Note, v.Date8 AS OrdinationDate, v.Place8 AS OrdinationPlace, v.Giver8 AS OrdinationBy,
    sa.Date AS BaptismDate, sa.ReceivedPlace AS BaptismPlace
	FROM Parishioner pa
	INNER JOIN Vocation v ON pa.Id = v.ParishionerId
	LEFT JOIN Sacrament sa ON sa.ParishionerId = pa.Id AND sa.Type=1
	LEFT JOIN ValueSet vs1 ON vs1.Code = v.TypeCode AND vs1.Category = 'SEMINARYTAG'
	LEFT JOIN VaiTro vt ON v.ServedRole = vt.Id
	LEFT JOIN Parish p ON v.ServedId = p.Id
    LEFT JOIN ValueSet vs ON CAST(vs.Code AS INT) = p.Category AND vs.Category = 'PARISHTYPE'
	LEFT JOIN Vicariate vi ON p.VicariateId = vi.Id
) AS a

WHERE 1=1 " + (!string.IsNullOrEmpty(conditionString) ? conditionString : "") + (orderBy != "" ? " ORDER BY " + orderBy + " " + orderDir : "")
    ;
            return _db.ExecuteQuery<VocationFilterViewModel>(query, args.ToArray());
        }
    }
    
}
