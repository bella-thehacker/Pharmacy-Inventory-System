
using System;
using System.Web;
using System.Web.UI;

namespace Pharmacy_Inventory_System
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateNavigation();
            }
        }

        private void UpdateNavigation()
        {
            string role = Convert.ToString(Session["UserRole"]);

            bool loggedIn = !string.IsNullOrWhiteSpace(role);

            // Show Sign In only when the user is logged out
            liSignIn.Visible = !loggedIn;

            // Show profile only when the user is logged in
            liProfile.Visible = loggedIn;

            // Show Admin Panel only to Admin users
            liAdminPanel.Visible =
                string.Equals(role, "Admin",
                StringComparison.OrdinalIgnoreCase);

            if (loggedIn)
            {
                lblProfileName.Text =
                    HttpUtility.HtmlEncode(
                        Convert.ToString(Session["UserName"]));

                lblProfileEmail.Text =
                    HttpUtility.HtmlEncode(
                        Convert.ToString(Session["UserEmail"]));

                lblProfileRole.Text =
                    HttpUtility.HtmlEncode(role);
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect(
                ResolveUrl("~/Account/Login.aspx"), false);

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
