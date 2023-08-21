using DataLayer.DBObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceLayer.Interface.Db
{
    public interface IAccountService 
    {
        public IQueryable<Account> GetList();
        public Task<Account> GetByIdAsync(int id);
        /// <summary>
        /// Create a group and add group leader
        /// </summary>
        /// <param name="account"></param>
        /// <param name="creatorId">id of creator account id</param>
        /// <returns></returns>
        public Task CreateAsync(Account account);
        public Task UpdateAsync(Account account);
        public Task RemoveAsync(int id);
        public Task<Account> GetAccountByUserNameAsync(string userName);
        public Task<Account> GetAccountByEmailAsync(string email);
        public Task<Account> GetProfileByIdAsync(int id);
        public IQueryable<Account> SearchStudents(string search, int? groupId);
        public Task<bool> ExistAsync(int id);
        public Task<bool> ExistUsernameAsync(string username);
        public Task<bool> ExistEmailAsync(string email);
    }
}
