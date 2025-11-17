using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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

        public bool Add(ProjectRequestDTO dto)
        {
            if (string.IsNullOrWhiteSpace(dto.email)) return false;

            var entity = new Data.DataModel.project_request
            {
                company_name = dto.company_name,
                contact_person = dto.contact_person,
                email = dto.email,
                phone_number = dto.phone_number,
                project_details = dto.project_details,
                ip_address = dto.ip_address,
                is_read = false,
                created_date = DateTime.Now
            };

            _projectRepository.Add(entity);
            return true;
        }

        public bool Update(ProjectRequestDTO dto)
        {
            var entity = _projectRepository.Get(dto.project_request_id);
            if (entity == null) return false;

            // DTO'dan Entity'ye Eşleştirme (Admin'in güncelleyebileceği alanlar)
            entity.is_read = dto.is_read;
            entity.estimated_duration = dto.estimated_duration.HasValue
                ? dto.estimated_duration.Value.ToString()
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

            //Entity'den DTO'ya Dönüşüm
            return new ProjectRequestDTO
            {
                project_request_id = entity.project_request_id,
                company_name = entity.company_name,
                contact_person = entity.contact_person,
                email = entity.email,
                project_details = entity.project_details,
                is_read = entity.is_read ?? false,
                estimated_duration = decimal.TryParse(entity.estimated_duration, out decimal duration) ? (decimal?)duration : null,
                created_date = entity.created_date ?? DateTime.MinValue // Nullable kontrolü
            };
        }

        public List<ProjectRequestDTO> GetAll()
        {
            var entities = _projectRepository.GetAll();
            var dtos = new List<ProjectRequestDTO>();

            // Listeyi dönderken Entity'den DTO'ya Dönüşüm

            foreach(var entity in entities)
            {
                dtos.Add(new ProjectRequestDTO
                {
                    project_request_id = entity.project_request_id,
                    company_name = entity.company_name,
                    contact_person = entity.contact_person,
                    email = entity.email,
                    project_details = entity.project_details,
                    is_read = entity.is_read ?? false,
                    estimated_duration = decimal.TryParse(entity.estimated_duration, out decimal duration) ? (decimal?)duration : null,
                    created_date = entity.created_date ?? DateTime.MinValue // Nullable kontrolü
                });
            }
            return dtos;
        }
    }
}
