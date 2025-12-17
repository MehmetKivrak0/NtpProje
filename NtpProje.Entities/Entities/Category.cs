using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Kategori domain entity'si
    /// Veritabanı tablosu: categories
    /// </summary>
    public class Category : BaseEntity
    {
        /// <summary>
        /// Kategori adı
        /// </summary>
        public string Name { get; set; }
        
        /// <summary>
        /// Kategori açıklaması
        /// </summary>
        public string Description { get; set; }
        
        /// <summary>
        /// URL dostu kategori adı
        /// </summary>
        public string Slug { get; set; }
    }
}

