<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Classroom Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f2f5;
        }
        .container {
            text-align: center;
        }
        .welcome-text {
            font-size: 24px;
            color: #1a73e8;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #1a73e8;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 0 10px;
        }
        .btn:hover {
            background-color: #1557b0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="welcome-text">Welcome to Classroom</h1>
        <a href="login" class="btn">Login</a>
    </div>
</body>
</html>