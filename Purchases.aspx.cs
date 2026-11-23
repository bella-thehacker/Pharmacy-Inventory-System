
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

            // Add sample purchase history only once
            SeedSamplePurchases();

            txtPurchaseDate.Text =
                DateTime.Today.ToString("yyyy-MM-dd");

            string saved = Request.QueryString["saved"];

            if (saved == "1")
                ShowMessage("Purchase saved.", true);

            if (saved == "2")
                ShowMessage(
                    "Purchase saved and the medicine's stock was increased.",
                    true);

            BindGrid();
        }

        // SEARCH PURCHASES
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        // FILTER MEDICINES WHEN SUPPLIER CHANGES
        protected void ddlSupplier_SelectedIndexChanged(
            object sender, EventArgs e)
        {
            LoadMedicineDropdown(ddlSupplier.SelectedValue);
        }

        // SAVE A NEW PURCHASE
        protected void btnSavePurchase_Click(object sender, EventArgs e)
        {
            DateTime purchaseDate, expiry;
            int qty;
            decimal unitCost;

            string supplier = ddlSupplier.SelectedValue;
            string medicine = ddlMedicine.SelectedValue;
            string batch = txtBatchNumber.Text.Trim();

            if (!DateTime.TryParseExact(
                txtPurchaseDate.Text,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out purchaseDate))
            {
                Fail("Enter a valid purchase date.");
                return;
            }

            if (supplier.Length == 0)
            {
                Fail("Select a supplier.");
                return;
            }

            if (medicine.Length == 0)
            {
                Fail("Select a medicine.");
                return;
            }

            // Make sure this supplier supplies this medicine
            if (!IsMedicineSuppliedBy(supplier, medicine))
            {
                Fail("The selected supplier does not supply this medicine.");
                return;
            }

            if (!int.TryParse(txtQuantity.Text, out qty) || qty <= 0)
            {
                Fail("Enter a quantity greater than 0.");
                return;
            }

            if (!decimal.TryParse(
                txtUnitCost.Text,
                NumberStyles.Number,
                CultureInfo.InvariantCulture,
                out unitCost) || unitCost < 0)
            {
                Fail("Enter a valid unit cost.");
                return;
            }

            if (batch.Length == 0)
            {
                Fail("Enter the batch number.");
                return;
            }

            if (!DateTime.TryParseExact(
                txtExpiryDate.Text,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out expiry))
            {
                Fail("Enter a valid expiry date.");
                return;
            }

            if (expiry <= purchaseDate)
            {
                Fail("The expiry date must be after the purchase date.");
                return;
            }

            // Create purchase record
            DataRow row = AppData.Purchases.NewRow();

            row["PurchaseDate"] = purchaseDate.ToString("yyyy-MM-dd");
            row["Supplier"] = supplier;
            row["Medicine"] = medicine;
            row["Quantity"] = qty;
            row["UnitCost"] = unitCost;
            row["TotalCost"] = qty * unitCost;
            row["BatchNumber"] = batch;
            row["ExpiryDate"] = expiry.ToString("yyyy-MM-dd");
            row["InvoiceNumber"] = txtInvoice.Text.Trim();
            row["PaymentStatus"] = ddlPaymentStatus.SelectedValue;

            // Newest purchase appears first
            AppData.Purchases.Rows.InsertAt(row, 0);

            // Increase stock if the medicine exists
            DataRow med = AppData.Medicines.AsEnumerable()
                .FirstOrDefault(r =>
                    string.Equals(
                        r.Field<string>("Medicine"),
                        medicine,
                        StringComparison.OrdinalIgnoreCase));

            if (med != null)
            {
                med["Quantity"] =
                    med.Field<int>("Quantity") + qty;
            }

            // Redirect prevents duplicate saves when refreshing
            RedirectSaved(med != null ? "2" : "1");
        }

        // LOAD SUPPLIER AND MEDICINE DROPDOWNS
        private void LoadDropdowns()
        {
            ddlSupplier.Items.Clear();

            ddlSupplier.Items.Add(
                new ListItem("-- Select supplier --", ""));

            foreach (string supplier in AppData.SupplierNames())
            {
                ddlSupplier.Items.Add(
                    new ListItem(supplier, supplier));
            }

            LoadMedicineDropdown("");
        }

        // LOAD MEDICINES SUPPLIED BY THE SELECTED COMPANY
        private void LoadMedicineDropdown(string supplier)
        {
            ddlMedicine.Items.Clear();

            ddlMedicine.Items.Add(
                new ListItem("-- Select medicine --", ""));

            var medicines = AppData.MedicineNames();

            // No supplier selected: show all medicines
            if (string.IsNullOrWhiteSpace(supplier))
            {
                foreach (string medicine in medicines)
                {
                    ddlMedicine.Items.Add(
                        new ListItem(medicine, medicine));
                }

                return;
            }

            string[] allowedMedicines =
                GetMedicinesForSupplier(supplier);

            foreach (string medicine in medicines)
            {
                if (allowedMedicines.Contains(
                    medicine,
                    StringComparer.OrdinalIgnoreCase))
                {
                    ddlMedicine.Items.Add(
                        new ListItem(medicine, medicine));
                }
            }
        }

        // SUPPLIER AND MEDICINE RELATIONSHIPS
        private string[] GetMedicinesForSupplier(string supplier)
        {
            switch (supplier)
            {
                case "Nairobi Med Supplies Ltd":
                    return new string[]
                    {
                        "Paracetamol 500mg",
                        "Ibuprofen 400mg",
                        "Vitamin C 500mg"
                    };

                case "AfyaCare Distributors":
                    return new string[]
                    {
                        "Amoxicillin 500mg",
                        "Metformin 500mg"
                    };

                case "Medlink Pharmaceuticals":
                    return new string[]
                    {
                        "Cetirizine 10mg",
                        "Omeprazole 20mg"
                    };

                case "HealthPlus Wholesale":
                    return new string[]
                    {
                        "ORS Sachets"
                    };

                default:
                    return new string[0];
            }
        }

        private bool IsMedicineSuppliedBy(
            string supplier, string medicine)
        {
            return GetMedicinesForSupplier(supplier)
                .Contains(
                    medicine,
                    StringComparer.OrdinalIgnoreCase);
        }

        // ADD DEMONSTRATION PURCHASES ON FIRST LOAD
        private void SeedSamplePurchases()
        {
            // Do not add sample records again if purchases exist
            if (AppData.Purchases.Rows.Count > 0)
                return;

            AddSamplePurchase(
                "2026-11-03",
                "Nairobi Med Supplies Ltd",
                "Paracetamol 500mg",
                300, 3.00m,
                "PCM-B001",
                "2027-10-31",
                "INV-NMS-001",
                "Paid");

            AddSamplePurchase(
                "2026-11-04",
                "AfyaCare Distributors",
                "Amoxicillin 500mg",
                150, 12.00m,
                "AMX-B002",
                "2027-09-30",
                "INV-AFY-002",
                "Paid");

            AddSamplePurchase(
                "2026-11-05",
                "Medlink Pharmaceuticals",
                "Cetirizine 10mg",
                200, 5.00m,
                "CTZ-B003",
                "2027-11-30",
                "INV-MED-003",
                "Pending");

            AddSamplePurchase(
                "2026-11-06",
                "HealthPlus Wholesale",
                "ORS Sachets",
                100, 20.00m,
                "ORS-B004",
                "2027-08-31",
                "INV-HPL-004",
                "Paid");

            AddSamplePurchase(
                "2026-11-08",
                "Nairobi Med Supplies Ltd",
                "Ibuprofen 400mg",
                250, 6.00m,
                "IBP-B005",
                "2027-10-31",
                "INV-NMS-005",
                "Paid");

            AddSamplePurchase(
                "2026-11-09",
                "AfyaCare Distributors",
                "Metformin 500mg",
                100, 7.00m,
                "MTF-B006",
                "2027-09-30",
                "INV-AFY-006",
                "Partially Paid");

            AddSamplePurchase(
                "2026-11-10",
                "Medlink Pharmaceuticals",
                "Omeprazole 20mg",
                100, 9.00m,
                "OMP-B007",
                "2027-11-30",
                "INV-MED-007",
                "Paid");

            AddSamplePurchase(
                "2026-11-11",
                "Nairobi Med Supplies Ltd",
                "Vitamin C 500mg",
                200, 8.00m,
                "VTC-B008",
                "2027-10-31",
                "INV-NMS-008",
                "Paid");
        }

        // CREATE ONE SAMPLE PURCHASE ROW
        private void AddSamplePurchase(
            string date,
            string supplier,
            string medicine,
            int quantity,
            decimal unitCost,
            string batch,
            string expiry,
            string invoice,
            string paymentStatus)
        {
            DataRow row = AppData.Purchases.NewRow();

            row["PurchaseDate"] = date;
            row["Supplier"] = supplier;
            row["Medicine"] = medicine;
            row["Quantity"] = quantity;
            row["UnitCost"] = unitCost;
            row["TotalCost"] = quantity * unitCost;
            row["BatchNumber"] = batch;
            row["ExpiryDate"] = expiry;
            row["InvoiceNumber"] = invoice;
            row["PaymentStatus"] = paymentStatus;

            AppData.Purchases.Rows.Add(row);
        }

        // DISPLAY PURCHASE HISTORY AND SUMMARY
        private void BindGrid()
        {
            DataTable all = AppData.Purchases;

            gvPurchases.DataSource =
                AppData.Filter(all, txtSearch.Text);

            gvPurchases.DataBind();

            lblTotalPurchases.Text =
                all.Rows.Count.ToString();

            decimal value = all.AsEnumerable()
                .Sum(r => r.Field<decimal>("TotalCost"));

            lblPurchaseValue.Text =
                "KSh " + value.ToString(
                    "N2",
                    CultureInfo.InvariantCulture);

            // Pending includes Pending and Partially Paid
            lblPending.Text = all.AsEnumerable()
                .Count(r =>
                    r.Field<string>("PaymentStatus") != "Paid")
                .ToString();
        }

        // REDIRECT AFTER SAVE
        private void RedirectSaved(string code)
        {
            string url = Request.RawUrl;

            int q = url.IndexOf('?');

            if (q >= 0)
                url = url.Substring(0, q);

            Response.Redirect(
                url + "?saved=" + code,
                false);

            Context.ApplicationInstance.CompleteRequest();
        }

        // DISPLAY STATUS MESSAGE
        private void ShowMessage(string text, bool ok)
        {
            lblMessage.Text = Server.HtmlEncode(text);

            lblMessage.CssClass = ok
                ? "alert alert-success d-block"
                : "alert alert-danger d-block";
        }

        // DISPLAY ERROR AND REOPEN FORM
        private void Fail(string text)
        {
            ShowMessage(text, false);

            ClientScript.RegisterStartupScript(
                GetType(),
                "openForm",
                "showPurchaseForm(); calculateTotal();",
                true);

            BindGrid();
        }
    }
}
