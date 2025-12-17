using System;
using NtpProje.Entities.Abstract;

namespace NtpProje.Entities.Entities
{
    /// <summary>
    /// Ayar domain entity'si
    /// Veritabanı tablosu: settings
    /// </summary>
    public class Setting : BaseEntity
    {
        /// <summary>
        /// Ayar anahtarı (unique)
        /// </summary>
        public string Key { get; set; }
        
        /// <summary>
        /// Ayar değeri
        /// </summary>
        public string Value { get; set; }
        
        /// <summary>
        /// Ayar açıklaması
        /// </summary>
        public string Description { get; set; }
    }
}

