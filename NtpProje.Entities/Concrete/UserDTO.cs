using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Concrete
{
    public class UserDTO : BaseDTO
    {
        // NtpProje.Entities/Concrete/UserDTO.cs içinde kullanılmalıdır.

        public int User_id { get; set; }
        public string Full_name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; } // Şifre (Web katmanından gelir)
        public string PhoneNumber { get; set; } // Telefon numarası
        public string Role { get; set; }
        public DateTime? Last_login_date { get; set; }

        // NOT: BaseDTO'dan miras alınan alanlar da PascalCase olmalıdır:
        // public bool IsActive { get; set; }
        // public DateTime CreatedDate { get; set; }

    }
}
