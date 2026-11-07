
<%@ Page Title="Sign In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Pharmacy_Inventory_System.Account.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="auth-page">
        <div class="auth-card">

            <div class="auth-brand">
                <div class="auth-logo">PT</div>
                <h1>PharmaTrack</h1>
                <p>Pharmacy Inventory Management System</p>
            </div>

            <div class="auth-heading">
                <h2>Welcome Back</h2>
                <p>Sign in to access your pharmacy workspace.</p>
            </div>

            <div class="auth-form">

                <div class="auth-field">
                    <label for="<%= txtEmail.ClientID %>">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server"
                        CssClass="form-control"
                        TextMode="Email"
                        placeholder="Enter your email address">
                    </asp:TextBox>
                </div>

                <div class="auth-field">
                    <label for="<%= txtPassword.ClientID %>">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server"
                        TextMode="Password"
                        CssClass="form-control"
                        placeholder="Enter your password">
                    </asp:TextBox>
                </div>

                <asp:Label ID="lblMessage" runat="server"
                    CssClass="auth-message">
                </asp:Label>

                <asp:Button ID="btnLogin" runat="server"
                    Text="Sign In"
                    CssClass="auth-button"
                    OnClick="btnLogin_Click" />

            </div>

            <div class="auth-footer">
                Don't have an account?
                <a href="Register.aspx">Create an Account</a>
            </div>

        </div>

        <div class="auth-bottom">
            Secure access to your pharmacy management system.
        </div>
    </div>

</asp:Content>
