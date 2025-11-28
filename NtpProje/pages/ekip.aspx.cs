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
    // HATA BURADAYDI: ": System.Web.UI.Page" eklendi.
    public partial class Ekip : System.Web.UI.Page
    {
        // Designer dosyası çalışmazsa diye elle tanımlıyoruz (Garanti Çözüm)
        
        // TeamMemberService servisini çağırıyoruz (Senin proje yapına göre ismini yazdım)
        private TeamMemberService _teamService = new TeamMemberService();

        // ImageUrl'i düzgün şekilde çözümlemek için yardımcı metod
        protected string GetResolvedImageUrl(object imageUrlObj)
        {
            string imageUrl = imageUrlObj?.ToString() ?? "";
            
            if (string.IsNullOrEmpty(imageUrl))
            {
                // Varsayılan resim yoksa logo'yu kullan veya placeholder göster
                return ResolveUrl("~/images/logo/logo.png");
            }
            
            // Eğer tam URL ise (http:// veya https:// ile başlıyorsa) olduğu gibi kullan
            if (imageUrl.StartsWith("http://") || imageUrl.StartsWith("https://"))
            {
                return imageUrl;
            }
            
            // Relative path ise ResolveUrl ile çözümle
            return imageUrl.StartsWith("~/") ? ResolveUrl(imageUrl) : ResolveUrl("~/" + imageUrl);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EkipListele();
            }
        }

        private void EkipListele()
        {
            try
            {
                // Veritabanından tüm üyeleri çek
                var tumUyeler = _teamService.GetAll();

                // Sadece aktif üyeleri filtrele ve display_order'a göre sırala
                var ekipUyeleri = tumUyeler?
                    .Where(u => u.IsActive) // Sadece aktif üyeler
                    .OrderBy(u => u.DisplayOrder) // display_order'a göre sırala
                    .ThenBy(u => u.Name) // Aynı display_order varsa isme göre sırala
                    .ToList() ?? new List<TeamMemberDTO>();

                // Repeater'a bağla
                rptEkip.DataSource = ekipUyeleri;
                rptEkip.DataBind();

                // Veri yoksa "Üye bulunamadı" mesajını göster
                if (ekipUyeleri == null || ekipUyeleri.Count == 0)
                {
                    phEmptyEkip.Visible = true;
                    rptEkip.Visible = false;
                }
                else
                {
                    phEmptyEkip.Visible = false;
                    rptEkip.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda ekrana yazdır (Geliştirme aşaması için)
                Response.Write("Hata: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Ekip Listeleme Hatası: " + ex.Message + " | Stack: " + ex.StackTrace);
            }
        }
    }
}