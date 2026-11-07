using System;

namespace Pharmacy_Inventory_System.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;

            if (email == "admin@pharmatrack.com" &&
                password == "Admin@123")
            {
                Session["UserName"] = "Administrator";
                Session["UserEmail"] = email;
                Session["UserRole"] = "Admin";

                Response.Redirect(ResolveUrl("~/Default.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else if (email == "staff@pharmatrack.com" &&
                     password == "Staff@123")
            {
                Session["UserName"] = "Staff Member";
                Session["UserEmail"] = email;
                Session["UserRole"] = "Staff";

                Response.Redirect(ResolveUrl("~/Default.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                lblMessage.Text = "Invalid email address or password.";
            }
        }
    }
}