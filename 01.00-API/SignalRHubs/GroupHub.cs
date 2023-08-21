using API.SignalRHub.Tracker;
using APIExtension.ClaimsPrinciple;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using ShareResource.DTO.Connection;

namespace API.SignalRHub
{
    /// <summary>
    /// Use to count number of ppl in rooms
    /// </summary>
    [Authorize]
    public class GroupHub : Hub
    {
        //BE: SendAsync(GroupHub.CountMemberInGroupMsg, new { meetingId: int, countMember: int })
        public static string CountMemberInGroupMsg => "CountMemberInGroup";
        public static string OnLockedUserMsg => "OnLockedUser";

        private readonly PresenceTracker presenceTracker;
        public GroupHub(PresenceTracker tracker)
        {
            presenceTracker = tracker;
        }
        public override async Task OnConnectedAsync()
        {
            FunctionTracker.Instance().AddHubFunc("3.      Hub/Presence: OnConnectedAsync()");
            var isOnline = await presenceTracker.UserConnected(new UserConnectionSignalrDto(Context.User.GetUsername(), 0), Context.ConnectionId);
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            FunctionTracker.Instance().AddHubFunc("3.      Hub/Presence: OnDisconnectedAsync(Exception)");
            var isOffline = await presenceTracker.UserDisconnected(new UserConnectionSignalrDto(Context.User.GetUsername(), 0), Context.ConnectionId);
            await base.OnDisconnectedAsync(exception);
        }

        //TestOnly
        public async Task TestReceiveInvoke(string msg)
        {
            Console.WriteLine("+++++++++++==================== " + msg + " group ReceiveInvoke successfull");
            //int meetId = presenceTracker.
            Clients.Caller.SendAsync("OnTestReceiveInvoke", "group invoke dc rồi ae ơi " + msg);
        }
    }
}
