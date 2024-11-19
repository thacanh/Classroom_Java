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

        .info-card h3 {
            color: #3c4043;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }

        .info-card .material-icons {
            margin-right: 8px;
            color: #1a73e8;
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
        }

        .action-button {
            display: flex;
            align-items: center;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .primary-button {
            background-color: #1a73e8;
            color: white;
        }

        .secondary-button {
            background-color: #34a853;
            color: white;
        }

        .warning-button {
            background-color: #ea4335;
            color: white;
        }

        .action-button:hover {
            box-shadow: 0 1px 3px rgba(60,64,67,0.3);
            opacity: 0.9;
        }

        .action-button .material-icons {
            margin-right: 8px;
        }

        .students-section {
            background: white;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 2px rgba(60,64,67,0.3);
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
<!--                <button class="action-button primary-button" onclick="showAnnouncement()">
                    <i class="material-icons">announcement</i>
                    Tạo thông báo
                </button>
                <button class="action-button primary-button" onclick="showAssignment()">
                    <i class="material-icons">assignment</i>
                    Tạo bài tập
                </button>-->
            </div>

            <div class="students-section">
                <h2>Danh sách học sinh</h2>
                <ul class="students-list">
                    <c:forEach items="${students}" var="enrollment">
                        <li class="student-item">
                            <div class="student-avatar">
                                ${enrollment.nickname.charAt(0)}
                            </div>
                            <div class="student-info">
                                <strong>${enrollment.nickname}</strong>
                                <div>ID: ${enrollment.studentId}</div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('menuToggle').addEventListener('click', function() {
            var sidebar = document.getElementById('sidebar');
            var mainContent = document.getElementById('mainContent');
            
            sidebar.classList.toggle('open');
            mainContent.classList.toggle('sidebar-open');
        });
    </script>
</body>
</html>
