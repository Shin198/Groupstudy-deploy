using AutoMapper.QueryableExtensions;
using AutoMapper;
using DataLayer.DBObject;
using ShareResource.DTO;
using RepositoryLayer.Interface;
using Microsoft.EntityFrameworkCore;
using ServiceLayer.Interface;

namespace ServiceLayer.ClassImplement.Db
{
    public class StatService : IStatService
    {
        private IRepoWrapper repos;
        private readonly IMapper mapper;

        public StatService(IRepoWrapper repos, IMapper mapper)
        {
            this.repos = repos;
            this.mapper = mapper;
        }

        public async Task<StatGetDto> GetStatForStudentInMonth(int studentId, DateTime month)
        {
            DateTime start = new DateTime(month.Year, month.Month, 1, 0, 0, 0).Date;
            DateTime end = start.AddMonths(1);
            //Nếu tháng này thì chỉ lấy past meeting
            IQueryable<Meeting> allMeetingsOfJoinedGroups = month.Month == DateTime.Now.Month
                ? repos.Meetings.GetList()
                .Include(c => c.Connections)
                .Include(m => m.Group).ThenInclude(g => g.GroupMembers)
                .Where(e => ((e.ScheduleStart >= start && e.ScheduleStart.Value.Date < end) || (e.Start >= start && e.Start.Value.Date < end))
                    && e.Group.GroupMembers.Any(gm => gm.AccountId == studentId)
                    //lấy past meeting
                    && (e.End != null || e.ScheduleStart != null && e.ScheduleStart.Value.Date < DateTime.Today))
                : repos.Meetings.GetList()
                .Include(c => c.Connections)
                .Include(m => m.Group).ThenInclude(g => g.GroupMembers)
                .Where(c => c.ScheduleStart >= start && c.ScheduleStart.Value.Date < end
                    && c.Group.GroupMembers.Any(gm => gm.AccountId == studentId));
            //int totalMeetingsCount = allMeetingsOfJoinedGroups.Count() == 0
            //    ? 0 : allMeetingsOfJoinedGroups.Count();
            int totalMeetingsCount = allMeetingsOfJoinedGroups.Count();
            var atendedMeetings = allMeetingsOfJoinedGroups
                .Where(e => e.Connections.Any(c => c.AccountId == studentId));
            int atendedMeetingsCount = allMeetingsOfJoinedGroups.Count() == 0
                ? 0 : allMeetingsOfJoinedGroups
                .Where(e => e.Connections.Any(c => c.AccountId == studentId)).Count();
            long totalMeetingTime = allMeetingsOfJoinedGroups.Count() == 0 ? 0
                : allMeetingsOfJoinedGroups.SelectMany(m => m.Connections)
                    .Select(e => e.End.Value - e.Start).Select(ts => ts.Ticks).Sum();
            var timeSpan = new TimeSpan(totalMeetingTime);
            //var totalMeetingTime = allMeetingsOfJoinedGroups.SelectMany(m => m.Connections);//.Select(e=>e.End.Value-e.Start).Select(ts=>ts.Ticks).Sum(); 

            return new StatGetDto
            {
                TotalMeetings = allMeetingsOfJoinedGroups.ProjectTo<PastMeetingGetDto>(mapper.ConfigurationProvider),
                TotalMeetingsCount = totalMeetingsCount,
                AtendedMeetingsCount = atendedMeetingsCount,
                MissedMeetingsCount = totalMeetingsCount - atendedMeetingsCount,
                TotalMeetingTme = totalMeetingTime == 0 ? "Chưa tham gia buổi học nào"
                    : $"{timeSpan.Hours} giờ {timeSpan.Minutes} phút {timeSpan.Seconds} giây"
            };
        }
    }
}
