using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete; // ServiceService için
using NtpProje.Entities.DTOs; // ServiceDTO için

namespace NtpProje.pages.Admin
{
    public partial class hizmetekle : System.Web.UI.Page
    {
        // ============================================================
        // 1. MANUEL TANIMLAMALAR (Designer Hatasına Karşı)
        // ============================================================
        protected TextBox txtName;
        protected TextBox txtShortDescription;
        protected TextBox txtDescription;
        protected TextBox txtIcon;
        protected TextBox txtIconClass;
        protected TextBox txtImageUrl;
        protected TextBox txtSlug;
        protected TextBox txtDisplayOrder;
        protected TextBox txtViewCount;
        protected TextBox txtFeatures;
        protected TextBox txtTechnologies;
        protected TextBox txtProcessSteps;
        protected TextBox txtHighlightFeatures;
        protected TextBox txtWhyChooseUs;
        protected DropDownList ddlIsActive;
        protected FileUpload fileImageUpload;
        protected Button btnUploadImage;
        protected Button btnKaydet;
        protected Label lblDurumMesaj;
        protected Label lblUploadError;
        protected HiddenField hfServiceId;
        protected Literal ltrPageTitle;

        // ============================================================
        // 2. SERVİS BAĞLANTISI
        // ============================================================
        private readonly IBaseService<ServiceDTO> _serviceService = new ServiceService();

