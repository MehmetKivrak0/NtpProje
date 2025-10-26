using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _241613001_Mehmet_Kıvrak_NtpProje
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public string AktifSayfaAdi { get; private set; } = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AktifSayfaAdi = System.IO.Path.GetFileName(Request.Path).ToLower();
        }
    }
}