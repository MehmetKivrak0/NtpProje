using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // Servis
using NtpProje.Entities.Concrete; // DTO

namespace NtpProje_Web
{
    public partial class ProjeDetay : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer dosyası sorunu için)
        // ---------------------------------------------------------
       

        // Servis Bağlantısı
        private readonly ProjectService _projectService = new ProjectService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // URL'den ID'yi al (örn: proje_detay.aspx?id=5)
                string idStr = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int id))
                {
                    LoadProjectDetails(id);
                }
                else
                {
                    // ID yoksa veya geçersizse "Bulunamadı" göster
                    ShowNotFound();
                }
            }
        }

        private void LoadProjectDetails(int id)
        {
            try
            {
                // 1. Servisten projeyi çek
                ProjectDTO proje = _projectService.GetById(id);

                if (proje != null)
                {
                    // Proje bulunduysa İçeriği Aç, Hatayı Gizle
                    pnlContent.Visible = true;
                    pnlNotFound.Visible = false;

                    // 2. Verileri Kontrollere Ata
                    lblBaslik.Text = proje.Title;
                    lblKategori.Text = proje.Category;
                    lblMusteri.Text = string.IsNullOrEmpty(proje.ClientName) ? "Gizli" : proje.ClientName;

                    // Tarih Formatlama (Gün Ay Yıl)
                    lblTarih.Text = proje.CompletionDate.HasValue
                        ? proje.CompletionDate.Value.ToString("dd MMMM yyyy")
                        : "Devam Ediyor";

                    // Görüntülenme Sayısı
                    lblGoruntulenme.Text = proje.ViewCount.ToString();

                    // Resim ve Açıklama
                    imgProje.ImageUrl = proje.ImageUrl;
                    imgProje.AlternateText = proje.Title;
                    ltrAciklama.Text = proje.Description; // HTML içerik olabilir

                    // 3. Teknolojileri Listele (Virgülle ayrılmış string -> Liste)
                    if (!string.IsNullOrEmpty(proje.Technologies))
                    {
                        var techList = proje.Technologies
                            .Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                            .Select(t => t.Trim())
                            .ToList();

                        rptTeknolojiler.DataSource = techList;
                        rptTeknolojiler.DataBind();
                    }
                }
                else
                {
                    // Veritabanında bu ID ile proje yoksa
                    ShowNotFound();
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda (Geliştirme aşamasında ekrana bas)
                Response.Write("Hata: " + ex.Message);
            }
        }

        private void ShowNotFound()
        {
            pnlContent.Visible = false;
            pnlNotFound.Visible = true;
        }
    }
}