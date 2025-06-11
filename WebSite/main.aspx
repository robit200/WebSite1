<%@ Page Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="WebSite.main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>letterly</title> 
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Add to your <head> section -->
<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
<script src="https://cdn.amcharts.com/lib/5/map.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
    <!-- Add to your <body> (e.g., inside ContentPlaceHolder1) -->
<div id="chartdiv" style="width: 100%; height: 500px;"></div>
<div id="user-location" style="margin:10px 0; font-weight:bold;"></div>
    <script>
        // 1. Get user geolocation (country)
        fetch('http://ip-api.com/json/')
            .then(response => response.json())
            .then(data => {
                document.getElementById('user-location').innerText = "Your country: " + data.country;
            });

        // 2. Fetch account counts per country from your backend
        // Replace '/api/GetAccountCounts' with your actual endpoint
        let countryCounts = {};
        fetch('/api/GetAccountCounts')
            .then(response => response.json())
            .then(data => {
                countryCounts = data; // { "US": 123, "TR": 45, ... }
                drawMap();
            });

        // 3. Draw interactive map
        function drawMap() {
            am5.ready(function () {
                var root = am5.Root.new("chartdiv");
                root.setThemes([am5themes_Animated.new(root)]);

                var chart = root.container.children.push(
                    am5map.MapChart.new(root, {
                        panX: "none",
                        panY: "none",
                        wheelY: "none",
                        projection: am5map.geoMercator()
                    })
                );

                var polygonSeries = chart.series.push(
                    am5map.MapPolygonSeries.new(root, {
                        geoJSON: am5geodata_worldLow
                    })
                );

                polygonSeries.mapPolygons.template.setAll({
                    tooltipText: "{name}",
                    interactive: true
                });

                polygonSeries.mapPolygons.template.events.on("pointerover", function (ev) {
                    var countryId = ev.target.dataItem.dataContext.id;
                    var countryName = ev.target.dataItem.dataContext.name;
                    var count = countryCounts[countryId] || 0;
                    ev.target.set("tooltipText", countryName + "\nAccounts: " + count);
                });
            });
        }
</script>
    <script>
        function sendMessageToBot() {
            var userMessage = document.getElementById("userMessage").value;
            $.ajax({
                type: "POST",
                url: "main.aspx/SendMessageToDialogflow",
                data: JSON.stringify({ message: userMessage }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Bot cevabını göster
                    document.getElementById("botResponse").innerText = response.d;
                },
                error: function (err) {
                    console.error("Error:", err);
                    document.getElementById("botResponse").innerText = "Bir hata oluştu. Lütfen tekrar deneyin.";
                }
            });
        }

        function redirectToLetterPage() {
            window.location.href = 'letter.aspx';
        }
    </script>
    <!-- In your <head> section, include Leaflet CSS/JS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<!-- In your <body> (inside ContentPlaceHolder1), add the map container -->
<div id="map" style="width: 100%; height: 500px;"></div>

<!-- At the end of your <body> or inside <asp:Content> -->
<script>
    // ...your fetch and AJAX code...

    function drawMap() {
        // Center of the world
        var map = L.map('map').setView([20, 0], 2);

        // Add OpenStreetMap tiles
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 5,
            attribution: '© OpenStreetMap'
        }).addTo(map);

        // Load GeoJSON for countries (use a public source)
        fetch('https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json')
            .then(res => res.json())
            .then(geojson => {
                L.geoJSON(geojson, {
                    style: function (feature) {
                        // Highlight user's country
                        if (feature.properties.ISO_A2 === userCountry) {
                            return { color: "#ff7800", weight: 2, fillOpacity: 0.5 };
                        }
                        return { color: "#3388ff", weight: 1, fillOpacity: 0.2 };
                    },
                    onEachFeature: function (feature, layer) {
                        let code = feature.properties.ISO_A2;
                        let count = countryCounts[code] || 0;
                        layer.on('mouseover', function (e) {
                            layer.bindTooltip(
                                feature.properties.NAME + "<br>Accounts: " + count,
                                { sticky: true }
                            ).openTooltip();
                        });
                    }
                }).addTo(map);
            });
    }
