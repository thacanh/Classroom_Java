<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classroom</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
            padding: 24px 32px;
            margin-left: 60px;
            transition: margin-left 0.3s ease;
            padding-top: 120px;
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

        .header-buttons {
            display: flex;
            gap: 10px;
        }

        .add-class-btn, .join-class-btn {
            color: white;
            border: none;
            padding: 8px 24px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .add-class-btn {
            background-color: #1a73e8;
        }

        .add-class-btn:hover {
            background-color: #1557b0;
            box-shadow: 0 1px 3px 0 rgba(60,64,67,0.3), 0 4px 8px 3px rgba(60,64,67,0.15);
        }

        .join-class-btn {
            background-color: #34a853;
        }

        .join-class-btn:hover {
            background-color: #2d8e47;
            box-shadow: 0 1px 3px 0 rgba(60,64,67,0.3), 0 4px 8px 3px rgba(60,64,67,0.15);
        }

        .add-class-btn .material-icons, .join-class-btn .material-icons {
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
            transition: background-color 0.3s ease;
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
                <div class="header-buttons">
                    <button class="add-class-btn" onclick="openModal()">
                        <i class="material-icons">add</i>
                        <span>Tạo lớp học</span>
                    </button>
                    <button class="join-class-btn" onclick="openJoinModal()">
                        <i class="material-icons">group_add</i>
                        <span>Tham gia lớp học</span>
                    </button>
                </div>
            </div>
            <%@ include file="dashboard_class.jsp" %>
        </div>
    </div>

    <%@ include file="createclass.jsp" %>
    <%@ include file="joinclass.jsp" %>

    <script>
        function openModal() {
            document.getElementById('createClassModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('createClassModal').style.display = 'none';
        }

        function openJoinModal() {
            document.getElementById('joinClassModal').style.display = 'block';
        }

        function closeJoinModal() {
            document.getElementById('joinClassModal').style.display = 'none';
        }

        window.onclick = function(event) {
            if (event.target == document.getElementById('createClassModal')) {
                closeModal();
            }
            if (event.target == document.getElementById('joinClassModal')) {
                closeJoinModal();
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

        // Xử lý form tạo lớp học
        document.getElementById('createClassForm').addEventListener('submit', async function(event) {
            event.preventDefault();

            const formData = new FormData(this);

            try {
                const response = await fetch('createClass', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }

                const data = await response.json();
                console.log('Server response:', data);

                if (data.success) {
                    // Tạo element mới sử dụng dữ liệu từ form
                    const newCard = document.createElement('div');
                    newCard.className = 'class-card';
                    newCard.innerHTML = `
                        <div class="class-header">
                            <h2 class="class-title">${formData.get('name')}</h2>
                            <p class="class-section">${formData.get('subject')}</p>
                            <i class="material-icons class-menu">more_vert</i>
                        </div>
                        <div class="class-body">
                            <p>${formData.get('description')}</p>
                            <a href="classroom?id=${data.classroom.id}">Xem lớp học ${data.classroom.id}</a>
                        </div>
                    `;

                    // Thêm vào đầu danh sách
                    const classGrid = document.querySelector('.class-grid');
                    if (classGrid.firstChild) {
                        classGrid.insertBefore(newCard, classGrid.firstChild);
                    } else {
                        classGrid.appendChild(newCard);
                    }

                    // Đóng modal và reset form
                    closeModal();
                    this.reset();
                    window.location.reload();
                } else {
                    alert(data.message || 'Có lỗi xảy ra khi tạo lớp học!');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi tạo lớp học!');
            }
        });

        // Xử lý form tham gia lớp học
        document.getElementById('joinClassForm').addEventListener('submit', async function(event) {
            event.preventDefault();

            const formData = new FormData(this);

            try {
                const response = await fetch('joinClass', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }

                const data = await response.json();
                console.log('Server response:', data);

                if (data.success) {
                    // Đóng modal và reset form
                    closeJoinModal();
                    this.reset();
                    // Có thể thêm thông báo thành công hoặc chuyển hướng người dùng
                    alert('Tham gia lớp học thành công!');
                    // window.location.href = 'classroom?id=' + data.classId; // Chuyển hướng đến trang lớp học
                } else {
                    alert(data.message || 'Có lỗi xảy ra khi tham gia lớp học!');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi tham gia lớp học!');
            }
        });
    </script>
</body>
</html>
