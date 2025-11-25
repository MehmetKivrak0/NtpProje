using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // Servisler
using NtpProje.Entities.Concrete; // DTO'lar

namespace NtpProje_Web
{
    public partial class Iletisim : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // 1. MANUEL TANIMLAMALAR (Designer hatasına karşı sigorta)
        // ---------------------------------------------------------

        // Ayarlar (Settings) için
       
        protected global::System.Web.UI.HtmlControls.HtmlIframe ifHarita; // Harita

        // İletişim Formu
        protected global::System.Web.UI.WebControls.TextBox txtAdSoyad;
        protected global::System.Web.UI.WebControls.TextBox txtEmail;
        protected global::System.Web.UI.WebControls.TextBox txtTelefon;
        protected global::System.Web.UI.WebControls.DropDownList ddlKonu;
        protected global::System.Web.UI.WebControls.TextBox txtMesaj;
        protected global::System.Web.UI.WebControls.Label lblIletisimMesaj;

        // Teklif Formu
        protected global::System.Web.UI.WebControls.TextBox txtFirmaAdi;
        protected global::System.Web.UI.WebControls.TextBox txtYetkili;
        protected global::System.Web.UI.WebControls.TextBox txtTeklifEmail;
        protected global::System.Web.UI.WebControls.TextBox txtTeklifTelefon;
        protected global::System.Web.UI.WebControls.TextBox txtProjeDetay;
        protected global::System.Web.UI.WebControls.Label lblTeklifMesaj;

        // ---------------------------------------------------------
        // 2. SERVİSLERİ ÇAĞIRIYORUZ
        // ---------------------------------------------------------
        private readonly SettingService _settingService = new SettingService();
        private readonly ContactMessageService _contactService = new ContactMessageService();
        private readonly ProjectRequestService _projectService = new ProjectRequestService();

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
                // Text verileri
                litAdres.Text = _settingService.GetValueByKey("site_address");
                litTelefon.Text = _settingService.GetValueByKey("site_phone");
                litEmail.Text = _settingService.GetValueByKey("site_email");
                litSaatler.Text = _settingService.GetValueByKey("site_working_hours");

                // Harita Linki
                string mapLink = _settingService.GetValueByKey("site_map_embed");
                if (!string.IsNullOrEmpty(mapLink))
                {
                    ifHarita.Src = mapLink;
                }
                else
                {
                    ifHarita.Visible = false;
                }
            }
            catch
            {
                // Hata olursa boş kalsın
            }
        }

        // ---------------------------------------------------------
        // 4. İLETİŞİM FORMU GÖNDERME
        // ---------------------------------------------------------
        protected void btnGonder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // DTO Oluştur ve Doldur
                    ContactMessageDTO yeniMesaj = new ContactMessageDTO();
                    yeniMesaj.NameSurname = txtAdSoyad.Text;
                    yeniMesaj.Email = txtEmail.Text;
                    yeniMesaj.Phone = txtTelefon.Text;
                    yeniMesaj.Subject = ddlKonu.SelectedValue;
                    yeniMesaj.Message = txtMesaj.Text;
                    yeniMesaj.IpAddress = Request.UserHostAddress; // IP Adresini al
                    yeniMesaj.CreatedDate = DateTime.Now;

                    // Servise gönder (Veritabanına kayıt)
                    _contactService.Add(yeniMesaj);

                    // Başarılı mesajı
                    lblIletisimMesaj.Text = "Mesajınız başarıyla gönderildi. En kısa sürede döneceğiz.";
                    lblIletisimMesaj.CssClass = "form_mesaj success";
                    lblIletisimMesaj.Visible = true;

                    TemizleIletisimForm();
                }
                catch (Exception ex)
                {
                    lblIletisimMesaj.Text = "Hata oluştu: " + ex.Message;
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
            if (Page.IsValid)
            {
                try
                {
                    // DTO Oluştur ve Doldur
                    ProjectRequestDTO yeniTeklif = new ProjectRequestDTO();
                    yeniTeklif.CompanyName = txtFirmaAdi.Text;
                    yeniTeklif.AuthorizedPerson = txtYetkili.Text;
                    yeniTeklif.Email = txtTeklifEmail.Text;
                    yeniTeklif.Phone = txtTeklifTelefon.Text;
                    yeniTeklif.ProjectDetails = txtProjeDetay.Text;
                    yeniTeklif.IpAddress = Request.UserHostAddress;
                    yeniTeklif.RequestDate = DateTime.Now;
                    yeniTeklif.Status = "Pending"; // Beklemede

                    // Servise gönder
                    _projectService.Add(yeniTeklif);

                    // Başarılı mesajı
                    lblTeklifMesaj.Text = "Teklif talebiniz alındı. Projenizi inceleyip dönüş yapacağız.";
                    lblTeklifMesaj.CssClass = "form_mesaj success";
                    lblTeklifMesaj.Visible = true;

                    TemizleTeklifForm();
                }
                catch (Exception ex)
                {
                    lblTeklifMesaj.Text = "Hata oluştu: " + ex.Message;
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