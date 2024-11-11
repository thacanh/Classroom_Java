package com.classroom.dao;

import com.classroom.model.Classroom;
import com.classroom.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassroomDAO {
    public List<Classroom> getClassroomsByTeacher(int teacherId) {
        List<Classroom> classrooms = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM classrooms WHERE teacher_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, teacherId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Classroom classroom = new Classroom();
                classroom.setId(rs.getInt("id"));
                classroom.setName(rs.getString("name"));
                classroom.setDescription(rs.getString("description"));
                classroom.setTeacherId(rs.getInt("teacher_id"));
                classrooms.add(classroom);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return classrooms;
    }

    public boolean createClassroom(Classroom classroom) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO classrooms (name, description, teacher_id) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, classroom.getName());
            stmt.setString(2, classroom.getDescription());
            stmt.setInt(3, classroom.getTeacherId());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}