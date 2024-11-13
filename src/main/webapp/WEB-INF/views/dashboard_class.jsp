<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .class-grid {
        margin-top: 100px;
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }

    .class-card {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
        overflow: hidden;
        transition: box-shadow 0.3s ease, transform 0.3s ease;
        display: flex;
        flex-direction: column;
        min-height: 200px;
    }

    .class-card:hover {
        box-shadow: 0 1px 3px 0 rgba(60,64,67,0.3), 0 4px 8px 3px rgba(60,64,67,0.15);
        transform: translateY(-2px);
    }

    .class-header {
        background-color: #1aa260;
        color: white;
        padding: 16px;
        position: relative;
        overflow: hidden;
    }

    .class-title {
        font-size: 20px;
        margin: 0;
        font-weight: 500;
        word-wrap: break-word;
    }

    .class-section {
        font-size: 14px;
        margin-top: 4px;
        opacity: 0.9;
        word-wrap: break-word;
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
        padding: 12px 16px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        flex-grow: 1;
    }

    .class-body p {
        margin-bottom: 8px;
        word-wrap: break-word;
        max-height: 60px;
        overflow-y: auto;
        flex-grow: 1;
    }

    .class-body a {
        color: #1a73e8;
        background-color: #f0f0f0;
        padding: 4px 8px;
        text-decoration: none;
        font-weight: 500;
        border-radius: 4px;
        transition: color 0.3s ease, background-color 0.3s ease;
        font-size: 14px;
        margin-right: 8px;
    }

    .class-body a:hover {
        color: #174ea6;
        background-color: #e0e0e0;
        text-decoration: underline;
    }

    .class-footer {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        margin-top: 8px;
    }

    .class-id {
        text-align: right;
        font-weight: bold;
        font-size: 18px;
        margin: 0;
        margin-left: auto;
    }
</style>

<div class="class-grid">
    <c:forEach items="${classrooms}" var="classroom">
        <div class="class-card">
            <div class="class-header">
                <h2 class="class-title">${classroom.name}</h2>
                <p class="class-section">${classroom.subject}</p>
                <i class="material-icons class-menu" onclick="deleteClass('${classroom.id}')">close</i>
            </div>
            <div class="class-body">
                <p>${classroom.description}</p>
                <div class="class-footer">
                    <a href="classroom?id=${classroom.id}">Xem lớp học</a>
                    <div class="class-id">${classroom.id}</div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<script>
function deleteClass(classId) {
    if (confirm('Bạn có chắc chắn muốn xóa lớp học này?')) {
        fetch('deleteClassroom', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'id=' + classId
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Xóa lớp học thành công!');
                location.reload(); // Tải lại trang sau khi xóa
            } else {
                alert('Không thể xóa lớp học: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Có lỗi xảy ra khi xóa lớp học');
        });
    }
}
</script>