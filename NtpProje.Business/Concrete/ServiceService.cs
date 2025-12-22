using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.DTOs; // DTO
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (service)

namespace NtpProje.Business.Concrete
{
    public class ServiceService : IBaseService<ServiceDTO>
    {
        private readonly Repository<service> _serviceRepository;

        public ServiceService()
        {
            _serviceRepository = new Repository<service>();
        }

        // 1. GET ALL (Listeleme)
        public List<ServiceDTO> GetAll()
        {
            // Sadece aktif olanları getirmek istersen: .Where(x => x.is_active == true) ekleyebilirsin.
            var entities = _serviceRepository.GetAll();
            var dtos = new List<ServiceDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(MapEntityToDTO(entity));
            }
            return dtos;
        }

        // 2. GET BY ID (Detay)
        public ServiceDTO GetById(int id)
        {
            // SQL: service_id
            var entity = _serviceRepository.GetAll().FirstOrDefault(s => s.service_id == id);
            return entity != null ? MapEntityToDTO(entity) : null;
        }

        // 3. ADD (Ekleme)
        public bool Add(ServiceDTO dto)
        {
            try
            {
                var entity = new service
                {
                    // DTO -> Entity Eşleşmesi
                    service_name = dto.Name,
                    description = dto.Description,
                    short_description = dto.ShortDescription,
                    icon = dto.Icon,
                    icon_class = dto.IconClass,
                    image_url = dto.ImageUrl,

                    // Otomatik ve Varsayılan Değerler
                    is_active = true,
                    display_order = dto.DisplayOrder > 0 ? dto.DisplayOrder : 0,
                    view_count = 0,
                    created_date = DateTime.Now,

                    // Slug Oluşturma
                    slug = dto.Name.ToLower()
                            .Replace(" ", "-").Replace("ı", "i").Replace("ğ", "g")
                            .Replace("ü", "u").Replace("ş", "s").Replace("ö", "o").Replace("ç", "c")
                };

                // Yeni eklenen kolonlar (Reflection ile)
                SetPropertyIfExists(entity, "features", dto.Features);
                SetPropertyIfExists(entity, "technologies", dto.Technologies);
                SetPropertyIfExists(entity, "process_steps", dto.ProcessSteps);
                SetPropertyIfExists(entity, "highlight_features", dto.HighlightFeatures);
                SetPropertyIfExists(entity, "why_choose_us", dto.WhyChooseUs);

                _serviceRepository.Add(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 4. UPDATE (Güncelleme)
        public bool Update(ServiceDTO dto)
        {
            try
            {
                var entity = _serviceRepository.GetAll().FirstOrDefault(s => s.service_id == dto.Id);
                if (entity == null) return false;

                entity.service_name = dto.Name;
                entity.description = dto.Description;
                entity.short_description = dto.ShortDescription;
                entity.icon = dto.Icon;
                entity.icon_class = dto.IconClass;
                entity.image_url = dto.ImageUrl;
                entity.is_active = dto.IsActive;
                entity.display_order = dto.DisplayOrder;
                entity.updated_date = DateTime.Now;

                // İsim değiştiyse slug yenile
                entity.slug = dto.Name.ToLower().Replace(" ", "-").Replace("ı", "i");

                // Yeni eklenen kolonlar (Reflection ile)
                SetPropertyIfExists(entity, "features", dto.Features);
                SetPropertyIfExists(entity, "technologies", dto.Technologies);
                SetPropertyIfExists(entity, "process_steps", dto.ProcessSteps);
                SetPropertyIfExists(entity, "highlight_features", dto.HighlightFeatures);
                SetPropertyIfExists(entity, "why_choose_us", dto.WhyChooseUs);

                _serviceRepository.Update(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 5. DELETE (Silme)
        public bool Delete(int id)
        {
            try
            {
                var entity = _serviceRepository.GetAll().FirstOrDefault(s => s.service_id == id);
                if (entity == null) return false;

                _serviceRepository.Delete(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // --- MAPPING YARDIMCISI ---
        private ServiceDTO MapEntityToDTO(service entity)
        {
            var dto = new ServiceDTO
            {
                Id = entity.service_id,
                Name = entity.service_name,
                Slug = entity.slug,
                Description = entity.description,
                ShortDescription = entity.short_description,
                Icon = entity.icon,
                IconClass = entity.icon_class,
                ImageUrl = entity.image_url,

                // Nullable (bool?) -> bool dönüşümü
                IsActive = entity.is_active ?? true,

                // Nullable (int?) -> int dönüşümü
                DisplayOrder = entity.display_order ?? 0,
                ViewCount = entity.view_count ?? 0
            };

            // Yeni eklenen kolonlar (Reflection ile)
            dto.Features = GetPropertyIfExists(entity, "features") ?? "";
            dto.Technologies = GetPropertyIfExists(entity, "technologies") ?? "";
            dto.ProcessSteps = GetPropertyIfExists(entity, "process_steps") ?? "";
            dto.HighlightFeatures = GetPropertyIfExists(entity, "highlight_features") ?? "";
            dto.WhyChooseUs = GetPropertyIfExists(entity, "why_choose_us") ?? "";

            return dto;
        }

        // Reflection yardımcı metodları
        private void SetPropertyIfExists(object obj, string propertyName, object value)
        {
            try
            {
                var prop = obj.GetType().GetProperty(propertyName);
                if (prop != null && prop.CanWrite)
                {
                    prop.SetValue(obj, value, null);
                }
            }
            catch
            {
                // Property yoksa sessizce devam et
            }
        }

        private string GetPropertyIfExists(object obj, string propertyName)
        {
            try
            {
                var prop = obj.GetType().GetProperty(propertyName);
                if (prop != null && prop.CanRead)
                {
                    return prop.GetValue(obj, null) as string;
                }
            }
            catch
            {
                // Property yoksa null döndür
            }
            return null;
        }
    }
}
