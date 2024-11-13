package com.classroom.controller;

import com.classroom.model.Classroom;
import com.classroom.dao.ClassroomDAO;
import com.classroom.model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
public class CreateClassServlet extends HttpServlet {
    private ClassroomDAO classroomDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        classroomDAO = new ClassroomDAO();
        gson = new Gson();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            if (currentUser == null) {
                sendErrorResponse(response, "Người dùng chưa đăng nhập");
                return;
            }

            String name = request.getParameter("name");
            String subject = request.getParameter("subject");
            String description = request.getParameter("description");

            System.out.println("Received request - Name: " + name + ", Subject: " + subject);

            if (name == null || name.trim().isEmpty() || subject == null || subject.trim().isEmpty()) {
                sendErrorResponse(response, "Tên lớp học và môn học không được để trống");
                return;
            }

            Classroom classroom = new Classroom();
            classroom.setName(name);
            classroom.setSubject(subject);
            classroom.setDescription(description);
            classroom.setCreatorId(currentUser.getId());

            Classroom savedClassroom = classroomDAO.createClassroom(classroom);

            if (savedClassroom != null) {
                ResponseData responseData = new ResponseData(true, savedClassroom, null);
                out.print(gson.toJson(responseData));
            } else {
                sendErrorResponse(response, "Không thể tạo lớp học");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Lỗi khi tạo lớp học: " + e.getMessage());
        } finally {
            out.flush();
            out.close();
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        ResponseData responseData = new ResponseData(false, null, message);
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(responseData));
        out.flush();
    }

    private static class ResponseData {
        private final boolean success;
        private final Classroom classroom;
        private final String errorMessage;

        ResponseData(boolean success, Classroom classroom, String errorMessage) {
            this.success = success;
            this.classroom = classroom;
            this.errorMessage = errorMessage;
        }

        // Getters
        public boolean isSuccess() { return success; }
        public Classroom getClassroom() { return classroom; }
        public String getErrorMessage() { return errorMessage; }
    }
}

