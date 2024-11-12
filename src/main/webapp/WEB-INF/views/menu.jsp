<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        margin-top: 60px; /* Thêm margin-top để dịch menu xuống */
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

<div class="sidebar" id="sidebar">
    <ul>
        <li><a href="dashboard" class="active"><i class="material-icons">dashboard</i>Bảng điều khiển</a></li>
        <li><a href="calendar"><i class="material-icons">calendar_today</i>Lịch</a></li>
        <li><a href="todo"><i class="material-icons">check_circle</i>Việc cần làm</a></li>
    </ul>
</div>
