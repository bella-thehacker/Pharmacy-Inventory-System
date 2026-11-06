<%@ Page Title="Medicine" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Medicines.aspx.cs" Inherits="Pharmacy_Inventory_System.Medicines" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="dashboard-page container-fluid">

    <!-- PAGE HEADER -->
    <div class="dashboard-header">
        <div>
            <h1>Medicines</h1>
            <p>Manage medicines in your pharmacy inventory.</p>
        </div>
        <asp:Button ID="btnAddMedicine" runat="server" Text="+ Add Medicine"
            CssClass="btn btn-primary"
            OnClientClick="showMedicineForm(); return false;" />
    </div>

    <!-- STATUS MESSAGE (outside the hidden form so it is always visible) -->
    <asp:Label ID="lblMessage" runat="server" />

    <!-- MEDICINE STATISTICS -->
    <div class="row g-4 mb-4">
        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL MEDICINES</span>
                    <div class="stat-icon icon-teal">💊</div>
                </div>
                <div class="stat-value"><asp:Label ID="lblTotalMedicines" runat="server" Text="0" /></div>
                <span class="stat-description">Registered medicines</span>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">LOW STOCK</span>
                    <div class="stat-icon icon-orange">⚠</div>
                </div>
                <div class="stat-value"><asp:Label ID="lblLowStock" runat="server" Text="0" /></div>
                <span class="stat-description">Medicines needing restocking</span>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">OUT OF STOCK</span>
                    <div class="stat-icon icon-red">!</div>
                </div>
                <div class="stat-value"><asp:Label ID="lblOutOfStock" runat="server" Text="0" /></div>
                <span class="stat-description">Medicines unavailable</span>
            </div>
        </div>
    </div>

    <!-- ADD MEDICINE FORM -->
    <asp:Panel ID="pnlMedicineForm" runat="server" ClientIDMode="Static" Visible="true"
        CssClass="dashboard-panel" style="display:none;">

        <div class="panel-heading">
            <h4>Add New Medicine</h4>
            <p class="panel-description">Enter the details of the medicine.</p>
        </div>

        <div class="row g-3">
            <div class="col-md-6"><div class="form-group">
                <label>Medicine Name</label>
                <asp:TextBox ID="txtMedicineName" runat="server" CssClass="form-control" MaxLength="150" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                    <asp:ListItem>Antibiotics</asp:ListItem>
                    <asp:ListItem>Painkillers</asp:ListItem>
                    <asp:ListItem>Antimalarials</asp:ListItem>
                    <asp:ListItem>Vitamins</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>
                </asp:DropDownList>
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Manufacturer</label>
                <asp:TextBox ID="txtManufacturer" runat="server" CssClass="form-control" MaxLength="150" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Unit Price</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"
                    TextMode="Number" step="0.01" min="0" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Quantity</label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"
                    TextMode="Number" step="1" min="0" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Supplier</label>
                <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="form-control" />
            </div></div>
        </div>

        <!-- FORM BUTTONS -->
        <div class="form-actions mt-3">
            <asp:Button ID="btnSaveMedicine" runat="server" Text="Save Medicine"
                CssClass="btn btn-primary" OnClick="btnSaveMedicine_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                CssClass="btn btn-secondary"
                OnClientClick="hideMedicineForm(); return false;" CausesValidation="false" />
        </div>
    </asp:Panel>

    <!-- MEDICINE INVENTORY -->
    <div class="dashboard-panel mt-4">
        <div class="panel-heading">
            <h4>Medicine Inventory</h4>
            <p class="panel-description">View and search registered medicines.</p>
        </div>

        <div class="search-container mb-3">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search medicines..." />
            <asp:Button ID="btnSearch" runat="server" Text="Search"
                CssClass="btn btn-primary" OnClick="btnSearch_Click" />
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvMedicines" runat="server"
                CssClass="table table-hover align-middle dashboard-table"
                AutoGenerateColumns="false" GridLines="None"
                EmptyDataText="No medicines found.">
                <Columns>
                    <asp:BoundField DataField="Medicine" HeaderText="Medicine" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" />
                    <asp:BoundField DataField="Price" HeaderText="Price (Ksh)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="Supplier" HeaderText="Supplier" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</div>

<!-- MEDICINE JAVASCRIPT -->
<script>
function showMedicineForm() { document.getElementById("pnlMedicineForm").style.display = "block"; }
function hideMedicineForm() { document.getElementById("pnlMedicineForm").style.display = "none"; }
</script>

</asp:Content>