using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace NtpProje.pages.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        // Topbar'daki (Üst Bar) Admin bilgilerini Session'dan yükler
        private void LoadUserInfo()
        {
            
        }
        private void LoadStatistics()
        {
            // Bu veriler normalde Business katmanından çekilir
            // Örnek: ltrBlogYazisi.Text = postManager.GetTotalPostCount().ToString();
            // Şimdilik sabit (statik) verilerle dolduruyoruz:
            ltrToplamSayfa.Text = "15"; // Örnek
            ltrBlogYazisi.Text = "48"; // Örnek
            ltrToplamZiyaretci.Text = "2543"; // Örnek
            ltrYeniMesaj.Text = "12"; // Örnek
        }

        private void LoadBlogYazilari()
        {
            try
            {
                // Business katmanındaki GetPostsForDashboard metodunu çağır
                rptBlogYazilari.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Blog yazıları yüklenirken hata oluştu: " + ex.Message, false);
            }
        }
        private void LoadProjeler()
        {
            try
            {
                // (Gelecekte ProjectManager sınıfı yazılınca burası doldurulacak)
                // var projeler = projectManager.GetProjectsForDashboard();
                // rptProjeler.DataSource = projeler;
                rptProjeler.DataSource = null; // Şimdilik boş
                rptProjeler.DataBind();
            }
            catch (Exception ex)
            {
                ShowMessage("Projeler yüklenirken hata oluştu: " + ex.Message, false);
            }
        }
        protected void lnkCikisYap_Click(object sender, EventArgs e)
        {
            // 1. Sunucudaki hafızayı (Session) temizle
            Session.Clear();    // Tüm Session verilerini sil
            Session.Abandon();  // Oturumu tamamen sonlandır

            // 2. Kullanıcıyı Login sayfasına yönlendir
            // Login.aspx'in ana dizinde olduğunu varsayıyorum.
            Response.Redirect("~/Login.aspx");
        }

        protected void btnYeniYaziEkle_Click (object sender ,EventArgs e)
        {
            Response.Redirect("~/pages/Admin/YaziEkleDuzenle.aspx");
        }

        protected void rptBlogYazilari_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Tıklanan satırın PostId'sini al
            
        }
        protected void rptProjeler_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int projeId = Convert.ToInt32(e.CommandArgument);

            // (Gelecekte ProjectManager sınıfı yazılınca burası doldurulacak)

            ShowMessage($"Proje ID {projeId} için işlem (ProjectManager henüz yazılmadı).", false);
        }

        // Sayfanın üstünde mesaj göstermek için
        private void ShowMessage(string message, bool isSuccess)
        {
            string cssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
            string styles = "padding: 10px; border: 1px solid; margin-bottom: 10px; border-radius: 4px;";
            string borderColor = isSuccess ? "green" : "red";

            // HATA ÇÖZÜMÜ (CS0103): 'ltrMesaj' hatası için
            // .aspx dosyasına <asp:Literal ID="ltrMesaj"...> eklediğinden
            // ve Adım 3'ü (Convert to Web Application) yaptığından emin ol.
            ltrMesaj.Text = $"<div class='{cssClass}' style='{styles} border-color:{borderColor}; color:{borderColor};'> {Server.HtmlEncode(message)} </div>";
            ltrMesaj.Visible = true;
        }
        protected void btnYeniProjeEkle_Click(object sender, EventArgs e)
        {
            // TODO: Gelecekte proje ekleme sayfası oluşturulunca burası düzeltilecek.
            // Örnek: Response.Redirect("~/pages/Admin/ProjeEkleDuzenle.aspx"); 

            // Şimdilik sadece bir mesaj gösterelim
            ShowMessage("Proje Ekleme sayfası henüz oluşturulmadı.", false);
        }
    } 
}