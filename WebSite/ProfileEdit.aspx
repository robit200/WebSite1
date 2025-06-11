<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ProfileEdit.aspx.cs" Inherits="WebSite.ProfileEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .edit-container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 600px;
            height: 700px;
            background-color: rgba(0, 0, 0, 0.8);
            border-radius: 10px;
            padding: 20px;
        }
        .profile-pic {
            width: 100px;
            height: 100px;
            border: thin solid black;
            border-radius: 50%;
            background-size: cover;
            background-position: center;
            margin-right: 10px;
            position: absolute;
            top: 20px;
            left: 20px;
        }
        .profile-name {
            font-family: 'Special Elite', cursive;
            font-size: 20px;
            color: wheat;
            z-index: 3;
            position: absolute;
            top: 50px;
            left: 140px;
        }
        .bio-edit {
            width: calc(100% - 60px);
            height: 100px;
            background-color: rgb(16, 16, 16, 0.95);
            padding: 10px;
            border-radius: 10px;
            font-family: 'Special Elite', cursive;
            font-size: 16px;
            color: white;
            position: absolute;
            top: 140px;
            left: 20px;
            resize: none;
        }
        .save-button {
            position: absolute;
            top: 260px;
            left: 20px;
            background-color: wheat;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            margin: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="edit-container">
        <div class="profile-pic" style="background-image: url('images/profile.jpg');"></div>
        <div class="profile-name" id="profilenameControl" runat="server"></div>
        <asp:TextBox ID="bioTextBox" runat="server" TextMode="MultiLine" Rows="4" Columns="50" CssClass="bio-edit" />
        <asp:Button ID="SaveButton" runat="server" Text="Save" CssClass="save-button" OnClick="SaveButton_Click" />
    </div>
</asp:Content>

