using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

namespace NtpProje_Web
{
    public partial class blog_detay : System.Web.UI.Page
    {
        private readonly PostService _postService = new PostService();
        public PostDTO CurrentPost { get; private set; }
        
        // Repeater ve Panel kontrolleri için manuel tanımlamalar
        protected Repeater rptRelatedPosts;
        protected Panel pnlRelatedPosts;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBlogPost();
            }
        }

        private void LoadBlogPost()
        {
            try
            {
                // URL'den id parametresini al
                string idParam = Request.QueryString["id"];
                if (string.IsNullOrEmpty(idParam) || !int.TryParse(idParam, out int postId))
                {
                    Response.Redirect("blog.aspx");
                    return;
                }

                // Post'u veritabanından getir
                CurrentPost = _postService.GetById(postId);

                if (CurrentPost == null)
                {
                    // Post bulunamadıysa blog listesine yönlendir
                    Response.Redirect("blog.aspx");
                    return;
                }

                // Sayfa başlığını ayarla
                Page.Title = CurrentPost.Title;

                // İlgili yazıları yükle
                LoadRelatedPosts();
            }
            catch (Exception ex)
            {
                // Hata durumunda blog listesine yönlendir
                System.Diagnostics.Debug.WriteLine("Blog Detay Yükleme Hatası: " + ex.Message);
                Response.Redirect("blog.aspx");
            }
        }

        // Resim URL'sini düzenle
        protected string GetImageUrl(object imageUrl)
        {
            if (imageUrl == null || string.IsNullOrEmpty(imageUrl.ToString()))
                return ResolveUrl("~/images/default-blog.jpg");

            string url = imageUrl.ToString();
            
            // Eğer zaten tam URL ise (http:// veya https:// ile başlıyorsa) olduğu gibi döndür
            if (url.StartsWith("http://") || url.StartsWith("https://") || url.StartsWith("/"))
            {
                if (!url.Contains("/") && !url.StartsWith("http"))
                {
                    return ResolveUrl("~/images/" + url);
                }
                return url;
            }
            
            // Sadece dosya adı ise /images/ prefix'i ekle
            return ResolveUrl("~/images/" + url);
        }

        // Okuma süresini hesapla (dakika cinsinden)
        protected string GetReadingTime(int? readingTime)
        {
            if (readingTime.HasValue && readingTime.Value > 0)
            {
                return readingTime.Value + " dk";
            }
            
            // İçerik uzunluğundan tahmin edilmiş okuma süresi
            if (CurrentPost != null && !string.IsNullOrEmpty(CurrentPost.Content))
            {
                int wordCount = CurrentPost.Content.Split(new[] { ' ', '\t', '\n' }, StringSplitOptions.RemoveEmptyEntries).Length;
                int estimatedMinutes = Math.Max(1, wordCount / 200); // Ortalama 200 kelime/dakika
                return estimatedMinutes + " dk";
            }
            
            return "5 dk"; // Varsayılan
        }

        // Kategori listesini al
        protected string GetCategoryList()
        {
            if (CurrentPost == null || string.IsNullOrEmpty(CurrentPost.CategoryName))
                return "Genel";
            
            return CurrentPost.CategoryName;
        }

        // İlgili yazıları yükle ve Repeater'a bağla
        private void LoadRelatedPosts()
        {
            try
            {
                var relatedPosts = GetRelatedPosts();
                
                if (relatedPosts != null && relatedPosts.Count > 0 && rptRelatedPosts != null && pnlRelatedPosts != null)
                {
                    rptRelatedPosts.DataSource = relatedPosts;
                    rptRelatedPosts.DataBind();
                    pnlRelatedPosts.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("İlgili Yazılar Yükleme Hatası: " + ex.Message);
            }
        }

        // İlgili yazıları getir (mevcut post hariç, maksimum 4 tane)
        private List<PostDTO> GetRelatedPosts()
        {
            try
            {
                if (CurrentPost == null)
                    return new List<PostDTO>();

                // Yayınlanmış tüm postları getir
                var allPosts = _postService.GetPublishedPosts();
                
                // Mevcut postu hariç tut ve maksimum 4 tane al
                var relatedPosts = allPosts
                    .Where(p => p.Id != CurrentPost.Id)
                    .OrderByDescending(p => p.PublishDate)
                    .Take(4)
                    .ToList();

                return relatedPosts;
            }
            catch
            {
                return new List<PostDTO>();
            }
        }
    }
}