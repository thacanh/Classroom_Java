package com.classroom.controller;

import com.classroom.dao.UserDAO;
import com.classroom.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO(); // Tạo đối tượng UserDAO để xác thực người dùng

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển tiếp yêu cầu tới trang login.jsp
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy các tham số username và password từ form đăng nhập
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Gọi phương thức authenticate để kiểm tra thông tin người dùng
            User user = userDAO.authenticate(username, password);

            if (user != null) {
                // Nếu người dùng hợp lệ, lưu thông tin người dùng vào session và chuyển tới dashboard
                request.getSession().setAttribute("user", user); // Lưu user vào session
                response.sendRedirect("dashboard"); // Chuyển hướng đến Dashboard
            } else {
                // Nếu sai, hiển thị lỗi và forward lại về trang đăng nhập
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Xử lý lỗi khi không thể xác thực người dùng
            request.setAttribute("error", "An error occurred during authentication");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
