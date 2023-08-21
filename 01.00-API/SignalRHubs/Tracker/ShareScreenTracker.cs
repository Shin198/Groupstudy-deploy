using ShareResource.DTO.Connection;

namespace API.SignalRHub.Tracker
{
    public class ShareScreenTracker
    {
        // chứa xem user ở meeting nào đang shareScreen
        public static readonly List<UserConnectionSignalrDto> usersSharingScreen = new List<UserConnectionSignalrDto>();

        public Task<bool> AddUserSharingScreen(UserConnectionSignalrDto userMeetConnection)
        {
            #region old code
            //FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: UserConnectedToShareScreen(UserConnectionDto)");
            //bool isOnline = false;
            //lock (usersSharingScreen)
            //{
            //    var temp = usersSharingScreen.FirstOrDefault(x => x.UserName == userMeetConnection.UserName && x.RoomId == userMeetConnection.RoomId);

            //    if (temp == null)//chua co online
            //    {
            //        usersSharingScreen.Add(userMeetConnection);
            //        isOnline = true;
            //    }
            //}
            //return Task.FromResult(isOnline);
            #endregion
            FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: UserConnectedToShareScreen(UserConnectionDto)");
            bool isOnline = false;
            lock (usersSharingScreen)
            {
                UserConnectionSignalrDto exsited = usersSharingScreen.FirstOrDefault(x => x.Username == userMeetConnection.Username && x.MeetingId == userMeetConnection.MeetingId);

                if (exsited == null)//chua co online
                {
                    usersSharingScreen.Add(userMeetConnection);
                    isOnline = true;
                }
            }
            return Task.FromResult(isOnline);
        }

        public Task<bool> RemoveUserShareScreen(UserConnectionSignalrDto userMeetConnection)
        {
            #region old code
            //FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: RemoveUserShareScreen(UserConnectionDto)");
            //bool isOffline = false;
            //lock (usersSharingScreen)
            //{
            //    var temp = usersSharingScreen.FirstOrDefault(x => x.UserName == userMeetConnection.UserName && x.RoomId == userMeetConnection.RoomId);
            //    if (temp == null)
            //        return Task.FromResult(isOffline);
            //    else
            //    {
            //        usersSharingScreen.Remove(temp);
            //        isOffline = true;
            //    }
            //}
            //return Task.FromResult(isOffline);
            #endregion
            FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: UserDisconnectedShareScreen(UserConnectionDto)");
            bool isOffline = false;
            lock (usersSharingScreen)
            {
                var temp = usersSharingScreen.FirstOrDefault(x => x.Username == userMeetConnection.Username && x.MeetingId == userMeetConnection.MeetingId);
                if (temp == null)
                    return Task.FromResult(isOffline);
                else
                {
                    usersSharingScreen.Remove(temp);
                    isOffline = true;
                }
            }
            return Task.FromResult(isOffline);
        }

        public Task<bool> RemoveUserShareScreen(string username, int meetingId)
        {
            #region old code
            //FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: DisconnectedByUser(username, roomId)");
            //bool isOffline = false;
            //lock (usersSharingScreen)
            //{
            //    var temp = usersSharingScreen.FirstOrDefault(x => x.UserName == username && x.RoomId == meetingId);
            //    if(temp != null)
            //    {
            //        isOffline = true;
            //        usersSharingScreen.Remove(temp);
            //    }
            //}
            //return Task.FromResult(isOffline);
            #endregion
            FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: RemoveUserShareScreen(username, meetingId)");
            bool isOffline = false;
            lock (usersSharingScreen)
            {
                var temp = usersSharingScreen.FirstOrDefault(x => x.Username == username && x.MeetingId == meetingId);
                if (temp != null)
                {
                    isOffline = true;
                    usersSharingScreen.Remove(temp);
                }
            }
            return Task.FromResult(isOffline);
        }

        public Task<UserConnectionSignalrDto> GetUserIsSharingScreenForMeeting(int meetingId)
        {
            FunctionTracker.Instance().AddTrackerFunc("Tracker/ShareScreen: GetUserIsSharingScreenForMeeting(roomId)");
            UserConnectionSignalrDto user = null;
            lock (usersSharingScreen)
            {
                user = usersSharingScreen.FirstOrDefault(x => x.MeetingId == meetingId);                               
            }
            return Task.FromResult(user);
        }
    }
}
