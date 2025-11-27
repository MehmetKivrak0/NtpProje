using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // Business Katmanı
using NtpProje.Entities.Concrete; // Entities Katmanı

namespace NtpProje_Web.Admin // Namespace: Projenizdekiyle aynı olmalı
{
    public partial class YaziYonetimi : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer Hatasına Karşı)
        // ---------------------------------------------------------
       

        // Servisleri Çağırıyoruz
        private readonly PostService _postService = new PostService();
        private readonly ProjectService _projectService = new ProjectService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // GÜVENLİK KONTROLÜ (Master Page'de olsa bile burada da durabilir)
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            LoadPosts();
            LoadProjects();
        }

        private void LoadPosts()
        {
            try
            {
                // PostService'den verileri çekiyoruz
                var posts = _postService.GetAll();

                // Tarihe göre sıralama (Varsa)
                if (posts != null && posts.Count > 0)
                {
                    posts = posts.OrderByDescending(p => p.PublishDate).ToList();
                }

                if (rptPosts != null)
                {
                    rptPosts.DataSource = posts;
                    rptPosts.DataBind();
                }

                string totalPostCount = posts != null ? posts.Count.ToString() : "0";

                if (ltrTotalPosts != null)
                {
                    ltrTotalPosts.Text = totalPostCount;
                }

                if (ltrTotalPostsSidebar != null)
                {
                    ltrTotalPostsSidebar.Text = totalPostCount;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("POST YÜKLEME HATASI: " + ex.Message);
            }
        }

        private void LoadProjects()
        {
            try
            {
                // ProjectService'den verileri çekiyoruz
                var projects = _projectService.GetAll();

                // ID'ye göre sıralama (En son eklenen en üstte)
                if (projects != null && projects.Count > 0)
                {
                    projects = projects.OrderByDescending(p => p.Id).ToList();
                }

                if (rptProjects != null)
                {
                    rptProjects.DataSource = projects;
                    rptProjects.DataBind();
                }

                string totalProjectCount = projects != null ? projects.Count.ToString() : "0";

                if (ltrTotalProjects != null)
                {
                    ltrTotalProjects.Text = totalProjectCount;
                }

                if (ltrTotalProjectsSidebar != null)
                {
                    ltrTotalProjectsSidebar.Text = totalProjectCount;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("PROJE YÜKLEME HATASI: " + ex.Message);
            }
        }

        // ---------------------------------------------------------
        // ACTION COMMAND (Silme İşlemi İçin)
        // ---------------------------------------------------------
        protected void ActionCommand(object sender, RepeaterCommandEventArgs e)
        {
            // ID'yi al
            if (!int.TryParse(e.CommandArgument.ToString(), out int id))
            {
                return;
            }
            string commandName = e.CommandName;

            try
            {
                if (commandName == "DeletePost")
                {
                    _postService.Delete(id);
                }
                else if (commandName == "DeleteProject")
                {
                    _projectService.Delete(id);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("SİLME HATASI: " + ex.Message);
            }

            // İşlemden sonra listeyi yenile
            LoadData();
        }
    }
}