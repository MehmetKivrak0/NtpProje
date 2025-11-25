using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (project_request)

namespace NtpProje.Business.Concrete
{
    public class ProjectRequestService : IBaseService<ProjectRequestDTO>
    {
        private readonly ProjectRequestRepository _projectRepository;

        public ProjectRequestService()
        {
            _projectRepository = new ProjectRequestRepository();
        }

        // 1. GET ALL
        public List<ProjectRequestDTO> GetAll()
        {
            var entities = _projectRepository.GetAll();
            var dtos = new List<ProjectRequestDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(MapEntityToDTO(entity));
            }
            return dtos;
        }

        // 2. GET BY ID
        public ProjectRequestDTO GetById(int id)
        {
            var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_request_id == id);
            return entity != null ? MapEntityToDTO(entity) : null;
        }

        // 3. ADD
        public bool Add(ProjectRequestDTO dto)
        {
            try
            {
                var entity = new project_request
                {
                    company_name = dto.CompanyName,
                    contact_person = dto.AuthorizedPerson,
                    email = dto.Email,
                    phone_number = dto.Phone,
                    project_details = dto.ProjectDetails,
                    status = dto.Status ?? "Pending",
                    created_date = DateTime.Now,
                    is_read = false,
                    ip_address = dto.IpAddress,

                    // DÜZELTME: Artık ikisi de decimal olduğu için direkt atıyoruz.
                    // Çevirme işlemine gerek yok.
                    budget = dto.Budget,
                    quoted_price = dto.QuotedPrice,

                    // Duration string olduğu için direkt atanır
                    estimated_duration = dto.EstimatedDuration,
                    notes = dto.Notes
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
        public bool Update(ProjectRequestDTO dto)
        {
            try
            {
                var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_request_id == dto.Id);
                if (entity == null) return false;

                entity.is_read = dto.IsRead;
                entity.status = dto.Status;
                entity.notes = dto.Notes;

                // DÜZELTME: Direkt atama (Sayı -> Sayı)
                entity.quoted_price = dto.QuotedPrice;

                entity.quoted_date = dto.QuotedDate;
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
                var entity = _projectRepository.GetAll().FirstOrDefault(p => p.project_request_id == id);
                if (entity == null) return false;

                _projectRepository.Delete(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // --- MAPPING YARDIMCISI ---
        private ProjectRequestDTO MapEntityToDTO(project_request entity)
        {
            return new ProjectRequestDTO
            {
                Id = entity.project_request_id,
                CompanyName = entity.company_name,
                AuthorizedPerson = entity.contact_person,
                Email = entity.email,
                Phone = entity.phone_number,
                ProjectDetails = entity.project_details,
                Status = entity.status,

                // DÜZELTME: Direkt atama (Sayı -> Sayı)
                Budget = entity.budget,
                QuotedPrice = entity.quoted_price,

                EstimatedDuration = entity.estimated_duration,
                IsRead = entity.is_read ?? false,
                Notes = entity.notes,

                QuotedDate = entity.quoted_date,
                IpAddress = entity.ip_address,
                RequestDate = entity.created_date ?? DateTime.MinValue
            };
        }
    }
}