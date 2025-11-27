using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using NtpProje.Business.Concrete; // Servisler
using NtpProje.Entities.Concrete; // DTO'lar

namespace NtpProje_Web.Admin
{
    public partial class YaziEkleDuzenle : System.Web.UI.Page
    {
        // ---------------------------------------------------------
        // 1. MANUEL TANIMLAMALAR (Designer Hatasını Önlemek İçin)
        // ---------------------------------------------------------
        protected TextBox txtQuickCategoryName;
        protected TextBox txtQuickCategoryDesc;
        protected Label lblQuickCategoryError;
        protected Panel quickCategoryModal;
        protected Button btnSaveQuickCategory;
        protected FileUpload fileImageUpload;
        protected Button btnUploadImage;
        protected Label lblUploadError;

        // ---------------------------------------------------------
        // 2. SERVİSLERİ ÇAĞIRIYORUZ
        // ---------------------------------------------------------
        private readonly PostService _postService = new PostService();
        private readonly ProjectService _projectService = new ProjectService();
        private readonly CategoryService _categoryService = new CategoryService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // GÜVENLİK KONTROLÜ
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Varsayılan Değerler
                txtAuthor.Text = Session["FullName"] != null ? Session["FullName"].ToString() : "Admin";
                txtPublishDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                // Sayfa Yükleme İşlemleri
                LoadCategories();
                ConfigurePage();
            }
        }

        // --- KATEGORİLERİ DOLDUR ---
        private void LoadCategories()
        {
            try
            {
                var categories = _categoryService.GetAll();
                ddlKategori.DataSource = categories;
                ddlKategori.DataTextField = "Name"; // Görünen isim
                ddlKategori.DataValueField = "Id"; // Arka plandaki değer
                ddlKategori.DataBind();

                ddlKategori.Items.Insert(0, new ListItem("Kategori Seçiniz", "0"));
            }
            catch
            {
                lblDurumMesaj.Text = "Kategoriler yüklenirken hata oluştu.";
                lblDurumMesaj.Visible = true;
            }
        }

        // --- SAYFA MODUNU AYARLA (EKLEME / DÜZENLEME) ---
        private void ConfigurePage()
        {
            string type = Request.QueryString["type"]; // 'post' veya 'project'
            string action = Request.QueryString["action"]; // 'add' veya 'edit'
            string idStr = Request.QueryString["id"];

            // 1. Görünümü Ayarla
            if (type == "project")
            {
                ltrPageTitle.Text = "Proje";
                pnlProjectFields.Visible = true; // Proje alanlarını aç
            }
            else // Varsayılan: Blog Yazısı
            {
                ltrPageTitle.Text = "Blog Yazısı";
                pnlProjectFields.Visible = false; // Proje alanlarını gizle
            }

            // 2. Düzenleme Moduysa Verileri Getir
            if (action == "edit" && !string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int id))
            {
                hfItemId.Value = id.ToString();
                btnKaydet.Text = "Güncelle"; // Buton yazısını değiştir

                if (type == "project")
                    LoadProjectData(id);
                else
                    LoadPostData(id);
            }
        }

        // --- BLOG VERİSİNİ YÜKLE ---
        private void LoadPostData(int id)
        {
            var post = _postService.GetById(id);
            if (post != null)
            {
                txtBaslik.Text = post.Title;
                txtOzet.Text = post.Summary;
                txtIcerik.Text = post.Content;
                txtImageUrl.Text = post.ImageUrl;
                txtSlug.Text = post.Slug;

                // Tarih Formatı (Input type=date için yyyy-MM-dd gerekli)
                if (post.PublishDate.HasValue)
                    txtPublishDate.Text = post.PublishDate.Value.ToString("yyyy-MM-dd");

                // Dropdown Seçimleri
                if (ddlKategori.Items.FindByValue(post.CategoryId.ToString()) != null)
                    ddlKategori.SelectedValue = post.CategoryId.ToString();

                if (ddlStatus.Items.FindByValue(post.Status) != null)
                    ddlStatus.SelectedValue = post.Status;
            }
        }

        // --- PROJE VERİSİNİ YÜKLE ---
        private void LoadProjectData(int id)
        {
            var project = _projectService.GetById(id);
            if (project != null)
            {
                txtBaslik.Text = project.Title;
                txtOzet.Text = project.Description; // Projelerde Description özet gibi kullanılır
                txtIcerik.Text = project.Description;
                txtImageUrl.Text = project.ImageUrl;

                // Projeye Özel Alanlar
                txtClientName.Text = project.ClientName;
                txtTechnologies.Text = project.Technologies;

                // Kategori - Artık CategoryId kullanıyoruz, yoksa eski Category string'inden bul
                if (project.CategoryId > 0)
                {
                    if (ddlKategori.Items.FindByValue(project.CategoryId.ToString()) != null)
                        ddlKategori.SelectedValue = project.CategoryId.ToString();
                }
                else if (!string.IsNullOrEmpty(project.Category))
                {
                    // Eski yapı: Kategori adından bul
                    ListItem item = ddlKategori.Items.FindByText(project.Category);
                    if (item != null) ddlKategori.SelectedValue = item.Value;
                }
            }
        }

        // --- KAYDET BUTONU (Ortak Event) ---
        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string type = Request.QueryString["type"];
            string action = Request.QueryString["action"];

            // Hangi butona basıldı? (Taslak mı Yayınla mı?)
            Button btn = (Button)sender;
            // Butonun CommandName'inden durumu belirliyoruz (draft veya publish)
            string statusCmd = btn.CommandName;

            string status = "Published"; // Varsayılan
            if (statusCmd == "draft") status = "Draft";
            if (type == "project" && statusCmd == "publish") status = "Tamamlandı";

            try
            {
                if (type == "project")
                {
                    SaveProject(action, status);
                }
                else
                {
                    SavePost(action, status);
                }

                // İşlem başarılıysa listeye yönlendir
                Response.Redirect("YaziYonetimi.aspx");
            }
            catch (Exception ex)
            {
                lblDurumMesaj.Text = "Hata oluştu: " + ex.Message;
                lblDurumMesaj.Visible = true;
                lblDurumMesaj.CssClass = "message error";
            }
        }

        // --- BLOG KAYDETME MANTIĞI ---
        private void SavePost(string action, string status)
        {
            PostDTO post = new PostDTO
            {
                Title = txtBaslik.Text,
                Summary = txtOzet.Text,
                Content = txtIcerik.Text,
                ImageUrl = txtImageUrl.Text,
                Slug = !string.IsNullOrEmpty(txtSlug.Text) ? txtSlug.Text : txtBaslik.Text.ToLower().Replace(" ", "-"),
                Status = status,
                CategoryId = int.Parse(ddlKategori.SelectedValue),
                UserId = Convert.ToInt32(Session["UserID"] ?? 1),
                ViewCount = 0,
                ReadingTime = 5
            };

            // Tarih Kontrolü
            if (DateTime.TryParse(txtPublishDate.Text, out DateTime pDate))
                post.PublishDate = pDate;
            else
                post.PublishDate = DateTime.Now;

            if (action == "edit")
            {
                post.Id = int.Parse(hfItemId.Value);
                _postService.Update(post);
            }
            else
            {
                _postService.Add(post);
            }
        }

        // --- PROJE KAYDETME MANTIĞI ---
        private void SaveProject(string action, string status)
        {
            ProjectDTO project = new ProjectDTO
            {
                Title = txtBaslik.Text,
                Description = txtOzet.Text, // Projelerde özet kısmını kullanıyoruz
                ImageUrl = txtImageUrl.Text,
                CategoryId = int.Parse(ddlKategori.SelectedValue), // Kategori ID'sini alıyoruz
                Category = ddlKategori.SelectedItem.Text, // Kategori adını da saklıyoruz (geriye dönük uyumluluk için)
                ClientName = txtClientName.Text,
                Technologies = txtTechnologies.Text,
                Status = status, // Status artık kaydediliyor
                ViewCount = 0
                // CompletionDate formda yok, gerekirse eklenebilir
            };

            if (action == "edit")
            {
                project.Id = int.Parse(hfItemId.Value);
                _projectService.Update(project);
            }
            else
            {
                _projectService.Add(project);
            }
        }

        // --- HIZLI KATEGORİ EKLEME (Server-Side - En Basit Yöntem) ---
        protected void btnSaveQuickCategory_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtQuickCategoryName.Text.Trim()))
                {
                    lblQuickCategoryError.Text = "Kategori adı zorunludur!";
                    lblQuickCategoryError.Visible = true;
                    return;
                }

                var categoryDTO = new CategoryDTO
                {
                    Name = txtQuickCategoryName.Text.Trim(),
                    Description = txtQuickCategoryDesc.Text.Trim()
                };

                bool success = _categoryService.Add(categoryDTO);

                if (success)
                {
                    // Kategorileri yeniden yükle
                    LoadCategories();
                    
                    // Yeni eklenen kategoriyi seç
                    var newCategory = _categoryService.GetAll()
                        .FirstOrDefault(c => c.Name == categoryDTO.Name);
                    if (newCategory != null)
                    {
                        ddlKategori.SelectedValue = newCategory.Id.ToString();
                    }

                    // Modal'ı kapat ve temizle
                    txtQuickCategoryName.Text = "";
                    txtQuickCategoryDesc.Text = "";
                    lblQuickCategoryError.Visible = false;
                    quickCategoryModal.Style["display"] = "none";
                    
                    // Başarı mesajı göster
                    lblDurumMesaj.Text = "✅ Kategori başarıyla eklendi!";
                    lblDurumMesaj.CssClass = "alert-message success";
                    lblDurumMesaj.Visible = true;
                }
                else
                {
                    lblQuickCategoryError.Text = "Kategori eklenirken hata oluştu. Lütfen tekrar deneyin.";
                    lblQuickCategoryError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblQuickCategoryError.Text = "Hata: " + ex.Message + (ex.InnerException != null ? " | " + ex.InnerException.Message : "");
                lblQuickCategoryError.Visible = true;
            }
        }

        // --- RESİM YÜKLEME ---
        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            try
            {
                if (fileImageUpload.HasFile)
                {
                    // Dosya boyutu kontrolü (5MB)
                    if (fileImageUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        lblUploadError.Text = "Dosya boyutu 5MB'dan büyük olamaz!";
                        lblUploadError.Visible = true;
                        return;
                    }

                    // Dosya uzantısı kontrolü
                    string fileExtension = Path.GetExtension(fileImageUpload.FileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
                    
                    if (!allowedExtensions.Contains(fileExtension))
                    {
                        lblUploadError.Text = "Sadece JPG, PNG, GIF veya WEBP formatında dosya yükleyebilirsiniz!";
                        lblUploadError.Visible = true;
                        return;
                    }

                    // Images klasörü yolu
                    string imagesFolder = Server.MapPath("~/images/");
                    
                    // Klasör yoksa oluştur
                    if (!Directory.Exists(imagesFolder))
                    {
                        Directory.CreateDirectory(imagesFolder);
                    }

                    // Benzersiz dosya adı oluştur (tarih + rastgele sayı)
                    string fileName = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + 
                                     Path.GetFileNameWithoutExtension(fileImageUpload.FileName) + 
                                     fileExtension;

                    // Dosya yolunu oluştur
                    string filePath = Path.Combine(imagesFolder, fileName);

                    // Dosyayı kaydet
                    fileImageUpload.SaveAs(filePath);

                    // Sadece dosya adını veritabanında sakla (URL değil)
                    txtImageUrl.Text = fileName;

                    // Başarı mesajı
                    lblUploadError.Text = "✅ Resim başarıyla yüklendi!";
                    lblUploadError.CssClass = "form-error success-message";
                    lblUploadError.Visible = true;

                    // Önizleme için tam URL oluştur
                    string previewUrl = ResolveUrl("~/images/" + fileName);
                    
                    // Önizlemeyi göster
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowPreview", 
                        "document.getElementById('previewImg').src = '" + previewUrl + "'; document.getElementById('imagePreview').style.display = 'block';", true);
                }
                else
                {
                    lblUploadError.Text = "Lütfen bir dosya seçin!";
                    lblUploadError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblUploadError.Text = "Resim yüklenirken hata oluştu: " + ex.Message;
                lblUploadError.Visible = true;
            }
        }
    }
}