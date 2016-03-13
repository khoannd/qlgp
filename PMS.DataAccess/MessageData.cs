using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess.Models;

namespace PMS.DataAccess
{
    public class MessageData
    {
        private readonly PMSDataContext _db;

        public MessageData(string connection)
        {
            _db = new PMSDataContext(connection);
        }

        public IEnumerable<Message> GetInboxByParishId(int parishId)
        {
            return _db.Messages.Where(m => m.ParishId == parishId);
        }

        public IEnumerable<Message> GetInboxByDioceseId(int dioceseId)
        {
            return _db.Messages.Where(m => m.ParishId == null);
        }

        public Message GetMessageByMessageId(int id)
        {
            return _db.Messages.SingleOrDefault(m => m.Id == id);
        }
        public string GetDioceseNameByDioceseId(int dioceseId)
        {
            var diocese = _db.Dioceses.FirstOrDefault(d => d.Id == dioceseId);
            if (diocese != null)
            {
                return diocese.Name;
            }

            return "";
        }
        public IEnumerable<Message> GetSentByAccountId(int accountId)
        {
            return _db.Messages.Where(m => m.AccountId == accountId);          
        }

        public int CreateMessage(string[] ids, string title, string content, int accountId, int dioceseId)
        {
            try
            {
                
                foreach (var item in ids)
                {
                    int id = Int32.Parse(item);
                    if (id == 0)
                    {
                        var parish = _db.Parishes.Where(p => p.Vicariate.DioceseId == dioceseId);

                        foreach (var pId in parish)
                        {
                            var message = new Message
                            {
                                AccountId = accountId,
                                ParishId = pId.Id,
                                CreatedDate = DateTime.Now,
                                Title = title,
                                Content = content
                            };
                            _db.Messages.InsertOnSubmit(message);
                        }
                       
                    }
                    else if (id == -1)
                    {
                        var message = new Message
                        {
                            AccountId = accountId,
                            ParishId = null,
                            CreatedDate = DateTime.Now,
                            Title = title,
                            Content = content
                        };
                        _db.Messages.InsertOnSubmit(message);
                    }
    
                    else if(id > 0)
                    {
                        var message = new Message
                        {
                            AccountId = accountId,
                            ParishId = id,
                            CreatedDate = DateTime.Now,
                            Title = title,
                            Content = content
                        };
                        _db.Messages.InsertOnSubmit(message);
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

        public int DeleteMessage(int id)
        {
            try
            {
                Message message = _db.Messages.SingleOrDefault(m => m.Id == id);

                if (message == null)
                {
                    return 0;
                }

                _db.Messages.DeleteOnSubmit(message);
                _db.SubmitChanges();
                return 1;
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public int CountMessageByParishId(int id)
        {
            const string query = "SELECT COUNT(Id) FROM Message " +
                                "WHERE ParishId = {0}";
            return _db.ExecuteQuery<int>(query, id).SingleOrDefault();

        }

        public int CountMessageByDiocese(int id)
        {
            const string query = "SELECT COUNT(Id) FROM Message " +
                                "WHERE ParishId IS NULL";
            return _db.ExecuteQuery<int>(query).SingleOrDefault();

        }

    }
}
