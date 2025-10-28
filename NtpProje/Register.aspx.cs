// Register.aspx.cs

using System;
using System.Web.UI;         // : System.Web.UI.Page için gerekli
using NtpProje.Business; // UserManager sınıfımız için
using NtpProje.Entities;   // User sınıfımız için

namespace NtpProje_Web // Proje adınızdaki tire '-' alt çizgi '_' oldu, DİKKAT!
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa ilk kez yükleniyorsa yapılacak bir şey varsa buraya yazılır.
        }

        // Bu metod, Register.aspx'deki <asp:Button OnClick="btnRegister_Click"> tarafından çağrılır.
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // 1. Business katmanından bir nesne yarat
            UserManager userManager = new UserManager();

            // 2. Entities katmanından yeni, boş bir User nesnesi yarat
            User newUser = new User();

            // 3. Bu boş nesneyi TextBox'lardan gelen verilerle doldur
            newUser.FullName = txtFullName.Text;
            newUser.Email = txtEmail.Text;
            newUser.PhoneNumber = txtPhoneNumber.Text;

            // Güvenlik Uyarısı: Şifreyi hash'lemeyi unutma!
            newUser.Password = txtPassword.Text;

            // 4. Doldurduğumuz bu nesneyi Business katmanına yolla
            bool sonuc = userManager.Register(newUser);

            // 5. Business'tan dönen 'true'/'false' sonucunu kontrol et
            if (sonuc == true)
            {
                // Kayıt başarılı olduysa
                ltrMesaj.Text = "<div style='color:green; padding: 10px; border: 1px solid green; margin-bottom: 10px;'>Kayıt başarılı! Giriş sayfasına yönlendiriliyorsunuz...</div>";
                // Kullanıcıyı 3 saniye bekletip Login'e yolla
                Response.AddHeader("REFRESH", "3;URL=Login.aspx");
            }
            else
            {
                // Kayıt başarısız olduysa (muhtemelen e-posta zaten kullanımda)
                ltrMesaj.Text = "<div style='color:red; padding: 10px; border: 1px solid red; margin-bottom: 10px;'>Hata: Bu e-posta adresi zaten kullanılıyor veya bir sistem hatası oluştu.</div>";
            }
        }
    }
}