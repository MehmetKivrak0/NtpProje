using NtpProje.Entities.DTOs;

namespace NtpProje.Business.Validation
{
    public static class ValidationHelper
    {
        public static ValidationResult ValidateCategory(CategoryDTO dto)
        {
            var result = new ValidationResult();

            if (dto == null)
            {
                result.Errors.Add("Kategori bilgisi boş olamaz.");
                return result;
            }

            if (string.IsNullOrWhiteSpace(dto.Name))
            {
                result.Errors.Add("Kategori adı zorunludur.");
            }
            else if (dto.Name.Length > 100)
            {
                result.Errors.Add("Kategori adı 100 karakteri geçemez.");
            }

            if (!string.IsNullOrEmpty(dto.Description) && dto.Description.Length > 500)
            {
                result.Errors.Add("Açıklama 500 karakteri geçemez.");
            }

            return result;
        }
    }
}


