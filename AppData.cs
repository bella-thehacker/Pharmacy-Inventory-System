using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Pharmacy_Inventory_System
{
    /// <summary>
    /// One place that holds the in-memory (Session) tables shared by the Medicines,
    /// Suppliers and Purchases pages. No database is used; data lasts for the browser session.
    /// </summary>
    public static class AppData
    {
        public const int LowStockLevel = 10;   // 1..10 units = "low stock"

        private static readonly string[] DefaultSuppliers = { "Beta Healthcare", "Laborex", "Cosmos Limited", "Phillips Pharma" };
        private static readonly string[] DefaultMedicines = { "Paracetamol", "Amoxicillin", "Ibuprofen", "Metronidazole", "Vitamin C" };

        private static HttpSessionState S { get { return HttpContext.Current.Session; } }

        private static DataTable Get(string key, Func<DataTable> make)
        {
            if (S[key] == null) S[key] = make();
            return (DataTable)S[key];
        }

        private static DataTable Make(params object[][] cols)
        {
            var dt = new DataTable();
            foreach (var c in cols) dt.Columns.Add((string)c[0], (Type)c[1]);
            return dt;
        }

        public static DataTable Suppliers
        {
            get
            {
                return Get("Suppliers", () => Make(
                    new object[] { "Company", typeof(string) }, new object[] { "ContactPerson", typeof(string) },
                    new object[] { "Phone", typeof(string) }, new object[] { "Email", typeof(string) },
                    new object[] { "Location", typeof(string) }, new object[] { "Address", typeof(string) }));
            }
        }

        public static DataTable Medicines
        {
            get
            {
                return Get("Medicines", () => Make(
                    new object[] { "Medicine", typeof(string) }, new object[] { "Category", typeof(string) },
                    new object[] { "Manufacturer", typeof(string) }, new object[] { "Price", typeof(decimal) },
                    new object[] { "Quantity", typeof(int) }, new object[] { "Supplier", typeof(string) }));
            }
        }

        public static DataTable Purchases
        {
            get
            {
                return Get("Purchases", () => Make(
                    new object[] { "PurchaseDate", typeof(string) }, new object[] { "Supplier", typeof(string) },
                    new object[] { "Medicine", typeof(string) }, new object[] { "Quantity", typeof(int) },
                    new object[] { "UnitCost", typeof(decimal) }, new object[] { "TotalCost", typeof(decimal) },
                    new object[] { "BatchNumber", typeof(string) }, new object[] { "ExpiryDate", typeof(string) },
                    new object[] { "InvoiceNumber", typeof(string) }, new object[] { "PaymentStatus", typeof(string) }));
            }
        }

        // Dropdown lists: the built-in names plus anything the user has registered
        public static string[] SupplierNames()
        {
            return DefaultSuppliers
                .Concat(Suppliers.AsEnumerable().Select(r => r.Field<string>("Company")))
                .Distinct(StringComparer.OrdinalIgnoreCase).OrderBy(n => n).ToArray();
        }

        public static string[] MedicineNames()
        {
            return DefaultMedicines
                .Concat(Medicines.AsEnumerable().Select(r => r.Field<string>("Medicine")))
                .Distinct(StringComparer.OrdinalIgnoreCase).OrderBy(n => n).ToArray();
        }

        // Rows where any column contains the search text
        public static DataTable Filter(DataTable source, string text)
        {
            text = (text ?? "").Trim();
            if (text.Length == 0) return source;
            var result = source.Clone();
            foreach (DataRow r in source.Rows)
                if (r.ItemArray.Any(v => Convert.ToString(v, CultureInfo.InvariantCulture)
                        .IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0))
                    result.ImportRow(r);
            return result;
        }
    }
}
