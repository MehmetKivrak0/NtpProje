using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class PostService : IBaseService<PostDTO>
    {
        private PostRepository _repository;

        public PostService()
        {
            _repository = new PostRepository();
        }

        public List<PostDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public PostDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public List<PostDTO> GetByCategory(int categoryId)
        {
            return _repository.GetByCategory(categoryId);
        }

        public void Add(PostDTO entity)
        {
            // Business logic eklenebilir (yayın tarihi kontrolü vb.)
            if (entity.PublishDate == DateTime.MinValue)
            {
                entity.PublishDate = DateTime.Now;
            }
            if (string.IsNullOrEmpty(entity.Status))
            {
                entity.Status = "Taslak";
            }
            _repository.Add(entity);
        }

        public void Update(PostDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }
    }
}

