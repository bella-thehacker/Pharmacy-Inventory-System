<%@ Page Title="Medicine" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Medicines.aspx.cs" Inherits="Pharmacy_Inventory_System.Medicines" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

 
<div class="dashboard-page container-fluid">

    <!-- PAGE HEADER -->
    <div class="dashboard-header">
        <div>
            <h1>Medicines</h1>
            <p>Manage medicines in your pharmacy inventory.</p>
        </div>

        <asp:Button ID="Button1" runat="server"
            Text="+ Add Medicine"
            CssClass="btn btn-primary"
            OnClientClick="showMedicineForm(); return false;" />
    </div>

    <!-- MEDICINE STATISTICS -->
    <div class="row g-4 mb-4">

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL MEDICINES</span>
                    <div class="stat-icon icon-teal">💊</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="Label1" runat="server" Text="0" />
                </div>
                <span class="stat-description">Registered medicines</span>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">LOW STOCK</span>
                    <div class="stat-icon icon-orange">⚠</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="Label2" runat="server" Text="0" />
                </div>
                <span class="stat-description">Medicines needing restocking</span>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">OUT OF STOCK</span>
                    <div class="stat-icon icon-red">!</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="Label3" runat="server" Text="0" />
                </div>
                <span class="stat-description">Medicines unavailable</span>
            </div>
        </div>

    </div>

    <!-- ADD MEDICINE FORM -->
    <asp:Panel ID="Panel1" runat="server"
        ClientIDMode="Static" Visible="true"
        CssClass="dashboard-panel" style="display:none;">

        <div class="panel-heading">
            <h4>Add New Medicine</h4>
            <p class="panel-description">
                Enter the details of the medicine.
            </p>
        </div>

        <div class="row g-3">

            <div class="col-md-6">
                <div class="form-group">
                    <label>Medicine Name</label>
                    <asp:TextBox ID="TextBox1" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Category</label>
                    <asp:DropDownList ID="DropDownList1" runat="server"
                        CssClass="form-control">
                        <asp:ListItem>Antibiotics</asp:ListItem>
                        <asp:ListItem>Painkillers</asp:ListItem>
                        <asp:ListItem>Antimalarials</asp:ListItem>
                        <asp:ListItem>Vitamins</asp:ListItem>
                        <asp:ListItem>Other</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Manufacturer</label>
                    <asp:TextBox ID="TextBox2" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Unit Price</label>
                    <asp:TextBox ID="TextBox3" runat="server"
                        CssClass="form-control" TextMode="Number" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Quantity</label>
                    <asp:TextBox ID="TextBox4" runat="server"
                        CssClass="form-control" TextMode="Number" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Supplier</label>
                    <asp:DropDownList ID="DropDownList2" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

        </div>

        <!-- FORM BUTTONS -->
        <div class="form-actions mt-3">

            <asp:Button ID="Button2" runat="server"
                Text="Save Medicine"
                CssClass="btn btn-primary"
                OnClick="btnSaveMedicine_Click" />

            <asp:Button ID="Button3" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary"
                OnClientClick="hideMedicineForm(); return false;"
                CausesValidation="false" />

        </div>

        <asp:Label ID="Label4" runat="server" />

    </asp:Panel>

    <!-- MEDICINE INVENTORY -->
    <div class="dashboard-panel mt-4">

        <div class="panel-heading">
            <h4>Medicine Inventory</h4>
            <p class="panel-description">
                View and search registered medicines.
            </p>
        </div>

        <div class="search-container mb-3">

            <asp:TextBox ID="TextBox5" runat="server"
                CssClass="search-input"
                placeholder="Search medicines..." />

            <asp:Button ID="Button4" runat="server"
                Text="Search"
                CssClass="btn btn-primary"
                OnClick="btnSearch_Click" />

        </div>

        <div class="table-responsive">

            <asp:GridView ID="GridView1" runat="server"
                CssClass="table table-hover align-middle dashboard-table"
                AutoGenerateColumns="true"
                GridLines="None"
                EmptyDataText="No medicines found." />

        </div>

    </div>

</div>

<!-- MEDICINE JAVASCRIPT -->
<script>
function showMedicineForm() {
    document.getElementById("pnlMedicineForm");
}

function hideMedicineForm() {
    document.getElementById("pnlMedicineForm");
}
</script>

</asp:Content>