package com.classroom.dao;

import com.classroom.model.Classroom;
import com.classroom.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassroomDAO {
    public Classroom createClassroom(Classroom classroom) throws SQLException {
        String sql = "INSERT INTO classrooms (name, subject, description) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, classroom.getName());
            stmt.setString(2, classroom.getSubject());
            stmt.setString(3, classroom.getDescription());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating classroom failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    classroom.setId(generatedKeys.getInt(1));
                    return classroom;
                } else {
                    throw new SQLException("Creating classroom failed, no ID obtained.");
                }
            }
        }
    }

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

    public Classroom getClassroomById(int id) throws SQLException {
        String sql = "SELECT * FROM classrooms WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClassroom(rs);
                }
            }
        }
        return null;
    }

    private Classroom mapResultSetToClassroom(ResultSet rs) throws SQLException {
        return new Classroom(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("subject"),
            rs.getString("description")
        );
    }

    public boolean updateClassroom(Classroom classroom) throws SQLException {
        String sql = "UPDATE classrooms SET name = ?, subject = ?, description = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, classroom.getName());
            stmt.setString(2, classroom.getSubject());
            stmt.setString(3, classroom.getDescription());
            stmt.setInt(4, classroom.getId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public boolean deleteClassroom(int id) throws SQLException {
        String sql = "DELETE FROM classrooms WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
}
