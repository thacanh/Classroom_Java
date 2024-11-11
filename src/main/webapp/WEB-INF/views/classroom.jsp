<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Classroom</title>
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
        .classroom-form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        h2 {
            text-align: center;
            color: #1a73e8;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #1557b0;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #1a73e8;
            text-decoration: none;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="classroom-form">
        <h2>Create New Classroom</h2>
        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">${error}</div>
        <% } %>
        <form action="classroom" method="post">
            <div class="form-group">
                <label for="name">Classroom Name</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required></textarea>
            </div>
            <button type="submit" class="submit-btn">Create Classroom</button>
        </form>
        <a href="dashboard" class="back-link">Back to Dashboard</a>
    </div>
</body>
</html>