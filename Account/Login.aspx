
<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Pharmacy_Inventory_System.Account.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">

                <div class="card shadow">
                    <div class="card-body p-4">

                        <h2 class="text-center">PharmaTrack</h2>
                        <p class="text-center">Pharmacy Inventory System</p>

                        <hr />

                        <h4 class="text-center mb-4">Sign In</h4>

                        <label>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server"
                            CssClass="form-control mb-3">
                        </asp:TextBox>

                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server"
                            TextMode="Password"
                            CssClass="form-control mb-3">
                        </asp:TextBox>

                        <asp:Button ID="btnLogin" runat="server"
                            Text="Sign In"
                            CssClass="btn btn-dark w-100" />

                        <asp:Label ID="lblMessage" runat="server"
                            CssClass="text-danger">
                        </asp:Label>

                        <hr />

                        <p class="text-center">
                            Don't have an account?
                            <a href="Register.aspx">Create an Account</a>
                        </p>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
