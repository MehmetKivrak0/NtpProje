using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business.Abstract;
using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;

namespace NtpProje_Web.Admin
{
    public partial class uzmanekp : System.Web.UI.Page
    {
        // Manuel tanımlamalar
        protected global::System.Web.UI.WebControls.Repeater rptTeamMembers;
        protected global::System.Web.UI.WebControls.Literal ltrTotalMembers;
        protected global::System.Web.UI.WebControls.Label lblMessage;
        protected global::System.Web.UI.WebControls.PlaceHolder phEmpty;
 
        private readonly IBaseService<TeamMemberDTO> _teamService = new TeamMemberService();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Güvenlik kontrolü
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Query string'den başarı mesajını kontrol et
                if (Request.QueryString["success"] == "1")
                {
                    ShowMessage("İşlem başarıyla tamamlandı.", "success");
                }

                LoadTeamMembers();
            }
        }

        private void LoadTeamMembers()
        {
            try
            {
                var teamMembers = _teamService.GetAll();

                // DisplayOrder ve Name'e göre sırala
                if (teamMembers != null && teamMembers.Count > 0)
                {
                    teamMembers = teamMembers
                        .OrderBy(t => t.DisplayOrder)
                        .ThenBy(t => t.Name)
                        .ToList();
                }

                if (rptTeamMembers != null)
                {
                    rptTeamMembers.DataSource = teamMembers;
                    rptTeamMembers.DataBind();
                }

                int totalCount = teamMembers != null ? teamMembers.Count : 0;
                if (ltrTotalMembers != null)
                {
                    ltrTotalMembers.Text = totalCount.ToString();
                }

                // Boş durum kontrolü
                if (phEmpty != null)
                {
                    phEmpty.Visible = (teamMembers == null || teamMembers.Count == 0);
                }

                if (rptTeamMembers != null)
                {
                    rptTeamMembers.Visible = (teamMembers != null && teamMembers.Count > 0);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Hata: " + ex.Message, "error");
                System.Diagnostics.Debug.WriteLine("Ekip Üyeleri Yükleme Hatası: " + ex.Message);
            }
        }

        protected void rptTeamMembers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                int memberId = Convert.ToInt32(e.CommandArgument);
                string commandName = e.CommandName;

                if (commandName == "Delete")
                {
                    bool deleted = _teamService.Delete(memberId);
                    if (deleted)
                    {
                        ShowMessage("Ekip üyesi başarıyla silindi.", "success");
                        LoadTeamMembers();
                    }
                    else
                    {
                        ShowMessage("Ekip üyesi silinirken bir hata oluştu.", "error");
                    }
                }
                else if (commandName == "ToggleActive")
                {
                    var member = _teamService.GetById(memberId);
                    if (member != null)
                    {
                        member.IsActive = !member.IsActive;
                        bool updated = _teamService.Update(member);
                        if (updated)
                        {
                            ShowMessage("Ekip üyesi durumu güncellendi.", "success");
                            LoadTeamMembers();
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
                System.Diagnostics.Debug.WriteLine("Ekip Üyesi İşlem Hatası: " + ex.Message);
            }
        }

        protected string RenderMemberAvatar(object dataItem)
        {
            if (dataItem == null) return "<div class=\"team-member-avatar\">?</div>";

            // DataItem'dan değerleri al
            var imageUrl = DataBinder.Eval(dataItem, "ImageUrl")?.ToString() ?? "";
            var name = DataBinder.Eval(dataItem, "Name")?.ToString() ?? "Ekip Üyesi";
            var firstLetter = !string.IsNullOrEmpty(name) && name.Length > 0 ? name.Substring(0, 1).ToUpper() : "?";

            if (!string.IsNullOrEmpty(imageUrl))
            {
                string resolvedUrl = imageUrl;
                if (!imageUrl.StartsWith("http://") && !imageUrl.StartsWith("https://") && !imageUrl.StartsWith("/"))
                {
                    resolvedUrl = ResolveUrl("~/" + imageUrl);
                }
                else if (imageUrl.StartsWith("~"))
                {
                    resolvedUrl = ResolveUrl(imageUrl);
                }

                return "<img src=\"" + resolvedUrl + "\" alt=\"" + HttpUtility.HtmlEncode(name) + "\" class=\"team-member-avatar\" style=\"object-fit: cover; width: 50px; height: 50px; border-radius: 50%;\" onerror=\"this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';\" />" +
                       "<div class=\"team-member-avatar\" style=\"display: none;\">" + firstLetter + "</div>";
            }

            // Fotoğraf yoksa avatar göster
            return "<div class=\"team-member-avatar\">" + firstLetter + "</div>";
        }

        private void ShowMessage(string message, string type)
        {
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.CssClass = "message-alert " + type + " visible";
                lblMessage.Visible = true;
            }
        }
    }
}
