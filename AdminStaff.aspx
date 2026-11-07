<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminStaff.aspx.cs" Inherits="Pharmacy_Inventory_System.AdminStaff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4 mb-5">

        <!-- Page Heading -->
        <div class="mb-4">
            <h2 class="fw-bold" style="color: #16324f;">
                Staff Management
            </h2>
            <p class="text-muted">
                Create staff accounts and manage your pharmacy team.
            </p>
        </div>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="d-block mb-3">
        </asp:Label>

        <!-- Create Staff Account -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body p-4">

                <h4 class="fw-bold mb-2" style="color: #16324f;">
                    Create Staff Account
                </h4>

                <p class="text-muted mb-4">
                    Enter the details below to register a new staff member.
                    New accounts will automatically receive the Staff role.
                </p>

                <div class="row g-3">

                    <div class="col-md-6">
                        <asp:Label ID="lblStaffName" runat="server"
                            Text="Full Name"
                            AssociatedControlID="txtStaffName"
                            CssClass="form-label" />

                        <asp:TextBox ID="txtStaffName" runat="server"
                            CssClass="form-control"
                            placeholder="Enter full name" />

                        <asp:RequiredFieldValidator ID="valStaffName"
                            runat="server"
                            ControlToValidate="txtStaffName"
                            ErrorMessage="Please enter the staff member's name."
                            CssClass="text-danger"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label ID="lblStaffEmail" runat="server"
                            Text="Email Address"
                            AssociatedControlID="txtStaffEmail"
                            CssClass="form-label" />

                        <asp:TextBox ID="txtStaffEmail" runat="server"
                            CssClass="form-control"
                            TextMode="Email"
                            placeholder="Enter email address" />

                        <asp:RequiredFieldValidator ID="valStaffEmail"
                            runat="server"
                            ControlToValidate="txtStaffEmail"
                            ErrorMessage="Please enter an email address."
                            CssClass="text-danger"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label ID="lblStaffPassword" runat="server"
                            Text="Password"
                            AssociatedControlID="txtStaffPassword"
                            CssClass="form-label" />

                        <asp:TextBox ID="txtStaffPassword" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Create a password" />

                        <asp:RequiredFieldValidator ID="valStaffPassword"
                            runat="server"
                            ControlToValidate="txtStaffPassword"
                            ErrorMessage="Please enter a password."
                            CssClass="text-danger"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6">
                        <asp:Label ID="lblConfirmPassword" runat="server"
                            Text="Confirm Password"
                            AssociatedControlID="txtConfirmPassword"
                            CssClass="form-label" />

                        <asp:TextBox ID="txtConfirmPassword" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Confirm password" />

                        <asp:CompareValidator ID="valConfirmPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtStaffPassword"
                            ErrorMessage="Passwords do not match."
                            CssClass="text-danger"
                            Display="Dynamic" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Account Role</label>
                        <asp:TextBox ID="txtStaffRole" runat="server"
                            CssClass="form-control"
                            Text="Staff"
                            ReadOnly="true" />
                    </div>

                </div>

                <div class="mt-4">
                    <asp:Button ID="btnCreateStaff" runat="server"
                        Text="Create Staff Account"
                        CssClass="btn btn-success"
                        OnClick="btnCreateStaff_Click" />
                </div>

            </div>
        </div>

        <!-- Staff List -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">

                <h4 class="fw-bold mb-2" style="color: #16324f;">
                    Registered Staff
                </h4>

                <p class="text-muted mb-4">
                    Staff accounts registered in the system will appear here.
                </p>

                <div class="table-responsive">

                    <asp:GridView ID="gvStaff" runat="server"
                        CssClass="table table-hover"
                        AutoGenerateColumns="False"
                        EmptyDataText="No staff accounts have been added yet."
                        GridLines="None">

                        <Columns>
                            <asp:BoundField DataField="StaffID"
                                HeaderText="Staff ID" />

                            <asp:BoundField DataField="StaffName"
                                HeaderText="Full Name" />

                            <asp:BoundField DataField="Email"
                                HeaderText="Email Address" />

                            <asp:BoundField DataField="Role"
                                HeaderText="Role" />
                        </Columns>

                    </asp:GridView>

                </div>

            </div>
        </div>

    </div>

</asp:Content>

