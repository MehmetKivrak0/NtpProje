// NtpProje.Business/Concrete/TeamMemberService.cs içinde:
using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using NtpProje.Data.DataModel;
using System.Collections.Generic;
using System.Linq;
using System;

namespace NtpProje.Business.Concrete
{
    public class TeamMemberService : IBaseService<TeamMemberDTO>
    {
        private readonly TeamMemberRepository _teamRepository = new TeamMemberRepository();

        public List<TeamMemberDTO> GetAll() // <--- CS01061 hatasýný çözer
        {
            var entities = _teamRepository.GetAll().OrderBy(t => t.display_order);
            var dtos = new List<TeamMemberDTO>();

            foreach (var entity in entities)
            {
                // Entity'den DTO'ya dönüþüm
                dtos.Add(new TeamMemberDTO
                {
                    team_member_id = entity.team_member_id,

                    // DTO (Küçük Harf) = Entity (Küçük Harf)
                    name = entity.name,
                    position = entity.position,
                    image_url = entity.image_url,
                    linkedin_url = entity.linkedin_url,
                    github_url = entity.github_url,

                    // Nullable kontrolleri
                    display_order = entity.display_order ?? 0,
                    is_active = entity.is_active ?? false
                    // created_date, updated_date BaseDTO'dan gelir.
                });
            }
            return dtos;
        }

        // Diðer IBaseService metotlarý (Add, Update, Delete, GetById) burada da doldurulmalýdýr.
        public bool Add(TeamMemberDTO dto) { throw new NotImplementedException(); }
        public bool Update(TeamMemberDTO dto) { throw new  NotImplementedException(); }
        public bool Delete(int id) { throw new NotImplementedException(); }
        public TeamMemberDTO GetById(int id) { throw new  NotImplementedException(); }
    }
}