using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete;

namespace NtpProje_Web
{
    public partial class Site : System.Web.UI.MasterPage
    {
        // HTML tarafında kullandığın <%= AktifSayfaAdi %> değişkeni
        public string AktifSayfaAdi { get; set; }

        // SettingService'i kullanarak veritabanından ayarları çekiyoruz
        private SettingService _settingService;
        private SettingService SettingService
        {
            get
            {
                if (_settingService == null)
                    _settingService = new SettingService();
                return _settingService;
            }
        }

        // Footer iletişim bilgileri için property'ler - Getter'da direkt veritabanından çekiyoruz
        public string FooterAdres
        {
            get
            {
                try
                {
                    string adres = SettingService.GetValueByKey("site_address");
                    return string.IsNullOrEmpty(adres) ? "Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / İzmir" : adres;
                }
                catch
                {
                    return "Kıbrıs Şehitleri Cd. No:48 K:6 - 601 / İzmir";
                }
            }
        }

        public string FooterTelefon
        {
            get
            {
                try
                {
                    string telefon = SettingService.GetValueByKey("site_phone");
                    return string.IsNullOrEmpty(telefon) ? "+90 232 464 1 184" : telefon;
                }
                catch
                {
                    return "+90 232 464 1 184";
                }
            }
        }

        public string FooterEmail
        {
            get
            {
                try
                {
                    string email = SettingService.GetValueByKey("site_email");
                    return string.IsNullOrEmpty(email) ? "info@gencbirey.com" : email;
                }
                catch
                {
                    return "info@gencbirey.com";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa her yüklendiğinde, şu an hangi sayfadayız onu buluyoruz
            // Örn: "iletisim.aspx"
            string path = Request.AppRelativeCurrentExecutionFilePath;
            AktifSayfaAdi = System.IO.Path.GetFileName(path);
        }
    }
}