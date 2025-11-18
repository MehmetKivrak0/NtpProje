using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class UserDTO : BaseDTO
    {
        // NtpProje.Entities/Concrete/UserDTO.cs içinde kullanýlmalýdýr.

        public int User_id { get; set; }
        public string Full_name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; } // Þifre (Web katmanýndan gelir)
        public string Role { get; set; }
        public DateTime? Last_login_date { get; set; }

        // NOT: BaseDTO'dan miras alýnan alanlar da PascalCase olmalýdýr:
        // public bool IsActive { get; set; }
        // public DateTime CreatedDate { get; set; }

    }
}

