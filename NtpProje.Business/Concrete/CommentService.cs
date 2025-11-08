using NtpProje.Business.Abstract;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;

namespace NtpProje.Business.Concrete
{
    public class CommentService : IBaseService<CommentDTO>
    {

        public CommentService()
        {
            _repository = new CommentRepository();
        }

        public List<CommentDTO> GetAll()
        {
            return _repository.GetAll();
        }

        public CommentDTO GetById(int id)
        {
            return _repository.GetById(id);
        }

        public List<CommentDTO> GetByPost(int postId)
        {
            return _repository.GetByPost(postId);
        }

        public void Add(CommentDTO entity)
        {
            // Yeni yorumlar varsayılan olarak onay bekliyor
            if (entity.CommentDate == DateTime.MinValue)
            {
                entity.CommentDate = DateTime.Now;
            }
            entity.IsApproved = false; // Admin onayı gerekli
            _repository.Add(entity);
        }

        public void Update(CommentDTO entity)
        {
            _repository.Update(entity);
        }

        public void Delete(int id)
        {
            _repository.Delete(id);
        }

        public void ApproveComment(int commentId)
        {
            var comment = _repository.GetById(commentId);
            if (comment != null)
            {
                comment.IsApproved = true;
                _repository.Update(comment);
            }
        }
    }
}

