<%@ Page Title="Purchases" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Purchases.aspx.cs" Inherits="Pharmacy_Inventory_System.Purchases" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="dashboard-page container-fluid">

    <!-- PAGE HEADER -->
    <div class="dashboard-header">
        <div>
            <h1>Purchases</h1>
            <p>Record and manage pharmacy purchases.</p>
        </div>
        <asp:Button ID="btnAddPurchase" runat="server" Text="+ Record Purchase"
            CssClass="btn btn-primary"
            OnClientClick="showPurchaseForm(); return false;" />
    </div>

    <!-- STATUS MESSAGE (outside the hidden form so it is always visible) -->
    <asp:Label ID="lblMessage" runat="server" />

    <!-- PURCHASE STATISTICS -->
    <div class="row g-4 mb-4">
        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL PURCHASES</span>
                    <div class="stat-icon icon-teal">📦</div>
                </div>
                <div class="stat-value"><asp:Label ID="lblTotalPurchases" runat="server" Text="0" /></div>
                <span class="stat-description">Recorded purchases</span>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">PURCHASE VALUE</span>
                    <div class="stat-icon icon-blue">💰</div>
                </div>
                <div class="stat-value"><asp:Label ID="lblPurchaseValue" runat="server" Text="Ksh 0.00" /></div>
                <span class="stat-description">Total purchase expenditure</span>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">PENDING PURCHASES</span>
                    <div class="stat-icon icon-orange">⌛</div>
                </div>
                <div class="stat-value"><asp:Label ID="lblPending" runat="server" Text="0" /></div>
                <span class="stat-description">Purchases awaiting payment</span>
            </div>
        </div>
    </div>

    <!-- RECORD PURCHASE FORM -->
    <asp:Panel ID="pnlPurchaseForm" runat="server" ClientIDMode="Static" Visible="true"
        CssClass="dashboard-panel" style="display:none;">

        <div class="panel-heading">
            <h4>Record New Purchase</h4>
            <p class="panel-description">Enter the details of the medicine purchase.</p>
        </div>

        <div class="row g-3">
            <div class="col-md-6"><div class="form-group">
                <label>Purchase Date</label>
                <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-control" TextMode="Date" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Supplier</label>
                <asp:DropDownList ID="ddlSupplier" runat="server" CssClass="form-control" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Medicine</label>
                <asp:DropDownList ID="ddlMedicine" runat="server" CssClass="form-control" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Quantity</label>
                <asp:TextBox ID="txtQuantity" runat="server" ClientIDMode="Static" CssClass="form-control"
                    TextMode="Number" step="1" min="1" oninput="calculateTotal()" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Unit Cost (Ksh)</label>
                <asp:TextBox ID="txtUnitCost" runat="server" ClientIDMode="Static" CssClass="form-control"
                    TextMode="Number" step="0.01" min="0" oninput="calculateTotal()" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Batch Number</label>
                <asp:TextBox ID="txtBatchNumber" runat="server" CssClass="form-control" MaxLength="50" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Expiry Date</label>
                <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" TextMode="Date" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Invoice Number</label>
                <asp:TextBox ID="txtInvoice" runat="server" CssClass="form-control" MaxLength="50" />
            </div></div>
            <div class="col-md-6"><div class="form-group">
                <label>Payment Status</label>
                <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="form-control">
                    <asp:ListItem>Paid</asp:ListItem>
                    <asp:ListItem>Pending</asp:ListItem>
                    <asp:ListItem>Partially Paid</asp:ListItem>
                </asp:DropDownList>
            </div></div>
        </div>

        <!-- PURCHASE TOTAL -->
        <div class="dashboard-panel mt-4">
            <div class="panel-heading">
                <h4>Purchase Total</h4>
                <p class="panel-description">Quantity multiplied by unit cost.</p>
            </div>
            <asp:Button ID="btnCalculate" runat="server" Text="Calculate Total"
                CssClass="btn btn-secondary"
                OnClientClick="calculateTotal(); return false;" CausesValidation="false" />
            <asp:Label ID="lblTotalCost" runat="server" ClientIDMode="Static" Text="Ksh 0.00" />
        </div>

        <!-- FORM BUTTONS -->
        <div class="form-actions mt-3">
            <asp:Button ID="btnSavePurchase" runat="server" Text="Save Purchase"
                CssClass="btn btn-primary" OnClick="btnSavePurchase_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                CssClass="btn btn-secondary"
                OnClientClick="hidePurchaseForm(); return false;" CausesValidation="false" />
        </div>
    </asp:Panel>

    <!-- PURCHASE HISTORY -->
    <div class="dashboard-panel mt-4">
        <div class="panel-heading">
            <h4>Purchase History</h4>
            <p class="panel-description">View and search recorded pharmacy purchases.</p>
        </div>

        <div class="search-container mb-3">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search purchases..." />
            <asp:Button ID="btnSearch" runat="server" Text="Search"
                CssClass="btn btn-primary" OnClick="btnSearch_Click" />
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvPurchases" runat="server"
                CssClass="table table-hover align-middle dashboard-table"
                AutoGenerateColumns="false" GridLines="None"
                EmptyDataText="No purchases found.">
                <Columns>
                    <asp:BoundField DataField="PurchaseDate" HeaderText="Purchase Date" />
                    <asp:BoundField DataField="Supplier" HeaderText="Supplier" />
                    <asp:BoundField DataField="Medicine" HeaderText="Medicine" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="UnitCost" HeaderText="Unit Cost (Ksh)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="TotalCost" HeaderText="Total Cost (Ksh)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="BatchNumber" HeaderText="Batch Number" />
                    <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" />
                    <asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice Number" />
                    <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</div>

<!-- PURCHASE JAVASCRIPT -->
<script>
function showPurchaseForm() { document.getElementById("pnlPurchaseForm").style.display = "block"; }
function hidePurchaseForm() { document.getElementById("pnlPurchaseForm").style.display = "none"; }

function calculateTotal() {
    var quantity = parseFloat(document.getElementById("txtQuantity").value) || 0;
    var cost = parseFloat(document.getElementById("txtUnitCost").value) || 0;
    document.getElementById("lblTotalCost").textContent = "Ksh " + (quantity * cost).toFixed(2);
}
</script>

</asp:Content>