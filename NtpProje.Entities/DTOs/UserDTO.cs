using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.DTOs
{
    /// <summary>
    /// Kullanıcı DTO'su - Güvenli veri transferi için
    /// NOT: Şifre bu DTO'da YOK (güvenlik)
    /// </summary>
    public class UserDTO : BaseDTO
    {
        /// <summary>
        /// Kullanıcı ID (BaseDTO'dan Id geliyor ama User için özel Id)
        /// </summary>
        public int Id { get; set; }
        
        /// <summary>
        /// Kullanıcı adı ve soyadı
        /// </summary>
        public string FullName { get; set; }
        
        /// <summary>
        /// E-posta adresi
        /// </summary>
        public string Email { get; set; }
        
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
        
        // NOT: Password bu DTO'da YOK!
        // Güvenlik için şifre asla DTO'da taşınmamalı
        // Şifre sadece Entity'de ve hash'lenmiş olmalı
    }
}
