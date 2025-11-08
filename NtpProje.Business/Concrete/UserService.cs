using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class UserService : IBaseService<UserDTO>
    {
        private UserRepository _repository;

        public UserService()
        {
            _repository = new UserRepository();
        }

        public List<UserDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public UserDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public UserDTO GetByEmail(string email)
        {
            return _repository.GetByEmail(email);
        }

        public void Add(UserDTO entity)
        {
            // Business logic eklenebilir (validasyon, şifre şifreleme vb.)
            _repository.Add(entity);
        }

        public void Update(UserDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public bool Login(string email, string password)
        {
            var user = _repository.GetByEmail(email);
            if (user != null && user.Password == password)
            {
                return true;
            }
            return false;
        }
    }
}

