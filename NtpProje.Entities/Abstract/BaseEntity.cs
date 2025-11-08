using System;

namespace NtpProje.Entities.Abstract
{
    /// <summary>
    /// Tüm DTO sınıfları için temel sınıf
    /// </summary>
    public abstract class BaseDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}

