using System;
using System.Linq;
using System.Text.RegularExpressions;
using System.Data;

namespace Pharmacy_Inventory_System
{
    public partial class Suppliers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            if (Request.QueryString["saved"] == "1") ShowMessage("Supplier saved.", true);
            BindGrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnSaveSupplier_Click(object sender, EventArgs e)
        {
            string name = txtSupplierName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (name.Length == 0) { Fail("Enter the company name."); return; }
            if (!Regex.IsMatch(phone, @"^[0-9+()\-\s]{7,20}$")) { Fail("Enter a valid phone number."); return; }
            if (email.Length > 0)
            {
                try { new System.Net.Mail.MailAddress(email); }
                catch (FormatException) { Fail("Enter a valid email address."); return; }
            }
            if (AppData.SupplierNames().Contains(name, StringComparer.OrdinalIgnoreCase))
            { Fail("A supplier with that company name already exists."); return; }

            DataRow row = AppData.Suppliers.NewRow();
            row["Company"] = name;
            row["ContactPerson"] = txtContactPerson.Text.Trim();
            row["Phone"] = phone;
            row["Email"] = email;
            row["Location"] = txtLocation.Text.Trim();
            row["Address"] = txtAddress.Text.Trim();
            AppData.Suppliers.Rows.InsertAt(row, 0);   // newest first

            // Redirect so pressing F5 does not add the same supplier twice
            RedirectSaved("1");
        }

        private void BindGrid()
        {
            gvSuppliers.DataSource = AppData.Filter(AppData.Suppliers, txtSearch.Text);
            gvSuppliers.DataBind();
            lblTotalSuppliers.Text = AppData.Suppliers.Rows.Count.ToString();
        }

        // Reload this page (works with Friendly URLs) so pressing F5 does not repeat the save
        private void RedirectSaved(string code)
        {
            string url = Request.RawUrl;
            int q = url.IndexOf('?');
            if (q >= 0) url = url.Substring(0, q);
            Response.Redirect(url + "?saved=" + code, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowMessage(string text, bool ok)
        {
            lblMessage.Text = Server.HtmlEncode(text);
            lblMessage.CssClass = ok ? "alert alert-success d-block" : "alert alert-danger d-block";
        }

        // Show the error, keep what the user typed, and re-open the hidden form
        private void Fail(string text)
        {
            ShowMessage(text, false);
            ClientScript.RegisterStartupScript(GetType(), "openForm", "showSupplierForm();", true);
            BindGrid();
        }
    }
}