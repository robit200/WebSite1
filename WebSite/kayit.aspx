<%@ Page Title="" Language="C#" MasterPageFile="~/giris.Master" AutoEventWireup="true" CodeBehind="kayit.aspx.cs" Inherits="WebSite.kayit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .giris{
    font-family: 'Special Elite';
    position:absolute;
    z-index:3;
    display:flex;
    flex-direction:column;
    right: 22px;
    top: 250px;
    padding: 20px;
    border-radius:30px;
    background-color: rgba(0,0,0,0.7);
}
.giris input[type="text"], .giris input[type="password"]  {
    margin-bottom:10px;
    margin-top:10px;
    padding: 5px;
    border-radius:10px;
    border:1px solid #ccc;
    background-color: #333333;
    color:white;
    font-size:20px;
    width:400px;
    height:50px;
}
 .giris-button {
     font-family:'Special Elite';
     width:43%;
     margin-top:10px;
     margin-left:123px;
     padding:10px;
     border-radius:10px;
     border:none;
     background-color:#444444;
     color:white;
     font-size:20px;
     cursor:pointer;
 }
 .giris-button:hover {
     background-color:#555555;
 }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <div class="giris">
     <asp:TextBox ID="nameTextBox" runat="server" placeholder="Enter your name" CssClass="form-control" />
     <asp:Label ID="nameErrorLabel" runat="server" CssClass="error-message" ForeColor="Red" Visible="false" Text="Name is required." />
     
     <asp:TextBox ID="surnameTextBox" runat="server" placeholder="Enter your surname" CssClass="form-control" />
     <asp:Label ID="surnameErrorLabel" runat="server" CssClass="error-message" ForeColor="Red" Visible="false" Text="Surname is required." />
     
     <asp:TextBox ID="emailTextBox" runat="server" placeholder="Enter your email" CssClass="form-control" />
     <asp:Label ID="emailErrorLabel" runat="server" CssClass="error-message" ForeColor="Red" Visible="false" Text="Email is required." />
     
     <asp:TextBox ID="usernameTextBox" runat="server" placeholder="Enter your username" CssClass="form-control" />
     <asp:Label ID="usernameErrorLabel" runat="server" CssClass="error-message" ForeColor="Red" Visible="false" Text="Username is required." />
     
     <asp:TextBox ID="passwordTextBox" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="form-control" />
     <asp:Label ID="passwordErrorLabel" runat="server" CssClass="error-message" ForeColor="Red" Visible="false" Text="Password is required." />
     
     <asp:Button ID="SignUpButton" runat="server" Text="Sign Up" OnClick="SignUp_Click" CssClass="giris-button" />
 </div>
</asp:Content>
