using System;
using System.Data;
using System.Linq;
using System.Globalization;
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

            if (!IsPostBack)
            {
                // Load shared demo records
                AppData.SeedDemoData();

                // Display current date
                lblCurrentDate.Text =
                    DateTime.Now.ToString("dddd, dd MMMM yyyy");

                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            DataTable medicines = AppData.Medicines;
            DataTable suppliers = AppData.Suppliers;
            DataTable sales = AppData.Sales;

            // Medicine and supplier totals
            lblTotalMedicines.Text =
                medicines.Rows.Count.ToString();

            lblTotalSuppliers.Text =
                suppliers.Rows.Count.ToString();

            // Low stock: quantity from 1 to 10
            int lowStock = medicines.AsEnumerable().Count(r =>
                r.Field<int>("Quantity") > 0 &&
                r.Field<int>("Quantity") <= AppData.LowStockLevel);

            lblLowStock.Text = lowStock.ToString();

            // Expiring medicines: purchase expiry within 30 days
            DateTime today = DateTime.Today;
            DateTime expiryLimit = today.AddDays(30);

            int expiring = AppData.Purchases.AsEnumerable().Count(r =>
            {
                DateTime expiryDate;

                return DateTime.TryParse(
                    Convert.ToString(r["ExpiryDate"]),
                    CultureInfo.InvariantCulture,
                    DateTimeStyles.None,
                    out expiryDate)
                    && expiryDate.Date >= today
                    && expiryDate.Date <= expiryLimit;
            });

            lblExpiringMedicines.Text = expiring.ToString();

            // Recent sales
            DataView view = sales.DefaultView;
            view.Sort = "SaleDate DESC";

            DataTable recentSales = view.ToTable();

            if (recentSales.Rows.Count > 5)
            {
                recentSales = recentSales.AsEnumerable()
                    .Take(5)
                    .CopyToDataTable();
            }

            gvRecentSales.DataSource = recentSales;
            gvRecentSales.DataBind();
        }
    }
}