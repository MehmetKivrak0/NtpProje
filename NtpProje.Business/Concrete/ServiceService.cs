using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using NtpProje.Data.DataModel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace NtpProje.Business.Concrete
{
    public class ServiceService : IBaseService<ServiceDTO>
    {
        private readonly ServiceRepository _serviceRepository = new ServiceRepository();

        // GET ALL (Web sayfasýnda ve Admin listelemede kullanýlýr)
        public List<ServiceDTO> GetAll()
        {
            var entities = _serviceRepository.GetAll(s => s.is_active == true)
                                              .OrderBy(s => s.display_order);
            var dtos = new List<ServiceDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new ServiceDTO
                {
                    service_id = entity.service_id,
                    service_name = entity.service_name,
                    slug = entity.slug,
                    description = entity.description,
                    short_description = entity.short_description,
                    icon = entity.icon,
                    icon_class = entity.icon_class,
                    image_url = entity.image_url,
                    display_order = entity.display_order,
                    view_count = entity.view_count,
                    Is_active = entity.is_active ?? false, // DTO'dan gelen alan
                    Created_date = entity.updated_date ?? DateTime.MinValue
                });
            }
            return dtos;
        }

        // ADD (Yeni hizmet ekleme)
        public bool Add(ServiceDTO dto)
        {
            if (string.IsNullOrWhiteSpace(dto.service_name)) return false;

            var entity = new Data.DataModel.service
            {
                service_name = dto.service_name,
                slug = dto.slug,
                description = dto.description,
                short_description = dto.short_description,
                icon = dto.icon,
                icon_class = dto.icon_class,
                image_url = dto.image_url,
                display_order = dto.display_order,
                is_active = true,
                created_date = DateTime.Now,
                updated_date = DateTime.Now
            };

            _serviceRepository.Add(entity);
            return true;
        }

        // UPDATE (Hizmet düzenleme) - TAMAMLANDI
        public bool Update(ServiceDTO dto)
        {
            var entity = _serviceRepository.Get(dto.service_id);
            if (entity == null) return false;

            // DTO'dan Entity'ye Eþleþtirme
            entity.service_name = dto.service_name;
            entity.slug = dto.slug;
            entity.description = dto.description;
            entity.short_description = dto.short_description;
            entity.icon = dto.icon;
            entity.icon_class = dto.icon_class;
            entity.image_url = dto.image_url;
            entity.display_order = dto.display_order;
            entity.is_active = dto.Is_active; // DTO'dan al
            entity.updated_date = DateTime.Now;

            _serviceRepository.Update(entity);
            return true;
        }

        // DELETE (Hizmet silme) - TAMAMLANDI
        public bool Delete(int id)
        {
            var entity = _serviceRepository.Get(id);
            if (entity == null) return false;

            _serviceRepository.Delete(entity);
            return true;
        }

        // GET BY ID (Detay/Düzenleme için) - TAMAMLANDI
        public ServiceDTO GetById(int id)
        {
            var entity = _serviceRepository.Get(id);
            if (entity == null) return null;

            return new ServiceDTO
            {
                service_id = entity.service_id,
                service_name = entity.service_name,
                slug = entity.slug,
                description = entity.description,
                short_description = entity.short_description,
                icon = entity.icon,
                icon_class = entity.icon_class,
                image_url = entity.image_url,
                display_order = entity.display_order,
                view_count = entity.view_count,
                Is_active = entity.is_active ?? false,
                Created_date = entity.created_date ?? DateTime.MinValue
            };
        }
    }
}