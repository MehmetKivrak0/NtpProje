using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO burada (ProjectDTO)
using NtpProje.Entities.Logging;
using NtpProje.Data.Concrete;     // Repository burada
using NtpProje.Data.DataModel;    // Veritabanı tablosu burada (project - küçük p)
using NtpProje.Business.Concrete; // CategoryService için

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
            // ÖNCE VIEW KULLANIMINI DENİYORUZ (Performanslı ve teknoloji sayısı gibi ek bilgileri de içerir)
            try
            {
                var viewResults = _projectRepository.GetProjectDetailsFromView();
                if (viewResults != null && viewResults.Count > 0)
                {
                    // View'dan gelen teknolojileri kullanmak için kategori ID'lerini de bulalım
                    foreach (var dto in viewResults)
                    {
                        int categoryId = 0;
                        if (!string.IsNullOrEmpty(dto.Category))
                        {
                            var categoryService = new CategoryService();
                            var allCategories = categoryService.GetAll();
                            var matchedCategory = allCategories.FirstOrDefault(c => c.Name == dto.Category);
                            if (matchedCategory != null)
                                categoryId = matchedCategory.Id;
                        }
                        dto.CategoryId = categoryId;
                    }
                    return viewResults;
                }
            }
            catch (Exception ex)
            {
                // View kullanılamazsa normal yönteme geç (Güvenli Fallback)
                System.Diagnostics.Debug.WriteLine("View kullanımı başarısız, normal yönteme geçiliyor: " + ex.Message);
            }

            // VIEW KULLANILAMAZSA NORMAL YÖNTEM (Mevcut Kod - Geriye Uyumluluk)
            var entities = _projectRepository.GetAll();
            var dtos = new List<ProjectDTO>();

            foreach (var entity in entities)
            {
                // Kategori adından kategori ID'sini bul
                int categoryId = 0;
                if (!string.IsNullOrEmpty(entity.category))
                {
                    var categoryService = new CategoryService();
                    var allCategories = categoryService.GetAll();
                    var matchedCategory = allCategories.FirstOrDefault(c => c.Name == entity.category);
                    if (matchedCategory != null)
                        categoryId = matchedCategory.Id;
                }

                dtos.Add(new ProjectDTO
                {
                    // Sol Taraf: DTO (PascalCase) = Sağ Taraf: Veritabanı (snake_case)
                    Id = entity.project_id,
                    Title = entity.project_name,
                    Description = entity.description,
                    Category = entity.category, // Eski yapı için korunuyor
                    CategoryId = categoryId, // categories tablosundan bulunan ID
                    ImageUrl = entity.image_url,
                    Technologies = entity.short_description, // technologies yoktu, bunu kullandık
                    ClientName = entity.client_name,
                    CompletionDate = entity.completion_date,
                    Status = entity.status,
                    ViewCount = entity.view_count ?? 0
                });
            }
            return dtos;
        }

        // 2. GET BY ID
        public ProjectDTO GetById(int id)
        {
            // Küçük harf 'project_id' kullanıyoruz
            var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_id == id);

            if (entity == null) return null;

            // Kategori adından kategori ID'sini bul
            int categoryId = 0;
            if (!string.IsNullOrEmpty(entity.category))
            {
                var categoryService = new CategoryService();
                var allCategories = categoryService.GetAll();
                var matchedCategory = allCategories.FirstOrDefault(c => c.Name == entity.category);
                if (matchedCategory != null)
                    categoryId = matchedCategory.Id;
            }

            return new ProjectDTO
            {
                Id = entity.project_id,
                Title = entity.project_name,
                Description = entity.description,
                Category = entity.category, // Eski yapı için korunuyor
                CategoryId = categoryId, // categories tablosundan bulunan ID
                ImageUrl = entity.image_url,
                Technologies = entity.short_description,
                ClientName = entity.client_name,
                CompletionDate = entity.completion_date,
                Status = entity.status,
                ViewCount = entity.view_count ?? 0
            };
        }

        // 3. ADD
        public bool Add(ProjectDTO dto)
        {
            try
            {
                // 'project' sınıfından (küçük p) nesne üretiyoruz
                // CategoryId'den kategori adını bul
                string categoryName = dto.Category;
                if (dto.CategoryId > 0 && string.IsNullOrEmpty(categoryName))
                {
                    var categoryService = new CategoryService();
                    var category = categoryService.GetById(dto.CategoryId);
                    if (category != null)
                        categoryName = category.Name;
                }

                var entity = new project
                {
                    project_name = dto.Title,
                    description = dto.Description,
                    category = categoryName ?? dto.Category, // categories tablosundan gelen kategori adı
                    image_url = dto.ImageUrl,
                    short_description = dto.Technologies,
                    
                    // client_name eklendi
                    client_name = dto.ClientName,
                    
                    // completion_date eklendi
                    completion_date = dto.CompletionDate,
                    
                    // status eklendi
                    status = dto.Status ?? "Devam Ediyor",
                    
                    // project_date NOT NULL olduğu için mutlaka set edilmeli
                    project_date = DateTime.Now,

                    // Zorunlu diğer alanlar (Tablo yapısına göre)
                    created_date = DateTime.Now,
                    is_published = true,
                    view_count = 0,
                    slug = dto.Title != null ? dto.Title.ToLower().Replace(" ", "-") : "project"
                };

                using (var scope = new TransactionScope())
                {
                    _projectRepository.Add(entity);
                    scope.Complete();
                    return true;
                }
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "ProjectService.Add");
                throw;
            }
        }

        // 4. UPDATE
        public bool Update(ProjectDTO dto)
        {
            try
            {
                var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_id == dto.Id);
                if (entity == null) return false;

                // CategoryId'den kategori adını bul
                string categoryName = dto.Category;
                if (dto.CategoryId > 0 && string.IsNullOrEmpty(categoryName))
                {
                    var categoryService = new CategoryService();
                    var category = categoryService.GetById(dto.CategoryId);
                    if (category != null)
                        categoryName = category.Name;
                }

                entity.project_name = dto.Title;
                entity.description = dto.Description;
                entity.category = categoryName ?? dto.Category; // categories tablosundan gelen kategori adı
                entity.image_url = dto.ImageUrl;
                entity.short_description = dto.Technologies;
                
                // client_name eklendi
                entity.client_name = dto.ClientName;
                
                // completion_date eklendi
                entity.completion_date = dto.CompletionDate;
                
                // status eklendi
                if (!string.IsNullOrEmpty(dto.Status))
                    entity.status = dto.Status;
                
                // project_date güncellenmesi (opsiyonel, genelde değiştirilmez)
                // Eğer DTO'da project_date varsa güncellenebilir, yoksa mevcut değer korunur
                
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

        // 6. SAYIM: Toplam proje adedi
        public int CountAll()
        {
            try
            {
                return _projectRepository.GetAll().Count();
            }
            catch
            {
                return 0;
            }
        }

        // 7. Dashboard sayıları (Stored Procedure: sp_GetDashboardCounts)
        public DashboardCountsDTO GetDashboardCounts()
        {
            return _projectRepository.GetDashboardCountsFromSp();
        }

        // 8. Aktif projeleri TVF üzerinden getir (fn_GetActiveProjects)
        public List<ProjectDTO> GetActiveProjectsFromFunction()
        {
            return _projectRepository.GetActiveProjectsFromFunction();
        }
    }
}
