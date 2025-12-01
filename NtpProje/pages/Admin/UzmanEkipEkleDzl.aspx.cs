using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

namespace NtpProje_Web.Admin
{
    public partial class UzmanEkipEkleDzl : System.Web.UI.Page
    {
        // Manuel tanımlamalar
        protected global::System.Web.UI.WebControls.TextBox txtName;
        protected global::System.Web.UI.WebControls.TextBox txtTitle;
        protected global::System.Web.UI.WebControls.TextBox txtPosition;
        protected global::System.Web.UI.WebControls.TextBox txtBio;
        protected global::System.Web.UI.WebControls.TextBox txtEmail;
        protected global::System.Web.UI.WebControls.TextBox txtPhone;
        protected global::System.Web.UI.WebControls.TextBox txtLinkedIn;
        protected global::System.Web.UI.WebControls.TextBox txtTwitter;
        protected global::System.Web.UI.WebControls.TextBox txtGithub;
        protected global::System.Web.UI.WebControls.TextBox txtImageUrl;
        protected global::System.Web.UI.WebControls.FileUpload fileImageUpload;
        protected global::System.Web.UI.WebControls.Button btnUploadImage;
        protected global::System.Web.UI.WebControls.Label lblUploadError;
        protected global::System.Web.UI.WebControls.DropDownList ddlIsActive;
        protected global::System.Web.UI.WebControls.TextBox txtDisplayOrder;
        protected global::System.Web.UI.WebControls.HiddenField hfMemberId;
        protected global::System.Web.UI.WebControls.Label lblMessage;
        protected global::System.Web.UI.WebControls.Literal ltrPageTitle;
 
        private readonly IBaseService<TeamMemberDTO> _teamService = new TeamMemberService();
        private bool _isEditMode = false;
        private int _memberId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Güvenlik kontrolü
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Action ve ID parametrelerini kontrol et
            string action = Request.QueryString["action"];
            string idParam = Request.QueryString["id"];

            _isEditMode = (action == "edit" && !string.IsNullOrEmpty(idParam));

            if (_isEditMode)
            {
                if (int.TryParse(idParam, out _memberId))
                {
                    if (hfMemberId != null)
                        hfMemberId.Value = _memberId.ToString();
                    if (ltrPageTitle != null)
                        ltrPageTitle.Text = "Ekip Üyesi";
                }
                else
                {
                    ShowMessage("Geçersiz ekip üyesi ID'si.", "error");
                    return;
                }
            }
            else
            {
                // PostBack'te HiddenField'den ID'yi kontrol et
                if (IsPostBack && hfMemberId != null && !string.IsNullOrEmpty(hfMemberId.Value))
                {
                    if (int.TryParse(hfMemberId.Value, out _memberId) && _memberId > 0)
                    {
                        _isEditMode = true;
                    }
                }

                if (ltrPageTitle != null)
                    ltrPageTitle.Text = "Yeni Ekip Üyesi";
            }

            if (!IsPostBack)
            {
                if (_isEditMode)
                {
                    LoadMemberData();
                }
                else
                {
                    // Yeni ekleme modunda formu varsayılan değerlerle doldur
                    ClearForm();
                }
            }
        }

