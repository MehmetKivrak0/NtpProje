using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _241613001_Mehmet_Kıvrak_NtpProje.pages
{
    public partial class projeler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjeler();
                LoadIstatistikler();
            }
        }

        private void LoadProjeler()
        {
            // TODO: Veritabanından projeleri çek
            // Örnek: DataTable dt = ProjectManager.GetAllProjects();
            // rptProjeler.DataSource = dt;
            // rptProjeler.DataBind();

            // Şimdilik örnek veri ile çalışıyoruz
            var projeler = new List<object>
            {
                new { Id = 1, Baslik = "E-Ticaret Platformu", Kategori = "E-Ticaret", 
                    Aciklama = "Modern ve responsive e-ticaret platformu. Ödeme sistemi entegrasyonu, admin paneli ve gelişmiş stok yönetimi özellikleriyle tam kapsamlı çözüm.",
                    ResimKucuk = "../example/1_s.jpg", Teknolojiler = new[] { "ASP.NET", "React", "SQL" } },
                new { Id = 2, Baslik = "Mobil Bankacılık Uygulaması", Kategori = "Mobil Uygulama",
                    Aciklama = "iOS ve Android platformları için geliştirilmiş güvenli bankacılık uygulaması. Biometric authentication ve end-to-end şifreleme.",
                    ResimKucuk = "../example/2_s.jpg", Teknolojiler = new[] { "React Native", "Node.js" } },
                new { Id = 3, Baslik = "Kurumsal ERP Sistemi", Kategori = "Kurumsal Yazılım",
                    Aciklama = "500+ kullanıcılı entegre ERP sistemi. Finans, İK, stok, üretim modülleriyle tam kapsamlı işletme yönetim çözümü.",
                    ResimKucuk = "../example/3_s.jpg", Teknolojiler = new[] { ".NET Core", "Angular", "PostgreSQL" } },
                new { Id = 4, Baslik = "Kurumsal Web Portalı", Kategori = "Web Geliştirme",
                    Aciklama = "Çok dilli kurumsal web sitesi ve gelişmiş yönetim paneli. SEO optimizasyonu ve analytics entegrasyonu ile profesyonel çözüm.",
                    ResimKucuk = "../example/4_s.jpg", Teknolojiler = new[] { "Vue.js", "Laravel", "MySQL" } }
            };

            rptProjeler.DataSource = projeler;
            rptProjeler.DataBind();
        }

        private void LoadIstatistikler()
        {
            // TODO: Veritabanından istatistikleri çek
            // lblTamamlananProje.Text = ProjectManager.GetCompletedProjectCount() + "+";
            // lblMutluMusteri.Text = CustomerManager.GetHappyCustomerCount() + "+";
            // lblMusteriMemnuniyeti.Text = CustomerManager.GetSatisfactionRate() + "%";
            // lblYilDeneyim.Text = "10+";
        }

        protected void rptProjeler_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var teknolojiler = ((dynamic)e.Item.DataItem).Teknolojiler;
                var rptTeknolojiler = (Repeater)e.Item.FindControl("rptTeknolojiler");
                if (rptTeknolojiler != null && teknolojiler != null)
                {
                    rptTeknolojiler.DataSource = teknolojiler;
                    rptTeknolojiler.DataBind();
                }
            }
        }
    }
}