package com.classroom.controller;

import com.classroom.dao.ClassroomDAO;
import com.classroom.model.Classroom;
import com.classroom.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

// Xóa annotation @WebServlet("/classroom") vì đã khai báo trong web.xml
public class ClassroomServlet extends HttpServlet {
    private ClassroomDAO classroomDAO = new ClassroomDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("views/login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Classroom classroom = new Classroom();
        classroom.setName(name);
        classroom.setDescription(description);
        classroom.setTeacherId(user.getId());

        if (classroomDAO.createClassroom(classroom)) {
            response.sendRedirect("views/dashboard.jsp");
        } else {
            request.setAttribute("error", "Failed to create classroom");
            request.getRequestDispatcher("views/classroom.jsp").forward(request, response);
        }
    }
}