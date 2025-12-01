using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
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
        protected global::System.Web.UI.WebControls.Label lblTeamMemberCount;
        protected global::System.Web.UI.WebControls.Label lblContactMessageCount;

        // Aktivite Listesi ve Kullanıcı Bilgileri (Varsa HTML'de kullanılanlar)
        protected global::System.Web.UI.WebControls.Repeater rptRecentActivities;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyActivities;
        protected global::System.Web.UI.WebControls.HiddenField hfChartData;
        protected global::System.Web.UI.WebControls.Button btnExportCSV;

        // Servisleri Çağırıyoruz
        private readonly PostService _postService = new PostService(); // GetPublishedPosts() metodu için concrete kalıyor
        private readonly IBaseService<CommentDTO> _commentService = new CommentService();
        private readonly IBaseService<ProjectRequestDTO> _projectRequestService = new ProjectRequestService();
        private readonly UserService _userService = new UserService(); // Login/Register metodları için concrete kalıyor
        private readonly IBaseService<ProjectDTO> _projectService = new ProjectService();
        private readonly IBaseService<TeamMemberDTO> _teamMemberService = new TeamMemberService();
        private readonly IBaseService<ContactMessageDTO> _contactMessageService = new ContactMessageService();

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

                // 6. Toplam Uzman Ekip Sayısı (Grafik için)
                var teamMembers = _teamMemberService.GetAll();
                int teamMemberCount = teamMembers != null ? teamMembers.Count : 0;
                lblTeamMemberCount.Text = teamMemberCount.ToString();

                // 7. Toplam İletişim Mesajı Sayısı (Grafik için)
                var contactMessages = _contactMessageService.GetAll();
                int contactMessageCount = contactMessages != null ? contactMessages.Count : 0;
                lblContactMessageCount.Text = contactMessageCount.ToString();
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
                var teamMembers = _teamMemberService.GetAll();
                var contactMessages = _contactMessageService.GetAll();
                
                int blogCount = posts != null ? posts.Count : 0;
                int projectCount = projects != null ? projects.Count : 0;
                int teamMemberCount = teamMembers != null ? teamMembers.Count : 0;
                int contactMessageCount = contactMessages != null ? contactMessages.Count : 0;

                // JSON formatında veri hazırla (basit string interpolation)
                if (hfChartData != null)
                {
                    hfChartData.Value = string.Format("{{\"blogCount\":{0},\"projectCount\":{1},\"teamMemberCount\":{2},\"contactMessageCount\":{3}}}", 
                        blogCount, projectCount, teamMemberCount, contactMessageCount);
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

        // CSV Export Metodu
        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            try
            {
                // Aktiviteleri yükle
                var activities = GetRecentActivitiesForExport();

                // CSV içeriğini oluştur
                var csvContent = new System.Text.StringBuilder();
                
                // BOM (Byte Order Mark) ekle - Türkçe karakterler için
                csvContent.Append("\uFEFF");
                
                // CSV Başlık satırı
                csvContent.AppendLine("Tip,Başlık,Detay,Tarih");

                // CSV Veri satırları
                foreach (var activity in activities)
                {
                    // CSV formatında özel karakterleri temizle ve tırnak içine al
                    string tip = EscapeCsvField(activity.Icon + " " + GetActivityType(activity.Icon));
                    string baslik = EscapeCsvField(activity.Title);
                    string detay = EscapeCsvField(activity.Meta);
                    string tarih = EscapeCsvField(activity.Date);

                    csvContent.AppendLine($"{tip},{baslik},{detay},{tarih}");
                }

                // Response ayarları
                Response.Clear();
                Response.Buffer = true;
                Response.ContentType = "text/csv; charset=utf-8";
                Response.ContentEncoding = System.Text.Encoding.UTF8;
                
                // Dosya adı (tarih ile)
                string fileName = $"Son_Aktiviteler_{DateTime.Now:yyyyMMdd_HHmmss}.csv";
                Response.AddHeader("Content-Disposition", $"attachment; filename=\"{fileName}\"");

                // CSV içeriğini gönder
                Response.Write(csvContent.ToString());
                Response.End();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("CSV Export Hata: " + ex.Message);
                Response.Write("CSV export sırasında bir hata oluştu: " + ex.Message);
            }
        }

        // Aktiviteleri export için hazırla
        private List<ActivityItem> GetRecentActivitiesForExport()
        {
            var activities = new List<ActivityItem>();

            // Son eklenen blog yazıları
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

            // Son eklenen projeler
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
            return activities.OrderByDescending(a => a.SortDate).Take(10).ToList();
        }

        // CSV alanlarını escape et (virgül, tırnak, yeni satır karakterlerini temizle)
        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return "";

            // Virgül, tırnak veya yeni satır içeriyorsa tırnak içine al ve içindeki tırnakları çift tırnak yap
            if (field.Contains(",") || field.Contains("\"") || field.Contains("\n") || field.Contains("\r"))
            {
                return "\"" + field.Replace("\"", "\"\"") + "\"";
            }

            return field;
        }

        // Aktivite tipini belirle
        private string GetActivityType(string icon)
        {
            switch (icon)
            {
                case "📝":
                    return "Blog Yazısı";
                case "💼":
                    return "Proje";
                default:
                    return "Diğer";
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