using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO (CategoryDTO)
using NtpProje.Entities.Logging;
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

        // 1. L�STELEME (GET ALL)
        public List<CategoryDTO> GetAll()
        {
            var entities = _categoryRepository.GetAll();
            var dtos = new List<CategoryDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new CategoryDTO
                {
                    // SOL: DTO (Senin kodun) = SA�: SQL S�tunlar� (Senin Tablon)
                    Id = entity.category_id,
                    Name = entity.category_name,
                    Description = entity.description,
                    Slug = entity.slug
                });
            }
            return dtos;
        }

        // 2. ID �LE GET�R (GET BY ID)
        public CategoryDTO GetById(int id)
        {
            // SQL: category_id
            var entity = _categoryRepository.GetAll().FirstOrDefault(c => c.category_id == id);

            if (entity == null) return null;

            return new CategoryDTO
            {
                Id = entity.category_id,
                Name = entity.category_name,
                Description = entity.description,
                Slug = entity.slug
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

                    // SQL: slug (Otomatik olu�turuyoruz: "Web Tasar�m" -> "web-tasarim")
                    slug = dto.Name.ToLower().Replace(" ", "-").Replace("�", "i").Replace("�", "g").Replace("�", "u").Replace("�", "s").Replace("�", "o").Replace("�", "c"),

                    // SQL: is_active (Varsay�lan aktif olsun)
                    is_active = true,

                    // SQL: display_order (Varsay�lan 0)
                    display_order = 0
                };

                _categoryRepository.Add(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CategoryService.Add");
                throw;
            }
        }

        // 4. G�NCELLEME (UPDATE)
        public bool Update(CategoryDTO dto)
        {
            try
            {
                var entity = _categoryRepository.GetAll().FirstOrDefault(c => c.category_id == dto.Id);
                if (entity == null) return false;

                entity.category_name = dto.Name;
                entity.description = dto.Description;

                // Slug'� da isme g�re g�ncelleyelim
                entity.slug = dto.Name.ToLower().Replace(" ", "-").Replace("�", "i").Replace("�", "g").Replace("�", "u").Replace("�", "s").Replace("�", "o").Replace("�", "c");

                _categoryRepository.Update(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CategoryService.Update");
                throw;
            }
        }

        // 5. S�LME (DELETE)
        public bool Delete(int id)
        {
            try
            {
                var entity = _categoryRepository.GetAll().FirstOrDefault(c => c.category_id == id);
                if (entity == null) return false;

                _categoryRepository.Delete(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CategoryService.Delete");
                throw;
            }
        }
    }
}