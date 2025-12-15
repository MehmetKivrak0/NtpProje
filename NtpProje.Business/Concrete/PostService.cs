using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.DataModel;
using NtpProje.Entities.Logging;

namespace NtpProje.Business.Concrete
{
    public class PostService : IBaseService<PostDTO>
    {
        private readonly PostRepository _postRepository;
        private readonly CategoryRepository _categoryRepository;
        private readonly UserRepository _userRepository;

        public PostService()
        {
            _postRepository = new PostRepository();
            _categoryRepository = new CategoryRepository();
            _userRepository = new UserRepository();
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

        // Yalnızca toplam blog sayısını döner (veri taşımadan hızlı sayaç)
        public int CountAll()
        {
            try
            {
                return _postRepository.GetAll().Count();
            }
            catch
            {
                return 0;
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

                    // Kategori ID
                    category_id = dto.CategoryId,

                    // User ID - DTO'dan alınıyor, yoksa varsayılan 1
                    user_id = dto.UserId > 0 ? dto.UserId : 1,
                    
                    status = dto.Status ?? "Draft",
                    created_date = DateTime.Now,
                    
                    // publish_date NOT NULL olduğu için mutlaka set edilmeli
                    publish_date = dto.PublishDate ?? DateTime.Now,

                    // Varsayılan değerler
                    view_count = 0,
                    reading_time = dto.ReadingTime
                };

                _postRepository.Add(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "PostService.Add");
                throw;
            }
        }

        public bool Update(PostDTO dto)
        {
            try
            {
                var entity = _postRepository.GetAll().FirstOrDefault(p => p.post_id == dto.Id);
                if (entity == null) return false;

                entity.title = dto.Title;
                entity.slug = dto.Slug ?? dto.Title.ToLower().Replace(" ", "-");
                entity.content = dto.Content;
                entity.summary = dto.Summary;
                entity.image_url = dto.ImageUrl;
                entity.category_id = dto.CategoryId;
                entity.status = dto.Status;

                // publish_date NOT NULL olduğu için mutlaka set edilmeli
                if (dto.PublishDate.HasValue)
                {
                    entity.publish_date = dto.PublishDate.Value;
                }
                else
                {
                    // Eğer tarih verilmemişse mevcut tarihi koru veya şimdiki zamanı kullan
                    if (entity.publish_date == default(DateTime))
                        entity.publish_date = DateTime.Now;
                }

                entity.updated_date = DateTime.Now;

                _postRepository.Update(entity);
                return true;
            }
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "PostService.Update");
                throw;
            }
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
            catch (Exception ex)
            {
                AppLogger.LogError(ex, "PostService.Delete");
                throw;
            }
        }

        // --- MAPPING METOTLARI ---

        private List<PostDTO> MapEntitiesToDTOs(IEnumerable<Data.DataModel.post> entities)
        {
            return entities.Select(MapEntityToDTO).ToList();
        }

        private PostDTO MapEntityToDTO(Data.DataModel.post entity)
        {
            string categoryName = "";
            string authorFullName = "";

            // Kategori adını getir
            if (entity.category_id > 0)
            {
                var categoryEntity = _categoryRepository.Get(entity.category_id);
                categoryName = categoryEntity?.category_name ?? "";
            }

            // Yazar adını getir
            if (entity.user_id > 0)
            {
                var userEntity = _userRepository.Get(entity.user_id);
                authorFullName = userEntity?.full_name ?? "";
            }

            return new PostDTO
            {
                Id = entity.post_id,
                Title = entity.title,
                Slug = entity.slug,
                Content = entity.content,
                Summary = entity.summary,
                ImageUrl = entity.image_url,

                // Nullable değerler için varsayılan değerler
                ViewCount = entity.view_count ?? 0,
                ReadingTime = entity.reading_time ?? 0,
                CategoryId = entity.category_id,
                UserId = entity.user_id,

                PublishDate = entity.publish_date,
                Status = entity.status,

                CategoryName = categoryName,
                AuthorFullName = authorFullName
            };
        }
    }
}