</script>
    <style>
        .profile-container {
            position:absolute;
            top:10px;
            left:10px;
            display:flex;
            align-items:center;
            z-index:3;
        }

        .profile-pic {
            width:50px;
            height:50px;
            border:thin;
            border-radius:50%;
            border-color:black;
            background-size:cover;
            background-position:center;
            margin-right:10px;
            z-index: 3;
            transition: transform 0.3s ease;
        }
        .profile-name{
            font-family:'Special Elite';
            font-size:20px;
            z-index:3;
        }
        .profile-pic:hover {
            cursor: pointer;
            transform: scale(1.2);
        }
        .menu {
            display: none;
            position: absolute;
            top: 60px;
            left: 10px;
            background-color: rgba(0,0,0,0.5);
            color: black;
            min-width: 100px;
            box-shadow: 0px 8px 16px 0px;
            z-index: 3;
        }
        .menu a {
            color: wheat;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .menu a:hover{
            background-color: black;
        }
        .letter-image-container {
            position: fixed;
            right:-550px;
            top: 50%;
            transform: translateY(-50%) rotate(-10deg);
            z-index: 1;
        }
        .letter-image {
            height:100vh;
            opacity: 0.8;
            transition: transform 0.3s ease, opacity 0.3s ease;
        }
        .letter-image-container:hover .letter-image {
            transform: scale(1.05);
            opacity: 1;
        }
        .letter-text {
            position: absolute;
            top: 50%;
            left: 50px;
            transform: translate(-50%, -50%) rotate(90deg);
            font-family: 'Special Elite', cursive;
            font-size: 50px;
            color: #ffffff;
            text-shadow: 2px 2px 4px #000000;
            letter-spacing:2px;
            transition: font-size 0.3s ease;
        }
        .letter-image-container:hover .letter-text {
            font-size: 55px;
        }
        .letter-image-container a {
            text-decoration: none;
        }
        .chat-bar {
            position: fixed;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 200px;
            height: 50px;
            background-color: #333;
            color: white;
            text-align: center;
            line-height: 50px;
            cursor: pointer;
            z-index: 4;
            transition: background-color 0.3s ease;
        }
        .chat-bar:hover {
            background-color: #555;
        }
        .chat-window {
            display: none;
            position: fixed;
            bottom: 60px;
            left: 50%;
            transform: translateX(-50%);
            width: 400px;
            height: 500px;
            background-color: rgba(0, 0, 0, 0.8);
            border: 1px solid #ccc;
            box-shadow: 0px 0px 20px rgba(0,0,0,0.2);
            z-index: 5;
            border-radius: 10px;
            overflow: hidden;
            animation: slideUp 0.5s ease-out;
        }
        @keyframes slideUp {
            from {
                transform: translateX(-50%) translateY(100%);
            }
            to {
                transform: translateX(-50%) translateY(0);
            }
        }
        .chat-header {
            background-color: #333;
            color: white;
            padding: 10px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }
        .chat-header span {
            font-size: 24px;
            font-weight: bold;
            color: #ffcc00;
        }
        .chat-body {
            padding: 10px;
            height: 380px;
            overflow-y: auto;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            font-family: Arial, sans-serif;
            font-size: 14px;
        }
        .chat-footer {
            padding: 10px;
            text-align: center;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .chat-footer input {
            width: 70%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }
        .chat-footer button {
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .chat-footer button:hover {
            background-color: #555;
        }
        .message {
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 10px;
            max-width: 80%;
            word-wrap: break-word;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            position: relative;
        }
        .message.user {
            background-color: #4CAF50;
            color: white;
            align-self: flex-end;
        }
        .message.bot {
            background-color: #f1f1f1;
            color: black;
            align-self: flex-start;
        }
        .timestamp {
            font-size: 10px;
            color: #ccc;
            position: absolute;
            bottom: -15px;
            right: 10px;
        }
                #botResponse {
            margin-top: 20px;
            padding: 10px;
            background-color: #f1f1f1;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
    <script>
        function toggleChatWindow() {
            var chatWindow = document.getElementById("chatWindow");
            if (chatWindow.style.display === "none" || chatWindow.style.display === "") {
                chatWindow.style.display = "block";
            } else {
                chatWindow.style.display = "none";
            }
        } //penpalla ilgili

        function togglemenu() {
            var menu = document.getElementById("menu");
            if (menu.style.display === "none" || menu.style.display === "") {
                menu.style.display = "block";
            } else {
                menu.style.display = "none";
            }
        }

        function sendMessage(event) { //yeniden penpal
            event.preventDefault();
            var messageInput = document.getElementById("messageInput");
            var message = messageInput.value;
            if (message.trim() !== "") {
                var chatBody = document.getElementById("chatBody");
                var newMessage = document.createElement("div");
                newMessage.className = "message user";
                newMessage.innerHTML = "You: " + message + "<span class='timestamp'>" + new Date().toLocaleTimeString() + "</span>";
                chatBody.appendChild(newMessage);
                messageInput.value = "";

                // Call WebMethod 
                PageMethods.SendMessageToDialogflow(message, function (response) {
                    var botMessage = document.createElement("div");
                    botMessage.className = "message bot";
                    botMessage.innerHTML = "Bot: " + response + "<span class='timestamp'>" + new Date().toLocaleTimeString() + "</span>";
                    chatBody.appendChild(botMessage);
                });
            }
        }

        document.getElementById("messageInput").addEventListener("keypress", function (event) {
            if (event.key === "Enter") {
                event.preventDefault(); 
                sendMessage(event);
            }

        });
        function redirectToLetterPage() {
            window.location.href = 'letter.aspx'; 
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-container">    
        <div id="profilepic" class="profile-pic" onclick="togglemenu()" runat="server" > </div>
        <div id="profilename" class="profile-name" runat="server"> </div>
        <div id="menu" class="menu">
            <a href="profile.aspx"> Profile </a>
            <a href="settings.aspx">Settings </a>
            <asp:LinkButton ID="LogoutLink" runat="server" OnClick="LogoutLink_Click">Logout</asp:LinkButton>
        </div>
    </div>
    <div class="letter-image-container" onclick="redirectToLetterPage()">  
        <a href="javascript:void(0);">
            <img src="Images/letter.jpg" alt="Write a Letter" class="letter-image" />
            <div class="letter-text">Write Letter</div>
        </a>
    </div> 
    <div class="chat-bar" onclick="toggleChatWindow()">PenPal.ai</div>     
    <div id="chatWindow" class="chat-window">
        <div class="chat-header"><span>PenPal.ai</span></div>
        <div id="chatBody" class="chat-body"></div>
        <div class="chat-footer">
            <input type="text" id="messageInput" placeholder="Type your message..." />
            <button type="button" onclick="sendMessage(event)">Send</button>
             <div id="botResponse"></div>
        </div>
    </div>
</asp:Content>

