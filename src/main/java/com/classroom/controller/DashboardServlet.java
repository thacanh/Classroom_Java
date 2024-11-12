package com.classroom.controller;

import com.classroom.dao.ClassroomDAO;
import com.classroom.model.Classroom;
import com.classroom.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.sql.SQLException;

public class DashboardServlet extends HttpServlet {
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
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            List<Classroom> classrooms = classroomDAO.getAllClassrooms();
            request.setAttribute("classrooms", classrooms);
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        }
    }
}
