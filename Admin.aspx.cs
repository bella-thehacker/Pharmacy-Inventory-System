
using System;

namespace Pharmacy_Inventory_System
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string role = Convert.ToString(Session["UserRole"]);

            if (!string.Equals(role, "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlAdminContent.Visible = false;
                lblAccessMessage.Visible = true;

                if (string.IsNullOrWhiteSpace(role))
                {
                    lblAccessMessage.Text =
                        "Please sign in with an Admin account to access this page.";
                }
                else
                {
                    lblAccessMessage.Text =
                        "Access denied. Only Admin users can access the Admin Panel.";
                }
            }
        }
    }
}
