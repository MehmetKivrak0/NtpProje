// Register.aspx.cs içinde (Doldurulmuş Metot)

using System;
using System.Web.UI;
using NtpProje.Business.Concrete; // UserService için doğru namespace
using NtpProje.Entities.Concrete;  // UserDTO için doğru namespace
using System.Web.UI.WebControls; // Repeater/Label gibi kontroller için

namespace NtpProje_Web // Namespace adınızı kontrol edin
{
    public partial class Register : System.Web.UI.Page
    {
        private readonly UserService _userService = new UserService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa ilk kez yükleniyorsa yapılacak bir şey varsa buraya yazılır.
        }

        // Bu metod, Register.aspx'deki <asp:Button OnClick="btnRegister_Click"> tarafından çağrılır.
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // ASP.NET doğrulama kontrolleri (Validator) başarılıysa devam et
            {
                // 1. Verileri DTO'ya yükle (DTO alanlarını PascalCase varsayıyoruz)
                var newUser = new UserDTO
                {
                    Full_name = txtFullName.Text,     // txtFullName.Text formdan gelen Ad Soyad
                    Email = txtEmail.Text,           // txtEmail.Text formdan gelen Email
                    Password = txtPassword.Text,       // txtPassword.Text formdan gelen Şifre

                    // Diğer DTO alanlarına formda karşılık yoksa default değerler atayın:
                    Role = "User",
                    Is_active = true,
                };

                // 2. Business Service'i çağır
                if (_userService.Register(newUser))
                {
                    // Kayıt başarılı: Login sayfasına yönlendir
                    Response.Redirect("Login.aspx?status=registered");
                }
                else
                {
                    // Kayıt başarısız (E-posta zaten kullanılıyor vb. İş Kuralı ihlali)
                    // lblMessage'ı görünür hale getirelim.
                    // Sayfanızda lblMessage adında bir Label olduğunu varsayıyoruz.
                    lblMessage.Text = "Kayıt işlemi başarısız oldu. E-posta adresi zaten kullanılıyor olabilir.";
                    // lblMessage.CssClass = "alert alert-danger"; // CSS sınıfınız varsa
                    lblMessage.Visible = true;

                    // Not: Eğer lblMessage tanınmazsa, designer.cs hatası hala vardır.
                }
            }
        }
    }
}