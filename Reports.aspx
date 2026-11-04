<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="Pharmacy_Inventory_System.Reports" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlReports" runat="server"
        CssClass="reports-page">

      
        <asp:Panel ID="pnlHeading" runat="server"
            CssClass="reports-header">

            <asp:Label ID="lblTitle" runat="server"
                Text="Reports & Analytics"
                CssClass="reports-title" />

            <asp:Label ID="lblDescription" runat="server"
                Text="Monitor pharmacy sales and inventory performance."
                CssClass="reports-description" />

        </asp:Panel>


        <asp:Panel ID="pnlSummary" runat="server"
            CssClass="reports-summary">

            <asp:Panel ID="pnlSales" runat="server"
                CssClass="report-card">

                <asp:Label ID="lblSalesHeading" runat="server"
                    Text="TOTAL SALES"
                    CssClass="report-card-title" />

                <asp:Label ID="lblTotalSales" runat="server"
                    Text="KSh 0.00"
                    CssClass="report-card-value" />

                <asp:Label ID="lblSalesNote" runat="server"
                    Text="Completed sales revenue"
                    CssClass="report-card-note" />

            </asp:Panel>


            <asp:Panel ID="pnlTransactions" runat="server"
                CssClass="report-card">

                <asp:Label ID="lblTransactionsHeading" runat="server"
                    Text="TRANSACTIONS"
                    CssClass="report-card-title" />

                <asp:Label ID="lblTransactions" runat="server"
                    Text="0"
                    CssClass="report-card-value" />

                <asp:Label ID="lblTransactionsNote" runat="server"
                    Text="Completed sales"
                    CssClass="report-card-note" />

            </asp:Panel>


            <asp:Panel ID="pnlItems" runat="server"
                CssClass="report-card">

                <asp:Label ID="lblItemsHeading" runat="server"
                    Text="ITEMS SOLD"
                    CssClass="report-card-title" />

                <asp:Label ID="lblItemsSold" runat="server"
                    Text="0"
                    CssClass="report-card-value" />

                <asp:Label ID="lblItemsNote" runat="server"
                    Text="Total quantities sold"
                    CssClass="report-card-note" />

            </asp:Panel>


            <asp:Panel ID="pnlMedicines" runat="server"
                CssClass="report-card">

                <asp:Label ID="lblMedicinesHeading" runat="server"
                    Text="MEDICINES"
                    CssClass="report-card-title" />

                <asp:Label ID="lblMedicineCount" runat="server"
                    Text="0"
                    CssClass="report-card-value" />

                <asp:Label ID="lblMedicinesNote" runat="server"
                    Text="Registered medicines"
                    CssClass="report-card-note" />

            </asp:Panel>

        </asp:Panel>


       
        <asp:Panel ID="pnlFilters" runat="server"
            CssClass="report-panel">

            <asp:Label ID="lblFilterTitle" runat="server"
                Text="Generate Sales Report"
                CssClass="report-panel-title" />

            <asp:Label ID="lblFilterDescription" runat="server"
                Text="Choose a date range to view sales performance."
                CssClass="report-panel-description" />

            <div class="row g-3 align-items-end">

                <div class="col-md-4">

                    <asp:Label ID="lblStartDate" runat="server"
                        Text="Start Date"
                        AssociatedControlID="txtStartDate"
                        CssClass="form-label" />

                    <asp:TextBox ID="txtStartDate" runat="server"
                        TextMode="Date"
                        CssClass="form-control" />

                </div>


                <div class="col-md-4">

                    <asp:Label ID="lblEndDate" runat="server"
                        Text="End Date"
                        AssociatedControlID="txtEndDate"
                        CssClass="form-label" />

                    <asp:TextBox ID="txtEndDate" runat="server"
                        TextMode="Date"
                        CssClass="form-control" />

                </div>


                <div class="col-md-4">

                    <asp:Button ID="btnGenerate" runat="server"
                        Text="Generate Report"
                        CssClass="btn btn-success w-100" />

                </div>

            </div>

        </asp:Panel>

      
       <!-- Chart -->
        <asp:Panel ID="pnlSalesChart" runat="server"
            CssClass="report-panel">

            <asp:Label ID="lblChartTitle" runat="server"
                Text="Monthly Sales Performance"
                CssClass="report-panel-title" />

            <asp:Label ID="lblChartDescription" runat="server"
                Text="Visual overview of pharmacy sales revenue."
                CssClass="report-panel-description" />

         <div class="report-chart-container">

    <canvas id="salesChart"></canvas>

