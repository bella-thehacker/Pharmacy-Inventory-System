<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Pharmacy_Inventory_System.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4 mb-5 admin-page">

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
            
            <!-- Activity Logs -->
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-body p-4">

                    <div class="d-flex justify-content-between
                        align-items-center flex-wrap mb-2">

                        <div>
                            <h4 class="fw-bold mb-1 admin-section-title">
                                Activity Logs
                            </h4>

                            <p class="text-muted mb-0">
                                Monitor user logins and pharmacy activities.
                            </p>
                        </div>

                        <span class="badge bg-success">
                            Recent Activities
                        </span>

                    </div>

                    <hr />

                    <!-- Activity Filters -->
                    <div class="row g-3 mb-4">

                        <div class="col-md-4">
                            <label class="form-label">Employee</label>

                            <asp:DropDownList ID="ddlEmployee"
                                runat="server" CssClass="form-select">
                                <asp:ListItem>All Employees</asp:ListItem>
                                <asp:ListItem>Jane Doe</asp:ListItem>
                                <asp:ListItem>John Smith</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Activity Type</label>

                            <asp:DropDownList ID="ddlActivity"
                                runat="server" CssClass="form-select">
                                <asp:ListItem>All Activities</asp:ListItem>
                                <asp:ListItem>Login</asp:ListItem>
                                <asp:ListItem>Logout</asp:ListItem>
                                <asp:ListItem>Sale</asp:ListItem>
                                <asp:ListItem>Purchase</asp:ListItem>
                                <asp:ListItem>Stock Update</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Activity Date</label>

                            <asp:TextBox ID="txtActivityDate"
                                runat="server" TextMode="Date"
                                CssClass="form-control">
                            </asp:TextBox>
                        </div>

                    </div>

                    <!-- Activity Table -->
                    <div class="table-responsive">

                        <table class="table table-hover align-middle">

                            <thead>
                                <tr>
                                    <th>Employee</th>
                                    <th>Activity</th>
                                    <th>Description</th>
                                    <th>Date & Time</th>
                                </tr>
                            </thead>

                            <tbody>

                                <tr>
                                    <td>Monica Geller</td>
                                    <td>
                                        <span class="badge bg-success">
                                            Login
                                        </span>
                                    </td>
                                    <td>Signed into PharmaTrack</td>
                                    <td>07 Nov 2026, 08:15 AM</td>
                                </tr>

                                <tr>
                                    <td>Chandler Bing</td>
                                    <td>
                                        <span class="badge bg-primary">
                                            Sale
                                        </span>
                                    </td>
                                    <td>Completed sale #102</td>
                                    <td>07 Nov 2026, 08:42 AM</td>
                                </tr>

                                <tr>
                                    <td>Phoebe Buffay</td>
                                    <td>
                                        <span class="badge bg-info text-dark">
                                            Purchase
                                        </span>
                                    </td>
                                    <td>Recorded purchase #205</td>
                                    <td>07 Nov 2026, 09:05 AM</td>
                                </tr>

                                <tr>
                                    <td>Joey Tribbianni</td>
                                    <td>
                                        <span class="badge bg-secondary">
                                            Logout
                                        </span>
                                    </td>
                                    <td>Signed out of PharmaTrack</td>
                                    <td>07 Nov 2026, 09:30 AM</td>
                                </tr>

                                <tr>
                                    <td>Racheal Green</td>
                                    <td>
                                        <span class="badge bg-warning text-dark">
                                            Stock Update
                                        </span>
                                    </td>
                                    <td>Updated medicine stock quantity</td>
                                    <td>07 Nov 2026, 10:10 AM</td>
                                </tr>

                            </tbody>

                        </table>

                    </div>

                    <p class="text-muted small mb-0">
                        Demo logs install actuall logs after.
                    </p>

                </div>
            </div>


        </asp:Panel>

    </div>

</asp:Content>
