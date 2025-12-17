using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Proje domain entity'si
    /// Veritabanı tablosu: projects
    /// </summary>
    public class Project : BaseEntity
    {
        /// <summary>
        /// Proje başlığı
        /// </summary>
        public string Title { get; set; }
        
        /// <summary>
        /// Proje açıklaması
        /// </summary>
        public string Description { get; set; }
        
        /// <summary>
        /// Kullanılan teknolojiler
        /// </summary>
        public string Technologies { get; set; }
        
        /// <summary>
        /// Proje görseli URL'i
        /// </summary>
        public string ImageUrl { get; set; }
        
        /// <summary>
        /// Kategori (String - eski alan)
        /// </summary>
        public string Category { get; set; }
        
        /// <summary>
        /// Kategori ID'si (Foreign Key)
        /// </summary>
        public int CategoryId { get; set; }
        
        /// <summary>
        /// Müşteri adı
        /// </summary>
        public string ClientName { get; set; }
        
        /// <summary>
        /// Görüntülenme sayısı
        /// </summary>
        public int ViewCount { get; set; }
        
        /// <summary>
        /// Proje tamamlanma tarihi
        /// </summary>
        public DateTime? CompletionDate { get; set; }
        
        /// <summary>
        /// Proje durumu (Completed, InProgress, Planned)
        /// </summary>
        public string Status { get; set; }
    }
}