</div>

<asp:Label ID="lblChartMessage" runat="server"
    Text="Sales chart will appear here once transaction data is available."
    CssClass="report-chart-message" />

        </asp:Panel>


        
        <asp:Panel ID="pnlSalesReport" runat="server"
            CssClass="report-panel">

            <asp:Label ID="lblSalesReportTitle" runat="server"
                Text="Sales Transactions"
                CssClass="report-panel-title" />

            <asp:Label ID="lblSalesReportDescription" runat="server"
                Text="Detailed records of completed sales."
                CssClass="report-panel-description" />

            <div class="table-responsive">

                <asp:GridView ID="gvSales" runat="server"
                    CssClass="table table-hover align-middle"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    EmptyDataText="No sales records found.">

                    <Columns>

                        <asp:BoundField DataField="SaleID"
                            HeaderText="Sale ID" />

                        <asp:BoundField DataField="SaleDate"
                            HeaderText="Date"
                            DataFormatString="{0:dd MMM yyyy}" />

                        <asp:BoundField DataField="PaymentMethod"
                            HeaderText="Payment Method" />

                        <asp:BoundField DataField="TotalAmount"
                            HeaderText="Total Amount"
                            DataFormatString="{0:N2}" />

                    </Columns>

                </asp:GridView>

            </div>

        </asp:Panel>


       
        <asp:Panel ID="pnlStockReport" runat="server"
            CssClass="report-panel">

            <asp:Label ID="lblStockReportTitle" runat="server"
                Text="Inventory Summary"
                CssClass="report-panel-title" />

            <asp:Label ID="lblStockReportDescription" runat="server"
                Text="Overview of available pharmacy stock."
                CssClass="report-panel-description" />

            <div class="table-responsive">

                <asp:GridView ID="gvStock" runat="server"
                    CssClass="table table-hover align-middle"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    EmptyDataText="No inventory records found.">

                    <Columns>

                        <asp:BoundField DataField="MedicineName"
                            HeaderText="Medicine" />

                        <asp:BoundField DataField="Quantity"
                            HeaderText="Available Stock" />

                        <asp:BoundField DataField="UnitPrice"
                            HeaderText="Unit Price"
                            DataFormatString="{0:N2}" />

                        <asp:BoundField DataField="ExpiryDate"
                            HeaderText="Expiry Date"
                            DataFormatString="{0:dd MMM yyyy}" />

                    </Columns>

                </asp:GridView>

            </div>

        </asp:Panel>

    </asp:Panel>

  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    window.addEventListener("load", function () {

        var chartCanvas = document.getElementById("salesChart");

        if (!chartCanvas) {
            return;
        }

        if (typeof window.Chart === "undefined") {
            console.error("Chart.js did not load.");
            return;
        }

        var salesChart = new window.Chart(chartCanvas, {
            type: "bar",

            data: {
                labels: [
                    "January", "February", "March",
                    "April", "May", "June"
                ],

                datasets: [{
                    label: "Monthly Sales (KSh)",
                    data: [0, 0, 0, 0, 0, 0],
                    backgroundColor: "#16a085",
                    borderRadius: 6
                }]
            },

            options: {
                responsive: true,
                maintainAspectRatio: false,

                plugins: {
                    legend: {
                        display: true
                    }
                },

                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

    });
</script>
</asp:Content>

