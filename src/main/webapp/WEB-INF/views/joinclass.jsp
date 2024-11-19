<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="joinClassModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeJoinModal()">&times;</span>
        <h2>Tham gia lớp học</h2>
        <form id="joinClassForm">
            <div class="form-group">
                <label for="nickName">Biệt danh:</label>
                <input type="text" id="nickName" name="nickName" required>
                <label for="classId">Mã lớp học:</label>
                <input type="text" id="classId" name="classId" required>
            </div>
            <button type="submit" class="btn-submit">Tham gia</button>
        </form>
    </div>
</div>

<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
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
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
    }

    .form-group input {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .btn-submit {
        background-color: #1a73e8;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    .btn-submit:hover {
        background-color: #1557b0;
    }
</style>