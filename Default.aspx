
<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Pharmacy_Inventory_System._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="dashboard-page container-fluid">

    <!-- DASHBOARD HEADER -->
    <div class="dashboard-header">
        <div>
            <h1>Dashboard Overview</h1>
            <p>Welcome to PharmaTrack Pharmacy Inventory Management System.</p>
        </div>

        <div class="dashboard-date">
            <asp:Label ID="lblCurrentDate" runat="server" />
        </div>
    </div>

  
    <!-- MAIN STATISTICS -->
    <div class="row g-4 mb-4">

        <div class="col-xl-3 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL MEDICINES</span>
                    <div class="stat-icon icon-teal">💊</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalMedicines" runat="server" Text="8" />
                </div>
                <span class="stat-description">Registered medicine types</span>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">TOTAL SUPPLIERS</span>
                    <div class="stat-icon icon-blue">🚚</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalSuppliers" runat="server" Text="4" />
                </div>
                <span class="stat-description">Approved  suppliers</span>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">LOW STOCK ITEMS</span>
                    <div class="stat-icon icon-orange">⚠</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblLowStock" runat="server" Text="0" />
                </div>
                <span class="stat-description">Medicines needing restocking</span>
            </div>
        </div>

        <div class="col-xl-3 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">EXPIRING BATCHES</span>
                    <div class="stat-icon icon-red">⌛</div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblExpiringMedicines" runat="server" Text="0" />
                </div>
                <span class="stat-description">Batches nearing expiry</span>
            </div>
        </div>

    </div>

    <!-- SALES SUMMARY -->
    <div class="row g-4 mb-4">

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label"> SALES</span>
                    <div class="stat-icon icon-teal">🛒</div>
                </div>
                <div class="stat-value">KSh 17,020.00</div>
                <span class="stat-description">8 sample transactions</span>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">AVERAGE SALE</span>
                    <div class="stat-icon icon-blue">📊</div>
                </div>
                <div class="stat-value">KSh 2,127.50</div>
                <span class="stat-description">Average  transaction</span>
            </div>
        </div>

        <div class="col-xl-4 col-md-6">
            <div class="dashboard-stat">
                <div class="stat-top">
                    <span class="stat-label">PURCHASE VALUE</span>
                    <div class="stat-icon icon-orange">📦</div>
                </div>
                <div class="stat-value">KSh 10,400.00</div>
                <span class="stat-description">8 sample purchase records</span>
            </div>
        </div>

    </div>

    <!-- RECENT SALES AND ALERTS -->
    <div class="row g-4 mb-4">

        <!-- RECENT SALES -->
        <div class="col-lg-7">
            <div class="dashboard-panel">

                <div class="panel-heading">
                    <h4>Recent Sales</h4>
                    <p class="panel-description">
                        Latest sample pharmacy transactions
                    </p>
                </div>

                <div class="table-responsive">
                    <asp:GridView ID="gvRecentSales" runat="server"
                        CssClass="table table-hover align-middle dashboard-table"
                        AutoGenerateColumns="False"
                        GridLines="None"
                        EmptyDataText="No sales transactions recorded yet.">

                        <Columns>

                            <asp:BoundField DataField="SaleID"
                                HeaderText="Sale ID" />

                            <asp:BoundField DataField="SaleDate"
                                HeaderText="Date"
                                DataFormatString="{0:dd MMM yyyy}" />

                            <asp:BoundField DataField="Customer"
                                HeaderText="Customer" />

                            <asp:BoundField DataField="TotalAmount"
                                HeaderText="Amount (KSh)"
                                DataFormatString="{0:N2}" />

                        </Columns>

                    </asp:GridView>
                </div>

            </div>
        </div>

        <!-- INVENTORY ALERTS -->
        <div class="col-lg-5">
            <div class="dashboard-panel">

                <div class="panel-heading">
                    <h4>Inventory Alerts</h4>
                    <p class="panel-description">
                        Important stock notifications
                    </p>
                </div>

                <div class="alert-item">
                    <div class="alert-dot alert-warning"></div>
                    <div class="alert-content">
                        <strong>Low Stock Monitoring</strong>
                        <span>Review medicines with quantities at or below the stock limit.</span>
                    </div>
                </div>

                <div class="alert-item">
                    <div class="alert-dot alert-danger"></div>
                    <div class="alert-content">
                        <strong>Expiry Monitoring</strong>
                        <span>Check purchase batches approaching their expiry dates.</span>
                    </div>
                </div>

                <div class="alert-item">
                    <div class="alert-dot alert-warning"></div>
                    <div class="alert-content">
                        <strong>Stock Updates</strong>
                        <span>Record purchases and completed sales to maintain stock levels.</span>
                    </div>
                </div>

                <div class="alert-item">
                    <div class="alert-dot alert-danger"></div>
                    <div class="alert-content">
                        <strong>Payment Follow-up</strong>
                        <span>Review pending or partially paid supplier purchases.</span>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <!-- QUICK ACTIONS -->
    <div class="dashboard-panel quick-actions-panel">

        <div class="panel-heading">
            <h4>Quick Actions</h4>
            <p class="panel-description">
                Quickly access important pharmacy functions
            </p>
        </div>

        <div class="row g-3">

            <div class="col-xl-3 col-md-6">
                <a href="<%= ResolveUrl("~/Medicines.aspx") %>" class="quick-action">
                    <span class="quick-action-icon">💊</span>
                    <span>Add / Manage Medicines</span>
                </a>
            </div>

            <div class="col-xl-3 col-md-6">
                <a href="<%= ResolveUrl("~/Suppliers.aspx") %>" class="quick-action">
                    <span class="quick-action-icon">🚚</span>
                    <span>Manage Suppliers</span>
                </a>
            </div>

            <div class="col-xl-3 col-md-6">
                <a href="<%= ResolveUrl("~/Purchases.aspx") %>" class="quick-action">
                    <span class="quick-action-icon">📦</span>
                    <span>Record Purchase</span>
                </a>
            </div>

            <div class="col-xl-3 col-md-6">
                <a href="<%= ResolveUrl("~/Sales.aspx") %>" class="quick-action">
                    <span class="quick-action-icon">🛒</span>
                    <span>Record Sale</span>
                </a>
            </div>

        </div>

    </div>

</div>

</asp:Content>
