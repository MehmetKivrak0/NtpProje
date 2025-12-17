using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Hizmet domain entity'si
    /// Veritabanı tablosu: services
    /// </summary>
    public class Service : BaseEntity
    {
        /// <summary>
        /// Hizmet adı
        /// </summary>
        public string Name { get; set; }
        
        /// <summary>
        /// URL dostu hizmet adı
        /// </summary>
        public string Slug { get; set; }
        
        /// <summary>
        /// Detaylı açıklama
        /// </summary>
        public string Description { get; set; }
        
        /// <summary>
        /// Kısa açıklama
        /// </summary>
        public string ShortDescription { get; set; }
        
        /// <summary>
        /// İkon kodu
        /// </summary>
        public string Icon { get; set; }
        
        /// <summary>
        /// İkon CSS class'ı
        /// </summary>
        public string IconClass { get; set; }
        
        /// <summary>
        /// Hizmet görseli URL'i
        /// </summary>
        public string ImageUrl { get; set; }
        
        /// <summary>
        /// Görüntülenme sırası
        /// </summary>
        public int DisplayOrder { get; set; }
        
        /// <summary>
        /// Görüntülenme sayısı
        /// </summary>
        public int ViewCount { get; set; }
        
        /// <summary>
        /// Özellikler listesi (JSON formatında)
        /// </summary>
        public string Features { get; set; }
        
        /// <summary>
        /// Teknolojiler (JSON formatında)
        /// </summary>
        public string Technologies { get; set; }
        
        /// <summary>
        /// Süreç adımları (JSON formatında)
        /// </summary>
        public string ProcessSteps { get; set; }
        
        /// <summary>
        /// Öne çıkan özellikler (JSON formatında)
        /// </summary>
        public string HighlightFeatures { get; set; }
        
        /// <summary>
        /// Neden bizi tercih etmelisiniz (JSON formatında)
        /// </summary>
        public string WhyChooseUs { get; set; }
    }
}

