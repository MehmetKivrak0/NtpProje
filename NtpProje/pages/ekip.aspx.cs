using NtpProje.Business.Concrete;
using NtpProje.Entities.Concrete;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace _241613001_Mehmet_Kıvrak_NtpProje.pages
{
    // Inherits kısmındaki sınıf adınızın 'ekip' olduğunu varsayıyoruz.
    public partial class ekip : System.Web.UI.Page
    {
        private readonly TeamMemberService _teamMemberService = new TeamMemberService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTeamMembers();
            }
        }

        private void BindTeamMembers()
        {
            try
            {
                // 1. Ekip üyelerini Service katmanından al
                // TeamMemberService.GetAll() metodu, List<TeamMemberDTO> döndürmelidir.
                List<TeamMemberDTO> ekipUyeleri = _teamMemberService.GetAll();

                // 2. Repeater'a bağla
                rptEkip.DataSource = ekipUyeleri;
                rptEkip.DataBind();
            }
            catch (Exception ex)
            {
                // Hata oluşursa Response.Write ile gösterin veya loglayın
                System.Diagnostics.Debug.WriteLine("EKİP ÜYELERİ YÜKLEME HATASI: " + ex.ToString());
            }
        }
    }
}