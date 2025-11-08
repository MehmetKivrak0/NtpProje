using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class CategoryService : IBaseService<CategoryDTO>
    {
        private CategoryRepository _repository;

        public CategoryService()
        {
            _repository = new CategoryRepository();
        }

        public List<CategoryDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public CategoryDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public void Add(CategoryDTO entity)
        {
            // Business logic eklenebilir (kategori adı kontrolü vb.)
            _repository.Add(entity);
        }

        public void Update(CategoryDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}

