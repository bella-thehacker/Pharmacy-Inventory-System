using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pharmacy_Inventory_System
{
    public partial class Sales : Page
    {
        private DataTable Basket
        {
            get
            {
                if (Session["CurrentSaleBasket"] == null)
                {
                    DataTable t = new DataTable();
                    t.Columns.Add("MedicineName", typeof(string));
                    t.Columns.Add("Quantity", typeof(int));
                    t.Columns.Add("UnitPrice", typeof(decimal));
                    t.Columns.Add("LineTotal", typeof(decimal));
                    Session["CurrentSaleBasket"] = t;
                }
                return (DataTable)Session["CurrentSaleBasket"];
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            btnAddItem.Click += btnAddItem_Click;
            btnCancelSale.Click += btnCancelSale_Click;
            btnCompleteSale.Click += btnCompleteSale_Click;
            btnPrintReceipt.Click += btnPrintReceipt_Click;
            btnEmailReceipt.Click += btnEmailReceipt_Click;
            ddlMedicine.AutoPostBack = true;
            ddlMedicine.SelectedIndexChanged += ddlMedicine_SelectedIndexChanged;
            gvSaleItems.RowCommand += gvSaleItems_RowCommand;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AppData.SeedData();
            if (!IsPostBack) LoadMedicines();
            BindBasket();
            string lastSale = Convert.ToString(Session["LastCompletedSale"]);
            btnPrintReceipt.Enabled = !String.IsNullOrEmpty(lastSale);
            btnEmailReceipt.Enabled = !String.IsNullOrEmpty(lastSale);
            if (!IsPostBack && !String.IsNullOrEmpty(lastSale)) ShowMessage("Sale " + lastSale + " is complete. You can print the receipt.", true);
        }

        private void LoadMedicines()
        {
            ddlMedicine.Items.Clear();
            ddlMedicine.Items.Add(new ListItem("-- Select medicine --", ""));
            foreach (DataRow r in AppData.Medicines.Rows)
            {
                int stock = Convert.ToInt32(r["Quantity"]);
                if (stock > 0) ddlMedicine.Items.Add(new ListItem(r["Medicine"] + " (Stock: " + stock + ")", Convert.ToString(r["Medicine"])));
            }
            UpdatePrice();
        }

        private void ddlMedicine_SelectedIndexChanged(object sender, EventArgs e) { UpdatePrice(); }

        private void UpdatePrice()
        {
            DataRow medicine = FindMedicine(ddlMedicine.SelectedValue);
            lblUnitPrice.Text = medicine == null ? "Select medicine" : "KSh " + Convert.ToDecimal(medicine["Price"]).ToString("N2");
        }

        private DataRow FindMedicine(string name)
        {
            if (String.IsNullOrWhiteSpace(name)) return null;
            return AppData.Medicines.AsEnumerable().FirstOrDefault(r => String.Equals(Convert.ToString(r["Medicine"]), name, StringComparison.OrdinalIgnoreCase));
        }

        private void btnAddItem_Click(object sender, EventArgs e)
        {
            Page.Validate("SaleItem");
            if (!Page.IsValid) { ShowMessage("Please enter a valid quantity.", false); return; }
            DataRow medicine = FindMedicine(ddlMedicine.SelectedValue);
            int quantity;
            if (medicine == null) { ShowMessage("Select a medicine first.", false); return; }
            if (!Int32.TryParse(txtQuantity.Text, out quantity) || quantity < 1) { ShowMessage("Enter a quantity greater than zero.", false); return; }
            int stock = Convert.ToInt32(medicine["Quantity"]);
            DataRow existing = Basket.AsEnumerable().FirstOrDefault(r => String.Equals(r.Field<string>("MedicineName"), ddlMedicine.SelectedValue, StringComparison.OrdinalIgnoreCase));
            int inBasket = existing == null ? 0 : existing.Field<int>("Quantity");
            if (quantity + inBasket > stock) { ShowMessage("Not enough stock. Available quantity: " + stock + ".", false); return; }
            decimal price = Convert.ToDecimal(medicine["Price"]);
            if (existing == null)
            {
                DataRow row = Basket.NewRow(); row["MedicineName"] = ddlMedicine.SelectedValue; row["Quantity"] = quantity; row["UnitPrice"] = price; row["LineTotal"] = price * quantity; Basket.Rows.Add(row);
            }
            else
            {
                existing["Quantity"] = inBasket + quantity; existing["LineTotal"] = price * (inBasket + quantity);
            }
            txtQuantity.Text = ""; BindBasket(); ShowMessage("Item added to the sale.", true);
        }

        private void gvSaleItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "RemoveItem") return;
            int index; if (!Int32.TryParse(Convert.ToString(e.CommandArgument), out index)) return;
            if (index >= 0 && index < Basket.Rows.Count) Basket.Rows.RemoveAt(index);
            BindBasket();
        }

        private void btnCancelSale_Click(object sender, EventArgs e)
        {
            Basket.Clear(); Session.Remove("LastCompletedSale"); BindBasket();
            btnPrintReceipt.Enabled = false; btnEmailReceipt.Enabled = false;
            ShowMessage("Current sale cancelled.", true);
        }

        private void btnCompleteSale_Click(object sender, EventArgs e)
        {
            if (Basket.Rows.Count == 0) { ShowMessage("Add at least one medicine before completing the sale.", false); return; }
            if (String.IsNullOrWhiteSpace(ddlPaymentMethod.SelectedValue)) { ShowMessage("Select a payment method.", false); return; }
            foreach (DataRow item in Basket.Rows)
            {
                DataRow medicine = FindMedicine(item.Field<string>("MedicineName"));
                if (medicine == null || Convert.ToInt32(medicine["Quantity"]) < item.Field<int>("Quantity"))
                { ShowMessage("Stock changed for " + item["MedicineName"] + ". Please review the sale.", false); return; }
            }
            decimal total = Basket.AsEnumerable().Sum(r => r.Field<decimal>("LineTotal"));
            string saleId = "SAL" + (AppData.Sales.Rows.Count + 1).ToString("0000");
            DataRow sale = AppData.Sales.NewRow(); sale["SaleID"] = saleId; sale["SaleDate"] = DateTime.Now;
            sale["Customer"] = "Walk-in Customer"; sale["PaymentMethod"] = ddlPaymentMethod.SelectedValue; sale["TotalAmount"] = total; AppData.Sales.Rows.Add(sale);
            foreach (DataRow item in Basket.Rows)
            {
                DataRow medicine = FindMedicine(item.Field<string>("MedicineName"));
                medicine["Quantity"] = Convert.ToInt32(medicine["Quantity"]) - item.Field<int>("Quantity");
                DataRow detail = AppData.SaleItems.NewRow(); detail["SaleID"] = saleId; detail["MedicineName"] = item["MedicineName"];
                detail["Quantity"] = item["Quantity"]; detail["UnitPrice"] = item["UnitPrice"]; detail["LineTotal"] = item["LineTotal"]; AppData.SaleItems.Rows.Add(detail);
            }
            Session["LastCompletedSale"] = saleId; Basket.Clear(); LoadMedicines(); BindBasket();
            btnPrintReceipt.Enabled = true; btnEmailReceipt.Enabled = true;
            ShowMessage("Sale " + saleId + " completed. Total: KSh " + total.ToString("N2") + ".", true);
        }

        private void btnPrintReceipt_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Convert.ToString(Session["LastCompletedSale"]))) { ShowMessage("Complete a sale before printing a receipt.", false); return; }
            ClientScript.RegisterStartupScript(GetType(), "printReceipt", "window.print();", true);
        }

        private void btnEmailReceipt_Click(object sender, EventArgs e)
        {
            string email = txtCustomerEmail.Text.Trim();
            if (String.IsNullOrEmpty(Convert.ToString(Session["LastCompletedSale"]))) { ShowMessage("Complete a sale before preparing a receipt.", false); return; }
            if (email.Length == 0 || !email.Contains("@") || !email.Contains(".")) { ShowMessage("Enter the customer's email address.", false); return; }
            ShowMessage("Receipt details are ready for " + email + ". Email delivery needs the pharmacy's SMTP email settings to be configured.", true);
        }

        private void BindBasket()
        {
            gvSaleItems.DataSource = Basket; gvSaleItems.DataBind();
            decimal total = Basket.AsEnumerable().Sum(r => r.Field<decimal>("LineTotal"));
            lblGrandTotal.Text = total.ToString("N2");
        }

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Text = HttpUtility.HtmlEncode(message);
            lblMessage.CssClass = success ? "alert alert-success d-block mb-3" : "alert alert-danger d-block mb-3";
        }
    }
}
