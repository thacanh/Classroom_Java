package com.classroom.dao;

import com.classroom.model.User;
import com.classroom.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    // Phương thức xác thực người dùng
    public User authenticate(String username, String password) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String storedPasswordHash = rs.getString("password");
                        // So sánh mật khẩu người dùng với mật khẩu đã mã hóa
                        if (BCrypt.checkpw(password, storedPasswordHash)) {
                            User user = new User(
                                rs.getInt("id"),
                                rs.getString("username"),
                                null, // Không lưu trữ mật khẩu
                                rs.getString("email"),
                                rs.getString("role")
                            );
                            return user;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error during authentication", e);
            throw e;  // Ném lại ngoại lệ SQLException
        }
        return null;
    }

    // Phương thức đăng ký người dùng mới
    public boolean addUser(User user) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            // Kiểm tra xem người dùng đã tồn tại hay chưa
            if (getUserByUsername(user.getUsername()) != null) {
                return false; // Người dùng đã tồn tại
            }

            // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, user.getUsername());
                stmt.setString(2, hashedPassword); // Lưu mật khẩu đã mã hóa
                stmt.setString(3, user.getEmail());
                stmt.setString(4, user.getRole());

                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error during user registration", e);
            throw e;  // Ném lại ngoại lệ SQLException
        }
    }

    // Phương thức lấy thông tin người dùng dựa trên tên đăng nhập
    public User getUserByUsername(String username) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        User user = new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            null, // Không lưu trữ mật khẩu
                            rs.getString("email"),
                            rs.getString("role")
                        );
                        return user;
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error during fetching user by username", e);
            throw e;  // Ném lại ngoại lệ SQLException
        }
        return null;
    }
}
