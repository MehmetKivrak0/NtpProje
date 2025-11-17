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
        // TODO: Repository ve Constructor eklenecek.
        private readonly PostRepository _postRepository;

        public PostService()
        {
            _postRepository = new PostRepository();
        }

        // Blog Sayfasý Ýçin Özel Metot
        public List<PostDTO> GetPublishedPosts()
        {
            try
            {
                // 1. Repository'den yayýnlanmýþ ve aktif olan postlarý çek
                // Entity adý 'post' olarak varsayýlmýþtýr.
                var entities = _postRepository.GetAll(p => p.status == "Published") // is_active kontrolü kaldýrýldý
                                      .OrderByDescending(p => p.publish_date);

                // 2. Entity listesini DTO listesine dönüþtür ve döndür
                return MapEntitiesToDTOs(entities);
            }
            catch (Exception)
            {
                // Geliþtirme/Test aþamasý için hatayý görme
                // System.Diagnostics.Debug.WriteLine("PostService HATA: " + ex.ToString());

                // Hata oluþtuðunda boþ bir liste döndürerek programýn çökmesini engelle
                return new List<PostDTO>();
            }

        }
        private List<PostDTO> MapEntitiesToDTOs(IEnumerable<Data.DataModel.post> entities)
        {
            // MapEntityToDTO metodunun da tanýmlý olmasý gerekir.
            return entities.Select(MapEntityToDTO).ToList();
        }

        // DTO'ya Tekil Dönüþüm Metodu (MapEntitiesToDTOs içinde kullanýldýðý için bu da gerekli)
        private PostDTO MapEntityToDTO(Data.DataModel.post entity)
        {
            // Bu metodun içeriði, PostService tam kodunda verilmiþtir.
            // DTO alanlarýný Entity alanlarýna eþleyen dönüþüm mantýðýný buraya yerleþtirin.
            throw new NotImplementedException(); // Ya da gerçek dönüþüm mantýðýný doldurun
        }

    }
}

