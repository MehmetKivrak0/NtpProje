using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // Servisler
using NtpProje.Entities.Concrete; // DTO'lar

namespace NtpProje_Web.Admin
{
    public partial class admin_dashboard : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer hatasına karşı)
        // ---------------------------------------------------------
        protected global::System.Web.UI.WebControls.Label lblTotalPosts;
        protected global::System.Web.UI.WebControls.Label lblNewComments;
        protected global::System.Web.UI.WebControls.Label lblProjectRequests;
        protected global::System.Web.UI.WebControls.Label lblTotalUsers;
        protected global::System.Web.UI.WebControls.Label lblProjectCount;

        // Aktivite Listesi ve Kullanıcı Bilgileri (Varsa HTML'de kullanılanlar)
        protected global::System.Web.UI.WebControls.Repeater rptRecentActivities;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyActivities;
        protected global::System.Web.UI.WebControls.HiddenField hfChartData;

        // Servisleri Çağırıyoruz
        private readonly PostService _postService = new PostService();
        private readonly CommentService _commentService = new CommentService();
        private readonly ProjectRequestService _projectRequestService = new ProjectRequestService();
        private readonly UserService _userService = new UserService();
        private readonly ProjectService _projectService = new ProjectService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Güvenlik kontrolü
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardStats();
                LoadRecentActivities();
                LoadChartData();
            }
        }

        private void LoadDashboardStats()
        {
            try
            {
                // 1. Toplam Blog Yazısı
                var posts = _postService.GetAll();
                lblTotalPosts.Text = posts != null ? posts.Count.ToString() : "0";

                // 2. Onay Bekleyen Yorumlar
                var comments = _commentService.GetAll();
                int pendingComments = comments != null ? comments.Count(c => !c.IsApproved) : 0;
                lblNewComments.Text = pendingComments.ToString();

                // 3. Okunmamış Proje Teklifleri
                var requests = _projectRequestService.GetAll();
                int unreadRequests = requests != null ? requests.Count(r => !r.IsRead) : 0;
                lblProjectRequests.Text = unreadRequests.ToString();

                // 4. Toplam Kullanıcı Sayısı
                var users = _userService.GetAll();
                lblTotalUsers.Text = users != null ? users.Count.ToString() : "0";

                // 5. Toplam Proje Sayısı (Grafik için)
                var projects = _projectService.GetAll();
                int projectCount = projects != null ? projects.Count : 0;
                lblProjectCount.Text = projectCount.ToString();
            }
            catch (Exception ex)
            {
                lblTotalPosts.Text = "-";
                lblNewComments.Text = "-";
                lblProjectRequests.Text = "-";
                lblTotalUsers.Text = "-";
                System.Diagnostics.Debug.WriteLine("Dashboard Hata: " + ex.Message);
            }
        }

        private void LoadRecentActivities()
        {
            try
            {
                var activities = new List<ActivityItem>();

                // Son eklenen blog yazıları (Son 5)
                var recentPosts = _postService.GetAll();
                if (recentPosts != null)
                {
                    foreach (var post in recentPosts.OrderByDescending(p => p.PublishDate ?? DateTime.MinValue).Take(5))
                    {
                        activities.Add(new ActivityItem
                        {
                            Icon = "📝",
                            IconColor = "#63207c",
                            Title = "Yeni Blog Yazısı: " + post.Title,
                            Meta = "Kategori: " + (post.CategoryName ?? "Belirtilmemiş"),
                            Date = post.PublishDate?.ToString("dd MMMM yyyy HH:mm") ?? "Tarih yok",
                            SortDate = post.PublishDate ?? DateTime.MinValue
                        });
                    }
                }

                // Son eklenen projeler (Son 5)
                var recentProjects = _projectService.GetAll();
                if (recentProjects != null)
                {
                    foreach (var project in recentProjects.OrderByDescending(p => p.Id).Take(5))
                    {
                        activities.Add(new ActivityItem
                        {
                            Icon = "💼",
                            IconColor = "#28a745",
                            Title = "Yeni Proje: " + project.Title,
                            Meta = "Müşteri: " + (project.ClientName ?? "Belirtilmemiş"),
                            Date = project.CompletionDate.HasValue ? project.CompletionDate.Value.ToString("dd MMMM yyyy") : "Tarih yok",
                            SortDate = project.CompletionDate ?? DateTime.MinValue
                        });
                    }
                }

                // Tarihe göre sırala (en yeni üstte) ve son 10 taneyi al
                activities = activities.OrderByDescending(a => a.SortDate).Take(10).ToList();

                if (rptRecentActivities != null)
                {
                    rptRecentActivities.DataSource = activities;
                    rptRecentActivities.DataBind();
                }

                if (phEmptyActivities != null)
                {
                    phEmptyActivities.Visible = (activities == null || activities.Count == 0);
                    if (rptRecentActivities != null)
                        rptRecentActivities.Visible = !(activities == null || activities.Count == 0);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Recent Activities Hata: " + ex.Message);
            }
        }

        private void LoadChartData()
        {
            try
            {
                // Blog ve Proje sayılarını al
                var posts = _postService.GetAll();
                var projects = _projectService.GetAll();
                
                int blogCount = posts != null ? posts.Count : 0;
                int projectCount = projects != null ? projects.Count : 0;

                // JSON formatında veri hazırla (basit string interpolation)
                if (hfChartData != null)
                {
                    hfChartData.Value = string.Format("{{\"blogCount\":{0},\"projectCount\":{1}}}", blogCount, projectCount);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Chart Data Hata: " + ex.Message);
                if (hfChartData != null)
                {
                    hfChartData.Value = "{\"blogCount\":0,\"projectCount\":0}";
                }
            }
        }
    }

    // --- DÜZELTME: Sınıfı dışarı çıkardık ---
    public class ActivityItem
    {
        public string Icon { get; set; }
        public string IconColor { get; set; }
        public string Title { get; set; }
        public string Meta { get; set; }
        public string Date { get; set; }
        public DateTime SortDate { get; set; } // Sıralama için eklendi
    }
}