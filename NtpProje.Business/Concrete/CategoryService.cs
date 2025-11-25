using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO (CategoryDTO)
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (category)

namespace NtpProje.Business.Concrete
{
    public class CategoryService : IBaseService<CategoryDTO>
    {
        private readonly CategoryRepository _categoryRepository;

        public CategoryService()
        {
            _categoryRepository = new CategoryRepository();
        }

        // 1. LÝSTELEME (GET ALL)
        public List<CategoryDTO> GetAll()
        {
            var entities = _categoryRepository.GetAll();
            var dtos = new List<CategoryDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new CategoryDTO
                {
                    // SOL: DTO (Senin kodun) = SAÐ: SQL Sütunlarý (Senin Tablon)
                    Id = entity.category_id,
                    Name = entity.category_name,
                    Description = entity.description
                });
            }
            return dtos;
        }

        // 2. ID ÝLE GETÝR (GET BY ID)
        public CategoryDTO GetById(int id)
        {
            // SQL: category_id
            var entity = _categoryRepository.GetAll().FirstOrDefault(c => c.category_id == id);

            if (entity == null) return null;

            return new CategoryDTO
            {
                Id = entity.category_id,
                Name = entity.category_name,
                Description = entity.description
            };
        }

        // 3. EKLEME (ADD)
        public bool Add(CategoryDTO dto)
        {
            try
            {
                var entity = new category
                {
                    // SQL: category_name
                    category_name = dto.Name,

                    // SQL: description
                    description = dto.Description,

                    // SQL: slug (Otomatik oluþturuyoruz: "Web Tasarým" -> "web-tasarim")
                    slug = dto.Name.ToLower().Replace(" ", "-").Replace("ý", "i").Replace("ð", "g").Replace("ü", "u").Replace("þ", "s").Replace("ö", "o").Replace("ç", "c"),

                    // SQL: is_active (Varsayýlan aktif olsun)
                    is_active = true,

                    // SQL: display_order (Varsayýlan 0)
                    display_order = 0
                };

                _categoryRepository.Add(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 4. GÜNCELLEME (UPDATE)
        public bool Update(CategoryDTO dto)
        {
            try
            {
                var entity = _categoryRepository.GetAll().FirstOrDefault(c => c.category_id == dto.Id);
                if (entity == null) return false;

                entity.category_name = dto.Name;
                entity.description = dto.Description;

                // Slug'ý da isme göre güncelleyelim
                entity.slug = dto.Name.ToLower().Replace(" ", "-").Replace("ý", "i").Replace("ð", "g").Replace("ü", "u").Replace("þ", "s").Replace("ö", "o").Replace("ç", "c");

                _categoryRepository.Update(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 5. SÝLME (DELETE)
        public bool Delete(int id)
        {
            try
            {
                var entity = _categoryRepository.GetAll().FirstOrDefault(c => c.category_id == id);
                if (entity == null) return false;

                _categoryRepository.Delete(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}