<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sales.aspx.cs" Inherits="Pharmacy_Inventory_System.Sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="sales-page">

     
        <div class="sales-header">
            <h2 class="fw-bold" style="color: #16324f;">Sales Management</h2>
            <p class="text-muted">
                Record pharmacy sales and manage customer transactions.
            </p>
        </div>

     
        <asp:Label ID="lblMessage" runat="server"
            CssClass="d-block mb-3"
            EnableViewState="false" />

      
        <div class="sales-section">

            <h4 class="panel-heading">New Sale</h4>
            <p class="panel-description">
                Select a medicine and enter the quantity to add it to the sale.
            </p>

            <div class="row g-3 align-items-end">

                <div class="col-lg-5 col-md-6">
                    <asp:Label ID="lblMedicine" runat="server"
                        Text="Select Medicine"
                        AssociatedControlID="ddlMedicine"
                        CssClass="form-label fw-semibold" />

                    <asp:DropDownList ID="ddlMedicine" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="-- Select medicine --" Value="" />
                    </asp:DropDownList>
                </div>

                <div class="col-lg-2 col-md-6">
                    <asp:Label ID="lblQuantity" runat="server"
                        Text="Quantity"
                        AssociatedControlID="txtQuantity"
                        CssClass="form-label fw-semibold" />

                    <asp:TextBox ID="txtQuantity" runat="server"
                        CssClass="form-control"
                        TextMode="Number"
                        min="1"
                        placeholder="Enter quantity" />

                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server"
                        ControlToValidate="txtQuantity"
                        ErrorMessage="Enter a quantity."
                        CssClass="text-danger small"
                        Display="Dynamic"
                        ValidationGroup="SaleItem" />

                    <asp:RangeValidator ID="rvQuantity" runat="server"
                        ControlToValidate="txtQuantity"
                        MinimumValue="1"
                        MaximumValue="100000"
                        Type="Integer"
                        ErrorMessage="Quantity must be a whole number greater than zero."
                        CssClass="text-danger small"
                        Display="Dynamic"
                        ValidationGroup="SaleItem" />
                </div>

               
                <div class="col-lg-2 col-md-6">
                    <label class="form-label fw-semibold">Unit Price</label>
                    <div class="form-control bg-light">
                        <asp:Label ID="lblUnitPrice" runat="server"
                            Text="Select medicine" />
                    </div>
                </div>

               
                <div class="col-lg-3 col-md-6">
                    <asp:Button ID="btnAddItem" runat="server"
                        Text="+ Add Item"
                        CssClass="btn btn-success w-100"
                        ValidationGroup="SaleItem" />
                </div>

            </div>
        </div>

       
        <div class="dashboard-panel mb-4">

            <h4 class="panel-heading">Sale Items</h4>
            <p class="panel-description">
                Review the medicines included in this transaction.
            </p>

            <div class="table-responsive">

                <asp:GridView ID="gvSaleItems" runat="server"
                    CssClass="table table-hover align-middle"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    EmptyDataText="No items have been added to this sale yet.">

                    <Columns>

                        <asp:BoundField DataField="MedicineName"
                            HeaderText="Medicine" />

                        <asp:BoundField DataField="Quantity"
                            HeaderText="Quantity" />

                        <asp:BoundField DataField="UnitPrice"
                            HeaderText="Unit Price"
                            DataFormatString="{0:N2}" />

                        <asp:BoundField DataField="LineTotal"
                            HeaderText="Subtotal"
                            DataFormatString="{0:N2}" />

                        <asp:ButtonField ButtonType="Button"
                            Text="Remove"
                            CommandName="RemoveItem"
                            ControlStyle-CssClass="btn btn-sm btn-outline-danger" />

                    </Columns>

                </asp:GridView>

            </div>

            <!-- Total of entire medicine sale thingy -->
           <div class="d-flex justify-content-end mt-3">
    <div class="sales-total">
        <div class="sales-total-label">SALE TOTAL</div>
        <div class="sales-total-value">
            KSh
            <asp:Label ID="lblGrandTotal" runat="server"
                Text="0.00" />
        </div>
    </div>
</div>

       
        <div class="dashboard-panel">

            <h4 class="panel-heading">Complete Transaction</h4>
            <p class="panel-description">
                Choose the payment method before completing the sale.
            </p>

            <div class="row g-3 align-items-end">

                <div class="col-md-4">
                    <asp:Label ID="lblPaymentMethod" runat="server"
                        Text="Payment Method"
                        AssociatedControlID="ddlPaymentMethod"
                        CssClass="form-label fw-semibold" />

                    <asp:DropDownList ID="ddlPaymentMethod" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="-- Select payment method --" Value="" />
                        <asp:ListItem Text="Cash" Value="Cash" />
                        <asp:ListItem Text="Mobile Money" Value="Mobile Money" />
                        <asp:ListItem Text="Card" Value="Card" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-8 d-flex justify-content-md-end gap-2">

                    <asp:Button ID="btnCancelSale" runat="server"
                        Text="Cancel Sale"
                        CssClass="btn btn-outline-secondary"
                        CausesValidation="false" />

                    <asp:Button ID="btnCompleteSale" runat="server"
                        Text="Complete Sale"
                        CssClass="btn btn-success px-4" />

                </div>

            </div>

        </div>

    </div>

    

<div class="sales-section sales-receipt-section">

    <h4 class="sales-section-title">Customer Receipt</h4>

    <p class="sales-section-description">
        Print a physical receipt or send a digital copy to the customer.
    </p>

    <div class="row g-3 align-items-end">

        <div class="col-md-6">
            <asp:Label ID="lblCustomerEmail" runat="server"
                Text="Customer Email Address"
                AssociatedControlID="txtCustomerEmail"
                CssClass="form-label fw-semibold" />

            <asp:TextBox ID="txtCustomerEmail" runat="server"
                CssClass="form-control"
                TextMode="Email"
                placeholder="customer@example.com" />

            <asp:RegularExpressionValidator
                ID="revCustomerEmail" runat="server"
                ControlToValidate="txtCustomerEmail"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Enter a valid email address."
                CssClass="text-danger small"
                Display="Dynamic" />
        </div>

        <div class="col-md-6 d-flex gap-2">

            <asp:Button ID="btnPrintReceipt" runat="server"
                Text="Print Receipt"
                CssClass="btn btn-outline-primary"
                CausesValidation="false" />

            <asp:Button ID="btnEmailReceipt" runat="server"
                Text="Email Receipt"
                CssClass="btn btn-primary"
                CausesValidation="false" />

        </div>

    </div>

</div>
    </div>


</asp:Content>
