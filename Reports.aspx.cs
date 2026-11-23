using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace Pharmacy_Inventory_System
{
    public partial class Reports : Page
    {
        protected void Page_Init(object sender, EventArgs e) { btnGenerate.Click += btnGenerate_Click; }

        protected void Page_Load(object sender, EventArgs e)
        {
            AppData.SeedData();
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Today.AddDays(-90).ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
            BindReports();
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            DateTime start, end;
            if (!DateTime.TryParse(txtStartDate.Text, out start) || !DateTime.TryParse(txtEndDate.Text, out end) || start.Date > end.Date)
            {
                lblChartMessage.Text = "Choose a valid date range. The start date must not be after the end date.";
                return;
            }
            BindReports();
        }

        private void BindReports()
        {
            DateTime start, end;
            if (!DateTime.TryParse(txtStartDate.Text, out start)) start = DateTime.Today.AddDays(-90);
            if (!DateTime.TryParse(txtEndDate.Text, out end)) end = DateTime.Today;
            DataTable allSales = AppData.Sales;
            var filtered = allSales.AsEnumerable().Where(r => r.Field<DateTime>("SaleDate").Date >= start.Date && r.Field<DateTime>("SaleDate").Date <= end.Date).ToList();
            decimal revenue = filtered.Sum(r => r.Field<decimal>("TotalAmount"));
            lblTotalSales.Text = "KSh " + revenue.ToString("N2");
            lblTransactions.Text = filtered.Count.ToString();
            lblItemsSold.Text = AppData.SaleItems.AsEnumerable().Where(r => filtered.Any(s => s.Field<string>("SaleID") == r.Field<string>("SaleID"))).Sum(r => r.Field<int>("Quantity")).ToString();
            lblMedicineCount.Text = AppData.Medicines.Rows.Count.ToString();

            DataTable salesView = allSales.Clone();
            foreach (DataRow r in filtered.OrderByDescending(r => r.Field<DateTime>("SaleDate"))) salesView.ImportRow(r);
            gvSales.DataSource = salesView; gvSales.DataBind();

            DataTable stock = new DataTable(); stock.Columns.Add("MedicineName", typeof(string)); stock.Columns.Add("Quantity", typeof(int)); stock.Columns.Add("UnitPrice", typeof(decimal)); stock.Columns.Add("ExpiryDate", typeof(DateTime));
            int index = 0;
            foreach (DataRow medicine in AppData.Medicines.Rows)
            {
                DataRow row = stock.NewRow(); row["MedicineName"] = medicine["Medicine"]; row["Quantity"] = medicine["Quantity"];
                row["UnitPrice"] = medicine["Price"]; row["ExpiryDate"] = DateTime.Today.AddMonths(3 + (index++ % 18)); stock.Rows.Add(row);
            }
            gvStock.DataSource = stock; gvStock.DataBind();
            lblChartMessage.Text = filtered.Count == 0 ? "No sales were recorded in this date range." : "Sales revenue for the selected period.";
            RenderChart(filtered, start, end);
        }

        private void RenderChart(System.Collections.Generic.List<DataRow> sales, DateTime start, DateTime end)
        {
            DateTime firstMonth = new DateTime(start.Year, start.Month, 1);
            DateTime lastMonth = new DateTime(end.Year, end.Month, 1);
            if ((lastMonth - firstMonth).TotalDays > 550) firstMonth = lastMonth.AddMonths(-11);
            var labels = new System.Collections.Generic.List<string>();
            var values = new System.Collections.Generic.List<decimal>();
            for (DateTime month = firstMonth; month <= lastMonth; month = month.AddMonths(1))
            {
                labels.Add(month.ToString("MMM yyyy", CultureInfo.InvariantCulture));
                values.Add(sales.Where(r => r.Field<DateTime>("SaleDate").Year == month.Year && r.Field<DateTime>("SaleDate").Month == month.Month).Sum(r => r.Field<decimal>("TotalAmount")));
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string labelsJson = serializer.Serialize(labels); string valuesJson = serializer.Serialize(values);
            string script = "window.addEventListener('load',function(){var c=document.getElementById('salesChart');if(!c||typeof Chart==='undefined')return;var old=Chart.getChart(c);if(old)old.destroy();new Chart(c,{type:'bar',data:{labels:" + labelsJson + ",datasets:[{label:'Sales revenue (KSh)',data:" + valuesJson + ",backgroundColor:'#16a085',borderRadius:6}]},options:{responsive:true,maintainAspectRatio:false,scales:{y:{beginAtZero:true}},plugins:{legend:{display:true}}}});});";
            ClientScript.RegisterStartupScript(GetType(), "liveSalesChart", script, true);
        }
    }
}
