<%@ Page Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebSite.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Letterly</title>
<style>
    @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css');
    .profil-alan {
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
        z-index: 3;
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
    .profile-bio {
        width: 90%;
        height: 100px;
        background-color: rgb(16, 16, 16, 0.95);
        padding: 10px;
        border-radius: 10px;
        font-family: 'Special Elite', cursive;
        font-size: 16px;
        color: white;
        margin-top: 140px;
        position: relative;
    }
    .edit-button {
        position: absolute;
        top: 20px;
        right: 20px;
        background-color: wheat;
        border: none;
        padding: 10px;
        cursor: pointer;
        border-radius: 5px;
    }
    .header {
         text-align: center;
        font-size: 50px;
        margin: 20px 0;
        cursor: pointer;
         position: fixed;
        top: 0;
         background-color: #121212;
        z-index: 1000;
        padding: 10px 0;
         right: 0;
    }
    .header .icons {
        display: flex;
        justify-content: flex-end;
        align-items: flex-start; 
        margin-top:0;
        z-index:3;
    }
    .header .icons i {
        font-size: 24px;
        margin-left: 20px;
        cursor: pointer;
    }
</style>
    <script type="text/javascript">
        function redirectToHome() {
            window.location.href = 'main.aspx';
        }

        function redirectToLogout() {
            window.location.href = 'giris.aspx';
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="header">
         <div class="icons">
             <i class="fas fa-home" onclick="redirectToHome()"></i>
             <i class="fas fa-sign-out-alt" onclick="redirectToLogout()"></i>
         </div>
     </div>
    <div class="profil-alan">
        <div id="profilepic" class="profile-pic" runat="server"></div>
        <div id="profilename" class="profile-name" runat="server"></div>
        <div id="profilebio" class="profile-bio" runat="server"></div>
        <asp:Button ID="editButton" runat="server" Text="Edit" CssClass="edit-button" OnClick="EditButton_Click" />
    </div>

</asp:Content>

