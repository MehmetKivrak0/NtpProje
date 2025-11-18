using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions; // Gerekli olabilir
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete;
using NtpProje.Data.Concrete;
using NtpProje.Data.DataModel;

namespace NtpProje.Business.Concrete
{
    // IBaseService sözleşmesini ProjectRequestDTO ile uyguluyoruz
    public class ProjectRequestService : IBaseService<ProjectRequestDTO>
    {
        private readonly ProjectRequestRepository _projectRepository;

        // EKLENDİ: Constructor (Yapıcı Metot)
        public ProjectRequestService()
        {
            // CS0649 uyarısını ve Runtime hatalarını çözer.
            _projectRepository = new ProjectRequestRepository();
        }

        public bool Add(ProjectRequestDTO dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Email)) return false;

            var entity = new Data.DataModel.project_request
            {
                company_name = dto.Company_name,
                contact_person = dto.Contact_person,
                email = dto.Email,
                phone_number = dto.Phone_number,
                project_details = dto.Project_details,
                ip_address = dto.Ip_address,
                is_read = false,
                created_date = DateTime.Now
            };

            _projectRepository.Add(entity);
            return true;
        }

        public bool Update(ProjectRequestDTO dto)
        {
            var entity = _projectRepository.Get(dto.Project_request_id);
            if (entity == null) return false;

            // DTO'dan Entity'ye Eşleştirme (Admin'in güncelleyebileceği alanlar)
            entity.is_read = dto.Is_read;

            // String/Decimal Dönüşümü Güvenli Yapılır
            entity.estimated_duration = dto.Estimated_duration.HasValue
                ? dto.Estimated_duration.Value.ToString()
                : null;

            entity.updated_date = DateTime.Now;
            _projectRepository.Update(entity);
            return true;
        }

        public bool Delete(int id)
        {
            var entity = _projectRepository.Get(id);
            if (entity == null) return false;

            _projectRepository.Delete(entity);
            return true;
        }

        public ProjectRequestDTO GetById(int id)
        {
            var entity = _projectRepository.Get(id);
            if (entity == null) return null;

            // Entity'den DTO'ya Dönüşüm (String/Decimal Dönüşümü Güvenli Yapılır)
            return new ProjectRequestDTO
            {
                Project_request_id = entity.project_request_id,
                Company_name = entity.company_name,
                Contact_person = entity.contact_person,
                Email = entity.email,
                Project_details = entity.project_details,
                Is_read = entity.is_read ?? false,

                // String'i decimal'e dönüştürme (TryParse kullanılır)
                Estimated_duration = decimal.TryParse(entity.estimated_duration, out decimal duration) ? (decimal?)duration : null,

                Created_date = entity.created_date ?? DateTime.MinValue // Nullable kontrolü
            };
        }

        public List<ProjectRequestDTO> GetAll()
        {
            var entities = _projectRepository.GetAll();
            var dtos = new List<ProjectRequestDTO>();

            // Listeyi dönderken Entity'den DTO'ya Dönüşüm
            foreach (var entity in entities)
            {
                dtos.Add(new ProjectRequestDTO
                {
                    Project_request_id = entity.project_request_id,
                    Company_name = entity.company_name,
                    Contact_person = entity.contact_person,
                    Email = entity.email,
                    Project_details = entity.project_details,
                    Is_read = entity.is_read ?? false,
                    Estimated_duration = decimal.TryParse(entity.estimated_duration, out decimal duration) ? (decimal?)duration : null,
                    Created_date = entity.created_date ?? DateTime.MinValue // Nullable kontrolü
                });
            }
            return dtos;
        }
    }
}