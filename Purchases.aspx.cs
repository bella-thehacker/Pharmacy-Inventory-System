using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace Pharmacy_Inventory_System
{
    public partial class Purchases : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            LoadDropdowns();
            txtPurchaseDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            string saved = Request.QueryString["saved"];
            if (saved == "1") ShowMessage("Purchase saved.", true);
            if (saved == "2") ShowMessage("Purchase saved and the medicine's stock was increased.", true);
            BindGrid();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnSavePurchase_Click(object sender, EventArgs e)
        {
            DateTime purchaseDate, expiry;
            int qty;
            decimal unitCost;
            string batch = txtBatchNumber.Text.Trim();

            if (!DateTime.TryParseExact(txtPurchaseDate.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out purchaseDate))
            { Fail("Enter a valid purchase date."); return; }
            if (ddlSupplier.SelectedValue.Length == 0) { Fail("Select a supplier."); return; }
            if (ddlMedicine.SelectedValue.Length == 0) { Fail("Select a medicine."); return; }
            if (!int.TryParse(txtQuantity.Text, out qty) || qty <= 0)
            { Fail("Enter a quantity greater than 0."); return; }
            if (!decimal.TryParse(txtUnitCost.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out unitCost) || unitCost < 0)
            { Fail("Enter a valid unit cost."); return; }
            if (batch.Length == 0) { Fail("Enter the batch number."); return; }
            if (!DateTime.TryParseExact(txtExpiryDate.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out expiry))
            { Fail("Enter a valid expiry date."); return; }
            if (expiry <= purchaseDate) { Fail("The expiry date must be after the purchase date."); return; }

            DataRow row = AppData.Purchases.NewRow();
            row["PurchaseDate"] = purchaseDate.ToString("yyyy-MM-dd");
            row["Supplier"] = ddlSupplier.SelectedValue;
            row["Medicine"] = ddlMedicine.SelectedValue;
            row["Quantity"] = qty;
            row["UnitCost"] = unitCost;
            row["TotalCost"] = qty * unitCost;
            row["BatchNumber"] = batch;
            row["ExpiryDate"] = expiry.ToString("yyyy-MM-dd");
            row["InvoiceNumber"] = txtInvoice.Text.Trim();
            row["PaymentStatus"] = ddlPaymentStatus.SelectedValue;
            AppData.Purchases.Rows.InsertAt(row, 0);   // newest first

            // If the medicine is registered on the Medicines page, add the purchased stock to it
            DataRow med = AppData.Medicines.AsEnumerable().FirstOrDefault(r =>
                string.Equals(r.Field<string>("Medicine"), ddlMedicine.SelectedValue, StringComparison.OrdinalIgnoreCase));
            if (med != null) med["Quantity"] = med.Field<int>("Quantity") + qty;

            // Redirect so pressing F5 does not record the same purchase twice
            RedirectSaved(med != null ? "2" : "1");
        }

        private void LoadDropdowns()
        {
            ddlSupplier.Items.Clear();
            ddlSupplier.Items.Add(new ListItem("-- Select supplier --", ""));
            foreach (string s in AppData.SupplierNames()) ddlSupplier.Items.Add(s);

            ddlMedicine.Items.Clear();
            ddlMedicine.Items.Add(new ListItem("-- Select medicine --", ""));
            foreach (string m in AppData.MedicineNames()) ddlMedicine.Items.Add(m);
        }

        private void BindGrid()
        {
            DataTable all = AppData.Purchases;
            gvPurchases.DataSource = AppData.Filter(all, txtSearch.Text);
            gvPurchases.DataBind();

            lblTotalPurchases.Text = all.Rows.Count.ToString();
            decimal value = all.AsEnumerable().Sum(r => r.Field<decimal>("TotalCost"));
            lblPurchaseValue.Text = "Ksh " + value.ToString("N2", CultureInfo.InvariantCulture);
            // "Awaiting payment" = Pending or Partially Paid
            lblPending.Text = all.AsEnumerable().Count(r => r.Field<string>("PaymentStatus") != "Paid").ToString();
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
            ClientScript.RegisterStartupScript(GetType(), "openForm", "showPurchaseForm(); calculateTotal();", true);
            BindGrid();
        }
    }
}