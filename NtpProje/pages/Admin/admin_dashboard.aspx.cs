using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // Servisler
using NtpProje.Entities.Concrete; // DTO'lar

namespace NtpProje_Web.Admin // DİKKAT: HTML'deki Inherits ile aynı olmalı
{
    public partial class admin_dashboard : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer hatasına karşı)
        // ---------------------------------------------------------
        protected global::System.Web.UI.WebControls.Repeater rptRecentActivities;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyActivities;
        protected global::System.Web.UI.WebControls.Label lblProjectCount;
        protected global::System.Web.UI.WebControls.Label lblUserName;
        protected global::System.Web.UI.WebControls.Label lblUserRole;
        protected global::System.Web.UI.WebControls.Label lblUserInitials;

        // Servisleri Çağırıyoruz
        private readonly PostService _postService = new PostService();
        private readonly CommentService _commentService = new CommentService();
        private readonly ProjectRequestService _projectRequestService = new ProjectRequestService();
        private readonly UserService _userService = new UserService();
        private readonly ProjectService _projectService = new ProjectService();

        // Label tanımlamaları (Designer hatası için)
       
        protected void Page_Load(object sender, EventArgs e)
        {
            // Güvenlik kontrolü (Master Page'de olsa bile burada da durabilir)
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadDashboardStats();
                LoadRecentActivities();
            }
        }

        private void LoadUserInfo()
        {
            try
            {
                // Session'dan kullanıcı bilgilerini al
                var adminUser = Session["AdminUser"] as UserDTO;
                
                if (adminUser != null)
                {
                    // Kullanıcı adı ve soyadı
                    string fullName = adminUser.Full_name ?? "Kullanıcı";
                    if (lblUserName != null)
                        lblUserName.Text = fullName;

                    // Kullanıcı rolü
                    string role = adminUser.Role ?? "Yönetici";
                    if (lblUserRole != null)
                        lblUserRole.Text = role;

                    // Kullanıcı baş harfleri (Avatar için)
                    string initials = GetInitials(fullName);
                    if (lblUserInitials != null)
                        lblUserInitials.Text = initials;
                }
                else
                {
                    // Session'da kullanıcı yoksa varsayılan değerler
                    if (lblUserName != null)
                        lblUserName.Text = "Kullanıcı";
                    if (lblUserRole != null)
                        lblUserRole.Text = "Yönetici";
                    if (lblUserInitials != null)
                        lblUserInitials.Text = "K";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadUserInfo Hata: " + ex.Message);
            }
        }

        private string GetInitials(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName))
                return "K";

            string[] parts = fullName.Trim().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            
            if (parts.Length == 0)
                return "K";
            
            if (parts.Length == 1)
                return parts[0].Substring(0, 1).ToUpper();
            
            // İlk ve son kelimenin baş harfleri
            return (parts[0].Substring(0, 1) + parts[parts.Length - 1].Substring(0, 1)).ToUpper();
        }

        private void LoadDashboardStats()
        {
            try
            {
                // 1. Toplam Blog Yazısı
                // Eğer null dönerse hata vermemesi için ? operatörü kullanıyoruz
                var posts = _postService.GetAll();
                int totalPosts = posts != null ? posts.Count : 0;
                lblTotalPosts.Text = totalPosts.ToString();

                // Proje sayısını da hesapla (pasta grafiği için)
                var projects = _projectService.GetAll();
                int totalProjects = projects != null ? projects.Count : 0;
                if (lblProjectCount != null)
                    lblProjectCount.Text = totalProjects.ToString();

                // 2. Onay Bekleyen Yorumlar
                var comments = _commentService.GetAll();
                // IsApproved alanı false olanları say
                int pendingComments = comments != null ? comments.Count(c => !c.IsApproved) : 0;
                lblNewComments.Text = pendingComments.ToString();

                // 3. Okunmamış Proje Teklifleri
                var requests = _projectRequestService.GetAll();
                // IsRead alanı false olanları say
                int unreadRequests = requests != null ? requests.Count(r => !r.IsRead) : 0;
                lblProjectRequests.Text = unreadRequests.ToString();

                // 4. Toplam Kullanıcı Sayısı
                var users = _userService.GetAll();
                lblTotalUsers.Text = users != null ? users.Count.ToString() : "0";
            }
            catch (Exception ex)
            {
                // Hata olursa "-" yazsın
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
                var recentPosts = _postService.GetAll()
                    .OrderByDescending(p => p.PublishDate ?? DateTime.MinValue)
                    .Take(5)
                    .ToList();

                foreach (var post in recentPosts)
                {
                    activities.Add(new ActivityItem
                    {
                        Icon = "📝",
                        IconColor = "#63207c",
                        Title = "Yeni Blog Yazısı: " + post.Title,
                        Meta = "Kategori: " + (post.CategoryName ?? "Belirtilmemiş"),
                        Date = post.PublishDate?.ToString("dd MMMM yyyy HH:mm") ?? "Tarih belirtilmemiş"
                    });
                }

                // Son eklenen projeler (Son 5) - ID'ye göre sırala (en yeni üstte)
                var recentProjects = _projectService.GetAll()
                    .OrderByDescending(p => p.Id)
                    .Take(5)
                    .ToList();

                foreach (var project in recentProjects)
                {
                    string projectDate = project.CompletionDate.HasValue 
                        ? project.CompletionDate.Value.ToString("dd MMMM yyyy")
                        : "Tarih belirtilmemiş";
                    
                    activities.Add(new ActivityItem
                    {
                        Icon = "💼",
                        IconColor = "#28a745",
                        Title = "Yeni Proje: " + project.Title,
                        Meta = "Kategori: " + (project.Category ?? "Belirtilmemiş") + (string.IsNullOrEmpty(project.ClientName) ? "" : " | Müşteri: " + project.ClientName),
                        Date = projectDate
                    });
                }

                // Tarihe göre sırala (en yeni üstte)
                activities = activities.OrderByDescending(a => a.Date).Take(10).ToList();

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

        // Activity Item için yardımcı sınıf
        public class ActivityItem
        {
            public string Icon { get; set; }
            public string IconColor { get; set; }
            public string Title { get; set; }
            public string Meta { get; set; }
            public string Date { get; set; }
        }
    }
}