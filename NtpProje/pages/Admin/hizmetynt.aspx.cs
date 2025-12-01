using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete; // ServiceService için
using NtpProje.Entities.Concrete; // ServiceDTO için

namespace NtpProje.pages.Admin
{
    public partial class hizmetynt : BaseAdminPage
    {
        // ============================================================
        // 1. MANUEL TANIMLAMALAR (Designer Hatasına Karşı)
        // ============================================================
        // HTML tarafında kullandığınız kontrollerin ID'lerini buraya ekleyin
        // Örnek: Repeater, Literal, Label, PlaceHolder, Button vb.
        
        


        // ============================================================
        // 2. SERVİS BAĞLANTISI
        // ============================================================
        // ServiceService, veritabanı işlemlerini yönetir
        private readonly IBaseService<ServiceDTO> _serviceService = new ServiceService();


        // ============================================================
        // 3. OVERRIDE METODLAR (BaseAdminPage'den türetilmiş)
        // ============================================================

        /// <summary>
        /// Page_Load event handler (BaseAdminPage mantığını çağırır)
        /// </summary>
        

        /// <summary>
        /// Sayfa ilk yüklendiğinde çalışır (BaseAdminPage'den override)
        /// </summary>
        protected override void OnPageLoadFirstTime()
        {
            // Query string'den başarı mesajını kontrol et
            CheckSuccessMessage();

            // Verileri yükle
            LoadServices();
        }

        /// <summary>
        /// Mesaj gösterir (BaseAdminPage'den override)
        /// </summary>
        protected override void ShowMessage(string message, string type)
        {
            // type: "success", "error", "warning", "info"
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.CssClass = "message-alert " + type + " visible";
                lblMessage.Visible = true;
            }
        }


        // ============================================================
        // 4. VERİ YÜKLEME METODU
        // ============================================================
        private void LoadServices()
        {
            try
            {
                // ServiceService'den tüm hizmetleri çek
                var services = _serviceService.GetAll();

                // DisplayOrder'a göre sırala, sonra isme göre
                if (services != null)
                {
                    services = services.OrderBy(s => s.DisplayOrder).ThenBy(s => s.Name).ToList();
                }

                // Repeater'a verileri bağla
                if (rptServices != null)
                {
                    rptServices.DataSource = services;
                    rptServices.DataBind();
                }

                // Toplam sayıyı göster
                int totalCount = services != null ? services.Count : 0;
                if (ltrTotalServices != null)
                {
                    ltrTotalServices.Text = totalCount.ToString();
                }
                
                // Sidebar toplam sayı
                if (ltrTotalServicesSidebar != null)
                {
                    ltrTotalServicesSidebar.Text = totalCount.ToString();
                }
                
                // Aktif ve pasif hizmet sayılarını göster
                int activeCount = services != null ? services.Count(s => s.IsActive) : 0;
                int inactiveCount = services != null ? services.Count(s => !s.IsActive) : 0;
                
                if (ltrActiveServices != null)
                {
                    ltrActiveServices.Text = activeCount.ToString();
                }
                
                if (ltrInactiveServices != null)
                {
                    ltrInactiveServices.Text = inactiveCount.ToString();
                }

                // Boş durum kontrolü
                if (phEmpty != null)
                {
                    phEmpty.Visible = (services == null || services.Count == 0);
                }

                if (rptServices != null)
                {
                    rptServices.Visible = (services != null && services.Count > 0);
                }
            }
            catch (Exception ex)
            {
                // Hata durumunda mesaj göster
                ShowMessage("Hata: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Hizmet Yükleme Hatası: " + ex.Message);
            }
        }


        // ============================================================
        // 5. REPEATER ITEM COMMAND (Silme, Düzenleme vb. İşlemler)
        // ============================================================
        // HTML tarafında Repeater'da OnItemCommand="rptServices_ItemCommand" ekleyin
        protected void rptServices_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                // CommandArgument'ten ID'yi al
                if (!int.TryParse(e.CommandArgument.ToString(), out int serviceId))
                {
                    ShowMessage("Geçersiz hizmet ID'si.", "error");
                    return;
                }

                string commandName = e.CommandName;

                // Silme işlemi
                if (commandName == "Delete")
                {
                    bool deleted = _serviceService.Delete(serviceId);
                    if (deleted)
                    {
                        ShowMessage("Hizmet başarıyla silindi.", "success");
                        LoadServices(); // Listeyi yenile
                    }
                    else
                    {
                        ShowMessage("Hizmet silinirken bir hata oluştu.", "error");
                    }
                }
                // Aktif/Pasif yapma işlemi
                else if (commandName == "ToggleActive")
                {
                    var service = _serviceService.GetById(serviceId);
                    if (service != null)
                    {
                        service.IsActive = !service.IsActive;
                        bool updated = _serviceService.Update(service);
                        if (updated)
                        {
                            ShowMessage("Hizmet durumu güncellendi.", "success");
                            LoadServices(); // Listeyi yenile
                        }
                        else
                        {
                            ShowMessage("Durum güncellenirken bir hata oluştu.", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Hizmet İşlem Hatası: " + ex.Message);
            }
        }


        // ============================================================
        // 6. REPEATER ITEM DATA BOUND (Veri Bağlandığında)
        // ============================================================
        // HTML tarafında Repeater'da OnItemDataBound="rptServices_ItemDataBound" ekleyin
        // İç içe Repeater kullanıyorsanız bu metodu kullanabilirsiniz
        protected void rptServices_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Sadece Item ve AlternatingItem için işlem yap
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // DataItem'dan ServiceDTO'yu al
                var service = e.Item.DataItem as ServiceDTO;

                // İçerideki kontrolleri bulup işlem yapabilirsiniz
                // Şu an için gerekli değil, HTML tarafında Eval kullanıyoruz
            }
        }


