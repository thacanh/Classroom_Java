<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển - Bản sao Google Classroom</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f3f4;
        }
        .container {
            display: flex;
        }
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
        .main-content {
            flex-grow: 1;
            padding: 24px 32px;
            margin-left: 60px;
        }
        .main-content h1 {
            font-size: 24px;
            color: #3c4043;
            margin-bottom: 16px;
        }
        .class-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .class-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3);
            overflow: hidden;
        }
        .class-header {
            height: 100px;
            background-color: #1aa260;
            color: white;
            padding: 16px;
            position: relative;
        }
        .class-title {
            font-size: 24px;
            margin: 0;
        }
        .class-section {
            font-size: 14px;
            margin-top: 4px;
        }
        .class-menu {
            position: absolute;
            top: 12px;
            right: 12px;
            color: white;
            cursor: pointer;
        }
        .class-body {
            padding: 16px;
        }
        .add-class-btn {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 8px 24px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3);
        }
        .add-class-btn .material-icons {
            margin-right: 8px;
            font-size: 20px;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .menu-toggle {
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 1001;
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <button id="menuToggle" class="menu-toggle">
        <i class="material-icons">menu</i>
    </button>
    
    <div class="container">
        <div class="sidebar" id="sidebar">
            <h2>Menu</h2>
            <ul>
                <li><a href="dashboard"><i class="material-icons">dashboard</i>Bảng điều khiển</a></li>
                <li><a href="calendar"><i class="material-icons">calendar_today</i>Lịch</a></li>
                <li><a href="todo"><i class="material-icons">check_circle</i>Việc cần làm</a></li>
            </ul>
        </div>
        <div class="main-content">
            <h1>Lớp học của tôi</h1>
            <button class="add-class-btn" onclick="openModal()">
                <i class="material-icons">add</i>
                <span>Tạo lớp học</span>
            </button>
            <div class="class-grid">
                <c:forEach items="${classrooms}" var="classroom">
                    <div class="class-card">
                        <div class="class-header">
                            <h2 class="class-title">${classroom.className}</h2>
                            <p class="class-section">${classroom.section}</p>
                            <i class="material-icons class-menu">more_vert</i>
                        </div>
                        <div class="class-body">
                            <p>${classroom.description}</p>
                            <a href="classroom?id=${classroom.id}">Xem lớp học</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Modal để tạo lớp học mới -->
    <div id="createClassModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Tạo lớp học mới</h2>
            <form action="createClass" method="POST">
                <label for="className">Tên lớp học:</label>
                <input type="text" id="className" name="className" required><br><br>
                <label for="section">Phần:</label>
                <input type="text" id="section" name="section"><br><br>
                <label for="subject">Môn học:</label>
                <input type="text" id="subject" name="subject"><br><br>
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description"></textarea><br><br>
                <input type="submit" value="Tạo lớp học">
            </form>
        </div>
    </div>

    <script>
        function openModal() {
            document.getElementById('createClassModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('createClassModal').style.display = 'none';
        }

        // Đóng modal nếu người dùng nhấp chuột bên ngoài
        window.onclick = function(event) {
            if (event.target == document.getElementById('createClassModal')) {
                closeModal();
            }
        }

        // Chuyển đổi thanh bên
        document.getElementById('menuToggle').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('open');
        });
    </script>
</body>
</html>
