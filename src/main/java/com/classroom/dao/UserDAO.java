package com.classroom.dao;

import com.classroom.model.User;
import com.classroom.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    if (BCrypt.checkpw(password, storedHash)) {
                        return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            null, // Không lưu mật khẩu trong bộ nhớ
                            rs.getString("email"),
                            rs.getString("role")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Xác thực thất bại", e);
        }
        return null;
    }

    public boolean addUser(User user) {
        // Kiểm tra xem tên người dùng đã tồn tại hay chưa
        if (getUserByUsername(user.getUsername()) != null) {
            return false;
        }

        String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, hashedPassword);
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());

            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Thêm người dùng thất bại", e);
        }
        return false;
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        null, // Không lưu mật khẩu trong bộ nhớ
                        rs.getString("email"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Lấy người dùng theo tên người dùng thất bại", e);
        }
        return null;
    }
}
