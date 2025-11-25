using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NtpProje_Web
{
    public partial class Site : System.Web.UI.MasterPage
    {
        // HTML tarafında kullandığın <%= AktifSayfaAdi %> değişkeni
        public string AktifSayfaAdi { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa her yüklendiğinde, şu an hangi sayfadayız onu buluyoruz
            // Örn: "iletisim.aspx"
            string path = Request.AppRelativeCurrentExecutionFilePath;
            AktifSayfaAdi = System.IO.Path.GetFileName(path);
        }
    }
}