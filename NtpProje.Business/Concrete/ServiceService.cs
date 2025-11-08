using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class ServiceService : IBaseService<ServiceDTO>
    {
        private ServiceRepository _repository;

        public ServiceService()
        {
            _repository = new ServiceRepository();
        }

        public List<ServiceDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public ServiceDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public void Add(ServiceDTO entity)
        {
            _repository.Add(entity);
        }

        public void Update(ServiceDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}

