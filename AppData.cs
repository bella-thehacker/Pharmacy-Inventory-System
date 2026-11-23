using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;

namespace Pharmacy_Inventory_System
{
    public static class AppData
    {
        public const int LowStockLevel = 10;
        private static System.Web.SessionState.HttpSessionState S { get { return HttpContext.Current.Session; } }

        private static DataTable Get(string key, Func<DataTable> create)
        {
            if (S[key] == null) S[key] = create();
            return (DataTable)S[key];
        }

        private static DataTable Make(params object[][] columns)
        {
            DataTable table = new DataTable();
            foreach (object[] column in columns) table.Columns.Add((string)column[0], (Type)column[1]);
            return table;
        }

        private static DataTable SuppliersTable()
        {
            return Get("Suppliers", () => Make(
            new object[] { "Company", typeof(string) }, new object[] { "ContactPerson", typeof(string) },
            new object[] { "Phone", typeof(string) }, new object[] { "Email", typeof(string) },
            new object[] { "Location", typeof(string) }, new object[] { "Address", typeof(string) }));
        }

        private static DataTable MedicinesTable()
        {
            return Get("Medicines", () => Make(
            new object[] { "Medicine", typeof(string) }, new object[] { "Category", typeof(string) },
            new object[] { "Manufacturer", typeof(string) }, new object[] { "Price", typeof(decimal) },
            new object[] { "Quantity", typeof(int) }, new object[] { "Supplier", typeof(string) }));
        }

        private static DataTable PurchasesTable()
        {
            return Get("Purchases", () => Make(
            new object[] { "PurchaseDate", typeof(string) }, new object[] { "Supplier", typeof(string) },
            new object[] { "Medicine", typeof(string) }, new object[] { "Quantity", typeof(int) },
            new object[] { "UnitCost", typeof(decimal) }, new object[] { "TotalCost", typeof(decimal) },
            new object[] { "BatchNumber", typeof(string) }, new object[] { "ExpiryDate", typeof(string) },
            new object[] { "InvoiceNumber", typeof(string) }, new object[] { "PaymentStatus", typeof(string) }));
        }

        private static DataTable SalesTable()
        {
            return Get("Sales", () => Make(
            new object[] { "SaleID", typeof(string) }, new object[] { "SaleDate", typeof(DateTime) },
            new object[] { "Customer", typeof(string) }, new object[] { "PaymentMethod", typeof(string) },
            new object[] { "TotalAmount", typeof(decimal) }));
        }

        public static DataTable SaleItems
        {
            get
            {
                return Get("SaleItems", () => Make(
            new object[] { "SaleID", typeof(string) }, new object[] { "MedicineName", typeof(string) },
            new object[] { "Quantity", typeof(int) }, new object[] { "UnitPrice", typeof(decimal) },
            new object[] { "LineTotal", typeof(decimal) }));
            }
        }

        public static DataTable Suppliers { get { SeedData(); return SuppliersTable(); } }
        public static DataTable Medicines { get { SeedData(); return MedicinesTable(); } }
        public static DataTable Purchases { get { SeedData(); return PurchasesTable(); } }
        public static DataTable Sales { get { SeedData(); return SalesTable(); } }

