using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.DataModel;

namespace NtpProje.Business.Concrete
{
    public class PostService : IBaseService<PostDTO>
    {
        private readonly PostRepository _postRepository;
        private readonly CategoryRepository _categoryRepository;

        public PostService()
        {
            _postRepository = new PostRepository();
            _categoryRepository = new CategoryRepository();
        }

        // --- ÖZEL METOTLAR ---

        public List<PostDTO> GetPublishedPosts()
        {
            try
            {
                var entities = _postRepository.GetAll()
                                            .Where(p => p.status == "Published")
                                            .OrderByDescending(p => p.publish_date)
                                            .ToList();

                return MapEntitiesToDTOs(entities);
            }
            catch
            {
                return new List<PostDTO>();
            }
        }

        // --- IBASE SERVICE METOTLARI ---

        public List<PostDTO> GetAll()
        {
            var entities = _postRepository.GetAll();
            return MapEntitiesToDTOs(entities);
        }

        public PostDTO GetById(int id)
        {
            var entity = _postRepository.GetAll().FirstOrDefault(p => p.post_id == id);
            return entity != null ? MapEntityToDTO(entity) : null;
        }

        public bool Add(PostDTO dto)
        {
            try
            {
                var entity = new post
                {
                    title = dto.Title,
                    slug = dto.Slug ?? dto.Title.ToLower().Replace(" ", "-"),
                    content = dto.Content,
                    summary = dto.Summary,
                    image_url = dto.ImageUrl,

                    // DÜZELTME: int olduðu için direkt atýyoruz
                    category_id = dto.CategoryId,

                    user_id = 1,
                    status = dto.Status ?? "Draft",
                    created_date = DateTime.Now,

                    // DÜZELTME: int olduðu için direkt atýyoruz
                    view_count = 0,
                    reading_time = dto.ReadingTime
                };

                _postRepository.Add(entity);
                return true;
            }
            catch { return false; }
        }

        public bool Update(PostDTO dto)
        {
            try
            {
                var entity = _postRepository.GetAll().FirstOrDefault(p => p.post_id == dto.Id);
                if (entity == null) return false;

                entity.title = dto.Title;
                entity.content = dto.Content;
                entity.summary = dto.Summary;
                entity.image_url = dto.ImageUrl;
                entity.category_id = dto.CategoryId;
                entity.status = dto.Status;

                // DÜZELTME: Tarih nullable ise kontrol et, deðilse direkt ata
                if (dto.PublishDate.HasValue)
                {
                    entity.publish_date = dto.PublishDate.Value;
                }

                entity.updated_date = DateTime.Now;

                _postRepository.Update(entity);
                return true;
            }
            catch { return false; }
        }

        public bool Delete(int id)
        {
            try
            {
                var entity = _postRepository.GetAll().FirstOrDefault(p => p.post_id == id);
                if (entity == null) return false;

                _postRepository.Delete(entity);
                return true;
            }
            catch { return false; }
        }

        // --- MAPPING METOTLARI ---

        private List<PostDTO> MapEntitiesToDTOs(IEnumerable<Data.DataModel.post> entities)
        {
            return entities.Select(MapEntityToDTO).ToList();
        }

        private PostDTO MapEntityToDTO(Data.DataModel.post entity)
        {
            string categoryName = "";

            // DÜZELTME 1 (CS1061 Çözümü): 
            // category_id 'int' olduðu için .HasValue ve .Value SÝLÝNDÝ.
            // Sadece 0'dan büyük mü diye bakýyoruz.
            if (entity.category_id > 0)
            {
                var categoryEntity = _categoryRepository.Get(entity.category_id);
                categoryName = categoryEntity?.category_name ?? "";
            }

            return new PostDTO
            {
                Id = entity.post_id,
                Title = entity.title,
                Slug = entity.slug,
                Content = entity.content,
                Summary = entity.summary,
                ImageUrl = entity.image_url,

                // --- DÜZELTÝLEN KISIM ---
                // "?? 0" ekledik. Anlamý: Eðer null gelirse 0 yap.
                ViewCount = entity.view_count ?? 0,
                ReadingTime = entity.reading_time ?? 0,
                CategoryId = entity.category_id,                // ------------------------

                PublishDate = entity.publish_date,
                Status = entity.status,

                CategoryName = categoryName,
                AuthorFullName = ""
            };
        }
    }
}