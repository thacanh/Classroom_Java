package com.classroom.controller;

import com.classroom.model.Classroom;
import com.classroom.dao.ClassroomDAO;
import com.classroom.model.ClassEnrollment;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ClassroomServlet extends HttpServlet {
    private ClassroomDAO classroomDAO;
    
    @Override
    public void init() throws ServletException {
        classroomDAO = new ClassroomDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String classId = request.getParameter("id");
        
        if (classId != null && !classId.isEmpty()) {
            try {
                Classroom classroom = classroomDAO.getClassroomById(classId);
                
                if (classroom != null) {
                    request.setAttribute("classroom", classroom);
                    
                    List<ClassEnrollment> students = classroomDAO.getClassEnrollments(classId);
                    request.setAttribute("students", students);
                   
                    request.getRequestDispatcher("/WEB-INF/views/classroom.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Classroom not found");
                }
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing classroom ID");
        }
    }
}
