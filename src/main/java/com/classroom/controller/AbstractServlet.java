package com.classroom.controller;

import com.classroom.dao.ClassroomDAO;
import com.classroom.model.Classroom;
import com.classroom.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.sql.SQLException;
import java.util.ArrayList;

public class AbstractServlet extends HttpServlet {
    private ClassroomDAO classroomDAO;
    
    @Override
    public void init() throws ServletException {
        classroomDAO = new ClassroomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            List<Classroom> classrooms = new ArrayList<>();
            classrooms.addAll(classroomDAO.getCreatedClassrooms(user.getId()));
            classrooms.addAll(classroomDAO.getEnrolledClassrooms(user.getId()));

            request.setAttribute("classrooms", classrooms);
            
            request.getRequestDispatcher("/WEB-INF/views/abstract.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }
}