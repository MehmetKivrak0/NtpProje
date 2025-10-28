using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business;
using NtpProje.Entities;


namespace NtpProje.pages.Admin
{
    public partial class UyePaneli : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void LoadUserProfile()
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                UserManager userManager = new UserManager();
                User currentUser = userManager.GetUserById(userId);

                if (currentUser != null)
                {
                    // Ekrandaki Literal'ları doldur
                    ltrProfileFullName.Text = currentUser.FullName;
                    ltrProfileEmail.Text = currentUser.Email;
                    ltrProfilePhone.Text = string.IsNullOrEmpty(currentUser.PhoneNumber) ? "-" : currentUser.PhoneNumber;
                    ltrProfileRegisterDate.Text = "-"; // Kayıt tarihi alanı eklenirse doldurulur.
                                                       //ltrProfileBio.Text = currentUser.Bio ?? "-"; // Bio alanı eklenirse

                    // Topbar bilgilerini de güncelle (Master Page yoksa)
                    ltrUserName.Text = currentUser.FullName;
                    ltrUserAvatar.Text = currentUser.FullName.Substring(0, 1).ToUpper();
                    ltrUserRole.Text = currentUser.Role;

                    // Modal içindeki HiddenField'a ID'yi tekrar atayalım (güvenlik için)
                    hfUserId.Value = currentUser.UserId.ToString();
                }
                else
                {
                    ShowMessage("Kullanıcı bilgileri bulunamadı.", false);
                    // Belki kullanıcıyı login'e atmak gerekir?
                    // Response.Redirect("~/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Profil bilgileri yüklenirken hata oluştu: " + ex.Message, false);
            }
        }

        protected void btnOpenProfileModal_Click(object sender , EventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                UserManager userManeger = new UserManager();
                User currentUser = userManeger.GetUserById(userId);

                if (currentUser == null)
                {
                    {
                        hfUserId.Value = currentUser.UserId.ToString();
                        txtProfileEmail.Text = currentUser.Email;
                        txtProfileName.Text = currentUser.FullName;
                        txtProfilePhone.Text = currentUser.PhoneNumber;
                    }
                }
                profileModal.Visible = true;
            }
            catch (Exception ex)
            {

                ShowMessage("Profil bilgileri yüklenirken hata oluştu: " + ex.Message, false);
                profileModal.Visible = false; // Hata olursa modalı gösterme
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            // Mesajın stilini belirle (Bootstrap alert sınıfları varsayıldı, istersen değiştirebilirsin)
            string cssClass = isSuccess ? "alert alert-success" : "alert alert-danger";

            // Ekstra stil (istersen admin.css'e taşıyabilirsin)
            string styles = "padding: 10px; border: 1px solid; margin-bottom: 10px; border-radius: 4px;";
            string borderColor = isSuccess ? "green" : "red";

            // ltrMesaj kontrolünün Text özelliğine HTML içeriğini ata
            ltrMesaj.Text = $"<div class='{cssClass}' style='{styles} border-color:{borderColor}; color:{borderColor};'> {Server.HtmlEncode(message)} </div>";

            // Mesajın hemen görünmesi için (UpdatePanel kullanmıyorsak gerekli değil ama zararı olmaz)
            ltrMesaj.Visible = true;
        }

        protected void lnkCikisYap_Click(object sender, EventArgs e)
        {
            Session.Clear();    // Tüm Session verilerini temizle
            Session.Abandon();  // Oturumu tamamen sonlandır

            // Login sayfasına yönlendir (Login.aspx'in pages klasöründe olduğunu varsayıyoruz)
            Response.Redirect("~/Login.aspx");
        }
        protected void btnViewPost_Click(object sender, EventArgs e)
        {
            // 1. Tıklanan LinkButton kontrolünü al
            LinkButton btn = (LinkButton)sender;

            // 2. Button'un CommandArgument'ına .aspx'te bağladığımız PostId'yi al
            string postId = btn.CommandArgument;

            // 3. PostId geçerli bir sayı mı diye kontrol et (isteğe bağlı ama güvenli)
            if (int.TryParse(postId, out int id))
            {
                // 4. Kullanıcıyı yazı detay sayfasına yönlendir (QueryString ile ID'yi gönder)
                // Varsayılan sayfa adı: PostDetay.aspx, kendi sayfa adınla değiştir
                Response.Redirect($"~/pages/PostDetay.aspx?id={id}");
            }
            else
            {
                // Geçersiz ID ise bir hata mesajı gösterilebilir
                ShowMessage("Geçersiz yazı ID'si.", false);
            }

        }
        // MODAL KAPATMA BUTONUNA TIKLANDIĞINDA ÇALIŞACAK METOT
        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            // Profil düzenleme modal panelini gizle
            profileModal.Visible = false;
        }
        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            // Sayfadaki validasyon kontrolleri (RequiredFieldValidator vb.) geçerli mi?
            if (Page.IsValid)
            {
                try
                {
                    // Gizli alandan güncellenecek kullanıcının ID'sini al
                    int userId = Convert.ToInt32(hfUserId.Value);
                    UserManager userManager = new UserManager(); // Business katmanını kullan

                    // Veritabanından mevcut kullanıcıyı tekrar al (güncelleme için en güvenli yol)
                    User userToUpdate = userManager.GetUserById(userId);

                    if (userToUpdate != null)
                    {
                        // TextBox'lardaki yeni verilerle nesneyi güncelle
                        userToUpdate.FullName = txtProfileName.Text;
                        userToUpdate.Email = txtProfileEmail.Text;
                        userToUpdate.PhoneNumber = txtProfilePhone.Text;
                        userToUpdate.Bio= txtProfileBio.Text; // Hakkımda alanı

                        // Business katmanındaki UpdateProfile metodunu çağır
                        bool updateResult = userManager.UpdateProfile(userToUpdate); // Bu metot Business'ta olmalı

                        if (updateResult)
                        {
                            profileModal.Visible = false; // Modalı kapat
                            LoadUserProfile(); // Ekrandaki profil bilgilerini yenile
                            ShowMessage("Profil başarıyla güncellendi!", true); // Başarı mesajı göster

                            // Session'daki adı da güncelle (Topbar'da doğru görünmesi için)
                            Session["UserFullName"] = userToUpdate.FullName;

                            // Eğer Master Page kullanılsaydı Master Page'i de güncellemek gerekirdi
                            // ((Uye)this.Master).UpdateUserInfo(); 
                            // Master Page olmadığı için Topbar'ı doğrudan güncelleyebiliriz (LoadUserProfile içinde yapılıyor)
                        }
                        else
                        {
                            // Business katmanı false döndürdüyse (örn: e-posta zaten kullanılıyor)
                            ShowMessage("Profil güncellenirken bir hata oluştu (belki e-posta kullanılıyor?).", false);
                            // Hata durumunda modalı açık bırak ki kullanıcı düzeltebilsin
                            profileModal.Visible = true;
                        }
                    }
                    else
                    {
                        ShowMessage("Güncellenecek kullanıcı bulunamadı.", false);
                        profileModal.Visible = true; // Hata durumunda modalı açık bırak
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Profil kaydedilirken bir hata oluştu: " + ex.Message, false);
                    profileModal.Visible = true; // Hata durumunda modalı açık bırak
                }
            }
            // else: Validasyon başarısızsa hiçbir şey yapma, validasyon mesajları zaten ASP.NET tarafından gösterilir.
            // Hatta modalı açık tutmak iyi olur.
            if (!Page.IsValid)
            {
                profileModal.Visible = true; // Validasyon hatası varsa modal açık kalsın
            }
        }




    }
}