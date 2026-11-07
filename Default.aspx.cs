
using System;
using System.Web.UI;

namespace Pharmacy_Inventory_System
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check whether the user is logged in
            string role = Convert.ToString(Session["UserRole"]);

            if (string.IsNullOrWhiteSpace(role))
            {
                Response.Redirect(
                    ResolveUrl("~/Account/Login.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Display the current date on the dashboard
            if (!IsPostBack)
            {
                lblCurrentDate.Text =
                    DateTime.Now.ToString("dddd, dd MMMM yyyy");
            }
        }
    }
}
