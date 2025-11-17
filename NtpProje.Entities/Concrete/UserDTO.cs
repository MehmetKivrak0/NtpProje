using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class UserDTO : BaseDTO
    {
        public int user_id { get; set; }
        public string full_name { get; set; }
        public string email { get; set; }
        public string password { get; set; } // Þifre (Web katmanýndan gelir)
        public string role { get; set; }
        public DateTime? last_login_date { get; set; }

    }
}

