using NtpProje.Business.Abstract;
using NtpProje.Data.Concrete;
using NtpProje.Entities.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using NtpProje.Data.DataModel;

namespace NtpProje.Business.Concrete
{
    public class PostService : IBaseService<PostDTO>
    {
        private readonly Repository<post> _postRepository;
        private readonly Repository<category> _categoryRepository;
        private readonly Repository<user> _userRepository;

        public PostService()
        {
            _postRepository = new Repository<post>();
            _categoryRepository = new Repository<category>();
            _userRepository = new Repository<user>();
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
            try
            {
                System.Diagnostics.Debug.WriteLine("===== PostService.GetAll() BAŞLADI =====");
                
                var entities = _postRepository.GetAll();
                System.Diagnostics.Debug.WriteLine($"===== Repository'den dönen: {(entities == null ? "NULL" : entities.Count + " kayıt")} =====");
                
                if (entities != null && entities.Count > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"===== İlk kayıt - ID: {entities[0].post_id}, Title: {entities[0].title} =====");
                }
                
                var dtos = MapEntitiesToDTOs(entities);
                System.Diagnostics.Debug.WriteLine($"===== DTO'ya çevrildi: {(dtos == null ? "NULL" : dtos.Count + " kayıt")} =====");
                
                return dtos;
            }
            catch
            {
                System.Diagnostics.Debug.WriteLine("===== PostService.GetAll() HATA =====");
                return new List<PostDTO>(); // Boş liste döndür hata durumunda
            }
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
            catch
            {
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
            catch
            {
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
            catch
            {
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
            try
            {
                System.Diagnostics.Debug.WriteLine($"===== MapEntityToDTO başladı - Post ID: {entity.post_id} =====");
                
                string categoryName = "";
                string authorFullName = "";

                // Kategori adını getir
                if (entity.category_id > 0)
                {
                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"===== Category_id: {entity.category_id} getiriliyor =====");
                        var categoryEntity = _categoryRepository.Get(entity.category_id);
                        categoryName = categoryEntity?.category_name ?? "";
                        System.Diagnostics.Debug.WriteLine($"===== Category Name: {categoryName} =====");
                    }
                    catch
                    {
                        System.Diagnostics.Debug.WriteLine("===== Category getirme HATASI =====");
                        categoryName = "Bilinmiyor";
                    }
                }

                // Yazar adını getir
                if (entity.user_id > 0)
                {
                    try
                    {
                        System.Diagnostics.Debug.WriteLine($"===== User_id: {entity.user_id} getiriliyor =====");
                        var userEntity = _userRepository.Get(entity.user_id);
                        authorFullName = userEntity?.full_name ?? "";
                        System.Diagnostics.Debug.WriteLine($"===== Author Name: {authorFullName} =====");
                    }
                    catch
                    {
                        System.Diagnostics.Debug.WriteLine("===== User getirme HATASI =====");
                        authorFullName = "Bilinmiyor";
                    }
                }

                var dto = new PostDTO
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
                
                System.Diagnostics.Debug.WriteLine($"===== DTO oluşturuldu - ID: {dto.Id}, Title: {dto.Title} =====");
                return dto;
            }
            catch
            {
                System.Diagnostics.Debug.WriteLine("===== MapEntityToDTO HATASI =====");
                throw;
            }
        }
    }
}
