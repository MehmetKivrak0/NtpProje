# BaseAdminPage.cs İçeriği

Aşağıdaki kodu `NtpProje/pages/Admin/BaseAdminPage.cs` dosyasına kopyalayın.

```csharp
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NtpProje.pages.Admin
{
    /// <summary>
    /// Admin sayfaları için base class.
    /// Tüm admin sayfaları bu class'tan türeyebilir ve virtual metodları override edebilir.
    /// </summary>
    public abstract class BaseAdminPage : System.Web.UI.Page
    {
        // ============================================================
        // VIRTUAL METODLAR (Override edilebilir)
        // ============================================================

        /// <summary>
        /// Sayfa yüklendiğinde çalışır. Override edilebilir.
        /// </summary>
        protected virtual void OnPageLoad()
        {
            // Base implementation - boş bırakıldı, override edilebilir
        }

        /// <summary>
        /// Sayfa ilk yüklendiğinde (PostBack değilken) çalışır. Override edilebilir.
        /// </summary>
        protected virtual void OnPageLoadFirstTime()
        {
            // Base implementation - boş bırakıldı, override edilebilir
        }

        /// <summary>
        /// Güvenlik kontrolü yapar. Override edilebilir.
        /// </summary>
        protected virtual bool CheckSecurity()
        {
            // Varsayılan güvenlik kontrolü
            return Session["AdminUser"] != null;
        }

        /// <summary>
        /// Güvenlik kontrolü başarısız olduğunda çalışır. Override edilebilir.
        /// </summary>
        protected virtual void OnSecurityCheckFailed()
        {
            Response.Redirect("~/Login.aspx");
        }

        /// <summary>
        /// Mesaj gösterir. Override edilebilir.
        /// </summary>
        protected virtual void ShowMessage(string message, string type)
        {
            // Base implementation - Label kontrolü yok, override edilmeli
            // Alt sınıflarda lblMessage kontrolü varsa override edilir
        }

        // ============================================================
        // PAGE_LOAD EVENT HANDLER (Override edilemez, ama virtual metodları çağırır)
        // ============================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Güvenlik kontrolü
            if (!CheckSecurity())
            {
                OnSecurityCheckFailed();
                return;
            }

            // 2. Base OnPageLoad çağrısı
            OnPageLoad();

            // 3. İlk yüklemede OnPageLoadFirstTime çağrısı
            if (!IsPostBack)
            {
                OnPageLoadFirstTime();
            }
        }

        // ============================================================
        // YARDIMCI METODLAR (Override edilebilir)
        // ============================================================

        /// <summary>
        /// Query string'den başarı mesajını kontrol eder. Override edilebilir.
        /// </summary>
        protected virtual void CheckSuccessMessage()
        {
            if (Request.QueryString["success"] == "1")
            {
                ShowMessage("İşlem başarıyla tamamlandı.", "success");
            }
        }
    }
}
```

## Kullanım Örneği (hizmetynt.aspx.cs)

```csharp
namespace NtpProje.pages.Admin
{
    public partial class hizmetynt : BaseAdminPage  // ← BaseAdminPage'den türüyor
    {
        // Override edilen metodlar:
        protected override void OnPageLoadFirstTime()
        {
            CheckSuccessMessage();
            LoadServices();
        }
        
        protected override void ShowMessage(string message, string type)
        {
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.CssClass = "message-alert " + type + " visible";
                lblMessage.Visible = true;
            }
        }
        
        // Diğer metodlar...
    }
}
```

## Notlar

- `BaseAdminPage` abstract class olduğu için doğrudan instance oluşturulamaz
- Sadece bu class'tan türeyen sayfalar etkilenir
- Diğer sayfalar (`admin_dashboard`, `YaziYonetimi` vb.) normal çalışmaya devam eder
- Virtual metodlar override edilmese bile çalışır (boş implementation)

