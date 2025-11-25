using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete; // DTO
using NtpProje.Data.Concrete;     // Repository
using NtpProje.Data.DataModel;    // Entity (team_member)

namespace NtpProje.Business.Concrete
{
    public class TeamMemberService : IBaseService<TeamMemberDTO>
    {
        private readonly TeamMemberRepository _teamRepository;

        public TeamMemberService()
        {
            _teamRepository = new TeamMemberRepository();
        }

        // 1. GET ALL (Listeleme)
        public List<TeamMemberDTO> GetAll()
        {
            var entities = _teamRepository.GetAll();
            var dtos = new List<TeamMemberDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(MapEntityToDTO(entity));
            }
            return dtos;
        }

        // 2. GET BY ID (Detay)
        public TeamMemberDTO GetById(int id)
        {
            // SQL: team_member_id
            var entity = _teamRepository.GetAll().FirstOrDefault(t => t.team_member_id == id);
            return entity != null ? MapEntityToDTO(entity) : null;
        }

        // 3. ADD (Ekleme)
        public bool Add(TeamMemberDTO dto)
        {
            try
            {
                var entity = new team_member
                {
                    // DTO -> Entity Eþleþmesi
                    name = dto.Name,
                    title = dto.Title,
                    position = dto.Position,
                    image_url = dto.ImageUrl,
                    bio = dto.Bio,
                    email = dto.Email,
                    phone_number = dto.PhoneNumber,
                    linkedin_url = dto.LinkedInUrl,
                    twitter_url = dto.TwitterUrl,
                    github_url = dto.GithubUrl,

                    // Otomatik ve Varsayýlan Deðerler
                    is_active = true,
                    display_order = dto.DisplayOrder > 0 ? dto.DisplayOrder : 0,
                    created_date = DateTime.Now
                };

                _teamRepository.Add(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // 4. UPDATE (Güncelleme)
        public bool Update(TeamMemberDTO dto)
        {
            try
            {
                var entity = _teamRepository.GetAll().FirstOrDefault(t => t.team_member_id == dto.Id);
                if (entity == null) return false;

                entity.name = dto.Name;
                entity.title = dto.Title;
                entity.position = dto.Position;
                entity.image_url = dto.ImageUrl;
                entity.bio = dto.Bio;
                entity.email = dto.Email;
                entity.phone_number = dto.PhoneNumber;
                entity.linkedin_url = dto.LinkedInUrl;
                entity.twitter_url = dto.TwitterUrl;
                entity.github_url = dto.GithubUrl;
                entity.is_active = dto.IsActive;
                entity.display_order = dto.DisplayOrder;
                entity.updated_date = DateTime.Now;

                _teamRepository.Update(entity);
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
                var entity = _teamRepository.GetAll().FirstOrDefault(t => t.team_member_id == id);
                if (entity == null) return false;

                _teamRepository.Delete(entity);
                return true;
            }
            catch
            {
                return false;
            }
        }

        // --- MAPPING YARDIMCISI ---
        private TeamMemberDTO MapEntityToDTO(team_member entity)
        {
            return new TeamMemberDTO
            {
                // SOL: DTO = SAÐ: SQL
                Id = entity.team_member_id,
                Name = entity.name,
                Title = entity.title,
                Position = entity.position,
                ImageUrl = entity.image_url,
                Bio = entity.bio,
                Email = entity.email,
                PhoneNumber = entity.phone_number,
                LinkedInUrl = entity.linkedin_url,
                TwitterUrl = entity.twitter_url,
                GithubUrl = entity.github_url,

                // Nullable -> Non-Nullable Dönüþümleri
                IsActive = entity.is_active ?? true,
                DisplayOrder = entity.display_order ?? 0
            };
        }
    }
}