        private void LoadMemberData()
        {
            try
            {
                if (_memberId <= 0)
                {
                    ShowMessage("Geçersiz ekip üyesi ID'si.", "error");
                    Response.Redirect("uzmanekp.aspx");
                    return;
                }

                var member = _teamService.GetById(_memberId);
                if (member == null)
                {
                    ShowMessage("Ekip üyesi bulunamadı.", "error");
                    Response.Redirect("uzmanekp.aspx");
                    return;
                }

                // Form alanlarını doldur - null kontrolleri ile
                if (txtName != null) txtName.Text = member.Name ?? "";
                if (txtTitle != null) txtTitle.Text = member.Title ?? "";
                if (txtPosition != null) txtPosition.Text = member.Position ?? "";
                if (txtBio != null) txtBio.Text = member.Bio ?? "";
                if (txtEmail != null) txtEmail.Text = member.Email ?? "";
                if (txtPhone != null) txtPhone.Text = member.PhoneNumber ?? "";
                if (txtLinkedIn != null) txtLinkedIn.Text = member.LinkedInUrl ?? "";
                if (txtTwitter != null) txtTwitter.Text = member.TwitterUrl ?? "";
                if (txtGithub != null) txtGithub.Text = member.GithubUrl ?? "";
                if (txtImageUrl != null)
                {
                    txtImageUrl.Text = member.ImageUrl ?? "";
                    // Mevcut görsel varsa önizleme göster
                    if (!string.IsNullOrEmpty(member.ImageUrl))
                    {
                        string previewUrl = member.ImageUrl;
                        if (!previewUrl.StartsWith("http://") && !previewUrl.StartsWith("https://"))
                        {
                            previewUrl = previewUrl.StartsWith("/") ? previewUrl : "/" + previewUrl;
                        }
                        ClientScript.RegisterStartupScript(this.GetType(), "ShowExistingImage",
                            "var preview = document.getElementById('imagePreview'); " +
                            "var previewImg = document.getElementById('previewImg'); " +
                            "if (previewImg) { previewImg.src = '" + previewUrl + "'; } " +
                            "if (preview) { preview.style.display = 'block'; }", true);
                    }
                }
                if (txtDisplayOrder != null) txtDisplayOrder.Text = member.DisplayOrder.ToString();
                if (hfMemberId != null) hfMemberId.Value = member.Id.ToString();

                if (ddlIsActive != null)
                {
                    ddlIsActive.SelectedValue = member.IsActive ? "true" : "false";
                }

                // Sayfa başlığını güncelle
                if (ltrPageTitle != null)
                {
                    ltrPageTitle.Text = member.Name ?? "Ekip Üyesi";
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Veri yüklenirken hata oluştu: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Ekip Üyesi Yükleme Hatası: " + ex.Message + " | Stack: " + ex.StackTrace);
            }
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            Page.Validate("MainForm");
            if (!Page.IsValid)
                return;

            try
            {
                TeamMemberDTO member;

                if (_isEditMode && int.TryParse(hfMemberId.Value, out _memberId))
                {
                    // Düzenleme modu
                    member = _teamService.GetById(_memberId);
                    if (member == null)
                    {
                        ShowMessage("Ekip üyesi bulunamadı.", "error");
                        return;
                    }
                }
                else
                {
                    // Yeni ekleme modu
                    member = new TeamMemberDTO();
                }

                // Form verilerini DTO'ya aktar
                member.Name = txtName.Text.Trim();
                member.Title = txtTitle.Text.Trim();
                member.Position = txtPosition.Text.Trim();
                member.Bio = txtBio.Text.Trim();
                member.Email = txtEmail.Text.Trim();
                member.PhoneNumber = txtPhone.Text.Trim();
                member.LinkedInUrl = txtLinkedIn.Text.Trim();
                member.TwitterUrl = txtTwitter.Text.Trim();
                member.GithubUrl = txtGithub.Text.Trim();
                
                // ImageUrl - önce FileUpload kontrolü, yoksa TextBox
                if (fileImageUpload != null && fileImageUpload.HasFile && !string.IsNullOrEmpty(fileImageUpload.PostedFile.FileName))
                {
                    // Eğer yeni dosya yüklenmişse, önce yükle
                    // (btnUploadImage_Click zaten çağrılmış olabilir, ama emin olmak için)
                    // Burada sadece txtImageUrl'den okuyoruz çünkü yükleme işlemi btnUploadImage_Click'te yapılıyor
                }
                
                // ImageUrl'i al - FileUpload'tan veya TextBox'tan
                member.ImageUrl = !string.IsNullOrEmpty(txtImageUrl.Text.Trim()) ? txtImageUrl.Text.Trim() : "";
                
                member.IsActive = ddlIsActive.SelectedValue == "true";

                if (int.TryParse(txtDisplayOrder.Text, out int displayOrder))
                {
                    member.DisplayOrder = displayOrder;
                }
                else
                {
                    member.DisplayOrder = 0;
                }

                bool success = false;

                if (_isEditMode)
                {
                    // Güncelleme
                    success = _teamService.Update(member);
                    if (success)
                    {
                        // Başarılı güncelleme sonrası liste sayfasına yönlendir
                        Response.Redirect("uzmanekp.aspx?success=1&action=updated");
                    }
                    else
                    {
                        ShowMessage("Güncelleme sırasında bir hata oluştu.", "error");
                    }
                }
                else
                {
                    // Yeni ekleme
                    success = _teamService.Add(member);
                    if (success)
                    {
                        ShowMessage("Ekip üyesi başarıyla eklendi.", "success");
                        // Formu temizle
                        ClearForm();
                        // Liste sayfasına yönlendir
                        Response.Redirect("uzmanekp.aspx?success=1");
                    }
                    else
                    {
                        ShowMessage("Ekleme sırasında bir hata oluştu.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Ekip Üyesi Kayıt Hatası: " + ex.Message);
            }
        }

        private void ClearForm()
        {
            if (txtName != null) txtName.Text = "";
            if (txtTitle != null) txtTitle.Text = "";
            if (txtPosition != null) txtPosition.Text = "";
            if (txtBio != null) txtBio.Text = "";
            if (txtEmail != null) txtEmail.Text = "";
            if (txtPhone != null) txtPhone.Text = "";
            if (txtLinkedIn != null) txtLinkedIn.Text = "";
            if (txtTwitter != null) txtTwitter.Text = "";
            if (txtGithub != null) txtGithub.Text = "";
            if (txtImageUrl != null) txtImageUrl.Text = "";
            if (txtDisplayOrder != null) txtDisplayOrder.Text = "0";
            if (ddlIsActive != null) ddlIsActive.SelectedValue = "true";
            if (hfMemberId != null) hfMemberId.Value = "";
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            try
            {
                if (fileImageUpload != null && fileImageUpload.HasFile)
                {
                    // Dosya boyutu kontrolü (5MB)
                    if (fileImageUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        if (lblUploadError != null)
                        {
                            lblUploadError.Text = "❌ Dosya boyutu 5MB'dan büyük olamaz!";
                            lblUploadError.CssClass = "form-error";
                            lblUploadError.Visible = true;
                        }
                        return;
                    }

                    // Dosya uzantısı kontrolü
                    string fileExtension = Path.GetExtension(fileImageUpload.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

                    if (!allowedExtensions.Contains(fileExtension))
                    {
                        if (lblUploadError != null)
                        {
                            lblUploadError.Text = "❌ Sadece JPG, PNG, GIF veya WEBP formatında dosya yükleyebilirsiniz!";
                            lblUploadError.CssClass = "form-error";
                            lblUploadError.Visible = true;
                        }
                        return;
                    }

                    // Resmi direkt images/logo klasörüne kaydet
                    string saveFolder = Server.MapPath("~/images/logo/");
                    string relativePath = "images/logo/";

                    // Klasör yoksa oluştur
                    if (!Directory.Exists(saveFolder))
                    {
                        Directory.CreateDirectory(saveFolder);
                    }

                    // Benzersiz dosya adı oluştur (tarih + rastgele sayı + orijinal dosya adı)
                    string originalFileName = Path.GetFileNameWithoutExtension(fileImageUpload.FileName);
                    string safeFileName = originalFileName.Replace(" ", "-").Replace("_", "-");
                    // Türkçe karakterleri temizle
                    safeFileName = Regex.Replace(safeFileName, @"[^a-zA-Z0-9\-]", "");
                    string fileName = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + safeFileName + fileExtension;

                    // Dosya yolunu oluştur
                    string filePath = Path.Combine(saveFolder, fileName);

                    // Dosyayı kaydet
                    fileImageUpload.SaveAs(filePath);

                    // Mutlak URL oluştur (tam URL)
                    string scheme = Request.Url.Scheme; // http veya https
                    string authority = Request.Url.Authority; // localhost:44329
                    string relativeUrl = ResolveUrl("~/" + relativePath + fileName);
                    // ResolveUrl zaten "/" ile başlayan bir yol döndürür
                    string absoluteUrl = scheme + "://" + authority + relativeUrl;

                    // Veritabanında mutlak URL saklanacak
                    string dbPath = absoluteUrl;

                    // TextBox'a mutlak URL yaz
                    if (txtImageUrl != null)
                    {
                        txtImageUrl.Text = dbPath;
                    }

                    // Başarı mesajı
                    if (lblUploadError != null)
                    {
                        lblUploadError.Text = "✅ Resim başarıyla logo klasörüne yüklendi: " + fileName;
                        lblUploadError.CssClass = "form-error success-message";
                        lblUploadError.Visible = true;
                    }

                    // Önizleme için tam URL kullan
                    string previewUrl = absoluteUrl;

                    // JavaScript ile önizlemeyi göster
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowPreview",
                        "var preview = document.getElementById('imagePreview'); " +
                        "var previewImg = document.getElementById('previewImg'); " +
                        "if (previewImg) { previewImg.src = '" + previewUrl + "'; } " +
                        "if (preview) { preview.style.display = 'block'; }", true);
                }
                else
                {
                    if (lblUploadError != null)
                    {
                        lblUploadError.Text = "❌ Lütfen bir dosya seçin!";
                        lblUploadError.CssClass = "form-error";
                        lblUploadError.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                if (lblUploadError != null)
                {
                    lblUploadError.Text = "❌ Resim yüklenirken hata oluştu: " + ex.Message;
                    lblUploadError.CssClass = "form-error";
                    lblUploadError.Visible = true;
                }
                System.Diagnostics.Debug.WriteLine("Resim Yükleme Hatası: " + ex.Message + " | Stack: " + ex.StackTrace);
            }
        }

        private void ShowMessage(string message, string type)
        {
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.CssClass = "alert-message " + type;
                lblMessage.Visible = true;
            }
        }
    }
}
