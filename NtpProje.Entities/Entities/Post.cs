using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Blog yazısı domain entity'si
    /// Veritabanı tablosu: posts
    /// </summary>
    public class Post : BaseEntity
    {
        /// <summary>
        /// Yazı başlığı
        /// </summary>
        public string Title { get; set; }
        
        /// <summary>
        /// URL dostu yazı adı
        /// </summary>
        public string Slug { get; set; }
        
        /// <summary>
        /// Yazı içeriği (HTML)
        /// </summary>
        public string Content { get; set; }
        
        /// <summary>
        /// Yazı özeti
        /// </summary>
        public string Summary { get; set; }
        
        /// <summary>
        /// Kapak görseli URL'i
        /// </summary>
        public string ImageUrl { get; set; }
        
        /// <summary>
        /// Kategori ID'si (Foreign Key)
        /// </summary>
        public int CategoryId { get; set; }
        
        /// <summary>
        /// Yazar ID'si (Foreign Key)
        /// </summary>
        public int UserId { get; set; }
        
        /// <summary>
        /// Yazı durumu (Published, Draft, Archived)
        /// </summary>
        public string Status { get; set; }
        
        /// <summary>
        /// Yayınlanma tarihi
        /// </summary>
        public DateTime? PublishDate { get; set; }
        
        /// <summary>
        /// Görüntülenme sayısı
        /// </summary>
        public int ViewCount { get; set; }
        
        /// <summary>
        /// Okuma süresi (dakika)
        /// </summary>
        public int ReadingTime { get; set; }
    }
}

