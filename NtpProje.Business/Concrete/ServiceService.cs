using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (service)

namespace NtpProje.Business.Concrete
{
    public class ServiceService : IBaseService<ServiceDTO>
    {
        private readonly ServiceRepository _serviceRepository;

        public ServiceService()
        {
            _serviceRepository = new ServiceRepository();
        }

        // 1. GET ALL (Listeleme)
        public List<ServiceDTO> GetAll()
        {
            // Sadece aktif olanlarý getirmek istersen: .Where(x => x.is_active == true) ekleyebilirsin.
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
                    // DTO -> Entity Eþleþmesi
                    service_name = dto.Name,
                    description = dto.Description,
                    short_description = dto.ShortDescription,
                    icon = dto.Icon,
                    icon_class = dto.IconClass,
                    image_url = dto.ImageUrl,

                    // Otomatik ve Varsayýlan Deðerler
                    is_active = true,
                    display_order = dto.DisplayOrder > 0 ? dto.DisplayOrder : 0,
                    view_count = 0,
                    created_date = DateTime.Now,

                    // Slug Oluþturma
                    slug = dto.Name.ToLower()
                            .Replace(" ", "-").Replace("ý", "i").Replace("ð", "g")
                            .Replace("ü", "u").Replace("þ", "s").Replace("ö", "o").Replace("ç", "c")
                };

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

                // Ýsim deðiþtiyse slug yenile
                entity.slug = dto.Name.ToLower().Replace(" ", "-").Replace("ý", "i");

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
            return new ServiceDTO
            {
                Id = entity.service_id,
                Name = entity.service_name,
                Slug = entity.slug,
                Description = entity.description,
                ShortDescription = entity.short_description,
                Icon = entity.icon,
                IconClass = entity.icon_class,
                ImageUrl = entity.image_url,

                // Nullable (bool?) -> bool dönüþümü
                IsActive = entity.is_active ?? true,

                // Nullable (int?) -> int dönüþümü
                DisplayOrder = entity.display_order ?? 0,
                ViewCount = entity.view_count ?? 0
            };
        }
    }
}