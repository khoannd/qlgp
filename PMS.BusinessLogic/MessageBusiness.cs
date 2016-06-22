using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.DataAccess;
using PMS.DataAccess.Enumerations;
using PMS.DataAccess.Models;
using PMS.DataAccess.Utilities;

namespace PMS.BusinessLogic
{
    public class MessageBusiness
    {
        private readonly MessageData _messageData;
        private AccountBusiness account = null;

        public MessageBusiness(string connection)
        {
            _messageData = new MessageData(connection);
            account = new AccountBusiness(connection);
        }

        public IEnumerable<IConvertible[]> GetOrderedInboxByParamsAndPaging(int dioceseId, int parishId, int role, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {
            IEnumerable<Message> messages;
            //Load Data
            if (!account.IsDioceseRole(role))
            {
                messages = _messageData.GetInboxByParishId(parishId);
            }
            else
            {
                messages = _messageData.GetInboxByDioceseId(dioceseId);
            }
            

            IEnumerable<Message> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = messages.Where(c => (c.Title.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = messages;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (p.ParishId.HasValue ? p.ParishId : 0)) : filteredListItems.OrderByDescending(p => (p.ParishId.HasValue ? p.ParishId : 0));
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Title) : filteredListItems.OrderByDescending(p => p.Title);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Id,
                           (c.Account.ParishId.HasValue ? "Giáo xứ " + c.Account.Parish.Name : "Giáo phận " + _messageData.GetDioceseNameByDioceseId(dioceseId)),
                           c.Title,
                           c.CreatedDate.ToString("hh:mm:ss tt - dd/MM/yyyy"),
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public IEnumerable<IConvertible[]> GetOrderedSentByParamsAndPaging(int accountId, int dioceseId, string searchValue, int sortColumnIndex, string sortDirection,
                            int displayStart, int displayLength, out int totalRecords, out int totalDisplayRecords)
        {

            //Load Data
            IEnumerable<Message> messages = _messageData.GetSentByAccountId(accountId);


            IEnumerable<Message> filteredListItems;
            if (!string.IsNullOrEmpty(searchValue))
            {
                searchValue = searchValue.Trim().ToLower();
                filteredListItems = messages.Where(c => (c.Title.Trim().ToLower().Contains(searchValue)));
            }
            else
            {
                filteredListItems = messages;
            }

            //Sort
            if (sortColumnIndex == 2)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => (p.ParishId.HasValue ? p.Parish.Name : p.Account.Parish.Name)) : filteredListItems.OrderByDescending(p => (p.ParishId.HasValue ? p.Parish.Name : p.Account.Parish.Name));
            }
            if (sortColumnIndex == 3)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.Title) : filteredListItems.OrderByDescending(p => p.Title);
            }
            else if (sortColumnIndex == 4)
            {
                filteredListItems = sortDirection == "asc" ? filteredListItems.OrderBy(p => p.CreatedDate) : filteredListItems.OrderByDescending(p => p.CreatedDate);
            }

            //Paging
            var list = filteredListItems.ToList();
            int records = list.Count;
            var displayedList = list.Skip(displayStart).Take(displayLength);
            var result = from c in displayedList
                         select new IConvertible[]
                       {
                           c.Id,
                           c.Id,
                           (c.ParishId.HasValue ? "Giáo xứ " + c.Parish.Name : "Giáo phận " + _messageData.GetDioceseNameByDioceseId(dioceseId)),
                           c.Title,
                           c.CreatedDate.ToString("hh:mm:ss tt - dd/MM/yyyy"),
                           c.Id                  
                       };
            totalRecords = records;
            totalDisplayRecords = records;

            return result;
        }

        public int CreateMessage(string[] ids, string title, string content, int accountId, int dioceseId)
        {
            return _messageData.CreateMessage(ids, title, content, accountId, dioceseId);
        }

        public Message GetMessageByMessageId(int id)
        {
            return _messageData.GetMessageByMessageId(id);
        }

        public int DeleteMessage(int id)
        {
            return _messageData.DeleteMessage(id);
        }

        public int CountMessageByParishId(int id)
        {
            return _messageData.CountMessageByParishId(id);
        }

        public int CountMessageByDiocese(int id)
        {
            return _messageData.CountMessageByDiocese(id);
        }
    }
}
