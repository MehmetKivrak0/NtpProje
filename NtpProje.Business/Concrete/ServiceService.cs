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

                    // DÜZELTME: service_name kullanýldý
                    service_name = entity.service_name,

                    slug = entity.slug,
                    description = entity.description,

                    // DÜZELTME: short_description kullanýldý
                    short_description = entity.short_description,

                    icon = entity.icon,
                    icon_class = entity.icon_class,
                    image_url = entity.image_url,
                    display_order = entity.display_order,
                    view_count = entity.view_count,
                    is_active = entity.is_active ?? false // BaseDTO'dan gelen alan
                    // updated_date BaseDTO'dan geldiði için eklenebilir.
                });
            }
            return dtos;
        }

        // ADD (Yeni hizmet ekleme)
        public bool Add(ServiceDTO dto)
        {
            // DÜZELTME: title yerine service_name kontrolü
            if (string.IsNullOrWhiteSpace(dto.service_name)) return false;

            var entity = new Data.DataModel.service
            {
                // DÜZELTME: service_name kullanýldý
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
                updated_date = DateTime.Now // Veritabanýnda olduðu için kullanabiliriz
            };

            _serviceRepository.Add(entity);
            return true;
        }

        // ... Diðer IBaseService metotlarý (Update, Delete, GetById) da bu alanlarý kullanacak þekilde güncellenmelidir.
        // Sadece GetById metodu örneði:
        public ServiceDTO GetById(int id)
        {
            var entity = _serviceRepository.Get(id);
            if (entity == null) return null;

            return new ServiceDTO
            {
                service_id = entity.service_id,
                service_name = entity.service_name, // DÜZELTME
                short_description = entity.short_description, // DÜZELTME
                // ... tüm alanlar
                is_active = entity.is_active ?? false
            };
        }

        // ... (Diðer zorunlu IBaseService metotlarý Update ve Delete burada doldurulmalýdýr)
        public bool Update(ServiceDTO dto) { throw new NotImplementedException(); }
        public bool Delete(int id) { throw new NotImplementedException(); }
    }
}