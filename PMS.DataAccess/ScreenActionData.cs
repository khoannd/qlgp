using PMS.DataAccess.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.DataAccess
{
    public class ScreenActionData
    {
        private readonly PMSDataContext _db;

        public ScreenActionData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public int ChangeScreenActionEnable(string Id)
        {
            try
            {
                var item = _db.ScreenActions.SingleOrDefault(s => s.Id.Equals(Id));
                
                if(item == null)
                {
                    return 0;
                }

                item.Enabled = !item.Enabled;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return -1;
            }
        }

        public ScreenAction GetScreenActionById(string Id)
        {
            const string query = @"SELECT * FROM ScreenAction WHERE Id = {0}";
            return _db.ExecuteQuery<ScreenAction>(query, Id).SingleOrDefault();
        }

        public int AddScreenAction(ScreenAction screenAction)
        {
            try
            {
                _db.ScreenActions.InsertOnSubmit(screenAction);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return -1;
            }
        }

        public int UpdateScreenActionName(string Id, string name)
        {
            try
            {
                var item = _db.ScreenActions.SingleOrDefault(s => s.Id.Equals(Id));

                if (item == null)
                {
                    return 0;
                }

                item.Name = name;
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Source);
                return -1;
            }
        }
    }
}
