using System;
using System.Web.UI;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete; // Servisler
using NtpProje.Entities.DTOs; // DTO'lar

namespace NtpProje_Web
{
    public partial class Iletisim : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // MANUEL TANIMLAMALAR (Designer hatasına karşı)
        // ---------------------------------------------------------
        protected global::System.Web.UI.WebControls.Panel pnlHaritaWrapper;

        // ---------------------------------------------------------
        // SERVİSLERİ ÇAĞIRIYORUZ
        // ---------------------------------------------------------
        private readonly SettingService _settingService = new SettingService(); // SettingService kontrol edilmeli
        private readonly IBaseService<ContactMessageDTO> _contactService = new ContactMessageService();
        private readonly IBaseService<ProjectRequestDTO> _projectService = new ProjectRequestService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Sayfa ilk açıldığında veritabanından bilgileri çek
                AyarlariGetir();
            }
        }

        // ---------------------------------------------------------
        // 3. AYARLARI GETİRME (Settings Tablosundan)
        // ---------------------------------------------------------
        private void AyarlariGetir()
        {
            try
            {
                // Veritabanından verileri çekip Literal'lere yazıyoruz.
                // (litAdres vb. kontrolleri Designer dosyasından otomatik tanır)

                litAdres.Text = _settingService.GetValueByKey("site_address") ?? "Adres bilgisi girilmedi.";
                litTelefon.Text = _settingService.GetValueByKey("site_phone") ?? "Telefon bilgisi girilmedi.";
                litEmail.Text = _settingService.GetValueByKey("site_email") ?? "E-posta bilgisi girilmedi.";
                litSaatler.Text = _settingService.GetValueByKey("site_working_hours") ?? "Çalışma saatleri girilmedi.";

                // Harita Linki
                string mapLink = _settingService.GetValueByKey("site_map_embed");
                
                // Debug: Harita linkini kontrol et
                System.Diagnostics.Debug.WriteLine("=== HARITA LINKI KONTROL ===");
                System.Diagnostics.Debug.WriteLine("DB'den gelen link: " + (mapLink ?? "NULL/BOŞ"));
                System.Diagnostics.Debug.WriteLine("Link uzunluğu: " + (mapLink?.Length ?? 0));

                if (!string.IsNullOrEmpty(mapLink) && !string.IsNullOrWhiteSpace(mapLink))
                {
                    string haritaUrl = mapLink.Trim();
                    
                    // Eğer iframe kodu içeriyorsa, sadece src URL'sini çıkar
                    if (haritaUrl.Contains("src="))
                    {
                        // src="..." formatını bul
                        int srcPos = haritaUrl.IndexOf("src=\"");
                        if (srcPos < 0) srcPos = haritaUrl.IndexOf("src='");
                        
                        if (srcPos >= 0)
                        {
                            // Tırnak işaretinden sonrasını al
                            int startQuote = haritaUrl.IndexOf("\"", srcPos);
                            if (startQuote < 0) startQuote = haritaUrl.IndexOf("'", srcPos);
                            
                            if (startQuote >= 0)
                            {
                                startQuote += 1; // Tırnak işaretini atla
                                int endQuote = haritaUrl.IndexOf("\"", startQuote);
                                if (endQuote < 0) endQuote = haritaUrl.IndexOf("'", startQuote);
                                
                                if (endQuote > startQuote)
                                {
                                    haritaUrl = haritaUrl.Substring(startQuote, endQuote - startQuote);
                                }
                            }
                        }
                    }
                    
                    // URL'yi temizle
                    haritaUrl = haritaUrl.Trim().Trim('"', '\'', ' ');
                    
                    // URL geçerli mi kontrol et ve göster
                    System.Diagnostics.Debug.WriteLine("İşlenmiş URL: " + haritaUrl);
                    
                    if (!string.IsNullOrEmpty(haritaUrl) && (haritaUrl.StartsWith("http://") || haritaUrl.StartsWith("https://")))
                    {
                        if (ifHarita != null)
                        {
                            ifHarita.Src = haritaUrl;
                            System.Diagnostics.Debug.WriteLine("✅ Harita URL atandı: " + haritaUrl);
                        }
                        
                        if (pnlHaritaWrapper != null)
                        {
                            pnlHaritaWrapper.Visible = true;
                            System.Diagnostics.Debug.WriteLine("✅ Harita wrapper görünür yapıldı");
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("❌ Geçersiz URL: " + haritaUrl);
                        if (pnlHaritaWrapper != null)
                            pnlHaritaWrapper.Visible = false;
                    }
                }
                else
                {
                    if (pnlHaritaWrapper != null)
                        pnlHaritaWrapper.Visible = false;
                }
            }
            catch
            {
                // Hata olursa haritayı gizle
                if (pnlHaritaWrapper != null)
                    pnlHaritaWrapper.Visible = false;
            }
        }

        // ---------------------------------------------------------
        // 4. İLETİŞİM FORMU GÖNDERME
        // ---------------------------------------------------------
        protected void btnGonder_Click(object sender, EventArgs e)
        {
            // ValidationGroup sayesinde sadece bu formun validasyonları kontrol edilecek
            Page.Validate("IletisimForm");
            if (Page.IsValid)
            {
                try
                {
                    ContactMessageDTO yeniMesaj = new ContactMessageDTO();
                    yeniMesaj.NameSurname = txtAdSoyad.Text.Trim();
                    yeniMesaj.Email = txtEmail.Text.Trim();
                    yeniMesaj.Phone = txtTelefon.Text.Trim();
                    yeniMesaj.Subject = ddlKonu.SelectedValue;
                    yeniMesaj.Message = txtMesaj.Text.Trim();
                    yeniMesaj.IpAddress = Request.UserHostAddress;
                    yeniMesaj.CreatedDate = DateTime.Now;

                    // Varsayılan değerler (DTO'da eksikse serviste atanır ama buraya da yazabiliriz)
                    yeniMesaj.IsRead = false;

                    _contactService.Add(yeniMesaj);

                    lblIletisimMesaj.Text = "✅ Mesajınız başarıyla gönderildi. En kısa sürede döneceğiz.";
                    lblIletisimMesaj.CssClass = "form_mesaj success";
                    lblIletisimMesaj.Visible = true;

                    TemizleIletisimForm();
                }
                catch (Exception ex)
                {
                    lblIletisimMesaj.Text = "❌ Hata oluştu: " + ex.Message;
                    lblIletisimMesaj.CssClass = "form_mesaj error";
                    lblIletisimMesaj.Visible = true;
                }
            }
        }

        // ---------------------------------------------------------
        // 5. TEKLİF FORMU GÖNDERME
        // ---------------------------------------------------------
        protected void btnTeklifIste_Click(object sender, EventArgs e)
        {
            // ValidationGroup sayesinde sadece bu formun validasyonları kontrol edilecek
            Page.Validate("ProjeTeklifiForm");
            if (Page.IsValid)
            {
                try
                {
                    ProjectRequestDTO yeniTeklif = new ProjectRequestDTO();
                    yeniTeklif.CompanyName = txtFirmaAdi.Text.Trim();
                    yeniTeklif.AuthorizedPerson = txtYetkili.Text.Trim();
                    yeniTeklif.Email = txtTeklifEmail.Text.Trim();
                    yeniTeklif.Phone = txtTeklifTelefon.Text.Trim();
                    yeniTeklif.ProjectDetails = txtProjeDetay.Text.Trim();
                    yeniTeklif.IpAddress = Request.UserHostAddress;
                    yeniTeklif.RequestDate = DateTime.Now;
                    yeniTeklif.Status = "Pending";
                    yeniTeklif.IsRead = false;

                    _projectService.Add(yeniTeklif);

                    lblTeklifMesaj.Text = "✅ Teklif talebiniz alındı. Projenizi inceleyip dönüş yapacağız.";
                    lblTeklifMesaj.CssClass = "form_mesaj success";
                    lblTeklifMesaj.Visible = true;

                    TemizleTeklifForm();
                }
                catch (Exception ex)
                {
                    lblTeklifMesaj.Text = "❌ Hata oluştu: " + ex.Message;
                    lblTeklifMesaj.CssClass = "form_mesaj error";
                    lblTeklifMesaj.Visible = true;
                }
            }
        }

        // Formları temizlemek için yardımcı metotlar
        private void TemizleIletisimForm()
        {
            txtAdSoyad.Text = "";
            txtEmail.Text = "";
            txtTelefon.Text = "";
            txtMesaj.Text = "";
            ddlKonu.SelectedIndex = 0;
        }

        private void TemizleTeklifForm()
        {
            txtFirmaAdi.Text = "";
            txtYetkili.Text = "";
            txtTeklifEmail.Text = "";
            txtTeklifTelefon.Text = "";
            txtProjeDetay.Text = "";
        }
    }
}