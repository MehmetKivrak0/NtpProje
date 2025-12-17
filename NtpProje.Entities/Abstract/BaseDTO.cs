using System;

namespace NtpProje.Entities.Abstract
{
    /// <summary>
    /// Tüm DTO'ların base class'ı
    /// </summary>
    public abstract class BaseDTO
    {
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

