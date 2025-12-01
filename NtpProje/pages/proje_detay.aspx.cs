using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
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
        private readonly IBaseService<ProjectDTO> _projectService = new ProjectService();

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
                    imgProje.ImageUrl = GetImageUrl(proje.ImageUrl);
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