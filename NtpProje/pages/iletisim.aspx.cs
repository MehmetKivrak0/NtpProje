using System;
using System.Collections.Generic;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _241613001_Mehmet_Kıvrak_NtpProje.pages
{
    public partial class iletisim : System.Web.UI.Page
    {

        private readonly ContactMessageService _contactService = new ContactMessageService();
        private readonly ProjectRequestService _projectService = new ProjectRequestService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Sayfa ilk yüklendiğinde yapılacak işlemler
            }
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnTeklifIste_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // TODO: Veritabanına kaydet veya e-posta gönder
                    string firmaAdi = txtFirmaAdi.Text;
                    string yetkili = txtYetkili.Text;
                    string email = txtTeklifEmail.Text;
                    string telefon = txtTeklifTelefon.Text;
                    string projeDetay = txtProjeDetay.Text;

                    // Burada veritabanına kayıt veya e-posta gönderme işlemi yapılacak
                    // Örnek: ContactManager.SaveProjectRequest(firmaAdi, yetkili, email, telefon, projeDetay);

                    lblTeklifMesaj.Text = "Teklif talebiniz alındı. En kısa sürede size özel bir teklif hazırlayacağız.";
                    lblTeklifMesaj.CssClass = "form_mesaj success";
                    lblTeklifMesaj.Visible = true;

                    // Formu temizle
                    txtFirmaAdi.Text = "";
                    txtYetkili.Text = "";
                    txtTeklifEmail.Text = "";
                    txtTeklifTelefon.Text = "";
                    txtProjeDetay.Text = "";
                }
                catch (Exception ex)
                {
                    lblTeklifMesaj.Text = "Bir hata oluştu: " + ex.Message;
                    lblTeklifMesaj.CssClass = "form_mesaj error";
                    lblTeklifMesaj.Visible = true;
                }
            }
        }
    }
}