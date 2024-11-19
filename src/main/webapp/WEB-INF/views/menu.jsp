<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.classroom.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String username = (user != null) ? user.getUsername() : "Guest";
    String currentPage = request.getRequestURI();
    String dashboardActive = currentPage.contains("dashboard") ? "active" : "";
    String abstractActive = currentPage.contains("abstract") ? "active" : "";
    String makeQuizzActive = currentPage.contains("makequizz") ? "active" : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar Navigation</title>
    <style>
        .sidebar {
            width: 240px;
            height: 100vh;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3);
            position: fixed;
            left: -240px;
            transition: left 0.3s ease;
            z-index: 1000;
        }
        .sidebar.open {
            left: 0;
        }
        .sidebar h2 {
            font-size: 16px;
            color: #5f6368;
            margin-bottom: 16px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
            margin-top: 60px;
        }
        .sidebar li {
            margin-bottom: 12px;
        }
        .sidebar a {
            text-decoration: none;
            color: #3c4043;
            font-size: 14px;
            display: flex;
            align-items: center;
            padding: 8px 12px;
            border-radius: 0 20px 20px 0;
        }
        .sidebar a:hover {
            background-color: #f1f3f4;
        }
        .sidebar a i {
            margin-right: 12px;
        }
        .sidebar a.active {
            background-color: #e8f0fe;
            color: #1a73e8;
        }
        .sidebar a.active i {
            color: #1a73e8;
        }
    </style>
</head>
<body>
    <div class="sidebar" id="sidebar">
        <ul>
            <li><span>Xin chào, <strong><%= username %></strong></span></li>
            <li><a href="dashboard" class="<%= dashboardActive %>">
                <i class="material-icons">dashboard</i>Bảng điều khiển</a>
            </li>
            <li><a href="abstract" class="<%= abstractActive %>">
                <i class="material-icons">description</i>Tóm tắt bài giảng</a>
            </li>
            <li><a href="makequizz" class="<%= makeQuizzActive %>">
                <i class="material-icons">add_circle</i>Tạo bộ câu hỏi</a>
            </li>
            <li><a href="#" onclick="window.location.href='login';">
                <i class="material-icons">logout</i>Đăng xuất</a>
            </li>
        </ul>
    </div>
</body>
</html>
