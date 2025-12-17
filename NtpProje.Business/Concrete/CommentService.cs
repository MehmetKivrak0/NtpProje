using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Business.Abstract;
using NtpProje.Entities.DTOs;
using NtpProje.Data.Concrete;
using NtpProje.Data.DataModel;
using NtpProje.Entities.Logging;

namespace NtpProje.Business.Concrete
{
    public class CommentService : IBaseService<CommentDTO>
    {
        private readonly CommentRepository _commentRepository;

        public CommentService()
        {
            _commentRepository = new CommentRepository();
        }

        // 1. GET ALL
        public List<CommentDTO> GetAll()
        {
            var entities = _commentRepository.GetAll();
            var dtos = new List<CommentDTO>();

            foreach (var entity in entities)
            {
                dtos.Add(new CommentDTO
                {
                    Id = entity.comment_id,
                    AuthorName = entity.author_name,
                    AuthorEmail = entity.author_email,
                    Content = entity.content,

                    // Tarih ve Onay durumu genelde nullable olabilir, o y�zden ?? kalabilir.
                    // E�er bunlarda da hata verirse ?? k�s�mlar�n� sil.
                    CommentDate = entity.comment_date ?? DateTime.MinValue,
                    IsApproved = entity.is_approved ?? false,

                    // D�ZELTME BURADA: post_id 'int' oldu�u i�in ?? 0 silindi.
                    PostId = entity.post_id,

                    UserId = entity.user_id,
                    ParentCommentId = entity.parent_comment_id
                });
            }
            return dtos;
        }

        // 2. GET BY ID
        public CommentDTO GetById(int id)
        {
            var entity = _commentRepository.GetAll().FirstOrDefault(c => c.comment_id == id);
            if (entity == null) return null;

            return new CommentDTO
            {
                Id = entity.comment_id,
                AuthorName = entity.author_name,
                AuthorEmail = entity.author_email,
                Content = entity.content,

                CommentDate = entity.comment_date ?? DateTime.MinValue,
                IsApproved = entity.is_approved ?? false,

                // D�ZELTME BURADA: ?? 0 silindi
                PostId = entity.post_id,

                UserId = entity.user_id,
                ParentCommentId = entity.parent_comment_id
            };
        }

        // 3. ADD
        public bool Add(CommentDTO dto)
        {
            try
            {
                var entity = new comment
                {
                    author_name = dto.AuthorName,
                    author_email = dto.AuthorEmail,
                    content = dto.Content,
                    post_id = dto.PostId,
                    user_id = dto.UserId,
                    parent_comment_id = dto.ParentCommentId,
                    comment_date = DateTime.Now,
                    is_approved = false
                };

                _commentRepository.Add(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CommentService.Add");
                throw;
            }
        }

        // 4. UPDATE
        public bool Update(CommentDTO dto)
        {
            try
            {
                var entity = _commentRepository.GetAll().FirstOrDefault(c => c.comment_id == dto.Id);
                if (entity == null) return false;

                entity.content = dto.Content;
                entity.is_approved = dto.IsApproved;

                _commentRepository.Update(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CommentService.Update");
                throw;
            }
        }

        // 5. DELETE
        public bool Delete(int id)
        {
            try
            {
                var entity = _commentRepository.GetAll().FirstOrDefault(c => c.comment_id == id);
                if (entity == null) return false;

                _commentRepository.Delete(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CommentService.Delete");
                throw;
            }
        }

        // 6. SAYIM: Onay bekleyen yorum adedi
        public int CountPending()
        {
            try
            {
                return _commentRepository.GetAll().Count(c => !(c.is_approved ?? false));
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "CommentService.CountPending");
                throw;
            }
        }
    }
}