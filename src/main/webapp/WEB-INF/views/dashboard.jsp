<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển - Classroom</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #f1f3f4;
            line-height: 1.6;
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex-grow: 1;
            padding: 24px 32px;
            margin-left: 60px;
            transition: margin-left 0.3s ease;
        }

        .main-content.sidebar-open {
            margin-left: 300px;
        }

        .main-header {
            position: fixed;
            top: 0;
            left: 60px;
            right: 0;
            background-color: #f1f3f4;
            padding: 24px 32px;
            z-index: 999;
            transition: left 0.3s ease;
            border-bottom: 1px solid #e0e0e0;
        }

        .main-header.sidebar-open {
            left: 300px;
        }

        .main-header h1 {
            font-size: 24px;
            color: #3c4043;
            margin-bottom: 16px;
        }

        .class-grid {
            margin-top: 100px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .class-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3);
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }

        .class-card:hover {
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
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
            font-weight: 500;
        }

        .class-section {
            font-size: 14px;
            margin-top: 4px;
            opacity: 0.9;
        }

        .class-menu {
            position: absolute;
            top: 12px;
            right: 12px;
            color: white;
            cursor: pointer;
            padding: 8px;
            border-radius: 50%;
        }

        .class-menu:hover {
            background-color: rgba(255,255,255,0.1);
        }

        .class-body {
            padding: 16px;
        }

        .class-body a {
            color: #1a73e8;
            text-decoration: none;
            font-weight: 500;
        }

        .class-body a:hover {
            text-decoration: underline;
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
            transition: background-color 0.3s ease;
        }

        .add-class-btn:hover {
            background-color: #1557b0;
        }

        .add-class-btn .material-icons {
            margin-right: 8px;
            font-size: 20px;
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
            padding: 8px;
            border-radius: 50%;
            color: #5f6368;
        }

        .menu-toggle:hover {
            background-color: rgba(95,99,104,0.1);
        }
    </style>
</head>
<body>
    <button id="menuToggle" class="menu-toggle">
        <i class="material-icons">menu</i>
    </button>
    
    <div class="container">
        <%@ include file="menu.jsp" %>

        <div class="main-content" id="mainContent">
            <div class="main-header" id="mainHeader">
                <h1>Lớp học của tôi</h1>
                <button class="add-class-btn" onclick="openModal()">
                    <i class="material-icons">add</i>
                    <span>Tạo lớp học</span>
                </button>
            </div>
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

    <%@ include file="createclass.jsp" %>

    <script>
        function openModal() {
            document.getElementById('createClassModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('createClassModal').style.display = 'none';
        }

        window.onclick = function(event) {
            if (event.target == document.getElementById('createClassModal')) {
                closeModal();
            }
        }

        document.getElementById('menuToggle').addEventListener('click', function() {
            var sidebar = document.getElementById('sidebar');
            var mainContent = document.getElementById('mainContent');
            var mainHeader = document.getElementById('mainHeader');
            
            sidebar.classList.toggle('open');
            mainContent.classList.toggle('sidebar-open');
            mainHeader.classList.toggle('sidebar-open');
        });
    </script>
</body>
</html>
