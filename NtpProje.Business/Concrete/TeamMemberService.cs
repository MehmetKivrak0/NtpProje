using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class TeamMemberService : IBaseService<TeamMemberDTO>
    {
        private TeamMemberRepository _repository;

        public TeamMemberService()
        {
            _repository = new TeamMemberRepository();
        }

        public List<TeamMemberDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public TeamMemberDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public void Add(TeamMemberDTO entity)
        {
            _repository.Add(entity);
        }

        public void Update(TeamMemberDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}

