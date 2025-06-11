<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="letter.aspx.cs" Inherits="WebSite.letter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Letterly</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Special+Elite&display=swap');
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css');
        body {
            font-family: 'Special Elite', cursive;
            background-color: #121212;
            color: #ffffff;
            display: flex;
            flex-direction: row;
            height: 100vh;
            margin: 0;
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
            left: 45%;
        }
        .side {
            width: 50px;
            background-color: #030303d7;
            box-sizing: border-box;
            height: 100%;
            padding: 10px;
            position: fixed;
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .side button {
            background: none;
            border: none;
            color: #ffffff;
            font-size: 24px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 10px 0;
        }
        .side button i {
            font-size: 24px;
        }
        .profile-button {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .profile-pic {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-size: cover;
            background-position: center;
            margin-bottom: 5px;
        }
        .sidebar {
            width: 375px;
            background-color: #1e1e1e;
            padding: 20px;
            box-sizing: border-box;
            height: 100%;
            overflow-y: auto;
            margin-left: 50px; /* side öğesinin genişliği kadar boşluk bırak */
        }
        .sidebar .menu {
            margin-bottom: 20px;
        }
        .sidebar .menu button {
            background: linear-gradient(135deg, #444444, #666666);
            color: #ffffff;
            border: none;
            padding: 10px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            font-family: 'Special Elite';
            margin-bottom: 10px;
            width: 100%;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .sidebar .menu button:hover {
            background: linear-gradient(135deg, #555555, #777777);
            transform: scale(1.05);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
        }
        .sidebar .menu button:active {
            background: linear-gradient(135deg, #666666, #888888);
            transform: scale(0.95);
        }
        .inbox {
            flex-grow: 1;
            padding: 20px;
            box-sizing: border-box;
            overflow-y: auto;
        }
        .inbox .letter-item {
            background-color: #2e2e2e;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .inbox .letter-item:hover {
            background-color: #3e3e3e;
        }
        .inbox-head {
            font-size: 31px;
            margin: 0;
            border-bottom: 2px solid #ffffff;
            padding-bottom: 10px;
            width: 100%;
            text-align: center;
        }
        .letter-container {
            width: 175%;
            height: 75%;
            border: 1px solid #ffffff;
            padding: 20px;
            box-sizing: border-box;
            background-color: #1e1e1e;
            position: relative;
            margin-top: 100px;
            margin-left: 10px;
        }
        .letter-content {
            width: 100%;
            height: calc(100% - 60px);
            display: flex;
            flex-direction: column;
        }
        .letter-content textarea {
            flex-grow: 1;
            margin-bottom: 10px;
            background-color: #2e2e2e;
            color: #ffffff;
            border: 1px solid #ffffff;
            resize: none;
            width: 100%;
            height: 100%;
        }
        .letter-content input[type="file"] {
            margin-bottom: 10px;
            color: #ffffff;
        }
        .letter-content input[type="text"] {
            margin-bottom: 10px;
            background-color: #2e2e2e;
            color: #ffffff;
            border: 1px solid #ffffff;
            width: 100%;
        }
        .letter-content input[type="submit"] {
            background-color: #444444;
            color: #ffffff;
            border: none;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 20px;
            font-family: 'Special Elite';
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
        }
        .letter-content input[type="submit"]:hover {
            background-color: #555555;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .toolbar {
            display: flex;
            flex-wrap: nowrap;
            margin-bottom: 10px;
            overflow: hidden;
            width: 100%;
        }
        .toolbar .category {
            display: flex;
            margin-right: 10px;
        }
        .toolbar button {
            background: linear-gradient(135deg, #444444, #666666);
            color: #ffffff;
            border: none;
            padding: 10px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
            font-family: 'Special Elite';
            margin-right: 5px;
            transition: background 0.3s, transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .toolbar button:hover {
            background: linear-gradient(135deg, #555555, #777777);
            transform: scale(1.05);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
        }
        .toolbar button:active {
            background: linear-gradient(135deg, #666666, #888888);
            transform: scale(0.95);
        }
        .toolbar button i {
            margin-right: 5px;
        }
    </style>
    <script>
        function redirectToMain() {
            window.location.href = 'main.aspx';
        }

        function formatText(command, value = null) {
            document.execCommand(command, false, value);
        }

        function logout() {
            window.location.href = 'giris.aspx';
        }
    </script>
</head>
<body>
    <div class="header" onclick="redirectToMain()">Letterly</div>
    <div class="side">
        <button onclick="window.location.href='main.aspx'">
            <i class="fas fa-home"></i>
        </button>
        <button class="profile-button" onclick="window.location.href='Profile.aspx'">
            <div id="profilePic" class="profile-pic" runat="server"></div>
        </button>
        <button onclick="window.location.href='settings.aspx'">
            <i class="fas fa-cog"></i>
        </button>
        <button onclick="logout()">
            <i class="fas fa-sign-out-alt"></i>
        </button>
    </div>
    <div class="sidebar">
        <div class="inbox-head">INBOX</div>
        <div class="inbox">
            <asp:Repeater ID="inboxRepeater" runat="server">
                <ItemTemplate>
                    <div class="letter-item">
                        <strong><%# Eval("Sender") %></strong><br />
                        <%# Eval("Subject") %><br />
                        <small><%# Eval("SentDate") %></small>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <form id="form1" runat="server">
        <div class="letter-container">
            <div class="toolbar">
                <div class="category">
                    <button type="button" onclick="formatText('bold')"><i class="fas fa-bold"></i></button>
                    <button type="button" onclick="formatText('italic')"><i class="fas fa-italic"></i></button>
                    <button type="button" onclick="formatText('underline')"><i class="fas fa-underline"></i></button>
                </div>
                <div class="category">
                    <button type="button" onclick="formatText('justifyLeft')"><i class="fas fa-align-left"></i></button>
                    <button type="button" onclick="formatText('justifyCenter')"><i class="fas fa-align-center"></i></button>
                    <button type="button" onclick="formatText('justifyRight')"><i class="fas fa-align-right"></i></button>
                    <button type="button" onclick="formatText('justifyFull')"><i class="fas fa-align-justify"></i></button>
                </div>
                <div class="category">
                    <button type="button" onclick="formatText('foreColor', prompt('Enter a color:', 'black'))"><i class="fas fa-palette"></i></button>
                </div>
                <div class="category">
                    <button type="button" onclick="formatText('insertOrderedList')"><i class="fas fa-list-ol"></i></button>
                    <button type="button" onclick="formatText('insertUnorderedList')"><i class="fas fa-list-ul"></i></button>
                </div>
                <div class="category">
                    <button type="button" onclick="formatText('undo')"><i class="fas fa-undo"></i></button>
                    <button type="button" onclick="formatText('redo')"><i class="fas fa-redo"></i></button>
                </div>
                <div class="category">
                    <button type="button" onclick="formatText('createLink', prompt('Enter a URL:', 'http://'))"><i class="fas fa-link"></i></button>
                    <button type="button"><i class="fas fa-image"></i></button>
                </div>
            </div>
            <div class="letter-content">
                <input type="text" id="recipient" runat="server" placeholder="Recipient Username" />
                <input type="file" id="fileUpload" runat="server" />
                <textarea id="letterText" runat="server" rows="20" placeholder="Write your letter here..."></textarea>
                <asp:Button ID="sendButton" runat="server" Text="Send" OnClick="SendButton_Click" CssClass="btn-primary" />
            </div>
        </div>
    </form>
</body>
</html>

