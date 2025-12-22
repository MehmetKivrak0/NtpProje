using System;
using System.Runtime.Remoting.Metadata.W3cXsd2001;

namespace NtpProje.Entities.Abstract
{
    /// <summary>
    /// Tüm domain entity'lerin base class'ı
    /// </summary>
    public abstract class BaseEntity : IEntity
    {
        
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

