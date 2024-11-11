package com.classroom.controller;

import com.classroom.model.User; // Đảm bảo import lớp User
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập chưa
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            // Nếu người dùng chưa đăng nhập, chuyển hướng về trang đăng nhập
            response.sendRedirect("login");
        } else {
            // Nếu người dùng đã đăng nhập, chuyển tiếp đến trang dashboard
            // Sử dụng thông tin từ đối tượng User, chẳng hạn như username
            request.setAttribute("user", user); // Lưu đối tượng User vào request
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        }
    }
}
