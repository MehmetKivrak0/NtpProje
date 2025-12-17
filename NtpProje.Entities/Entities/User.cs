using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Kullanıcı domain entity'si
    /// Veritabanı tablosu: users
    /// </summary>
    public class User : BaseEntity
    {
        /// <summary>
        /// Kullanıcı adı ve soyadı
        /// </summary>
        public string FullName { get; set; }
        
        /// <summary>
        /// E-posta adresi (unique)
        /// </summary>
        public string Email { get; set; }
        
        /// <summary>
        /// Şifre (hash'lenmiş)
        /// </summary>
        public string Password { get; set; }
        
        /// <summary>
        /// Telefon numarası
        /// </summary>
        public string PhoneNumber { get; set; }
        
        /// <summary>
        /// Kullanıcı rolü (Admin, Editor, User)
        /// </summary>
        public string Role { get; set; }
        
        /// <summary>
        /// Son giriş tarihi
        /// </summary>
        public DateTime? LastLoginDate { get; set; }
    }
}

