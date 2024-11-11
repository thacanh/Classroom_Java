package com.classroom.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.classroom.dao.UserDAO;
import com.classroom.model.User;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo UserDAO (sử dụng một lớp DAO để xử lý cơ sở dữ liệu)
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển tiếp yêu cầu tới trang register.jsp
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy các tham số từ form đăng ký
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String email = request.getParameter("email"); // Nếu có trong form
            String role = "user"; // Mặc định cho người dùng mới là "user"

            // Kiểm tra các điều kiện đăng ký
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                request.setAttribute("error", "Username and password cannot be empty");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            } else if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xem người dùng đã tồn tại chưa
            if (userDAO.getUserByUsername(username) != null) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                return;
            }

            // Lưu thông tin người dùng vào cơ sở dữ liệu
            User newUser = new User(0, username, password, email, role); // Đảm bảo constructor phù hợp
            userDAO.addUser(newUser);

            // Nếu đăng ký thành công, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login");

        } catch (SQLException e) {
            // Bắt lỗi cơ sở dữ liệu và hiển thị thông báo lỗi
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred during registration");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } catch (Exception e) {
            // Bắt tất cả các loại lỗi khác và hiển thị thông báo lỗi
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during registration");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}
