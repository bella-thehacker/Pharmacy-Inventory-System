<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Pharmacy_Inventory_System.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4 mb-5">

        <!-- Page Heading -->
        <div class="mb-4">
            <h2 class="fw-bold" style="color: #16324f;">
                Admin Panel
            </h2>

            <p class="text-muted">
                Manage staff accounts and oversee pharmacy operations.
            </p>
        </div>

        <!-- Access Message -->
        <asp:Label ID="lblAccessMessage" runat="server"
            CssClass="alert alert-danger d-block"
            Visible="false">
        </asp:Label>

        <!-- Admin Content -->
        <asp:Panel ID="pnlAdminContent" runat="server">

            <!-- Summary Cards -->
            <div class="row g-4 mb-4">

                <div class="col-md-4">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <h6 class="text-muted">Staff Accounts</h6>
                            <h3 class="fw-bold" style="color: #16324f;">Manage Staff</h3>
                            <p class="text-muted">
                                Create and manage staff accounts.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <h6 class="text-muted">Inventory</h6>
                            <h3 class="fw-bold" style="color: #16324f;">Stock Overview</h3>
                            <p class="text-muted">
                                Monitor medicine stock and inventory activity.
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <h6 class="text-muted">Reports</h6>
                            <h3 class="fw-bold" style="color: #16324f;">System Reports</h3>
                            <p class="text-muted">
                                Review sales and pharmacy performance.
                            </p>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Staff Management -->
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">

                    <h4 class="fw-bold mb-2" style="color: #16324f;">
                        Staff Management
                    </h4>

                    <p class="text-muted">
                        Create staff accounts and manage their access to PharmaTrack.
                    </p>

                    <asp:Button ID="btnAddStaff" runat="server"
                        Text="Add New Staff"
                        CssClass="btn btn-success"
                        PostBackUrl="~/AdminStaff.aspx" />

                    <hr />

                    <p class="text-muted mb-0">
                        Staff account records will appear here once account
                        management is connected to the database.
                    </p>

                </div>
            </div>

        </asp:Panel>

    </div>

</asp:Content>
