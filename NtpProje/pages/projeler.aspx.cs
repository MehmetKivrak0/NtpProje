using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete; // Servis için
using NtpProje.Entities.DTOs; // DTO için

namespace NtpProje_Web
{
    public partial class Projeler : System.Web.UI.Page
    {
        // -------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer hatasını önlemek için)
        // -------------------------------------------------------
        protected global::System.Web.UI.WebControls.Repeater rptProjeler;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyProject; // HTML'e eklediğimiz placeholder

        // Servisi çağırıyoruz
        private readonly IBaseService<ProjectDTO> _projectService = new ProjectService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjeler();
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

        // Resim URL'sini düzenle (sadece dosya adıysa /images/ prefix'i ekle)
        protected string GetImageUrl(object imageUrl)
        {
            if (imageUrl == null || string.IsNullOrEmpty(imageUrl.ToString()))
                return ResolveUrl("~/images/default-project.jpg");

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