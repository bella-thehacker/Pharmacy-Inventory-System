
using System;

namespace Pharmacy_Inventory_System
{
    public partial class AdminStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string role = Convert.ToString(Session["UserRole"]);

            if (!string.Equals(role, "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect(
                    ResolveUrl("~/Default.aspx"), false);

                Context.ApplicationInstance.CompleteRequest();
                return;
            }
        }

        protected void btnCreateStaff_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            lblMessage.CssClass = "alert alert-info d-block";

            lblMessage.Text =
                "The form is ready. Staff account creation will be connected to the database next.";
        }
    }
}
