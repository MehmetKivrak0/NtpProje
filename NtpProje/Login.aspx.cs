using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NtpProje.Business;
using NtpProje.Entities;
namespace NtpProje
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            UserManager userManeger = new UserManager();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            User loggedınUser = userManeger.Login(email, password);

            if (loggedınUser != null)
            {
                Session["UserId"] = loggedınUser.UserId;
                Session["UserNameFull"] = loggedınUser.FullName;
                Session["UserRole"] = loggedınUser.Role;

                if (loggedınUser.Role == "Admin")
                {
                    Response.Redirect("~/pages/Admin/Default.aspx");
                }
                else
                {
                    Response.Redirect("~/pages/Admin/UyePaneli.aspx");
                }


            }



        }
    }
}