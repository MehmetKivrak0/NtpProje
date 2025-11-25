using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO burada (ProjectDTO)
using NtpProje.Data.Concrete;     // Repository burada
using NtpProje.Data.DataModel;    // Veritabaný tablosu burada (project - küçük p)

namespace NtpProje.Business.Concrete
{
    public class ProjectService : IBaseService<ProjectDTO>
    {
        private readonly ProjectRepository _projectRepository;

        public ProjectService()
        {
            _projectRepository = new ProjectRepository();
        }

        // 1. GET ALL
        public List<ProjectDTO> GetAll()
        {
            var entities = _projectRepository.GetAll();
            var dtos = new List<ProjectDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new ProjectDTO
                {
                    // Sol Taraf: DTO (PascalCase) = Sað Taraf: Veritabaný (snake_case)
                    Id = entity.project_id,
                    Title = entity.project_name,
                    Description = entity.description,
                    Category = entity.category,
                    ImageUrl = entity.image_url,
                    Technologies = entity.short_description // technologies yoktu, bunu kullandýk
                });
            }
            return dtos;
        }

        // 2. GET BY ID
        public ProjectDTO GetById(int id)
        {
            // Küçük harf 'project_id' kullanýyoruz
            var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_id == id);

            if (entity == null) return null;

            return new ProjectDTO
            {
                Id = entity.project_id,
                Title = entity.project_name,
                Description = entity.description,
                Category = entity.category,
                ImageUrl = entity.image_url,
                Technologies = entity.short_description
            };
        }

        // 3. ADD
        public bool Add(ProjectDTO dto)
        {
            try
            {
                // 'project' sýnýfýndan (küçük p) nesne üretiyoruz
                var entity = new project
                {
                    project_name = dto.Title,
                    description = dto.Description,
                    category = dto.Category,
                    image_url = dto.ImageUrl,
                    short_description = dto.Technologies,

                    // Zorunlu diðer alanlar (Tablo yapýna göre)
                    created_date = DateTime.Now,
                    is_published = true,
                    view_count = 0,
                    slug = dto.Title != null ? dto.Title.ToLower().Replace(" ", "-") : "project"
                };

                _projectRepository.Add(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 4. UPDATE
        public bool Update(ProjectDTO dto)
        {
            try
            {
                var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_id == dto.Id);
                if (entity == null) return false;

                entity.project_name = dto.Title;
                entity.description = dto.Description;
                entity.category = dto.Category;
                entity.image_url = dto.ImageUrl;
                entity.short_description = dto.Technologies;
                entity.updated_date = DateTime.Now;

                _projectRepository.Update(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 5. DELETE
        public bool Delete(int id)
        {
            try
            {
                var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_id == id);
                if (entity == null) return false;

                _projectRepository.Delete(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}