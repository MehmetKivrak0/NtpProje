using NtpProje.DataAccess; // ProjeContext'i kullanmak için
using NtpProje.Entities;   // User, Post, Category sınıflarını kullanmak için
using System;
using System.Collections.Generic;
using System.Data.Entity; // .Include() metodunu kullanabilmek için
using System.Linq;
namespace NtpProje.Business
{
    public class PostManager
    {
        public bool DeletePost(int postId)
        {
            try
            {
                using (var context = new ProjeContext())
                {
                    var postToDelete = context.Posts.Find(postId);

                    if (postToDelete == null)
                    {
                        return false; // Silinecek yazı bulunamadı
                    }

                    context.Posts.Remove(postToDelete);
                    context.SaveChanges();
                }
                return true; // Başarılı
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("DeletePost Hatası: " + ex.ToString());
                return false; // Başarısız
            }
        }

        // --- DASHBOARD İÇİN YAZILARI LİSTELEME METODU ---
        public List<object> GetPostsForDashboard()
        {
            try
            {
                using (var context = new ProjeContext())
                {
                    var posts = context.Posts
                                  .Include(p => p.Author)   // Yazar (User) tablosunu bağla
                                  .Include(p => p.Category) // Kategori tablosunu bağla
                                  .Select(p => new // Repeater'a uygun yeni bir nesne oluştur
                                  {
                                      PostId = p.PostId,
                                      Title = p.Title,
                                      AuthorName = p.Author.FullName, // Yazarın Adı
                                      CategoryName = p.Category.CategoryName, // Kategorinin Adı
                                      PublishDate = p.PublishDate,
                                      StatusName = (p.Status == "Published") ? "Yayında" : "Taslak",
                                      StatusCssClass = (p.Status == "Published") ? "success" : "warning"
                                  })
                                  .OrderByDescending(p => p.PublishDate) // En yeniler üstte
                                  .Take(5) // Sadece son 5 yazıyı al (opsiyonel)
                                  .ToList<object>(); // Obje listesine çevir

                    return posts;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GetPostsForDashboard Hatası: " + ex.ToString());
                return new List<object>(); // Hata olursa boş liste döndür
            }
        }

        // --- (Gelecekte buraya YaziEkle, YaziGuncelle metotları da eklenecek) ---
    }
}

