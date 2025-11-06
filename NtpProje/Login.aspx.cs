using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business;
using NtpProje.Entities;
namespace NtpProje
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            UserManager userManeger = new UserManager();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            User loggedınUser = userManeger.Login(email, password);

            if (loggedınUser != null)
            {
                Session["UserId"] = loggedınUser.UserId;
                Session["UserFullName"] = loggedınUser.FullName;
                Session["UserRole"] = loggedınUser.Role; // Session'a orijinal haliyle kaydet

                // --- DEĞİŞEN SATIR BURASI ---
                // Karşılaştırmayı güvenli yap:
                if (loggedınUser.Role.Trim().ToUpper() == "ADMİN")
                {
                    // ... Admin yönlendirmesi ...
                    Response.Redirect("~/pages/Admin/admin_dashboard.aspx");
                }
                else
                {
                    // ... Üye yönlendirmesi ...
                    Response.Redirect("~/pages/Admin/UyePaneli.aspx"); // Burayı Ana Sayfa olarak düzelttik
                }
            }
            else
            {
                // Hata mesajı...
                ltrMesaj.Text = "<div style='color:red;'>Hata: E-posta veya şifre hatalı.</div>";
            }
        }
    }
}