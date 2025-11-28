using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

// MANTIK BURADA: HTML tarafında "NtpProje_Web.Admin.IletisimMesajlari" dedik.
// O yüzden burası da KESİNLİKLE "NtpProje_Web.Admin" olmak zorunda.
namespace NtpProje_Web.Admin
{
    public partial class IletisimMesajlari : System.Web.UI.Page
    {
        // 1. MANUEL TANIMLAMALAR (Designer hatasına karşı)
        protected global::System.Web.UI.WebControls.Repeater rptMessages;
        protected global::System.Web.UI.WebControls.Literal ltrTotalMessages;
        protected global::System.Web.UI.WebControls.Literal ltrUnreadMessages;
        protected global::System.Web.UI.WebControls.Literal ltrReadMessages;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmpty;

        // Proje Teklifleri için kontroller
        protected global::System.Web.UI.WebControls.Repeater rptProjectRequests;
        protected global::System.Web.UI.WebControls.Literal ltrTotalProjectRequests;
        protected global::System.Web.UI.WebControls.Literal ltrUnreadProjectRequests;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmptyProjectRequests;

        // İletişim Bilgileri için TextBox'lar
        protected global::System.Web.UI.WebControls.TextBox txtAdres;
        protected global::System.Web.UI.WebControls.TextBox txtTelefon;
        protected global::System.Web.UI.WebControls.TextBox txtEmail;
        protected global::System.Web.UI.WebControls.TextBox txtSaatler;
        protected global::System.Web.UI.WebControls.TextBox txtHaritaLink;
        protected global::System.Web.UI.WebControls.Label lblContactInfoMessage;
        protected global::System.Web.UI.WebControls.Panel pnlContactInfoForm;
        protected global::System.Web.UI.WebControls.Button btnKaydet;

