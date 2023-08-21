using Microsoft.AspNetCore.Mvc;
using DataLayer.DBObject;
using API.SignalRHub.Tracker;
using API.SignalRHub;
using Microsoft.AspNetCore.SignalR;
using RepositoryLayer.Interface;
using ShareResource.DTO;
using Microsoft.AspNetCore.Authorization;
using ServiceLayer.Interface;
using ShareResource.Enums;
using APIExtension.ClaimsPrinciple;
using ShareResource.UpdateApiExtension;
using Swashbuckle.AspNetCore.Annotations;
using APIExtension.Const;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using APIExtension.Validator;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using System;
using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Hosting.Server.Features;

namespace API.Controllers
{
    // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [Route("api/[controller]")]
    [ApiController]
    public class AccountsController : ControllerBase
    {
        private readonly IServiceWrapper services;
        private readonly IMapper mapper;
        private readonly IValidatorWrapper validators;
        private readonly IAutoMailService mailService;
        private readonly IServer server;

        public AccountsController(IServiceWrapper services, IMapper mapper, IValidatorWrapper validators, IAutoMailService mailService, IServer server)
        {
            this.services = services;
            this.mapper = mapper;
            this.validators = validators;
            this.mailService = mailService;
            this.server=server;
        }
        private static string FAIL_CONFIRM_PASSWORD_MSG => "Xác nhận mật khẩu thất bại";

        //Get: api/Accounts/search
        [SwaggerOperation(
            Summary = $"[{Actor.Student_Parent}/{Finnished.False}/{Auth.True}] Search students by id, username, mail, Full Name"
            , Description = "Search theo tên, username, id" +
            "<br>Để search thêm thành viên mới cho group, thêm groupId để loại ra hết những student đã liên quan đến nhóm"
        )]
        [Authorize(Roles = Actor.Student_Parent)]
        [HttpGet("search")]
        public async Task<IActionResult> SearchStudent(string search, int? groupId)
        {
            var list = services.Accounts.SearchStudents(search, groupId);//.ToList();

            if (list == null)
            {
                return NotFound();
            }
            //var test = list.FirstOrDefault();
            var mapped = list.ProjectTo<AccountProfileDto>(mapper.ConfigurationProvider);
            //var mapped = mapper.Map<List<AccountProfileDto>>(list);
            return Ok(mapped);
        }

        // GET: api/Accounts/5
        [SwaggerOperation(
            Summary = $"[{Actor.Student_Parent}/{Finnished.True}/{Auth.True}] Get the self profile"
            , Description ="Lấy profile của account đang login, accountId dc lấy từ jwtToken"
        )]
        [Authorize(Roles = Actor.Student_Parent)]
        //[Authorize(Roles = "Student, Parent")]
        [HttpGet("profile")]
        public async Task<IActionResult> GetProfile()
        {
            int id = HttpContext.User.GetUserId();
            var user = await services.Accounts.GetProfileByIdAsync(id);

            if (user == null)
            {
                return NotFound();
            }
                  var mapped = mapper.Map<AccountProfileDto>(user);
            return Ok(mapped);
        }


