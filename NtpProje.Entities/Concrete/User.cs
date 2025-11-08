using System;

namespace NtpProje.Entities.Concrete
{
    public class UserDTO
    {
        public int UserId { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
        public string Bio { get; set; }

        public UserDTO() { }

        public UserDTO(int userId, string fullName, string email)
        {
            this.UserId = userId;
            this.FullName = fullName;
            this.Email = email;
        }

        public override string ToString()
        {
            return $"User: {FullName} ({Email})";
        }
    }
}

