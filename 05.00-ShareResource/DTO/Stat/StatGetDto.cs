using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShareResource.DTO
{
    public class StatGetDto
    {
        public IQueryable TotalMeetings { get; set; }
        public int TotalMeetingsCount { get; set; }
        public int AtendedMeetingsCount { get; set; }
        public int MissedMeetingsCount { get; set; }
        public string TotalMeetingTme { get; set; }
    }
}
