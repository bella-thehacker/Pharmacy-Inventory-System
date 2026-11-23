using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pharmacy_Inventory_System
{
    public partial class Medicines : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AppData.SeedData();
            if (!IsPostBack)
            {
                LoadSuppliers();
                if (Request.QueryString["saved"] == "1") ShowMessage("Medicine saved successfully.", true);
            }
            BindGrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e) { BindGrid(); }

        protected void btnSaveMedicine_Click(object sender, EventArgs e)
        {
            string name = txtMedicineName.Text.Trim();
            string manufacturer = txtManufacturer.Text.Trim();
            decimal price; int quantity;
            if (name.Length == 0) { Fail("Enter the medicine name."); return; }
            if (!Decimal.TryParse(txtPrice.Text, NumberStyles.Number, CultureInfo.CurrentCulture, out price) || price <= 0) { Fail("Enter a valid selling price greater than zero."); return; }
            if (!Int32.TryParse(txtQuantity.Text, out quantity) || quantity < 0) { Fail("Enter a valid stock quantity (zero or more)."); return; }
            if (String.IsNullOrWhiteSpace(ddlSupplier.SelectedValue)) { Fail("Select a supplier."); return; }
            bool duplicate = AppData.Medicines.AsEnumerable().Any(r => String.Equals(r.Field<string>("Medicine"), name, StringComparison.OrdinalIgnoreCase) && String.Equals(r.Field<string>("Manufacturer"), manufacturer, StringComparison.OrdinalIgnoreCase));
            if (duplicate) { Fail("This medicine from the same manufacturer is already registered."); return; }
            DataRow row = AppData.Medicines.NewRow(); row["Medicine"] = name; row["Category"] = ddlCategory.SelectedValue;
            row["Manufacturer"] = manufacturer; row["Price"] = price; row["Quantity"] = quantity; row["Supplier"] = ddlSupplier.SelectedValue;
            AppData.Medicines.Rows.InsertAt(row, 0);
            Response.Redirect(ResolveUrl("~/Medicines.aspx?saved=1"), false); Context.ApplicationInstance.CompleteRequest();
        }

        private void LoadSuppliers()
        {
            ddlSupplier.Items.Clear(); ddlSupplier.Items.Add(new ListItem("-- Select supplier --", ""));
            foreach (string supplier in AppData.SupplierNames()) ddlSupplier.Items.Add(new ListItem(supplier, supplier));
        }

        private void BindGrid()
        {
            DataTable all = AppData.Medicines; gvMedicines.DataSource = AppData.Filter(all, txtSearch.Text); gvMedicines.DataBind();
            lblTotalMedicines.Text = all.Rows.Count.ToString();
            lblLowStock.Text = all.AsEnumerable().Count(r => r.Field<int>("Quantity") > 0 && r.Field<int>("Quantity") <= AppData.LowStockLevel).ToString();
            lblOutOfStock.Text = all.AsEnumerable().Count(r => r.Field<int>("Quantity") == 0).ToString();
        }

        private void ShowMessage(string text, bool ok) { lblMessage.Text = HttpUtility.HtmlEncode(text); lblMessage.CssClass = ok ? "alert alert-success d-block" : "alert alert-danger d-block"; }
        private void Fail(string text) { ShowMessage(text, false); ClientScript.RegisterStartupScript(GetType(), "showMedicineForm", "showMedicineForm();", true); BindGrid(); }
    }
}
