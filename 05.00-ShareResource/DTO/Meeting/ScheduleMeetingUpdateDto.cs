using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShareResource.DTO
{
    public class ScheduleMeetingUpdateDto  : BaseUpdateDto
    {
        public int Id { get; set; }
        private string name;

        public string Name
        {
            get { return name.Trim(); }
            set { name = value.Trim(); }
        }
        private DateTime date;

        public DateTime Date
        {
            get { return date.Date; }
            set { date = value.Date; }
        }

        public TimeSpan ScheduleStartTime { get; set; }
        public TimeSpan ScheduleEndTime { get; set; }
    }
}
