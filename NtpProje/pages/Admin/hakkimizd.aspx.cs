using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

namespace NtpProje_Web.Admin
{
    public partial class hakkimizd : System.Web.UI.Page
    {
        // Manuel tanımlamalar
       

        private readonly SettingService _settingService = new SettingService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin kontrolü
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAboutContent();
            }
        }

        private void LoadAboutContent()
        {
            try
            {
                // Veritabanından mevcut içerikleri yükle
                string kimlik = _settingService.GetValueByKey("about_who_we_are");
                string vizyon = _settingService.GetValueByKey("about_vision");
                string misyon = _settingService.GetValueByKey("about_mission");

                if (txtKimlik != null)
                    txtKimlik.Text = kimlik ?? "";

                if (txtVizyon != null)
                    txtVizyon.Text = vizyon ?? "";

                if (txtMisyon != null)
                    txtMisyon.Text = misyon ?? "";
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: İçerikler yüklenirken bir hata oluştu: " + ex.Message, "error");
            }
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            try
            {
                // TinyMCE içeriklerini al (HTML içerik olabilir)
                string kimlik = txtKimlik != null ? txtKimlik.Text.Trim() : "";
                string vizyon = txtVizyon != null ? txtVizyon.Text.Trim() : "";
                string misyon = txtMisyon != null ? txtMisyon.Text.Trim() : "";

                // SettingService ile kaydet
                _settingService.SetValueByKey("about_who_we_are", kimlik);
                _settingService.SetValueByKey("about_vision", vizyon);
                _settingService.SetValueByKey("about_mission", misyon);

                ShowMessage("✅ Hakkımızda sayfası içerikleri başarıyla kaydedildi!", "success");

                // Sayfayı yeniden yükle (güncel içeriklerle)
                LoadAboutContent();
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Hata: İçerikler kaydedilirken bir hata oluştu: " + ex.Message, "error");
            }
        }

        private void ShowMessage(string message, string type)
        {
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.CssClass = "alert-message " + type;
                lblMessage.Visible = true;
            }
        }
    }
}