        // ============================================================
        // 3. PAGE_LOAD
        // ============================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            // Güvenlik Kontrolü
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ConfigurePage();
            }
        }

        // ============================================================
        // 4. SAYFA MODUNU AYARLA (EKLEME / DÜZENLEME)
        // ============================================================
        private void ConfigurePage()
        {
            string action = Request.QueryString["action"]; // 'add' veya 'edit'
            string idStr = Request.QueryString["id"];

            // Düzenleme Moduysa Verileri Getir
            if (action == "edit" && !string.IsNullOrEmpty(idStr) && int.TryParse(idStr, out int id))
            {
                ltrPageTitle.Text = "Hizmet";
                hfServiceId.Value = id.ToString();
                btnKaydet.Text = "🔄 Güncelle";

                LoadServiceData(id);
            }
            else
            {
                // Ekleme Modu
                ltrPageTitle.Text = "Hizmet";
                btnKaydet.Text = "💾 Kaydet";
                txtDisplayOrder.Text = "0";
                txtViewCount.Text = "0";
            }
        }

        // ============================================================
        // 5. HİZMET VERİSİNİ YÜKLE (Düzenleme için)
        // ============================================================
        private void LoadServiceData(int id)
        {
            try
            {
                var service = _serviceService.GetById(id);
                if (service != null)
                {
                    txtName.Text = service.Name ?? "";
                    txtShortDescription.Text = service.ShortDescription ?? "";
                    txtDescription.Text = service.Description ?? "";
                    txtIcon.Text = service.Icon ?? "";
                    txtIconClass.Text = service.IconClass ?? "";
                    txtImageUrl.Text = service.ImageUrl ?? "";
                    txtSlug.Text = service.Slug ?? "";
                    txtDisplayOrder.Text = service.DisplayOrder.ToString();
                    txtViewCount.Text = service.ViewCount.ToString();
                    
                    // Ek bilgiler
                    txtFeatures.Text = service.Features ?? "";
                    txtTechnologies.Text = service.Technologies ?? "";
                    txtProcessSteps.Text = service.ProcessSteps ?? "";
                    txtHighlightFeatures.Text = service.HighlightFeatures ?? "";
                    txtWhyChooseUs.Text = service.WhyChooseUs ?? "";

                    // Durum DropDown
                    if (ddlIsActive.Items.FindByValue(service.IsActive.ToString().ToLower()) != null)
                    {
                        ddlIsActive.SelectedValue = service.IsActive.ToString().ToLower();
                    }
                }
                else
                {
                    ShowMessage("Hizmet bulunamadı.", "error");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Veri yükleme hatası: " + ex.Message, "error");
            }
        }

        // ============================================================
        // 6. KAYDET BUTONU
        // ============================================================
        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string action = Request.QueryString["action"];
            bool isEdit = (action == "edit" && !string.IsNullOrEmpty(hfServiceId.Value));

            try
            {
                ServiceDTO serviceDTO = new ServiceDTO
                {
                    Name = txtName.Text.Trim(),
                    ShortDescription = txtShortDescription.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    Icon = txtIcon.Text.Trim(),
                    IconClass = txtIconClass.Text.Trim(),
                    ImageUrl = txtImageUrl.Text.Trim(),
                    Slug = txtSlug.Text.Trim(),
                    IsActive = ddlIsActive.SelectedValue == "true",
                    DisplayOrder = int.TryParse(txtDisplayOrder.Text, out int order) ? order : 0,
                    // Ek bilgiler
                    Features = txtFeatures.Text.Trim(),
                    Technologies = txtTechnologies.Text.Trim(),
                    ProcessSteps = txtProcessSteps.Text.Trim(),
                    HighlightFeatures = txtHighlightFeatures.Text.Trim(),
                    WhyChooseUs = txtWhyChooseUs.Text.Trim()
                };

                bool success = false;

                if (isEdit && int.TryParse(hfServiceId.Value, out int serviceId))
                {
                    // Düzenleme
                    serviceDTO.Id = serviceId;
                    serviceDTO.ViewCount = int.TryParse(txtViewCount.Text, out int viewCount) ? viewCount : 0;
                    
                    // Slug boşsa otomatik oluştur
                    if (string.IsNullOrEmpty(serviceDTO.Slug))
                    {
                        serviceDTO.Slug = GenerateSlug(serviceDTO.Name);
                    }

                    success = _serviceService.Update(serviceDTO);
                    
                    if (success)
                    {
                        ShowMessage("Hizmet başarıyla güncellendi.", "success");
                        Response.Redirect("hizmetynt.aspx?success=1");
                    }
                    else
                    {
                        ShowMessage("Hizmet güncellenirken bir hata oluştu.", "error");
                    }
                }
                else
                {
                    // Ekleme
                    serviceDTO.ViewCount = 0;
                    
                    // Slug boşsa otomatik oluştur
                    if (string.IsNullOrEmpty(serviceDTO.Slug))
                    {
                        serviceDTO.Slug = GenerateSlug(serviceDTO.Name);
                    }

                    success = _serviceService.Add(serviceDTO);
                    
                    if (success)
                    {
                        ShowMessage("Hizmet başarıyla eklendi.", "success");
                        Response.Redirect("hizmetynt.aspx?success=1");
                    }
                    else
                    {
                        ShowMessage("Hizmet eklenirken bir hata oluştu.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Hizmet Kaydetme Hatası: " + ex.Message);
            }
        }

        // ============================================================
        // 7. RESİM YÜKLEME
        // ============================================================
        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            try
            {
                if (fileImageUpload.HasFile)
                {
                    // Dosya kontrolü
                    string fileName = fileImageUpload.FileName;
                    string fileExtension = Path.GetExtension(fileName).ToLower();
                    string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

                    if (!allowedExtensions.Contains(fileExtension))
                    {
                        lblUploadError.Text = "Sadece JPG, PNG, GIF veya WEBP formatında dosya yükleyebilirsiniz.";
                        lblUploadError.Visible = true;
                        lblUploadError.CssClass = "form-error";
                        return;
                    }

                    // Dosya boyutu kontrolü (5MB)
                    if (fileImageUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                    {
                        lblUploadError.Text = "Dosya boyutu 5MB'dan büyük olamaz.";
                        lblUploadError.Visible = true;
                        lblUploadError.CssClass = "form-error";
                        return;
                    }

                    // Dosya adını oluştur (benzersiz)
                    string uniqueFileName = Guid.NewGuid().ToString() + fileExtension;
                    string uploadPath = Server.MapPath("~/images/");
                    
                    // Klasör yoksa oluştur
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    string fullPath = Path.Combine(uploadPath, uniqueFileName);
                    fileImageUpload.SaveAs(fullPath);

                    // TextBox'a dosya adını yaz
                    txtImageUrl.Text = uniqueFileName;
                    lblUploadError.Visible = false;
                    
                    ShowMessage("Resim başarıyla yüklendi: " + uniqueFileName, "success");
                }
                else
                {
                    lblUploadError.Text = "Lütfen bir dosya seçin.";
                    lblUploadError.Visible = true;
                    lblUploadError.CssClass = "form-error";
                }
            }
            catch (Exception ex)
            {
                lblUploadError.Text = "Resim yüklenirken hata: " + ex.Message;
                lblUploadError.Visible = true;
                lblUploadError.CssClass = "form-error";
                System.Diagnostics.Debug.WriteLine("Resim Yükleme Hatası: " + ex.Message);
            }
        }

        // ============================================================
        // 8. YARDIMCI METODLAR
        // ============================================================

        // Slug oluşturma
        private string GenerateSlug(string text)
        {
            if (string.IsNullOrEmpty(text))
                return "";

            string slug = text.ToLower()
                .Replace(" ", "-")
                .Replace("ş", "s").Replace("Ş", "s")
                .Replace("ğ", "g").Replace("Ğ", "g")
                .Replace("ü", "u").Replace("Ü", "u")
                .Replace("ı", "i").Replace("İ", "i")
                .Replace("ö", "o").Replace("Ö", "o")
                .Replace("ç", "c").Replace("Ç", "c");

            // Özel karakterleri temizle
            char[] invalidChars = Path.GetInvalidFileNameChars();
            foreach (char c in invalidChars)
            {
                slug = slug.Replace(c.ToString(), "");
            }

            // Çoklu tireleri tek tireye çevir
            while (slug.Contains("--"))
            {
                slug = slug.Replace("--", "-");
            }

            // Başta ve sonda tire varsa kaldır
            slug = slug.Trim('-');

            return slug;
        }

        // Mesaj gösterme
        private void ShowMessage(string message, string type)
        {
            if (lblDurumMesaj != null)
            {
                lblDurumMesaj.Text = message;
                lblDurumMesaj.CssClass = "alert-message " + type;
                lblDurumMesaj.Visible = true;
            }
        }
    }
}
