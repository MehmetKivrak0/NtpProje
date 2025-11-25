using System;
using System.Web.UI;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete; // DTO'lar için

namespace NtpProje_Web
{
    public partial class Hakkimizda : System.Web.UI.Page
    {
        // Designer hatasına karşı manuel tanımlamalar (HTML'deki Literal'ler)
       

        // Servis bağlantısı
        private readonly SettingService _settingService = new SettingService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAboutContent();
            }
        }

        private void LoadAboutContent()
        {
            try
            {
                // Veritabanından Key-Value yapısıyla içerikleri çek
                string kimlik = _settingService.GetValueByKey("about_who_we_are");
                string misyon = _settingService.GetValueByKey("about_mission");
                string vizyon = _settingService.GetValueByKey("about_vision");

                // Eğer veri boş gelirse varsayılan metin atayarak sayfanın çirkin görünmesini engelle
                ltrKimlik.Text = string.IsNullOrEmpty(kimlik)
                                 ? "<p>Şirket kimliği bilgisi Admin panelinden yakında eklenecektir.</p>"
                                 : kimlik;

                ltrMisyon.Text = string.IsNullOrEmpty(misyon)
                                 ? "<p>Misyon bildirisi Admin tarafından yakında eklenecektir.</p>"
                                 : misyon;

                ltrVizyon.Text = string.IsNullOrEmpty(vizyon)
                                 ? "<p>Vizyon bildirisi Admin tarafından yakında eklenecektir.</p>"
                                 : vizyon;
            }
            catch (Exception ex)
            {
                // Bağlantı hatası olursa ekrana hata mesajını bas
                Response.Write("<p style='color: red; font-weight: bold;'>Hata: Veri Çekilemedi. Bağlantı sorununu kontrol edin. (" + ex.Message + ")</p>");
            }
        }
    }
}