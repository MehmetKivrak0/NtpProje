using NtpProje.Entities.Abstract;
using System;

namespace NtpProje.Entities.Concrete
{
    public class TeamMemberDTO : BaseDTO
    {
        public int team_member_id { get; set; }
        public string name { get; set; } // Küçük harf
        public string title { get; set; }
        public string position { get; set; }
        public string image_url { get; set; }
        public string bio { get; set; }
        public string email { get; set; }
        public string phone_number { get; set; }
        public string linkedin_url { get; set; }
        public string twitter_url { get; set; }
        public string github_url { get; set; }
        public int? display_order { get; set; } // Nullable olmalı

        // BaseDTO'dan gelenler: created_date, updated_date, is_active
    }
}