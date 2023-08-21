using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShareResource.DTO
{
    public class ScheduleMeetingGetDto : BaseGetDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime? ScheduleStart { get; set; }
        public DateTime? ScheduleEnd { get; set; }
        public int GroupId { get; set; }
        public string GroupName { get; set; }

    }
}
