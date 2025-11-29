using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

namespace NtpProje_Web
{
    // DİKKAT: Class ismi "Hizmetler" ve ": System.Web.UI.Page" ekli.
    public partial class hizmetler : System.Web.UI.Page
    {
        // Designer olmadığı için elle eklediğimiz kontroller
      

        // Servis Bağlantısı
        private ServiceService _serviceService = new ServiceService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HizmetleriListele();
            }
        }

        private void HizmetleriListele()
        {
            try
            {
                var hizmetler = _serviceService.GetAll();

                // HTML tarafında ID="rptHizmetler" olduğu için burayı görüyor
                rptHizmetler.DataSource = hizmetler;
                rptHizmetler.DataBind();

                phEmptyMessage.Visible = (hizmetler == null || hizmetler.Count == 0);
            }
            catch (Exception ex)
            {
                // Hata durumunda (Geçici)
                Response.Write("Hata: " + ex.Message);
            }
        }

        // HTML tarafındaki OnItemDataBound buraya düşecek
        protected void rptHizmetler_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var currentHizmet = e.Item.DataItem as ServiceDTO; // DTO kullanıyorsan ServiceDTO, Entity ise Service

                // İçerideki Repeater'ı bul (Elle tanımlasak bile FindControl şarttır)
                Repeater rptFeaturesInternal = e.Item.FindControl("rptFeatures") as Repeater;

                if (rptFeaturesInternal != null && currentHizmet != null)
                {
                    // short_description alanını virgülle ayırıp listeleme
                    string featuresString = currentHizmet.ShortDescription;
                    if (!string.IsNullOrWhiteSpace(featuresString))
                    {
                        var featureList = featuresString.Split(',').Where(s => !string.IsNullOrWhiteSpace(s)).ToList();
                        rptFeaturesInternal.DataSource = featureList;
                        rptFeaturesInternal.DataBind();
                    }
                }
            }
        }

        // ============================================================
        // YARDIMCI METODLAR (ASPX'te kullanmak için)
        // ============================================================

        // Resim URL'sini düzenleme metodu
        public string GetImageUrl(object imageUrl)
        {
            if (imageUrl == null || string.IsNullOrEmpty(imageUrl.ToString()))
                return ResolveUrl("~/images/default-service.jpg"); // Varsayılan resim

            string url = imageUrl.ToString();

            // Eğer zaten tam URL ise (http:// veya / ile başlıyorsa) olduğu gibi döndür
            if (url.StartsWith("http://") || url.StartsWith("https://") || url.StartsWith("/"))
            {
                return url;
            }

            // Sadece dosya adı ise /images/ prefix'i ekle
            return ResolveUrl("~/images/" + url);
        }

        // Service Image HTML'i oluştur (resim yoksa ikon göster)
        public string GetServiceImage(object imageUrl, object icon)
        {
            string imageUrlStr = imageUrl != null ? imageUrl.ToString() : "";
            string iconStr = icon != null ? icon.ToString() : "";

            if (string.IsNullOrEmpty(imageUrlStr))
            {
                // Resim yoksa ikon göster
                string displayIcon = string.IsNullOrEmpty(iconStr) ? "📦" : iconStr;
                return "<div style='width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; font-size: 48px; background: #f3f4f6; border-radius: 8px;'>" + displayIcon + "</div>";
            }
            else
            {
                // Resim varsa img tag'i oluştur
                string imgUrl = GetImageUrl(imageUrl);
                return "<img src='" + imgUrl + "' alt='Hizmet' style='width: 100%; height: 100%; object-fit: cover; border-radius: 8px;' />";
            }
        }
    }
}