<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1002;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
        animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .modal-content {
        background-color: #fefefe;
        margin: 10% auto;
        padding: 24px;
        border: none;
        width: 100%;
        max-width: 500px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        position: relative;
        animation: slideIn 0.3s ease;
    }

    @keyframes slideIn {
        from { transform: translateY(-20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .modal-content h2 {
        color: #3c4043;
        font-size: 24px;
        margin-bottom: 20px;
        font-weight: 500;
    }

    .close {
        position: absolute;
        right: 24px;
        top: 20px;
        color: #5f6368;
        font-size: 28px;
        font-weight: normal;
        cursor: pointer;
        padding: 4px;
        line-height: 1;
        border-radius: 50%;
        transition: background-color 0.2s ease;
    }

    .close:hover {
        background-color: rgba(95,99,104,0.1);
    }

    .modal-content form {
        display: flex;
        flex-direction: column;
    }

    .form-group {
        margin-bottom: 16px;
    }

    .form-group label {
        display: block;
        color: #3c4043;
        font-size: 14px;
        margin-bottom: 8px;
        font-weight: 500;
    }

    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #dadce0;
        border-radius: 4px;
        font-size: 14px;
        color: #3c4043;
        transition: border-color 0.2s ease;
    }

    .form-group input:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: #1a73e8;
    }

    .form-group textarea {
        height: 100px;
        resize: vertical;
    }

    .submit-btn {
        background-color: #1a73e8;
        color: white;
        border: none;
        padding: 10px 24px;
        border-radius: 4px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        align-self: flex-end;
        transition: background-color 0.2s ease;
    }

    .submit-btn:hover {
        background-color: #1557b0;
    }
</style>

<div id="createClassModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Tạo lớp học mới</h2>
        <form action="createClass" method="POST">
            <div class="form-group">
                <label for="className">Tên lớp học</label>
                <input type="text" id="className" name="className" required>
            </div>
            
            <div class="form-group">
                <label for="subject">Môn học</label>
                <input type="text" id="subject" name="subject">
            </div>
            
            <div class="form-group">
                <label for="description">Mô tả</label>
                <textarea id="description" name="description"></textarea>
            </div>
            
            <button type="submit" class="submit-btn">Tạo lớp học</button>
        </form>
    </div>
</div>
