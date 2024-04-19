<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="veri.DBKatmani" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ders Notları</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #2193b0, #6dd5ed);
        }
        
        .top-panel {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #2c3e50;
            color: #fff;
            padding: 10px 20px;
        }
        
        .logo {
            display: flex;
            align-items: center;
        }
        
        .logo img {
            width: 50px;
            margin-right: 10px;
        }
        
        .university-name {
            font-size: 24px;
        }
        
        .user-info {
            font-size: 18px;
            margin-right: 20px;
        }
        
        .system-info {
            font-size: 14px;
        }
        
        .container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            position: absolute;
            top: 100px;
            left: 50%;
            transform: translate(-50%);
            width: 80%;
            max-width: 1000px;
        }
      
        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }
        
        .user-panel {
            display: flex;
            align-items: center;
            padding: 10px 20px;
            background-color: #ececec;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .user-panel img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
        .user-name {
            font-size: 18px;
            font-weight: bold;
        }
        
        .user-options {
            margin-left: auto;
            display: flex;
            align-items: center;
        }
        
        .user-options a {
            margin-right: 20px;
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
            transition: color 0.3s ease;
        }
        
        .user-options a:hover {
            color: #2980b9;
        }
        
        .content-panel {
            display: flex;
            margin-bottom: 20px;
        }
        
        .content-panel .sidebar {
            background-color: #f4f4f4;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 20%;
            padding: 20px;
            margin-right: 20px;
        }

        .content-panel .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .content-panel .sidebar li {
            margin-bottom: 10px;
        }

        .content-panel .sidebar a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            border-radius: 6px;
            background-color: rgba(0, 0, 0, 0.05); /* Hafif arka plan rengi */
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .content-panel .sidebar a:hover {
            background-color: #3498db;
            color: #fff;
            background-color: rgba(0, 0, 0, 0.1); /* Hafif arka plan rengi değişikliği */
        }

        .content-panel .main-content {
            flex-grow: 1;
            background-color: #fff;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        
        .profile-info {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }
        
        .info-block {
            margin-bottom: 15px;
        }
        
        .info-title {
            font-weight: bold;
        }
        .logo a {
            text-decoration: none;
            color: #fff; /* Beyaz renk */
            transition: color 0.3s ease;
        }
        .note-table {
            border-collapse: collapse;
            width: 100%;
            text-align: center;
        }

        .note-table th,
        .note-table td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .note-table th {
            background-color: #f2f2f2;
        }
        select {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .user-panel label {
            margin-right: 10px; 
        }
        .submit-button {
            text-align: right;
            margin-top: 20px;
        }
        .save-button {
            cursor: pointer;
        }
        
    </style>
</head>
<%
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String dersNotlar[][] = (String[][]) session.getAttribute("dersler");
    int selectedOptionIndex = (int) session.getAttribute("selectedOptionIndex");
    DBKatmani dbkatmani = new DBKatmani();
    String sonDonem = dbkatmani.getSonDonem();
    String [][] dersIsim = dbkatmani.getOgretmenDersİsim(email,sonDonem);
    String dersAdi = dersIsim[selectedOptionIndex][1];
    session.setAttribute("dersAdi", dersAdi);
    int rowCount = dersIsim.length;
    int colCount = 0;
    if (rowCount > 0) {
        colCount = dersIsim[0].length;
    }
    int colCount2 = 0;
    int rowCount2 = dersNotlar.length;
    if (rowCount2 > 0) {
        colCount2 = dersNotlar[0].length;
    }
%>
<body>
    <div class="top-panel">
        <div class="logo">
            <a href="ogretmenAnaSayfa.jsp" class="logo">
                <img src="resimler/logo.png" alt="Üniversite Logosu">
                <div class="university-name">Phoenix Üniversitesi</div>
            </a>
        </div>
        <div class="user-info"><%=username%></div>
    </div>
    <div class="container">
        <div class="user-panel">
            <label for="interests">Dersler:</label>
                <select id="interests" name="interests" onchange="secim(this)">
                <% for (int i = 0; i < rowCount; i++) { %>
                    <% for (int j = 0; j < colCount; j++) { %>
                    <option <%= i == selectedOptionIndex ? "selected" : "" %> >(<%=dersIsim[i][j]%>) <%j=j+1;%> <%=dersIsim[i][j]%></option>
                <% }} %>
                </select>
        </div>
        <div class="content-panel">
            <div class="sidebar">
                <ul>
                    <li><a href="ogretmenAnaSayfa.jsp">Ana Sayfa</a></li>
                    <li><a href="girilenDersler.jsp">Girilen Dersler</a></li>
                    <li><a href="sinavNotlari.jsp">Sınav Notları</a></li>
                </ul>
            </div>
            <div class="main-content">
                <h1>Sınav Notlarını Düzenle</h1>
                <form action="kaydetSinavNotlari.jsp" method="post">
                    <table class="note-table">
                        <tr>
                            <th>Öğrenci No</th>
                            <th>Öğrenci Adı</th>
                            <th>Vize</th>
                            <th>Final</th>
                            <th>Büt</th>
                            <th>Ortalama</th>
                            <th>Harf Notu</th>
                            <th>Durum</th>
                        </tr>
                        <% for (int i = 0; i < rowCount2; i++) { %>
                        <tr>
                            <% for (int j = 0; j < colCount2; j++) { %>
                            <td><%=dersNotlar[i][j]%></td>
                            <%j=j+1;%>
                            <td><%=dersNotlar[i][j]%></td>
                            <%j=j+1;%>
                            <td><input type="number" placeholder="<%=dersNotlar[i][j]%>" name="vize<%=i%>" min="0" max="100" oninput="validity.valid||(value='');"></td>
                            <%j=j+1;%>
                            <td><input type="number" placeholder="<%=dersNotlar[i][j]%>" name="final<%=i%>" min="0" max="100" oninput="validity.valid||(value='');"></td>
                            <%j=j+1;%>
                            <td><input type="number" placeholder="<%=dersNotlar[i][j]%>" name="but<%=i%>" min="0" max="100" oninput="validity.valid||(value='');"></td>
                            <%j=j+1;%>
                            <td><span><%=dersNotlar[i][j]%></span></td>
                            <%j=j+1;%>
                            <td><span><%=dersNotlar[i][j]%></span></td>
                            <%j=j+1;%>
                            <td><span><%=dersNotlar[i][j]%></span></td>
                            <%}%>
                        </tr>
                        <%}%>
                    </table>
                    <div class="submit-button">
                    <button class="save-button" name="action" value="sonuclandir">Sonuçlandır</button>
                    <button class="save-button" name="action" value="kaydet">Kaydet</button>
                </div>
                </form>
            </div>
        </div>
    </div>
<script>
    function secim(selectElement) {
        selectedOptionIndex = selectElement.selectedIndex;
        var selectedValue = document.getElementById("interests").value;
        selectedValue = selectedValue.replace(/\([^)]*\)/g, '');
        selectedValue = selectedValue.trim();
        if (selectedValue !== null) {
            window.location.href = "getSinavNotlari.jsp?selectedValue=" + selectedValue + "&selectedOptionIndex=" + selectedOptionIndex;
        }
    }
</script>
</body>
</html>