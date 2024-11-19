<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${classroom.name}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
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
            padding: 24px;
            margin-left: 60px;
            transition: margin-left 0.3s ease;
        }

        .main-content.sidebar-open {
            margin-left: 300px;
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
            transition: background-color 0.3s ease;
        }

        .menu-toggle:hover {
            background-color: rgba(95,99,104,0.1);
        }

        .classroom-header {
            background-color: #1a73e8;
            color: white;
            padding: 24px;
            border-radius: 8px;
            margin-bottom: 24px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .header-info {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .header-info p {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .header-info .material-icons {
            font-size: 20px;
        }

        .classroom-header h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .classroom-info {
            display: grid;
            grid-template-columns: 1fr;
            gap: 24px;
            margin-bottom: 32px;
        }

        .info-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 1px 2px rgba(60,64,67,0.3);
        }

        .info-card .material-icons {
            margin-right: 8px;
            color: #1a73e8;
        }

        .tab-menu {
            display: flex;
            border-bottom: 1px solid #e0e0e0;
            margin-bottom: 24px;
            background: white;
            border-radius: 8px 8px 0 0;
        }

        .tab-item {
            padding: 16px 32px;
            border: none;
            background: none;
            font-size: 16px;
            font-weight: 500;
            color: #5f6368;
            cursor: pointer;
            position: relative;
        }

        .tab-item.active {
            color: #1a73e8;
        }

        .tab-item.active::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            right: 0;
            height: 3px;
            background-color: #1a73e8;
        }

        .tab-item:hover {
            background-color: rgba(60,64,67,0.08);
        }

        .content-section {
            display: none;
            background: white;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 2px rgba(60,64,67,0.3);
        }

        .content-section.active {
            display: block;
        }

        .board-section {
            background: white;
            padding: 24px;
            border-radius: 8px;
        }

        .board-post {
            border-bottom: 1px solid #e0e0e0;
            padding: 16px 0;
        }

        .board-post:last-child {
            border-bottom: none;
        }

        .post-header {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            gap: 8px;
        }

        .post-content {
            margin-top: 8px;
            padding-left: 32px;
        }

        .students-list {
            list-style: none;
        }

        .student-item {
            display: flex;
            align-items: center;
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
        }

        .student-item:last-child {
            border-bottom: none;
        }

        .student-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #1a73e8;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 16px;
        }

        .student-info {
            flex-grow: 1;
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
            justify-content: flex-start;
        }

        .action-button {
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 1;
            max-width: 200px;
            min-width: 150px;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            text-align: center;
            transition: all 0.3s ease;
        }

        .primary-button {
            background-color: #1a73e8;
            color: white;
        }

        .action-button:hover {
            box-shadow: 0 1px 3px rgba(60,64,67,0.3);
            opacity: 0.9;
        }

        .action-button .material-icons {
            margin-right: 8px;
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
            <div class="classroom-header">
                <div class="header-content">
                    <h1>${classroom.name}</h1>
                    <div class="header-info">
                        <p><i class="material-icons">tag</i>Mã lớp: ${classroom.id}</p>
                        <p><i class="material-icons">subject</i>Môn học: ${classroom.subject}</p>
                    </div>
                </div>
            </div>

            <div class="classroom-info">
                <div class="info-card">
                    <h3><i class="material-icons">description</i>Mô tả</h3>
                    <p>${classroom.description}</p>
                </div>
            </div>

            <div class="action-buttons">
                <button class="action-button primary-button" onclick="joinMeeting()">
                    <i class="material-icons">video_call</i>
                    Vào học trực tuyến
                </button>
                <button class="action-button primary-button" onclick="Onboard()">
                    <i class="material-icons">assignment</i>
                    Gọi lên bảng
                </button>
            </div>

            <div class="tab-menu">
                <button class="tab-item active" onclick="showBoard()">
                    Bảng tin
                </button>
                <button class="tab-item" onclick="showStudentList()">
                    Mọi người
                </button>
            </div>

            <%@ include file="board.jsp" %>
            <%@ include file="students.jsp" %>
        </div>
    </div>

    <script>
        document.getElementById('menuToggle').addEventListener('click', function() {
            var sidebar = document.getElementById('sidebar');
            var mainContent = document.getElementById('mainContent');
            
            sidebar.classList.toggle('open');
            mainContent.classList.toggle('sidebar-open');
        });

        function hideAllSections() {
            document.querySelectorAll('.content-section').forEach(section => {
                section.classList.remove('active');
            });
        }

        function setActiveTab(index) {
            document.querySelectorAll('.tab-item').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.tab-item')[index].classList.add('active');
        }

        function showBoard() {
            hideAllSections();
            document.getElementById('boardSection').classList.add('active');
            setActiveTab(0);
        }

        function showStudentList() {
            hideAllSections();
            document.getElementById('studentsSection').classList.add('active');
            setActiveTab(1);
        }

        function joinMeeting() {
            alert('Đang kết nối đến phòng học trực tuyến...');
        }

        function Onboard() {
            alert('Đang mở chức năng gọi lên bảng...');
        }
    </script>
</body>
</html>