        public static void SeedData()
        {
            if (String.Equals(Convert.ToString(S["PharmaTrackDataVersion"]), "2", StringComparison.Ordinal)) return;
            // Refresh the older starter records once; subsequent visits preserve changes made in this session.
            SuppliersTable().Clear(); MedicinesTable().Clear(); SalesTable().Clear(); SaleItems.Clear(); PurchasesTable().Clear();
            DataTable suppliers = SuppliersTable();
            if (suppliers.Rows.Count == 0)
            {
                string[,] supplierData = {
                    {"Beta Healthcare", "Peter Mwangi", "0712345678", "orders@betahealthcare.co.ke", "Nairobi", "Industrial Area, Nairobi"},
                    {"Laborex Kenya", "Grace Wanjiku", "0723456789", "sales@laborex.co.ke", "Nairobi", "Mombasa Road, Nairobi"},
                    {"Cosmos Limited", "Brian Otieno", "0734567890", "info@cosmos.co.ke", "Kisumu", "Kisumu, Kenya"},
                    {"Phillips Pharma", "Mercy Njeri", "0745678901", "orders@phillipspharma.co.ke", "Nakuru", "Nakuru, Kenya"},
                    {"Nairobi Med Supplies", "David Kiptoo", "0701122334", "sales@nairobi-med.co.ke", "Nairobi", "Kariobangi, Nairobi"},
                    {"AfyaCare Distributors", "Faith Achieng", "0711223344", "contact@afyacare.co.ke", "Thika", "Thika, Kenya"},
                    {"Medlink Pharmaceuticals", "James Mutua", "0722334455", "orders@medlink.co.ke", "Mombasa", "Mombasa, Kenya"},
                    {"HealthPlus Wholesale", "Lydia Chebet", "0733445566", "sales@healthplus.co.ke", "Eldoret", "Eldoret, Kenya"},
                    {"Prime Medical Distributors", "Samuel Maina", "0744556677", "info@primemedical.co.ke", "Nyeri", "Nyeri, Kenya"},
                    {"Amani Pharma Supplies", "Ruth Wambui", "0755667788", "orders@amanipharma.co.ke", "Machakos", "Machakos, Kenya"}
                };
                for (int i = 0; i < supplierData.GetLength(0); i++)
                {
                    DataRow r = suppliers.NewRow();
                    r["Company"] = supplierData[i, 0]; r["ContactPerson"] = supplierData[i, 1];
                    r["Phone"] = supplierData[i, 2]; r["Email"] = supplierData[i, 3];
                    r["Location"] = supplierData[i, 4]; r["Address"] = supplierData[i, 5]; suppliers.Rows.Add(r);
                }
            }

            DataTable medicines = MedicinesTable();
            if (medicines.Rows.Count == 0)
            {
                object[,] medicineData = {
                    {"Paracetamol 500mg","Pain Relief","KEMSA Pharmaceutical",5m,250,"Beta Healthcare"},
                    {"Amoxicillin 500mg","Antibiotics","Medisel Kenya",18m,120,"Laborex Kenya"},
                    {"Ibuprofen 400mg","Pain Relief","Universal Corporation",12m,140,"Beta Healthcare"},
                    {"Metronidazole 400mg","Antibiotics","Cosmos Limited",15m,8,"Cosmos Limited"},
                    {"Vitamin C 500mg","Vitamins and Supplements","Phillips Pharma",15m,180,"Phillips Pharma"},
                    {"Cetirizine 10mg","Allergy","Dawa Limited",10m,90,"Nairobi Med Supplies"},
                    {"ORS Sachets","Rehydration","Reckitt",30m,75,"AfyaCare Distributors"},
                    {"Metformin 500mg","Diabetes","Cosmos Limited",12m,100,"Cosmos Limited"},
                    {"Omeprazole 20mg","Gastric Care","Laboratory & Allied",16m,65,"Medlink Pharmaceuticals"},
                    {"Aspirin 75mg","Pain Relief","Bayer",8m,0,"HealthPlus Wholesale"},
                    {"Ciprofloxacin 500mg","Antibiotics","Dawa Limited",22m,45,"Nairobi Med Supplies"},
                    {"Loratadine 10mg","Allergy","Universal Corporation",14m,35,"AfyaCare Distributors"},
                    {"Co-trimoxazole 960mg","Antibiotics","KEMSA Pharmaceutical",20m,55,"Laborex Kenya"},
                    {"Diclofenac 50mg","Pain Relief","Novartis",11m,28,"Prime Medical Distributors"},
                    {"Salbutamol Inhaler","Respiratory","GlaxoSmithKline",350m,18,"Phillips Pharma"},
                    {"Multivitamin Tablets","Vitamins and Supplements","Nature's Way",25m,80,"Amani Pharma Supplies"},
                    {"Ferrous Sulphate 200mg","Supplements","Dawa Limited",9m,110,"Cosmos Limited"},
                    {"Hydrocortisone Cream 1%","Skin Care","Trianon",85m,22,"Medlink Pharmaceuticals"},
                    {"Calamine Lotion 100ml","Skin Care","Reckitt",120m,16,"HealthPlus Wholesale"},
                    {"Loperamide 2mg","Gastric Care","Universal Corporation",7m,60,"Prime Medical Distributors"}
                };
                for (int i = 0; i < medicineData.GetLength(0); i++)
                {
                    DataRow r = medicines.NewRow(); r["Medicine"] = medicineData[i, 0]; r["Category"] = medicineData[i, 1];
                    r["Manufacturer"] = medicineData[i, 2]; r["Price"] = medicineData[i, 3]; r["Quantity"] = medicineData[i, 4];
                    r["Supplier"] = medicineData[i, 5]; medicines.Rows.Add(r);
                }
            }

            DataTable sales = SalesTable();
            if (sales.Rows.Count == 0)
            {
                string[] customers = { "Jane Wambui", "Brian Kiptoo", "Mercy Achieng", "Kevin Mwangi", "Anne Njeri", "Peter Otieno", "Faith Chebet", "Daniel Mutua", "Mary Atieno", "John Kamau" };
                string[] methods = { "Cash", "M-Pesa", "Card", "M-Pesa", "Cash" };
                DateTime first = new DateTime(2026, 10, 1);
                for (int i = 0; i < 30; i++)
                {
                    string id = "SAL" + (i + 1).ToString("000");
                    decimal total = 420m + ((i * 317) % 4200);
                    DateTime date = first.AddDays(i);
                    DataRow sale = sales.NewRow(); sale["SaleID"] = id; sale["SaleDate"] = date;
                    sale["Customer"] = customers[i % customers.Length]; sale["PaymentMethod"] = methods[i % methods.Length]; sale["TotalAmount"] = total; sales.Rows.Add(sale);
                    DataRow item = SaleItems.NewRow(); item["SaleID"] = id; item["MedicineName"] = medicines.Rows[i % medicines.Rows.Count]["Medicine"];
                    item["Quantity"] = 1 + (i % 4); item["UnitPrice"] = Math.Round(total / (1 + (i % 4)), 2); item["LineTotal"] = total; SaleItems.Rows.Add(item);
                }
            }
            S["PharmaTrackDataVersion"] = "2";
        }

        // Compatibility with older pages that still call the previous method name.
        public static void SeedDemoData()
        {
            SeedData();
        }

        public static string[] SupplierNames() { SeedData(); return SuppliersTable().AsEnumerable().Select(r => r.Field<string>("Company")).Where(x => !String.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase).OrderBy(x => x).ToArray(); }
        public static string[] MedicineNames() { SeedData(); return MedicinesTable().AsEnumerable().Select(r => r.Field<string>("Medicine")).Where(x => !String.IsNullOrWhiteSpace(x)).Distinct(StringComparer.OrdinalIgnoreCase).OrderBy(x => x).ToArray(); }

        public static DataTable Filter(DataTable source, string search)
        {
            search = (search ?? "").Trim(); if (search.Length == 0) return source;
            DataTable result = source.Clone();
            foreach (DataRow row in source.Rows)
                if (row.ItemArray.Any(v => Convert.ToString(v, CultureInfo.InvariantCulture).IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0)) result.ImportRow(row);
            return result;
        }
    }
}