        // ============================================================
        // 7. ARAMA/FİLTRELEME METODLARI
        // ============================================================
        // HTML'de arama TextBox'ı ve Button'ı varsa
        protected void btnAra_Click(object sender, EventArgs e)
        {
            string aramaMetni = txtArama != null ? txtArama.Text.Trim() : "";
            
            try
            {
                var services = _serviceService.GetAll();
                
                // Arama metnine göre filtrele
                if (!string.IsNullOrEmpty(aramaMetni))
                {
                    string aramaLower = aramaMetni.ToLower();
                    services = services.Where(s => 
                        (s.Name != null && s.Name.ToLower().Contains(aramaLower)) || 
                        (s.Description != null && s.Description.ToLower().Contains(aramaLower)) ||
                        (s.ShortDescription != null && s.ShortDescription.ToLower().Contains(aramaLower))
                    ).ToList();
                }
                
                // DisplayOrder'a göre sırala
                if (services != null)
                {
                    services = services.OrderBy(s => s.DisplayOrder).ThenBy(s => s.Name).ToList();
                }
                
                // Repeater'a bağla
                if (rptServices != null)
                {
                    rptServices.DataSource = services;
                    rptServices.DataBind();
                }
                
                // İstatistikleri güncelle
                int totalCount = services != null ? services.Count : 0;
                if (ltrTotalServicesSidebar != null)
                {
                    ltrTotalServicesSidebar.Text = totalCount.ToString();
                }
                
                // Boş durum kontrolü
                if (phEmpty != null)
                {
                    phEmpty.Visible = (services == null || services.Count == 0);
                }

                if (rptServices != null)
                {
                    rptServices.Visible = (services != null && services.Count > 0);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Arama sırasında hata: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Arama Hatası: " + ex.Message);
            }
        }


        // ============================================================
        // 8. YARDIMCI METODLAR
        // ============================================================
        
        // Not: ShowMessage metodu artık BaseAdminPage'de virtual olarak tanımlı
        // ve yukarıda override edildi. Burada tekrar tanımlamaya gerek yok.

        // Resim URL'sini düzenleme metodu (HTML'de kullanmak için)
        public string GetImageUrl(object imageUrl)
        {
            if (imageUrl == null || string.IsNullOrEmpty(imageUrl.ToString()))
                return ResolveUrl("~/images/default-service.jpg"); // Varsayılan resim

            string url = imageUrl.ToString();

            // Eğer zaten tam URL ise (http:// veya / ile başlıyorsa) olduğu gibi döndür
            if (url.StartsWith("http://") || url.StartsWith("https://") || url.StartsWith("/"))
            {
                return url;
            }

            // Sadece dosya adı ise /images/ prefix'i ekle
            return ResolveUrl("~/images/" + url);
        }

        // Service Image HTML'i oluştur (ASPX'te kullanmak için)
        public string GetServiceImage(object imageUrl, object icon, object name)
        {
            string imageUrlStr = imageUrl != null ? imageUrl.ToString() : "";
            string iconStr = icon != null ? icon.ToString() : "";
            string nameStr = name != null ? name.ToString() : "";

            if (string.IsNullOrEmpty(imageUrlStr))
            {
                // Resim yoksa ikon göster
                string displayIcon = string.IsNullOrEmpty(iconStr) ? "📦" : iconStr;
                return "<span>" + displayIcon + "</span>";
            }
            else
            {
                // Resim varsa img tag'i oluştur
                string imgUrl = GetImageUrl(imageUrl);
                return "<img src='" + imgUrl + "' alt='" + nameStr + "' />";
            }
        }

        // Kısa açıklamayı formatla (HTML'de kullanmak için)
        public string FormatShortDescription(object shortDesc)
        {
            if (shortDesc == null || string.IsNullOrEmpty(shortDesc.ToString()))
                return "";

            string desc = shortDesc.ToString();
            
            // Maksimum karakter sayısı (isteğe bağlı)
            // if (desc.Length > 150)
            // {
            //     desc = desc.Substring(0, 150) + "...";
            // }

            return desc;
        }

        // Formatlanmış açıklama döndür (ASPX'te kullanmak için)
        public string GetFormattedDescription(object shortDesc)
        {
            return FormatShortDescription(shortDesc);
        }
    }
}
