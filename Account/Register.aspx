
<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Pharmacy_Inventory_System.Account.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-page">
        <div class="auth-card register-card">

            <div class="auth-brand">
                <div class="auth-logo">PT</div>
                <h1>PharmaTrack</h1>
                <p>Pharmacy Inventory Management System</p>
            </div>

            <div class="auth-heading">
                <h2>Create Your Account</h2>
                <p>Register to access the pharmacy workspace.</p>
            </div>

            <div class="auth-form">

                <div class="auth-field">
                    <label for="<%= txtFullName.ClientID %>">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server"
                        CssClass="form-control"
                        placeholder="Enter your full name">
                    </asp:TextBox>
                </div>

                <div class="auth-field">
                    <label for="<%= txtEmail.ClientID %>">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server"
                        TextMode="Email"
                        CssClass="form-control"
                        placeholder="Enter your email address">
                    </asp:TextBox>
                </div>

                <div class="auth-field">
                    <label for="<%= txtPassword.ClientID %>">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server"
                        TextMode="Password"
                        CssClass="form-control"
                        placeholder="Create a password">
                    </asp:TextBox>
                </div>

                <div class="auth-field">
                    <label for="<%= txtConfirmPassword.ClientID %>">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server"
                        TextMode="Password"
                        CssClass="form-control"
                        placeholder="Enter your password again">
                    </asp:TextBox>
                </div>

                <asp:Label ID="lblMessage" runat="server"
                    CssClass="auth-message">
                </asp:Label>

                <asp:Button ID="btnRegister" runat="server"
                    Text="Create Account"
                    CssClass="auth-button" />

            </div>

            <div class="auth-footer">
                Already have an account?
                <a href="Login.aspx">Sign In</a>
            </div>

        </div>

        <div class="auth-bottom">
            Secure access to your pharmacy management system.
        </div>
    </div>

</asp:Content>
