using System;
using System.Web;
using System.Web.UI;

namespace NtpProje_Web.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            // --- MERKEZİ GÜVENLİK KONTROLÜ ---
            // Eğer kullanıcı giriş yapmamışsa, onu Login sayfasına at.
            // Bu kod burada olduğu için, bu Master Page'i kullanan HER SAYFA otomatik korunur.

            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Çıkış Yapma İşlemi
            Session.Abandon(); // Oturumu öldür
            Session.Clear();   // Verileri temizle
            Response.Redirect("~/Login.aspx"); // Girişe yönlendir
        }
    }
}