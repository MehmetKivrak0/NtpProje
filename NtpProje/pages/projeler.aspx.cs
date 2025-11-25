using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // Servis için
using NtpProje.Entities.Concrete; // DTO için

namespace NtpProje_Web
{
    public partial class Projeler : System.Web.UI.Page
    {
        // -------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer hatasını önlemek için)
        // -------------------------------------------------------
        protected global::System.Web.UI.WebControls.Repeater rptProjeler;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyProject; // HTML'e eklediğimiz placeholder

        // İstatistik Labelları
        protected global::System.Web.UI.WebControls.Label lblTamamlananProje;
        protected global::System.Web.UI.WebControls.Label lblMutluMusteri;
        protected global::System.Web.UI.WebControls.Label lblMusteriMemnuniyeti;
        protected global::System.Web.UI.WebControls.Label lblYilDeneyim;

        // Servisi çağırıyoruz
        private readonly ProjectService _projectService = new ProjectService();
        private readonly StatisticService _statisticService = new StatisticService();

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
            try
            {
                // 1. Servisten veritabanındaki projeleri çek
                List<ProjectDTO> projeler = _projectService.GetAll();

                // 2. Veriyi Repeater'a bağla
                rptProjeler.DataSource = projeler;
                rptProjeler.DataBind();

                // 3. Eğer veri yoksa "Bulunamadı" mesajını göster
                // (HTML tarafında phEmptyProject eklediysen çalışır)
                if (phEmptyProject != null)
                {
                    bool veriVar = (projeler != null && projeler.Count > 0);
                    phEmptyProject.Visible = !veriVar;
                    rptProjeler.Visible = veriVar;
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda (Geliştirme aşamasında görmek için)
                Response.Write("Hata: " + ex.Message);
            }
        }

        private void LoadIstatistikler()
        {
            // 1. ADIM: Önce hepsini varsayılan olarak "0" yapalım.
            // Böylece veritabanında veri yoksa ekranda sahte "150+" yazısı kalmaz.
            if (lblTamamlananProje != null) lblTamamlananProje.Text = "0";
            if (lblMutluMusteri != null) lblMutluMusteri.Text = "0";
            if (lblMusteriMemnuniyeti != null) lblMusteriMemnuniyeti.Text = "%0";
            if (lblYilDeneyim != null) lblYilDeneyim.Text = "0";

            try
            {
                // 2. ADIM: Veritabanından verileri çekmeye çalış
                var stats = _statisticService.GetAll();

                if (stats != null && stats.Count > 0)
                {
                    // Veri varsa üzerine yaz (Yoksa yukarıdaki "0"lar kalır)

                    var stat1 = stats.FirstOrDefault(s => s.Key == "project_count");
                    if (stat1 != null && lblTamamlananProje != null) lblTamamlananProje.Text = stat1.Value;

                    var stat2 = stats.FirstOrDefault(s => s.Key == "happy_clients");
                    if (stat2 != null && lblMutluMusteri != null) lblMutluMusteri.Text = stat2.Value;

                    var stat3 = stats.FirstOrDefault(s => s.Key == "satisfaction_rate");
                    if (stat3 != null && lblMusteriMemnuniyeti != null) lblMusteriMemnuniyeti.Text = stat3.Value;

                    var stat4 = stats.FirstOrDefault(s => s.Key == "years_experience");
                    if (stat4 != null && lblYilDeneyim != null) lblYilDeneyim.Text = stat4.Value;
                }
            }
            catch
            {
                // Hata olursa hiçbir şey yapma, ekranda "0" görünmeye devam etsin.
            }
        }

        protected void rptProjeler_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // DTO nesnesini yakala
                var proje = e.Item.DataItem as ProjectDTO;

                // İçerideki "rptTeknolojiler" repeater'ını bul
                Repeater rptTeknolojiler = e.Item.FindControl("rptTeknolojiler") as Repeater;

                // Eğer proje ve teknolojiler alanı doluysa
                if (rptTeknolojiler != null && proje != null && !string.IsNullOrEmpty(proje.Technologies))
                {
                    // Veritabanındaki string'i (Örn: "C#,React,SQL") virgülden bölüp listeye çevir
                    var teknolojiListesi = proje.Technologies
                        .Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                        .Select(t => t.Trim()) // Başındaki sonundaki boşlukları sil
                        .ToList();

                    rptTeknolojiler.DataSource = teknolojiListesi;
                    rptTeknolojiler.DataBind();
                }
            }
        }
    }
}