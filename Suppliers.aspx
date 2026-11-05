<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Suppliers.aspx.cs" Inherits="Pharmacy_Inventory_System.Suppliers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="dashboard-page container-fluid">

    <!-- PAGE HEADER -->
    <div class="dashboard-header">
        <div>
            <h1>Suppliers</h1>
            <p>Manage pharmacy suppliers and their contact information.</p>
        </div>

        <asp:Button ID="btnAddSupplier" runat="server"
            Text="+ Add Supplier"
            CssClass="btn btn-primary"
            OnClientClick="showSupplierForm(); return false;" />
    </div>

    <!-- SUPPLIER STATISTICS -->
    <div class="row g-4 mb-4">

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL SUPPLIERS</span>
                    <div class="stat-icon icon-blue">🚚</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalSuppliers" runat="server" Text="0" />
                </div>
                <span class="stat-description">Registered suppliers</span>
            </div>
        </div>

    </div>

    <!-- ADD SUPPLIER FORM -->
    <asp:Panel ID="pnlSupplierForm" runat="server"
        ClientIDMode="Static" Visible="true"
        CssClass="dashboard-panel" style="display:none;">

        <div class="panel-heading">
            <h4>Add New Supplier</h4>
            <p class="panel-description">
                Enter the supplier's company and contact details.
            </p>
        </div>

        <div class="row g-3">

            <div class="col-md-6">
                <div class="form-group">
                    <label>Company Name</label>
                    <asp:TextBox ID="txtSupplierName" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Contact Person</label>
                    <asp:TextBox ID="txtContactPerson" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server"
                        CssClass="form-control" TextMode="Phone" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server"
                        CssClass="form-control" TextMode="Email" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Location</label>
                    <asp:TextBox ID="txtLocation" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Address</label>
                    <asp:TextBox ID="txtAddress" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

        </div>

        <!-- FORM BUTTONS -->
        <div class="form-actions mt-3">

            <asp:Button ID="btnSaveSupplier" runat="server"
                Text="Save Supplier"
                CssClass="btn btn-primary"
                OnClick="btnSaveSupplier_Click" />

            <asp:Button ID="btnCancel" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary"
                OnClientClick="hideSupplierForm(); return false;"
                CausesValidation="false" />

        </div>

        <asp:Label ID="lblMessage" runat="server" />

    </asp:Panel>

    <!-- SUPPLIER DIRECTORY -->
    <div class="dashboard-panel mt-4">

        <div class="panel-heading">
            <h4>Supplier Directory</h4>
            <p class="panel-description">
                View and search registered pharmacy suppliers.
            </p>
        </div>

        <!-- SEARCH SUPPLIERS -->
        <div class="search-container mb-3">

            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="search-input"
                placeholder="Search suppliers..." />

            <asp:Button ID="btnSearch" runat="server"
                Text="Search"
                CssClass="btn btn-primary"
                OnClick="btnSearch_Click" />

        </div>

        <!-- SUPPLIER TABLE -->
        <div class="table-responsive">

            <asp:GridView ID="gvSuppliers" runat="server"
                CssClass="table table-hover align-middle dashboard-table"
                AutoGenerateColumns="true"
                GridLines="None"
                EmptyDataText="No suppliers found." />

        </div>

    </div>

</div>

<!-- SUPPLIER JAVASCRIPT -->
<script>
function showSupplierForm() {
    document.getElementById("pnlSupplierForm");
}

function hideSupplierForm() {
    document.getElementById("pnlSupplierForm");
}
</script>

</asp:Content>
