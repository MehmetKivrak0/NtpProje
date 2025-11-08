using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class ProjectService : IBaseService<ProjectDTO>
    {
        private ProjectRepository _repository;

        public ProjectService()
        {
            _repository = new ProjectRepository();
        }

        public List<ProjectDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public ProjectDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public void Add(ProjectDTO entity)
        {
            // Business logic eklenebilir
            if (entity.ProjectDate == DateTime.MinValue)
            {
                entity.ProjectDate = DateTime.Now;
            }
            _repository.Add(entity);
        }

        public void Update(ProjectDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}

