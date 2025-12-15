using System.Collections.Generic;

namespace NtpProje.Business.Validation
{
    /// <summary>
    /// Basit doğrulama sonucu nesnesi
    /// </summary>
    public class ValidationResult
    {
        public bool IsValid => Errors.Count == 0;
        public List<string> Errors { get; } = new List<string>();
    }
}


