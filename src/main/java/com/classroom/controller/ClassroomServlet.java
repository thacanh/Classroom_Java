package com.classroom.controller;

import com.classroom.dao.ClassroomDAO;
import com.classroom.model.Classroom;
import com.classroom.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ClassroomServlet extends HttpServlet {
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

        request.getRequestDispatcher("createclass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Tên lớp học không được để trống!");
            request.getRequestDispatcher("createclass.jsp").forward(request, response);
            return;
        }

        if (subject == null || subject.trim().isEmpty()) {
            request.setAttribute("error", "Môn học không được để trống!");
            request.getRequestDispatcher("createclass.jsp").forward(request, response);
            return;
        }

        try {
            Classroom classroom = new Classroom();
            classroom.setName(name.trim());
            classroom.setSubject(subject.trim());
            classroom.setDescription(description != null ? description.trim() : "");

            Classroom newClassroom = classroomDAO.createClassroom(classroom);
            
            if (newClassroom != null) {
                session.setAttribute("successMessage", "Tạo lớp học thành công!");
                response.sendRedirect("dashboard");
            } else {
                request.setAttribute("error", "Không thể tạo lớp học. Vui lòng thử lại!");
                request.getRequestDispatcher("createclass.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.out.println("Error creating classroom: " + e.getMessage());
            request.setAttribute("error", "Đã xảy ra lỗi khi tạo lớp học!");
            request.getRequestDispatcher("createclass.jsp").forward(request, response);
        }
    }
}
