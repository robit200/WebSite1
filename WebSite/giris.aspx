<%@ Page Title="" Language="C#" MasterPageFile="~/giris.Master" AutoEventWireup="true" CodeBehind="giris.aspx.cs" Inherits="WebSite.giris1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .giris{
            font-family: 'Special Elite';
            position:absolute;
            z-index:3;
            display:flex;
            flex-direction:column;
            right: 22px;
            top: 350px;
            padding: 20px;
            border-radius:30px;
            background-color: rgba(0,0,0,0.7);
        }
        .giris input[type="text"], .giris input[type="password"] {
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
        .giris .buttons {
            display:flex;
            flex-direction:row;
            justify-content:space-between;
            align-items:center;
        }
        .giris button, .giris .btn-primary {
            font-family:'Special Elite';
            width:43%;
            margin-top:10px;
            margin-left:5px;
            padding:10px;
            border-radius:10px;
            border:none;
            background-color:#444444;
            color:white;
            font-size:20px;
            cursor:pointer;
        }
        .giris button:hover, .giris .btn-primary:hover {
            background-color:#555555;
        }
        .giris .or {
            font-size:20px;
            margin: 0 5px 0 5px;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
    <script type="text/javascript">
        function validateForm() {
            var email = document.getElementById("email").value;
            var password = document.getElementById("password").value;
            var isValid = true;

            if (email === "") {
                document.getElementById("emailError").innerText = "Email cannot be empty";
                isValid = false;
            } else {
                document.getElementById("emailError").innerText = "";
            }

            if (password === "") {
                document.getElementById("passwordError").innerText = "Password cannot be empty";
                isValid = false;
            } else {
                document.getElementById("passwordError").innerText = "";
            }

            return isValid;
        }
        function redirectToSignUpPage() {
            window.location.href = 'kayit.aspx';
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPLaceHolder1" runat="server">
    <div class="giris">
        <input type="text" id="email" name="email" placeholder="Enter your Email"/> 
        <div id="emailError" class="error-message"></div>
        <input type="password" id="password" name="password" placeholder="Enter your password" />
        <div id="passwordError" class="error-message"></div>
        <div class="buttons">
            <asp:Button ID="Button1" runat="server" Text="Login" OnClientClick="return validateForm();" OnClick="LoginButton_Click" CssClass="btn-primary" />
            <span class="or">or</span>
            <button type="button" class="btn-primary" onclick="redirectToSignUpPage()">Sign Up</button>
        </div>
    </div>
</asp:Content>
