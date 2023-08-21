using DataLayer.DBObject;
using Microsoft.EntityFrameworkCore;
using RepositoryLayer.Interface;
using ServiceLayer.Interface.Db;

namespace ServiceLayer.ClassImplement.Db
{
    public class AccountService : IAccountService
    {
        private IRepoWrapper repos;

        public AccountService(IRepoWrapper repos)
        {
            this.repos = repos;
        }
        public IQueryable<Account> GetList()
        {
            return repos.Accounts.GetList();
        }
        public IQueryable<Account> SearchStudents(string search, int? groupId)
        {
            search = search.ToLower().Trim();
            if (groupId.HasValue)
            {
                //return repos.GroupMembers.GetList().Where(e=>e.GroupId!=groupId).Include(e => e.Account).Select(e=>e.Account)
                //.Where(e =>
                //    EF.Functions.Like(e.Id.ToString(), search + "%")
                //    //e.Id.ToString().Contains(search)
                //    //SqlFunctions.StringConvert((double)e.Id) 
                //    || e.Email.ToLower().Contains(search)
                //    || e.Username.ToLower().Contains(search)
                //    || e.FullName.ToLower().Contains(search)
                //);
                return repos.Accounts.GetList()
                .Include(e=>e.GroupMembers).ThenInclude(e=>e.Group)
                .Where(e =>
                    !e.GroupMembers.Any(e=>e.GroupId==groupId)
                    &&(EF.Functions.Like(e.Id.ToString(), search + "%")
                    || e.Email.ToLower().Contains(search)
                    || e.Username.ToLower().Contains(search)
                    || e.FullName.ToLower().Contains(search))
                );
            }
            return repos.Accounts.GetList()
                .Include(e=>e.GroupMembers).ThenInclude(e=>e.Group)
                .Where(e =>
                EF.Functions.Like(e.Id.ToString(), search+"%")
                //e.Id.ToString().Contains(search)
                    //SqlFunctions.StringConvert((double)e.Id) 
                    || e.Email.ToLower().Contains(search)
                    || e.Username.ToLower().Contains(search)
                    || e.FullName.ToLower().Contains(search)
                );
        }


        public async Task<Account> GetByIdAsync(int id)
        {
            return await repos.Accounts.GetByIdAsync(id);
        }

        public async Task<Account> GetProfileByIdAsync(int id)
        {
            return await repos.Accounts.GetProfileByIdAsync(id);
        }

        public async Task<Account> GetAccountByUserNameAsync(string userName)
        {
            Account account = await repos.Accounts.GetByUsernameAsync(userName);
            return account;
        }

        public async Task<Account> GetAccountByEmailAsync(string email)
        {
            Account account = await repos.Accounts.GetList()
                .SingleOrDefaultAsync(e=>e.Email==email);
            return account;
        }

        public async Task CreateAsync(Account entity)
        {
            await repos.Accounts.CreateAsync(entity);
        }

        public async Task RemoveAsync(int id)
        {
            await repos.Accounts.RemoveAsync(id);
        }

        public async Task UpdateAsync(Account entity)
        {
            await repos.Accounts.UpdateAsync(entity);
        }

        public async Task<bool> ExistAsync(int id)
        {
            return await repos.Accounts.IdExistAsync(id);
        }

        public async Task<bool> ExistUsernameAsync(string username)
        {
            return await repos.Accounts.GetList().AnyAsync(x => x.Username == username);
        }

        public async Task<bool> ExistEmailAsync(string email)
        {
            return await repos.Accounts.GetList().AnyAsync(x => x.Email == email);
        }
    }
}
