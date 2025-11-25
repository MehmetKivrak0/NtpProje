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
                // Veritabanından üyeleri çek
                var ekipUyeleri = _teamService.GetAll();

                // Repeater'a bağla
                // Not: HTML tarafında ID="rptEkip" olmalı
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
            }
        }
    }
}