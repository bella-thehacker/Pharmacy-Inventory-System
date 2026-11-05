<%@ Page Title="Purchases" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Purchases.aspx.cs" Inherits="Pharmacy_Inventory_System.Purchases" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="dashboard-page container-fluid">

    <!-- PAGE HEADER -->
    <div class="dashboard-header">
        <div>
            <h1>Purchases</h1>
            <p>Record and manage pharmacy purchases.</p>
        </div>

        <asp:Button ID="btnAddPurchase" runat="server"
            Text="+ Record Purchase"
            CssClass="btn btn-primary"
            OnClientClick="showPurchaseForm(); return false;" />
    </div>

    <!-- PURCHASE STATISTICS -->
    <div class="row g-4 mb-4">

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL PURCHASES</span>
                    <div class="stat-icon icon-teal">📦</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalPurchases" runat="server" Text="0" />
                </div>
                <span class="stat-description">Recorded purchases</span>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">PURCHASE VALUE</span>
                    <div class="stat-icon icon-blue">💰</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblPurchaseValue" runat="server" Text="Ksh 0.00" />
                </div>
                <span class="stat-description">Total purchase expenditure</span>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">PENDING PURCHASES</span>
                    <div class="stat-icon icon-orange">⌛</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblPending" runat="server" Text="0" />
                </div>
                <span class="stat-description">Purchases awaiting payment</span>
            </div>
        </div>

    </div>

    <!-- RECORD PURCHASE FORM -->
    <asp:Panel ID="pnlPurchaseForm" runat="server"
        ClientIDMode="Static" Visible="true"
        CssClass="dashboard-panel" style="display:none;">

        <div class="panel-heading">
            <h4>Record New Purchase</h4>
            <p class="panel-description">
                Enter the details of the medicine purchase.
            </p>
        </div>

        <div class="row g-3">

            <div class="col-md-6">
                <div class="form-group">
                    <label>Purchase Date</label>
                    <asp:TextBox ID="txtPurchaseDate" runat="server"
                        CssClass="form-control" TextMode="Date" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Supplier</label>
                    <asp:DropDownList ID="ddlSupplier" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Medicine</label>
                    <asp:DropDownList ID="ddlMedicine" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Quantity</label>
                    <asp:TextBox ID="txtQuantity" runat="server"
                        ClientIDMode="Static"
                        CssClass="form-control" TextMode="Number"
                        oninput="calculateTotal()" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Unit Cost (Ksh)</label>
                    <asp:TextBox ID="txtUnitCost" runat="server"
                        ClientIDMode="Static"
                        CssClass="form-control" TextMode="Number"
                        oninput="calculateTotal()" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Batch Number</label>
                    <asp:TextBox ID="txtBatchNumber" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Expiry Date</label>
                    <asp:TextBox ID="txtExpiryDate" runat="server"
                        CssClass="form-control" TextMode="Date" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Invoice Number</label>
                    <asp:TextBox ID="txtInvoice" runat="server"
                        CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Payment Status</label>
                    <asp:DropDownList ID="ddlPaymentStatus" runat="server"
                        CssClass="form-control">
                        <asp:ListItem>Paid</asp:ListItem>
                        <asp:ListItem>Pending</asp:ListItem>
                        <asp:ListItem>Partially Paid</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

        </div>

        <!-- PURCHASE TOTAL -->
        <div class="dashboard-panel mt-4">

            <div class="panel-heading">
                <h4>Purchase Total</h4>
                <p class="panel-description">
                    Quantity multiplied by unit cost.
                </p>
            </div>

            <asp:Button ID="btnCalculate" runat="server"
                Text="Calculate Total"
                CssClass="btn btn-secondary"
                OnClick="btnCalculate_Click"
                CausesValidation="false" />

            <asp:Label ID="lblTotalCost" runat="server"
                ClientIDMode="Static" Text="Ksh 0.00" />

        </div>

        <!-- FORM BUTTONS -->
        <div class="form-actions mt-3">

            <asp:Button ID="btnSavePurchase" runat="server"
                Text="Save Purchase"
                CssClass="btn btn-primary"
                OnClick="btnSavePurchase_Click" />

            <asp:Button ID="btnCancel" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary"
                OnClientClick="hidePurchaseForm(); return false;"
                CausesValidation="false" />

        </div>

        <asp:Label ID="lblMessage" runat="server" />

    </asp:Panel>

    <!-- PURCHASE HISTORY -->
    <div class="dashboard-panel mt-4">

        <div class="panel-heading">
            <h4>Purchase History</h4>
            <p class="panel-description">
                View and search recorded pharmacy purchases.
            </p>
        </div>

        <div class="search-container mb-3">

            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="search-input"
                placeholder="Search purchases..." />

            <asp:Button ID="btnSearch" runat="server"
                Text="Search"
                CssClass="btn btn-primary"
                OnClick="btnSearch_Click" />

        </div>

        <div class="table-responsive">

            <asp:GridView ID="gvPurchases" runat="server"
                CssClass="table table-hover align-middle dashboard-table"
                AutoGenerateColumns="true"
                GridLines="None"
                EmptyDataText="No purchases found." />

        </div>

    </div>

</div>

<!-- PURCHASE JAVASCRIPT -->
<script>
function showPurchaseForm() {
    document.getElementById("pnlPurchaseForm");
}

function hidePurchaseForm() {
    document.getElementById("pnlPurchaseForm");
}

function calculateTotal() {
    var quantity = Number(document.getElementById("txtQuantity"));
    var cost = Number(document.getElementById("txtUnitCost"));

    var total = quantity * cost;

    document.getElementById("lblTotalCost") =
        "Ksh " + total.toFixed(2);
}
</script>

</asp:Content>
