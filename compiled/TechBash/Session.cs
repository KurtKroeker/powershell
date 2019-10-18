using System;

namespace TechBash
{
    public class Session
    {
        public string SessionName { get; set; }
        public string SessionDescription { get; set; }
        public int MinutesLong { get; set; }

        public Session(string name, string description, int minutesLong = 60)
        {
            SessionName = name;
            SessionDescription = description;
            MinutesLong = minutesLong;
        }
    }
}
