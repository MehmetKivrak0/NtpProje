using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Web.UI.WebControls;
using System.Linq;
using System.Collections.Generic;

// Namespace tanımınızın doğru olduğundan emin olun
namespace _241613001_Mehmet_Kıvrak_NtpProje.pages
{
    public partial class blog : System.Web.UI.Page
    {
        private readonly PostService _postService = new PostService();
        private readonly CategoryService _categoryService = new CategoryService(); // Kategori adını göstermek için

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Sayfa ilk yüklendiğinde blog yazılarını getir ve Repeater'a bağla
                BindBlogPosts();
            }
        }

        private void BindBlogPosts()
        {
            try
            {
                // 1. Post Service'i kullanarak yayınlanmış tüm postları al
                List<PostDTO> posts = _postService.GetPublishedPosts();

                // 2. Repeater'a bağla
                rptBlog.DataSource = posts;
                rptBlog.DataBind();
            }
            catch (Exception)
            {
                // Hata mesajını kullanıcıya gösterebilir veya loglayabilirsiniz.
                // Response.Write("Blog yazıları yüklenirken hata oluştu: " + ex.Message);
            }
        }

        // 3. ItemDataBound Olayı (Her öğe veriye bağlandığında çalışır)
        protected void rptBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Yalnızca Item (normal öğe) veya AlternatingItem (bir sonraki öğe) tiplerinde çalışır
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Veriye bağlanan PostDTO nesnesini al
                PostDTO post = e.Item.DataItem as PostDTO;

                if (post != null)
                {
                    // Blog başlığını göstermek için LinkButton kontrolü bul
                    LinkButton lnkTitle = (LinkButton)e.Item.FindControl("lnkTitle");

                    if (lnkTitle != null)
                    {
                        // Başlık ve Yönlendirme
                        lnkTitle.Text = post.title;

                        // blog_detay sayfasına post_id ile yönlendir
                        lnkTitle.PostBackUrl = string.Format("blog_detay.aspx?id={0}&slug={1}", post.post_id, post.slug);
                    }

                    // Kategori adını göstermek için Label/Literal bul
                    Literal litCategory = (Literal)e.Item.FindControl("litCategory");
                    if (litCategory != null && !string.IsNullOrEmpty(post.CategoryName))
                    {
                        litCategory.Text = post.CategoryName;
                    }

                    // Okunma sayısını göstermek için Label/Literal bul
                    Literal litViewCount = (Literal)e.Item.FindControl("litViewCount");
                    if (litViewCount != null)
                    {
                        litViewCount.Text = post.view_count.ToString();
                    }
                }
            }
        }
    }
}