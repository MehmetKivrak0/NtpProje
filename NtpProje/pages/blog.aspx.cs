using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete;
using NtpProje.Entities.DTOs;

namespace NtpProje_Web
{
    // Class ismini "Blog" (Büyük Harf) yaptım. Standart olsun.
    public partial class Blog : System.Web.UI.Page
    {
        // -----------------------------------------------------------
        // 1. MANUEL TANIMLAMALAR (Hatayı çözen kısım burası)
        // -----------------------------------------------------------
        protected global::System.Web.UI.WebControls.Repeater rptBlog;
        protected global::System.Web.UI.WebControls.Repeater rptKategoriler; // İçerideki repeater için
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyBlog;

        // Servis Tanımları
        private readonly PostService _postService = new PostService();
        // private readonly CategoryService _categoryService = new CategoryService(); // Gerekirse açarsın

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBlogPosts();
            }
        }

        private void BindBlogPosts()
        {
            try
            {
                // Senin resimdeki metodun aynısı:
                var posts = _postService.GetPublishedPosts();
                // Eğer hata verirse: _postService.GetAll(); dene.

                // Elle tanımladığımız rptBlog artık burada hata vermeyecek
                rptBlog.DataSource = posts;
                rptBlog.DataBind();

                // Veri yoksa mesaj göster
                if (phEmptyBlog != null)
                {
                    phEmptyBlog.Visible = (posts == null || posts.Count == 0);
                    rptBlog.Visible = !(posts == null || posts.Count == 0);
                }
            }
            catch (Exception ex)
            {
                // Hata mesajı (Geliştirme aşamasında açık kalsın)
                Response.Write("Hata: " + ex.ToString());
            }
        }

        // HTML tarafındaki OnItemDataBound="rptBlog_ItemDataBound" için gerekli
        protected void rptBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // PostDTO nesnesini yakala
                var post = e.Item.DataItem as PostDTO;

                // İçerideki "rptKategoriler" repeater'ını bul
                Repeater rptKategoriler = e.Item.FindControl("rptKategoriler") as Repeater;

                // Eğer post ve kategori alanı doluysa
                if (rptKategoriler != null && post != null && !string.IsNullOrEmpty(post.CategoryName))
                {
                    // Kategori adını liste olarak ver (tek kategori olduğu için)
                    var kategoriListesi = new List<string> { post.CategoryName };
                    rptKategoriler.DataSource = kategoriListesi;
                    rptKategoriler.DataBind();
                }
            }
        }

        // Resim URL'sini düzenle (sadece dosya adıysa /images/ prefix'i ekle)
        protected string GetImageUrl(object imageUrl)
        {
            if (imageUrl == null || string.IsNullOrEmpty(imageUrl.ToString()))
                return ResolveUrl("~/images/default-blog.jpg");

            string url = imageUrl.ToString();
            
            // Eğer zaten tam URL ise (http:// veya / ile başlıyorsa) olduğu gibi döndür
            if (url.StartsWith("http://") || url.StartsWith("https://") || url.StartsWith("/"))
            {
                // Eğer /images/ ile başlamıyorsa ve sadece dosya adı gibi görünüyorsa
                if (!url.Contains("/") && !url.StartsWith("http"))
                {
                    return ResolveUrl("~/images/" + url);
                }
                return url;
            }
            
            // Sadece dosya adı ise /images/ prefix'i ekle
            return ResolveUrl("~/images/" + url);
        }
    }
}