        private readonly ContactMessageService _messageService = new ContactMessageService();
        private readonly SettingService _settingService = new SettingService();
        private readonly ProjectRequestService _projectRequestService = new ProjectRequestService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadMessages();
                LoadProjectRequests();
                LoadContactInfo();
            }
        }

        private void LoadMessages()
        {
            try
            {
                var messages = _messageService.GetAll().OrderByDescending(m => m.CreatedDate).ToList();

                if (ltrTotalMessages != null) ltrTotalMessages.Text = messages.Count.ToString();
                if (ltrUnreadMessages != null) ltrUnreadMessages.Text = messages.Count(m => !m.IsRead).ToString();
                if (ltrReadMessages != null) ltrReadMessages.Text = messages.Count(m => m.IsRead).ToString();

                if (messages.Count > 0)
                {
                    if (rptMessages != null)
                    {
                        rptMessages.DataSource = messages;
                        rptMessages.DataBind();
                        rptMessages.Visible = true;
                    }
                    if (phEmpty != null) phEmpty.Visible = false;
                }
                else
                {
                    if (rptMessages != null) rptMessages.Visible = false;
                    if (phEmpty != null) phEmpty.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Hata: " + ex.Message);
            }
        }

        protected void rptMessages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(e.CommandArgument.ToString(), out int id)) return;

            if (e.CommandName == "Delete")
            {
                _messageService.Delete(id);
            }
            else if (e.CommandName == "MarkRead")
            {
                var msg = _messageService.GetById(id);
                if (msg != null)
                {
                    msg.IsRead = true;
                    _messageService.Update(msg);
                }
            }
            LoadMessages();
        }

        private void LoadContactInfo()
        {
            try
            {
                // Veritabanından iletişim bilgilerini çek ve TextBox'lara yükle
                if (txtAdres != null)
                    txtAdres.Text = _settingService.GetValueByKey("site_address") ?? "";
                
                if (txtTelefon != null)
                    txtTelefon.Text = _settingService.GetValueByKey("site_phone") ?? "";
                
                if (txtEmail != null)
                    txtEmail.Text = _settingService.GetValueByKey("site_email") ?? "";
                
                if (txtSaatler != null)
                    txtSaatler.Text = _settingService.GetValueByKey("site_working_hours") ?? "";
                
                // Harita linki
                if (txtHaritaLink != null)
                {
                    string haritaLink = _settingService.GetValueByKey("site_map_embed") ?? "";
                    txtHaritaLink.Text = haritaLink;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("İletişim Bilgileri Yükleme Hatası: " + ex.Message);
            }
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            try
            {
                // Tüm bilgileri kaydet
                bool adresSaved = _settingService.SetValueByKey("site_address", txtAdres.Text.Trim());
                bool telefonSaved = _settingService.SetValueByKey("site_phone", txtTelefon.Text.Trim());
                bool emailSaved = _settingService.SetValueByKey("site_email", txtEmail.Text.Trim());
                bool saatlerSaved = _settingService.SetValueByKey("site_working_hours", txtSaatler.Text.Trim());
                
                // Harita linki - iframe tag'lerini temizleyip sadece src URL'sini al
                string haritaLink = txtHaritaLink.Text.Trim();
                if (!string.IsNullOrEmpty(haritaLink))
                {
                    // Eğer tam iframe kodu verilmişse, sadece src URL'sini çıkar
                    if (haritaLink.Contains("src="))
                    {
                        // src="..." veya src='...' kısmını bul
                        int srcStart = haritaLink.IndexOf("src=\"");
                        if (srcStart < 0) srcStart = haritaLink.IndexOf("src='");
                        if (srcStart < 0) srcStart = haritaLink.IndexOf("src =\"");
                        if (srcStart < 0) srcStart = haritaLink.IndexOf("src ='");
                        
                        if (srcStart >= 0)
                        {
                            // src=" veya src=' sonrası
                            srcStart = haritaLink.IndexOf("\"", srcStart);
                            if (srcStart < 0) srcStart = haritaLink.IndexOf("'", srcStart);
                            
                            if (srcStart >= 0)
                            {
                                srcStart += 1; // Tırnak işaretinden sonrası
                                int srcEnd = haritaLink.IndexOf("\"", srcStart);
                                if (srcEnd < 0) srcEnd = haritaLink.IndexOf("'", srcStart);
                                if (srcEnd < 0) srcEnd = haritaLink.IndexOf(" ", srcStart);
                                if (srcEnd < 0) srcEnd = haritaLink.IndexOf(">", srcStart);
                                
                                if (srcEnd > srcStart)
                                {
                                    haritaLink = haritaLink.Substring(srcStart, srcEnd - srcStart);
                                }
                                else if (srcStart < haritaLink.Length)
                                {
                                    haritaLink = haritaLink.Substring(srcStart);
                                }
                            }
                        }
                    }
                    // Eğer zaten sadece URL ise (https:// ile başlıyorsa), olduğu gibi kullan
                }
                bool haritaSaved = _settingService.SetValueByKey("site_map_embed", haritaLink);

                if (adresSaved && telefonSaved && emailSaved && saatlerSaved && haritaSaved)
                {
                    lblContactInfoMessage.Text = "✅ İletişim bilgileri başarıyla kaydedildi! Sitede güncellenecektir.";
                    lblContactInfoMessage.CssClass = "contact-info-message success";
                    lblContactInfoMessage.Visible = true;
                }
                else
                {
                    lblContactInfoMessage.Text = "❌ Kayıt sırasında bir hata oluştu. Lütfen tekrar deneyin.";
                    lblContactInfoMessage.CssClass = "contact-info-message error";
                    lblContactInfoMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblContactInfoMessage.Text = "❌ Hata: " + ex.Message;
                lblContactInfoMessage.CssClass = "contact-info-message error";
                lblContactInfoMessage.Visible = true;
                System.Diagnostics.Debug.WriteLine("İletişim Bilgileri Kayıt Hatası: " + ex.Message);
            }
        }

        private void LoadProjectRequests()
        {
            try
            {
                var requests = _projectRequestService.GetAll().OrderByDescending(r => r.RequestDate).ToList();

                if (ltrTotalProjectRequests != null)
                    ltrTotalProjectRequests.Text = requests.Count.ToString();
                
                if (ltrUnreadProjectRequests != null)
                    ltrUnreadProjectRequests.Text = requests.Count(r => !r.IsRead).ToString();

                if (requests.Count > 0)
                {
                    if (rptProjectRequests != null)
                    {
                        rptProjectRequests.DataSource = requests;
                        rptProjectRequests.DataBind();
                        rptProjectRequests.Visible = true;
                    }
                    if (phEmptyProjectRequests != null)
                        phEmptyProjectRequests.Visible = false;
                }
                else
                {
                    if (rptProjectRequests != null)
                        rptProjectRequests.Visible = false;
                    if (phEmptyProjectRequests != null)
                        phEmptyProjectRequests.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Proje Teklifleri Yükleme Hatası: " + ex.Message);
            }
        }

        protected void rptProjectRequests_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                if (!int.TryParse(e.CommandArgument.ToString(), out int id)) return;

                if (e.CommandName == "Delete")
                {
                    _projectRequestService.Delete(id);
                }
                else if (e.CommandName == "MarkRead")
                {
                    var request = _projectRequestService.GetById(id);
                    if (request != null)
                    {
                        request.IsRead = true;
                        _projectRequestService.Update(request);
                    }
                }
                LoadProjectRequests();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Proje Teklifi İşlem Hatası: " + ex.Message);
            }
        }
    }
}