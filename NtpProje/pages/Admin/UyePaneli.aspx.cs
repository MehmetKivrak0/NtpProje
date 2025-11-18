using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete; // UserService, PostService için
using NtpProje.Entities.Concrete;  // UserDTO, PostDTO için

namespace NtpProje.pages.Admin
{
    // DİKKAT: Sayfanın gerçekten 'UyePaneli' olarak tanımlı olması gerekir.
    public partial class UyePaneli : System.Web.UI.Page
    {
        private readonly UserService _userService = new UserService();
        private readonly PostService _postService = new PostService();

        // Gerekli Kontrollerin Tanımlı Olduğu Varsayılmıştır (designer.cs ile çözüldü)

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Yetki Kontrolü (Giriş Yapılmadıysa yönlendir)
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // 2. Kullanıcı Bilgilerini Yükle
                LoadUserProfile();
                BindUserPosts();
            }
        }

        private void LoadUserProfile()
        {
            // Session'dan kullanıcı ID'sini al ve integer'a çevir
            if (Session["UserID"] is int userId)
            {
                UserDTO user = _userService.GetById(userId);

                if (user != null)
                {
                    // Sayfadaki Literal kontrollerine bilgileri doldur
                    // DTO'daki alanlar PascalCase (Full_name, CreatedDate) olarak varsayılmıştır.
                    ltrPageTitle.Text = $"Hoş Geldiniz, {user.Full_name}!";
                    ltrUserName.Text = user.Full_name;
                    ltrUserRole.Text = user.Role;
                    ltrProfileFullName.Text = user.Full_name;
                    ltrProfileEmail.Text = user.Email;
                    // Not: DTO'da Phone_number ve Bio alanlarının olduğunu varsayıyorum.
                    // ltrProfilePhone.Text = user.Phone_number ?? "-";
                    // ltrProfileBio.Text = user.Bio ?? "";

                    // Tarih formatı
                    ltrProfileRegisterDate.Text = user.Created_date.ToString("dd MMMM yyyy");

                    // Modal'daki (Düzenleme formu) TextBox'ları doldur
                    // txtProfileName.Text = user.Full_name;
                    // txtProfileEmail.Text = user.Email;

                    // İstatistikleri doldur
                    // ltrTotalPosts.Text = _postService.GetPostsByUserId(userId).Count().ToString();
                }
            }
        }

        private void BindUserPosts()
        {
            if (Session["UserID"] is int userId)
            {
                try
                {
                    // Varsayım: PostService içinde GetPostsByUserId metodu olmalı.
                    // var userPosts = _postService.GetPostsByUserId(userId).Take(5).ToList();

                    // rptUserPosts.DataSource = userPosts;
                    // rptUserPosts.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("YAZI YÜKLEME HATASI: " + ex.ToString());
                    // ltrMesaj.Text = "<div class='alert alert-danger'>Yazılar yüklenirken hata oluştu.</div>";
                }
            }
        }

        // *******************************************************************
        // OLAY İŞLEYİCİLERİ (Butonlar)
        // *******************************************************************

        // CS1061 Hatasını Çözen Metot (View/Görüntüle butonu için)
        protected void btnViewPost_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string postId = btn.CommandArgument;

            // Kullanıcıyı detay sayfasına yönlendir (Ana sayfadaki blog detayına)
            Response.Redirect($"~/blog_detay.aspx?id={postId}");
        }

        // Profil Ayarları Modal Açma (Modalı Visible=true yaparak açar)
        protected void btnOpenProfileModal_Click(object sender, EventArgs e)
        {
            // profileModal.Visible = true;
        }

        // Profili Kaydetme
        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] is int userId && Page.IsValid)
            {
                UserDTO existingUser = _userService.GetById(userId);

                if (existingUser != null)
                {
                    // existingUser.Full_name = txtProfileName.Text;
                    // existingUser.Email = txtProfileEmail.Text;
                    // ...

                    if (_userService.Update(existingUser))
                    {
                        // Başarı mesajı göster ve sayfayı yenile
                        // Response.Redirect("UyePaneli.aspx?status=success");
                    }
                }
            }
        }

        // Modalı Kapatma
        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            // profileModal.Visible = false;
        }

        // Çıkış (Logout) Metodu
        protected void lnkCikisYap_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}