using System;

namespace NtpProje.Entities.Abstract
{
    /// <summary>
    /// Tüm domain entity'lerin base class'ı
    /// </summary>
    public abstract class BaseEntity : IEntity<int>
    {
        /// <summary>
        /// Primary key
        /// </summary>
        public int Id { get; set; }
        
        /// <summary>
        /// Kayıt oluşturulma tarihi
        /// </summary>
        public DateTime CreatedDate { get; set; }
        
        /// <summary>
        /// Kayıt güncellenme tarihi
        /// </summary>
        public DateTime? UpdatedDate { get; set; }
        
        /// <summary>
        /// Kayıt aktif mi?
        /// </summary>
        public bool IsActive { get; set; }
    }
}

