using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// İletişim mesajı domain entity'si
    /// Veritabanı tablosu: contact_messages
    /// </summary>
    public class ContactMessage : BaseEntity
    {
        /// <summary>
        /// Gönderenin adı ve soyadı
        /// </summary>
        public string NameSurname { get; set; }
        
        /// <summary>
        /// E-posta adresi
        /// </summary>
        public string Email { get; set; }
        
        /// <summary>
        /// Telefon numarası
        /// </summary>
        public string Phone { get; set; }
        
        /// <summary>
        /// Mesaj konusu
        /// </summary>
        public string Subject { get; set; }
        
        /// <summary>
        /// Mesaj içeriği
        /// </summary>
        public string Message { get; set; }
        
        /// <summary>
        /// Mesaj okundu mu?
        /// </summary>
        public bool IsRead { get; set; }
        
        /// <summary>
        /// Gönderen IP adresi
        /// </summary>
        public string IpAddress { get; set; }
        
        /// <summary>
        /// Mesaj yanıtlandı mı?
        /// </summary>
        public bool IsReplied { get; set; }
        
        /// <summary>
        /// Yanıt mesajı
        /// </summary>
        public string ReplyMessage { get; set; }
        
        /// <summary>
        /// Yanıt tarihi
        /// </summary>
        public DateTime? ReplyDate { get; set; }
    }
}

