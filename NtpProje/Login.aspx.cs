using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete;
using NtpProje.Entities.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NtpProje_Web // Namespace'in NtpProje_Web olduğuna dikkat et
{
    public partial class Login : System.Web.UI.Page
    {
        // -------------------------------------------------------------------
        // 1. EKSİK OLAN KONTROL TANIMLAMALARI (CS0103 Hatasını çözer)
        // -------------------------------------------------------------------
       // Varsayım: HTML'de vardı

        // 2. SERVİS TANIMI
        private readonly UserService _userService = new UserService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kullanıcı zaten giriş yapmışsa yönlendir
            if (Session["AdminUser"] != null)
            {
                Response.Redirect("~/pages/Admin/admin_dashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Kontrollerin C# tarafında görünür olması için (hata vermesin diye)
            if (Page.IsValid)
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();

                // lblMessage kontrolünü ekranda göstermeden önce sıfırla
                if (lblMessage != null) lblMessage.Visible = false;

                try
                {
                    // Stored Procedure ile kullanıcıyı kontrol et
                    var loggedInUser = _userService.Login(email, password);

                    if (loggedInUser != null)
                    {
                        // 1. Başarılı Giriş: Session oluşturma (DTO standartlarına uygun)
                        Session["AdminUser"] = loggedInUser;
                        Session["UserID"] = loggedInUser.Id;
                        Session["FullName"] = loggedInUser.FullName;
                        Session["Role"] = loggedInUser.Role;

                        // 2. Başarılı girişten sonra admin dashboard'a yönlendir
                        Response.Redirect("~/pages/Admin/admin_dashboard.aspx");
                    }
                    else
                    {
                        // Giriş başarısız: Hata mesajı göster
                        if (lblMessage != null)
                        {
                            lblMessage.Text = "Geçersiz e-posta veya şifre.";
                            lblMessage.Visible = true;
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Sistem hatası oluşursa programın durmasını engelle
                    if (lblMessage != null)
                    {
                        lblMessage.Text = "Sistem Hatası oluştu. Lütfen tekrar deneyin.";
                        lblMessage.Visible = true;
                    }
                    // DEBUGGING: Hatayı Visual Studio'nun Output penceresinde görebilirsin
                    System.Diagnostics.Debug.WriteLine("KRİTİK LOGIN HATA: " + ex.Message + " | Stack: " + ex.StackTrace);
                }
            }
        }
    }
}