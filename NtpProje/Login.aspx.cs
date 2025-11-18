using NtpProje.Business.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NtpProje
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly UserService _userService = new UserService();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                string email = txtEmail.Text;
                string password = txtPassword.Text;

                var loggedInUser = _userService.Login(email, password);

                if (loggedInUser != null)
                {
                    // Giriş başarılı: Session oluşturma
                    Session["UserID"] = loggedInUser.User_id;
                    Session["FullName"] = loggedInUser.Full_name;
                    Session["Role"] = loggedInUser.Role; // Yetkilendirme için kritik

                    // 2. Rol Bazlı Yönlendirme
                    if (loggedInUser.Role == "Admin")
                    {
                        // Yönetici Paneline yönlendir (Örn: Admin/blog.aspx)
                        Response.Redirect("~/pages/Admin/admin_dashboard.aspx");
                    }
                    else
                    {
                        // Standart kullanıcı ana sayfasına yönlendir
                        Response.Redirect("~/pages/Admin/UyePaneli.aspx");
                    }

                }
                else
                {
                    // Giriş başarısız: Hata mesajı göster
                    lblMessage.Text = "Geçersiz e-posta veya şifre.";
                    lblMessage.Visible = true;
                }
            }
        }
    }
}