using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Pharmacy_Inventory_System
{
    public partial class Medicines : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            LoadSuppliers();
            if (Request.QueryString["saved"] == "1") ShowMessage("Medicine saved.", true);
            BindGrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnSaveMedicine_Click(object sender, EventArgs e)
        {
            string name = txtMedicineName.Text.Trim();
            string maker = txtManufacturer.Text.Trim();
            decimal price;
            int qty;

            if (name.Length == 0) { Fail("Enter the medicine name."); return; }
            if (!decimal.TryParse(txtPrice.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out price) || price < 0)
            { Fail("Enter a valid unit price."); return; }
            if (!int.TryParse(txtQuantity.Text, out qty) || qty < 0)
            { Fail("Enter a valid quantity (0 or more)."); return; }
            if (ddlSupplier.SelectedValue.Length == 0)
            { Fail("Select a supplier."); return; }

            bool duplicate = AppData.Medicines.AsEnumerable().Any(r =>
                string.Equals(r.Field<string>("Medicine"), name, StringComparison.OrdinalIgnoreCase) &&
                string.Equals(r.Field<string>("Manufacturer"), maker, StringComparison.OrdinalIgnoreCase));
            if (duplicate) { Fail("That medicine from the same manufacturer is already registered."); return; }

            DataRow row = AppData.Medicines.NewRow();
            row["Medicine"] = name;
            row["Category"] = ddlCategory.SelectedValue;
            row["Manufacturer"] = maker;
            row["Price"] = price;
            row["Quantity"] = qty;
            row["Supplier"] = ddlSupplier.SelectedValue;
            AppData.Medicines.Rows.InsertAt(row, 0);   // newest first

            // Redirect so pressing F5 does not add the same medicine twice
            Response.Redirect(Request.Path + "?saved=1", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void LoadSuppliers()
        {
            ddlSupplier.Items.Clear();
            ddlSupplier.Items.Add(new ListItem("-- Select supplier --", ""));
            foreach (string s in AppData.SupplierNames()) ddlSupplier.Items.Add(s);
        }

        private void BindGrid()
        {
            DataTable all = AppData.Medicines;
            gvMedicines.DataSource = AppData.Filter(all, txtSearch.Text);
            gvMedicines.DataBind();

            lblTotalMedicines.Text = all.Rows.Count.ToString();
            lblLowStock.Text = all.AsEnumerable().Count(r =>
                r.Field<int>("Quantity") > 0 && r.Field<int>("Quantity") <= AppData.LowStockLevel).ToString();
            lblOutOfStock.Text = all.AsEnumerable().Count(r => r.Field<int>("Quantity") == 0).ToString();
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
            ClientScript.RegisterStartupScript(GetType(), "openForm", "showMedicineForm();", true);
            BindGrid();
        }
    }
}