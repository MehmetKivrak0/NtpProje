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

        // Şifre validasyon metodu (Server-side)
        protected void cvPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string password = args.Value;

            // Şifre gereksinimlerini kontrol et
            bool hasMinLength = password.Length >= 6;
            bool hasLowercase = System.Text.RegularExpressions.Regex.IsMatch(password, @"[a-z]");
            bool hasUppercase = System.Text.RegularExpressions.Regex.IsMatch(password, @"[A-Z]");

            // Tüm gereksinimler karşılanmalı
            args.IsValid = hasMinLength && hasLowercase && hasUppercase;

            if (!args.IsValid)
            {
                ((CustomValidator)source).ErrorMessage = "Şifre en az 6 karakter, bir büyük harf ve bir küçük harf içermelidir.";
            }
        }

        // Bu metod, Register.aspx'deki <asp:Button OnClick="btnRegister_Click"> tarafından çağrılır.
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // ValidationGroup kontrolü
            Page.Validate("RegisterForm");

            if (Page.IsValid) // ASP.NET doğrulama kontrolleri (Validator) başarılıysa devam et
            {
                // Şifre validasyonunu tekrar kontrol et (ekstra güvenlik için)
                if (!IsPasswordValid(txtPassword.Text))
                {
                    ShowErrorMessage("Şifre gereksinimleri karşılanmıyor. Şifre en az 6 karakter, bir büyük harf ve bir küçük harf içermelidir.");
                    return;
                }

                // 1. Verileri DTO'ya yükle (DTO alanlarını PascalCase varsayıyoruz)
                var newUser = new UserDTO
                {
                    Full_name = txtFullName.Text.Trim(),     // txtFullName.Text formdan gelen Ad Soyad
                    Email = txtEmail.Text.Trim(),           // txtEmail.Text formdan gelen Email
                    Password = txtPassword.Text,       // txtPassword.Text formdan gelen Şifre
                    PhoneNumber = txtPhoneNumber.Text.Trim(), // Telefon numarası

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
                    ShowErrorMessage("Kayıt işlemi başarısız oldu. E-posta adresi zaten kullanılıyor olabilir.");
                }
            }
            else
            {
                // Validasyon hatası var
                ShowErrorMessage("Lütfen tüm alanları doğru şekilde doldurun.");
            }
        }

        // Şifre validasyon yardımcı metodu
        private bool IsPasswordValid(string password)
        {
            if (string.IsNullOrWhiteSpace(password))
                return false;

            // En az 6 karakter
            if (password.Length < 6)
                return false;

            // En az bir küçük harf
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[a-z]"))
                return false;

            // En az bir büyük harf
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[A-Z]"))
                return false;

            return true;
        }

        // Hata mesajı gösterme yardımcı metodu
        private void ShowErrorMessage(string message)
        {
            // ltrMesaj kontrolü için manuel tanımlama (Designer hatasına karşı)
            System.Web.UI.WebControls.Literal ltrMesaj = FindControl("ltrMesaj") as System.Web.UI.WebControls.Literal;
            
            if (ltrMesaj != null)
            {
                ltrMesaj.Text = "<div style='background-color: #f8d7da; color: #721c24; padding: 12px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #f5c6cb;'>" +
                               "<strong>Hata:</strong> " + System.Web.HttpUtility.HtmlEncode(message) +
                               "</div>";
                ltrMesaj.Visible = true;
            }
        }
    }
}