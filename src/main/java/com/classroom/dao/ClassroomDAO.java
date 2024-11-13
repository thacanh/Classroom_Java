package com.classroom.dao;

import com.classroom.model.Classroom;
import com.classroom.util.DBConnection;
import java.util.Random;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassroomDAO {

    // Tạo lớp học mới
    public Classroom createClassroom(Classroom classroom) throws SQLException {
        String sql = "INSERT INTO classrooms (id, name, subject, description, creator_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String classId = generateUniqueClassId();

            stmt.setString(1, classId);
            stmt.setString(2, classroom.getName());
            stmt.setString(3, classroom.getSubject());
            stmt.setString(4, classroom.getDescription());
            stmt.setInt(5, classroom.getCreatorId());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Tạo lớp học thất bại, không có dòng nào bị ảnh hưởng.");
            }

            classroom.setId(classId);
            return classroom;
        }
    }

    private String generateUniqueClassId() throws SQLException {
        String classId;
        do {
            classId = generateClassId();
        } while (isClassIdExists(classId));
        return classId;
    }

    private String generateClassId() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder code = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < 6; i++) {
            code.append(characters.charAt(random.nextInt(characters.length())));
        }
        return code.toString();
    }

    private boolean isClassIdExists(String classId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM classrooms WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, classId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Lấy tất cả lớp học
    public List<Classroom> getAllClassrooms() throws SQLException {
        List<Classroom> classrooms = new ArrayList<>();
        String sql = "SELECT * FROM classrooms ORDER BY id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Classroom classroom = mapResultSetToClassroom(rs);
                classrooms.add(classroom);
            }
        }
        return classrooms;
    }

    // Lấy lớp học theo ID
    public Classroom getClassroomById(String id) throws SQLException {
        String sql = "SELECT * FROM classrooms WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClassroom(rs);
                }
            }
        }
        return null;
    }

    // Ánh xạ dữ liệu từ ResultSet vào lớp Classroom
    private Classroom mapResultSetToClassroom(ResultSet rs) throws SQLException {
        return new Classroom(
            rs.getString("id"),
            rs.getString("name"),
            rs.getString("subject"),
            rs.getString("description"),
            rs.getInt("creator_id")
        );
    }

    // Cập nhật thông tin lớp học
    public boolean updateClassroom(Classroom classroom) throws SQLException {
        String sql = "UPDATE classrooms SET name = ?, subject = ?, description = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, classroom.getName());
            stmt.setString(2, classroom.getSubject());
            stmt.setString(3, classroom.getDescription());
            stmt.setString(4, classroom.getId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    // Kiểm tra xem sinh viên có đang tham gia lớp học không
    public boolean isUserInClassroom(int studentId, String classroomId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM class_enrollments WHERE student_id = ? AND classroom_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setString(2, classroomId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Thêm sinh viên vào lớp học
    public boolean addUserToClassroom(int studentId, String classroomId) throws SQLException {
        String sql = "INSERT INTO class_enrollments (student_id, classroom_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setString(2, classroomId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    // Xóa sinh viên khỏi lớp học
    public boolean removeUserFromClassroom(int studentId, String classroomId) throws SQLException {
        String sql = "DELETE FROM class_enrollments WHERE student_id = ? AND classroom_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setString(2, classroomId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    // Lấy danh sách lớp học của một người dùng
    public List<Classroom> getClassroomsByUserId(int userId) throws SQLException {
        List<Classroom> classrooms = new ArrayList<>();
        String sql = "SELECT c.* FROM classrooms c " +
                    "JOIN class_enrollments ce ON c.id = ce.classroom_id " +
                    "WHERE ce.student_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    classrooms.add(mapResultSetToClassroom(rs));
                }
            }
        }
        return classrooms;
    }

    // Lấy danh sách lớp học do một người dùng tạo
    public List<Classroom> getClassroomsByCreatorId(int creatorId) throws SQLException {
        List<Classroom> classrooms = new ArrayList<>();
        String sql = "SELECT * FROM classrooms WHERE creator_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, creatorId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    classrooms.add(mapResultSetToClassroom(rs));
                }
            }
        }
        return classrooms;
    }
    
    public boolean isClassroomCreator(int userId, String classroomId) throws SQLException {
    String sql = "SELECT creator_id FROM classrooms WHERE id = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, classroomId);
        
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("creator_id") == userId;
            }
        }
    }
    return false;
    }
    public boolean deleteClassroom(String classroomId) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Xóa các enrollment trước
            String deleteEnrollments = "DELETE FROM class_enrollments WHERE classroom_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteEnrollments)) {
                stmt.setString(1, classroomId);
                stmt.executeUpdate();
            }

            // Sau đó xóa lớp học
            String deleteClassroom = "DELETE FROM classrooms WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteClassroom)) {
                stmt.setString(1, classroomId);
                int result = stmt.executeUpdate();

                conn.commit();
                return result > 0;
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
