<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f2f5;
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            text-align: center;
            color: #1a73e8;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .login-btn, .register-btn {
            width: 100%;
            padding: 10px;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        .login-btn {
            background-color: #1a73e8;
        }
        .login-btn:hover {
            background-color: #1557b0;
        }
        .register-btn {
            background-color: #34a853;
        }
        .register-btn:hover {
            background-color: #2c8b46;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #555;
        }
        .register-link a {
            color: #1a73e8;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">${error}</div>
        <% } %>
        <form action="login" method="post">
            <div class="form-group">
                <input type="text" name="username" placeholder="Tài khoản" required>
            </div>
            <div class="form-group">
                <input type="password" name="password" placeholder="Mật khẩu" required>
            </div>
            <button type="submit" class="login-btn">Đăng nhập</button>
        </form>

        <div class="register-link">
            <p>Bạn chưa có tài khoản? <a href="register">Đăng ký tại đây</a></p>
        </div>
    </div>
</body>
</html>
