using System;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;

namespace Pharmacy_Inventory_System
{
    public partial class Suppliers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AppData.SeedData();
            if (!IsPostBack && Request.QueryString["saved"] == "1") ShowMessage("Supplier saved successfully.", true);
            BindGrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e) { BindGrid(); }

        protected void btnSaveSupplier_Click(object sender, EventArgs e)
        {
            string name = txtSupplierName.Text.Trim(); string phone = txtPhone.Text.Trim(); string email = txtEmail.Text.Trim();
            if (name.Length == 0) { Fail("Enter the company name."); return; }
            if (!Regex.IsMatch(phone, @"^[0-9+()\s-]{7,20}$")) { Fail("Enter a valid phone number."); return; }
            if (email.Length > 0) { try { new MailAddress(email); } catch (FormatException) { Fail("Enter a valid email address."); return; } }
            if (AppData.Suppliers.AsEnumerable().Any(r => String.Equals(r.Field<string>("Company"), name, StringComparison.OrdinalIgnoreCase))) { Fail("A supplier with that company name already exists."); return; }
            DataRow row = AppData.Suppliers.NewRow(); row["Company"] = name; row["ContactPerson"] = txtContactPerson.Text.Trim(); row["Phone"] = phone;
            row["Email"] = email; row["Location"] = txtLocation.Text.Trim(); row["Address"] = txtAddress.Text.Trim(); AppData.Suppliers.Rows.InsertAt(row, 0);
            Response.Redirect(ResolveUrl("~/Suppliers.aspx?saved=1"), false); Context.ApplicationInstance.CompleteRequest();
        }

        private void BindGrid() { DataTable all = AppData.Suppliers; gvSuppliers.DataSource = AppData.Filter(all, txtSearch.Text); gvSuppliers.DataBind(); lblTotalSuppliers.Text = all.Rows.Count.ToString(); }
        private void ShowMessage(string text, bool ok) { lblMessage.Text = HttpUtility.HtmlEncode(text); lblMessage.CssClass = ok ? "alert alert-success d-block" : "alert alert-danger d-block"; }
        private void Fail(string text) { ShowMessage(text, false); ClientScript.RegisterStartupScript(GetType(), "showSupplierForm", "showSupplierForm();", true); BindGrid(); }
    }
}
