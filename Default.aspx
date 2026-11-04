
<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Pharmacy_Inventory_System._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="dashboard-page container-fluid">

        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div>
                <h1>Dashboard Overview</h1>
                <p>Welcome to PharmaTrack Pharmacy Inventory Management System.</p>
            </div>

            <div class="dashboard-date">
                <asp:Label ID="lblCurrentDate" runat="server" />
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row g-4 mb-4">

            <div class="col-xl-3 col-md-6">
                <div class="dashboard-stat">
                    <div class="stat-top">
                        <span class="stat-label">TOTAL MEDICINES</span>
                        <div class="stat-icon icon-teal">💊</div>
                    </div>
                    <div class="stat-value">
                        <asp:Label ID="lblTotalMedicines" runat="server" Text="0" />
                    </div>
                    <span class="stat-description">Registered medicines</span>
                </div>
            </div>

            <div class="col-xl-3 col-md-6">
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
                        <span class="stat-label">EXPIRING MEDICINES</span>
                        <div class="stat-icon icon-red">⌛</div>
                    </div>
                    <div class="stat-value">
                        <asp:Label ID="lblExpiringMedicines" runat="server" Text="0" />
                    </div>
                    <span class="stat-description">Medicines nearing expiry</span>
                </div>
            </div>

        </div>

        <!-- Recent Sales and Inventory Alerts -->
        <div class="row g-4 mb-4">

            <!-- Recent Sales -->
            <div class="col-lg-7">
                <div class="dashboard-panel">

                    <div class="panel-heading">
                        <h4>Recent Sales</h4>
                        <p class="panel-description">
                            Overview of recent pharmacy transactions
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

                                <asp:BoundField DataField="TotalAmount"
                                    HeaderText="Amount"
                                    DataFormatString="{0:N2}" />
                            </Columns>

                        </asp:GridView>
                    </div>

                </div>
            </div>

            <!-- Inventory Alerts -->
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
                            <span>Check medicines that need restocking.</span>
                        </div>
                    </div>

                    <div class="alert-item">
                        <div class="alert-dot alert-danger"></div>
                        <div class="alert-content">
                            <strong>Expiry Monitoring</strong>
                            <span>Review medicines approaching expiry.</span>
                        </div>
                    </div>

                    <div class="alert-item">
                        <div class="alert-dot alert-warning"></div>
                        <div class="alert-content">
                            <strong>Stock Updates</strong>
                            <span>Keep inventory quantities up to date.</span>
                        </div>
                    </div>

                </div>
            </div>

        </div>

        <!-- Quick Actions -->
        <div class="dashboard-panel quick-actions-panel">

            <div class="panel-heading">
                <h4>Quick Actions</h4>
                <p class="panel-description">
                    Quickly access important pharmacy functions
                </p>
            </div>

            <div class="row g-3">

                <div class="col-xl-3 col-md-6">
                    <a href="Medicines.aspx" class="quick-action">
                        <span class="quick-action-icon">💊</span>
                        <span>Add / Manage Medicines</span>
                    </a>
                </div>

                <div class="col-xl-3 col-md-6">
                    <a href="Suppliers.aspx" class="quick-action">
                        <span class="quick-action-icon">🚚</span>
                        <span>Manage Suppliers</span>
                    </a>
                </div>

                <div class="col-xl-3 col-md-6">
                    <a href="Purchases.aspx" class="quick-action">
                        <span class="quick-action-icon">📦</span>
                        <span>Record Purchase</span>
                    </a>
                </div>

                <div class="col-xl-3 col-md-6">
                    <a href="Sales.aspx" class="quick-action">
                        <span class="quick-action-icon">🛒</span>
                        <span>Record Sale</span>
                    </a>
                </div>

            </div>

        </div>

    </div>

</asp:Content>
