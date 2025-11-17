// Register.aspx.cs

using System;
using System.Web.UI;         // : System.Web.UI.Page için gerekli
using NtpProje.Business; // UserManager sınıfımız için
using NtpProje.Entities;   // User sınıfımız için

namespace NtpProje_Web // Proje adınızdaki tire '-' alt çizgi '_' oldu, DİKKAT!
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa ilk kez yükleniyorsa yapılacak bir şey varsa buraya yazılır.
        }

        // Bu metod, Register.aspx'deki <asp:Button OnClick="btnRegister_Click"> tarafından çağrılır.
        protected void btnRegister_Click(object sender, EventArgs e)
        {
           
        }
    }
}