        // PUT: api/Accounts/5
        [SwaggerOperation(
            Summary = $"[{Actor.Student_Parent}/{Finnished.True}/{Auth.True}] Update logined profile"
            , Description ="accountId là id của account đang cập nhật profile"
        )]
        [Authorize(Roles = "Student, Parent")]
        [HttpPut("{accountId}")]
        public async Task<IActionResult> UpdateProfile(int accountId, AccountUpdateDto dto)
        {
            if (accountId != HttpContext.User.GetUserId())
            {
                return Unauthorized("Không thể thay đổi profile của người khác");
            }
            if (accountId != dto.Id)
            {
                return BadRequest();
            }

            var account = await services.Accounts.GetByIdAsync(accountId);
            if (account == null)
            {
                return NotFound();
            }
            ValidatorResult valResult = await validators.Accounts.ValidateParams(dto);
            if (!valResult.IsValid)
            {
                return BadRequest(valResult.Failures);
            }
            try
            {
                account.PatchUpdate<Account, AccountUpdateDto>(dto);
                await services.Accounts.UpdateAsync(account);
                return Ok(account);
            }
            catch (Exception ex)
            {
                if (!UserExists(accountId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
        }

        // PUT: api/Accounts/5/Password
        [SwaggerOperation(
            Summary = $"[{Actor.Student_Parent}/{Finnished.True}/{Auth.True}] Update account password"
            , Description ="accountId là id của account đang cập nhật profile"
        )]
        [Authorize(Roles = Actor.Student_Parent)]
        [HttpPut("{accountId}/Password")]
        public async Task<IActionResult> ChangePassword(int accountId, AccountChangePasswordDto dto)
        {
            if (accountId != HttpContext.User.GetUserId())
            {
                return Unauthorized("Không thể thay đổi mật khẩu của người khác");
            }
            if (accountId != dto.Id)
            {
                return BadRequest();
            }
            var account = await services.Accounts.GetByIdAsync(accountId);
            if (account.Password != dto.ConfirmPassword)
            {
                return BadRequest(FAIL_CONFIRM_PASSWORD_MSG);
            }

            if (account == null)
            {
                return NotFound();
            }
            if(dto.OldPassword != dto.Password)
            {
                return Unauthorized("Nhập mật khẩu cũ thất bại");
            }
            try
            {
                account.PatchUpdate<Account, AccountChangePasswordDto>(dto);
                await services.Accounts.UpdateAsync(account);
                return Ok(account);
            }
            catch (Exception ex)
            {
                if (!UserExists(accountId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
        }

        [SwaggerOperation(
            Summary = $"[{Actor.Guest}/{Finnished.True}/{Auth.False}] Send a link to email to reset password"
            , Description = "gửi 1 link vào email để xác nhận reset password"
        )]
        [HttpGet("Password/Reset")]
        public async Task<IActionResult> ConfirmResetPassword(string email)
        {
            Account account = await services.Accounts.GetAccountByEmailAsync(email);
            if (account == null)
            {
                return NotFound("Tài khoản không tồn tại");
            }
            //Random password
            //string newPassword = RandomPassword(9);
            //account.Password = newPassword;
            //await services.Accounts.UpdateAsync(account);

            ////string mailContent="<a href=\"localhost\"></a>" 
            //string mailContent = $"<div>Mật khẩu mới của bạn là {newPassword}</div>";
            //bool sendSuccessful = await mailService.SendEmailWithDefaultTemplateAsync(new List<String> { email }, "Reset password", mailContent, null);
            bool sendSuccessful = await mailService.SendConfirmResetPasswordMailAsync(account, server.Features.Get<IServerAddressesFeature>().Addresses.First());
            if (!sendSuccessful)
            {
                //return BadRequest($"Something went wrong with sending mail. The new password is {newPassword}");
                return BadRequest($"Something went wrong with sending mail.");
            }
            //return Ok($"Reset successfully, check {email} inbox for the new password {newPassword}");
            return Ok($"Reset successfully, check {email} inbox for the new password");
        }

        [SwaggerOperation(
            Summary = $"[{Actor.Guest}/{Finnished.True}/{Auth.False}] DO NOT USE. Reset and send new password to email. Call the above api"
            , Description = "Không sử dụng. Gọi api trên để nhận được mail chứa 1 link gọi api này"
        )]
        [HttpGet("Password/Reset/Confirm")]

        public async Task<IActionResult> ConfirmResetPassword(string email, string secret)
        {
            Account account = await services.Accounts.GetAccountByEmailAsync(email);
            if (account == null)
            {
                return NotFound("Tài khoản không tồn tại");
            }
            //test secret
            string correctSecrete = DateTime.Today.ToString("yyyy-MM-dd");
            if(secret!=correctSecrete)
            {
                return Unauthorized("Incorrect secret");
            }
            //Random password
            //string newPassword = RandomPassword(9);
            //account.Password = newPassword;
            //await services.Accounts.UpdateAsync(account);

            ////string mailContent="<a href=\"localhost\"></a>" 
            //string mailContent = $"<div>Mật khẩu mới của bạn là {newPassword}</div>";
            //bool sendSuccessful = await mailService.SendEmailWithDefaultTemplateAsync(new List<String> { email }, "Reset password", mailContent, null);
            bool sendSuccessful = await mailService.SendNewPasswordMailAsync(account);
            if(!sendSuccessful)
            {
                //return BadRequest($"Something went wrong with sending mail. The new password is {newPassword}");
                return BadRequest($"Something went wrong with sending mail.");
            }
            //return Ok($"Reset successfully, check {email} inbox for the new password {newPassword}");
            return Ok($"Reset successfully, check {email} inbox for the new password");
        }
        /// ///////////////////////////////////////////////////////////////////////////////////////////////
        [Tags(Actor.Test)]
        [SwaggerOperation(
            Summary = $"[{Actor.Test}/{Finnished.False}] Get all the account"
        )]
        // GET: api/Accounts
        [HttpGet]
        public async Task<IActionResult> GetAccount()
        {
            IQueryable<Account> list = services.Accounts.GetList();
            if (list == null || !list.Any())
            {
                return NotFound();
            }
            var mapped = list.ProjectTo<StudentGetDto>(mapper.ConfigurationProvider);
            return Ok(mapped);
        }
        // GET: api/Accounts/Student
        [Tags(Actor.Test)]
        [SwaggerOperation(
          Summary = $"[{Actor.Test}/{Finnished.False}] Get all the student account"
      )]
        [HttpGet("Student")]
        public async Task<IActionResult> GetStudents()
        {
            IQueryable<Account> list = services.Accounts.GetList().Where(e => e.RoleId == (int)RoleNameEnum.Student);
            if (list == null || !list.Any())
            {
                return NotFound();
            }
            var mapped = list.ProjectTo<StudentGetDto>(mapper.ConfigurationProvider);
            return Ok(mapped);
        }

        // GET: api/Accounts/Student
        [Tags(Actor.Test)]
        [SwaggerOperation(
          Summary = $"[{Actor.Test}/{Finnished.False}] Get all the parent account"
        )]
        [HttpGet("Parent")]
        public async Task<IActionResult> GetParents()
        {
            IQueryable<Account> list = services.Accounts.GetList().Where(e => e.RoleId == (int)RoleNameEnum.Parent);
            if (list == null || !list.Any())
            {
                return NotFound();
            }
            return Ok(list);
        }

        // GET: api/Accounts/5
        [Tags(Actor.Test)]
        [SwaggerOperation(
          Summary = $"[{Actor.Test}/{Finnished.False}] Get account info "
        )]
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUser(int id)
        {
            var user = await services.Accounts.GetByIdAsync(id);

            if (user == null)
            {
                return NotFound();
            }
            var mapped = mapper.Map<StudentGetDto>(user);
            return Ok(mapped);
        }

        //// DELETE: api/Accounts/5
        //[HttpDelete("{id}")]
        //public async Task<IActionResult> DeleteUser(int id)
        //{
        //    if (services.Accounts == null)
        //    {
        //        return NotFound();
        //    }
        //    var dto = await services.Accounts.FindAsync(id);
        //    if (dto == null)
        //    {
        //        return NotFound();
        //    }

        //    services.Accounts.Remove(dto);
        //    await services.SaveChangesAsync();

        //    return NoContent();
        //}

        private bool UserExists(int id)
        {
            //return (services.Accounts?.Any(e => e.Id == id)).GetValueOrDefault();
            return (services.Accounts?.GetByIdAsync(id) is not null);
        }

        ////code yt
        //public async Task<AppUser> GetUserByIdAsync(Guid id)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: GetUserByIdAsync(id)");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/Room: GetRoomById(id)");
        //    return await services.Users.FindAsync(id);
        //}

        //public async Task<AppUser> GetUserByUsernameAsync(string username)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: GetUserByUsernameAsync(username)");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/User: GetUserByUsernameAsync(username)");
        //    return await services.Users.SingleOrDefaultAsync(u => u.UserName == username);
        //}

        //public async Task<MemberDto> GetMemberAsync(string username)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: GetMemberAsync(username)");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/User: GetMemberAsync(username)");
        //    return await services.Users.Where(x => x.UserName == username)
        //        .ProjectTo<MemberDto>(_mapper.ConfigurationProvider)//add CreateMap<AppUser, MemberDto>(); in AutoMapperProfiles
        //        .SingleOrDefaultAsync();
        //}

        //public async Task<IEnumerable<MemberDto>> GetUsersOnlineAsync(UserConnectionDto[] userOnlines)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: GetUsersOnlineAsync(UserConnectionDto[])");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/User: GetUsersOnlineAsync(UserConnectionDto[])");
        //    var listUserOnline = new List<MemberDto>();
        //    foreach (var u in userOnlines)
        //    {
        //        var dto = await services.Users.Where(x => x.UserName == u.UserName)
        //        .ProjectTo<MemberDto>(_mapper.ConfigurationProvider)
        //        .SingleOrDefaultAsync();

        //        listUserOnline.Add(dto);
        //    }
        //    //return await Task.Run(() => listUserOnline.ToList());
        //    return await Task.FromResult(listUserOnline.ToList());
        //}

        //public async Task<PagedList<MemberDto>> GetMembersAsync(UserParams userParams)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: GetMembersAsync(UserParams)");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/User: GetMembersAsync(UserParams)");
        //    var query = services.Users.AsQueryable();
        //    query = query.Where(u => u.UserName != userParams.CurrentUsername).OrderByDescending(u => u.LastActive);

        //    return await PagedList<MemberDto>.CreateAsync(query.ProjectTo<MemberDto>(_mapper.ConfigurationProvider).AsNoTracking(), userParams.PageNumber, userParams.PageSize);
        //}

        //public async Task<IEnumerable<MemberDto>> SearchMemberAsync(string displayname)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: SearchMemberAsync(name)");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/User: SearchMemberAsync(name)");
        //    return await services.Users.Where(u => u.DisplayName.ToLower().Contains(displayname.ToLower()))
        //        .ProjectTo<MemberDto>(_mapper.ConfigurationProvider)
        //        .ToListAsync();
        //}

        //public async Task<AppUser> UpdateLocked(string username)
        //{
        //    Console.WriteLine("4.         " + new String('~', 50));
        //    Console.WriteLine("4.         Repo/User: UpdateLocked(username)");
        //    FunctionTracker.Instance().AddRepoFunc("Repo/User: UpdateLocked(username)");
        //    var dto = await services.Users.SingleOrDefaultAsync(x => x.UserName == username);
        //    if (dto != null)
        //    {
        //        dto.Locked = !dto.Locked;
        //    }
        //    return dto;
        //}

        private string RandomPassword(int size, bool lowerCase = false)
        {
            var builder = new StringBuilder(size);

            // Unicode/ASCII Letters are divided into two blocks
            // (Letters 65–90 / 97–122):
            // The first group containing the uppercase letters and
            // the second group containing the lowercase.

            // char is a single Unicode character
            char offset = lowerCase ? 'a' : 'A';
            const int lettersOffset = 26; // A...Z or a..z: length = 26
            var _random = new Random();

            for (var i = 0; i < size; i++)
            {
                var @char = (char)_random.Next(offset, offset + lettersOffset);
                builder.Append(@char);
            }

            return lowerCase ? builder.ToString().ToLower() : builder.ToString();
        }

    }

}
