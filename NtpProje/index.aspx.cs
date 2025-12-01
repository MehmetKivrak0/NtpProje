using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

// DÜZELTME 1: Namespace'i temiz ve doğru olan "NtpProje_Web" yaptık.
namespace NtpProje_Web
{
    // DÜZELTME 2: Class adını HTML'e uyacak şekilde "Index" (Büyük I) yaptık.
    public partial class Index : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // MANUEL TANIMLAMALAR (HTML'deki kontroller)
        // ---------------------------------------------------------
        protected global::System.Web.UI.WebControls.Repeater rptHomeProjects;

        // İstatistik Labelları
        protected global::System.Web.UI.WebControls.Label lblHomeProjectCount;
        protected global::System.Web.UI.WebControls.Label lblHomeHappyClient;
        protected global::System.Web.UI.WebControls.Label lblHomeExperience;
        protected global::System.Web.UI.WebControls.Label lblHomeSatisfaction;

        // Servisleri Çağırıyoruz
        private readonly IBaseService<ServiceDTO> _serviceService = new ServiceService();
        private readonly IBaseService<ProjectDTO> _projectService = new ProjectService();
        private readonly PostService _postService = new PostService(); // GetPublishedPosts() metodu için concrete kalıyor
        private readonly IBaseService<StatisticDTO> _statisticService = new StatisticService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadServices();
                LoadProjects();
                LoadBlog();
                LoadStatistics();
            }
        }

        // 1. HİZMETLERİ GETİR (İlk 4 Tane)
        private void LoadServices()
        {
            try
            {
                var services = _serviceService.GetAll()
                                              .Where(x => x.IsActive) // Sadece aktifler
                                              .OrderBy(x => x.DisplayOrder)
                                              .Take(4)
                                              .ToList();

                if (rptHomeServices != null)
                {
                    rptHomeServices.DataSource = services;
                    rptHomeServices.DataBind();
                }
            }
            catch { }
        }

        // 2. PROJELERİ GETİR (Son 3 Tane)
        private void LoadProjects()
        {
            try
            {
                var projects = _projectService.GetAll()
                                              .OrderByDescending(x => x.Id)
                                              .Take(3)
                                              .ToList();

                if (rptHomeProjects != null)
                {
                    rptHomeProjects.DataSource = projects;
                    rptHomeProjects.DataBind();
                }
            }
            catch { }
        }

        // 3. BLOG YAZILARINI GETİR (Son 3 Tane)
        private void LoadBlog()
        {
            try
            {
                var posts = _postService.GetPublishedPosts()
                                        .Take(3)
                                        .ToList();

                if (rptHomeBlog != null)
                {
                    rptHomeBlog.DataSource = posts;
                    rptHomeBlog.DataBind();
                }
            }
            catch { }
        }

        // 4. İSTATİSTİKLERİ GETİR
        private void LoadStatistics()
        {
            try
            {
                var stats = _statisticService.GetAll();
                if (stats != null && stats.Count > 0)
                {
                    // Anahtarlara göre eşleştirme (Veritabanından çekilen Key'leri kullanır)
                    if (lblHomeProjectCount != null)
                        lblHomeProjectCount.Text = stats.FirstOrDefault(s => s.Key == "project_count")?.Value ?? "0";

                    if (lblHomeHappyClient != null)
                        lblHomeHappyClient.Text = stats.FirstOrDefault(s => s.Key == "happy_clients")?.Value ?? "0";

                    if (lblHomeSatisfaction != null)
                        lblHomeSatisfaction.Text = stats.FirstOrDefault(s => s.Key == "satisfaction_rate")?.Value ?? "0";

                    if (lblHomeExperience != null)
                        lblHomeExperience.Text = stats.FirstOrDefault(s => s.Key == "years_experience")?.Value ?? "0";
                }
            }
            catch { }
        }

        /// <summary>
        /// Resim URL'sini düzgün şekilde çözümler.
        /// Eğer sadece dosya adı ise (~/images/) ekler, zaten tam URL ise olduğu gibi döner.
        /// </summary>
        protected string GetImageUrl(object imageUrl)
        {
            if (imageUrl == null || string.IsNullOrWhiteSpace(imageUrl.ToString()))
                return ResolveUrl("~/images/no-image.jpg"); // Varsayılan resim

            string url = imageUrl.ToString().Trim();

            // Zaten tam URL ise (http:// veya https:// ile başlıyorsa) olduğu gibi döndür
            if (url.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ||
                url.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                return url;
            }

            // Sadece dosya adı ise (~/images/) ekle
            // Örn: "post-gorseli.jpg" -> "~/images/post-gorseli.jpg"
            if (!url.Contains("/") && !url.Contains("\\"))
            {
                return ResolveUrl("~/images/" + url);
            }

            // Göreceli yol ise (~/ ile başlıyorsa) ResolveUrl ile çözümle
            if (url.StartsWith("~/"))
            {
                return ResolveUrl(url);
            }

            // Diğer durumlarda olduğu gibi döndür
            return url;
        }
    }
}