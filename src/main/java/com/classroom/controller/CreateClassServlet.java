package com.classroom.controller;

import com.classroom.model.Classroom;
import com.classroom.dao.ClassroomDAO;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Lấy thông tin từ request
            String name = request.getParameter("name");
            String subject = request.getParameter("subject");
            String description = request.getParameter("description");

            // Log để debug
            System.out.println("Received request - Name: " + name + ", Subject: " + subject);

            // Validate input
            if (name == null || name.trim().isEmpty()) {
                sendErrorResponse(response, "Tên lớp học không được để trống");
                return;
            }

            // Create new classroom
            Classroom classroom = new Classroom();
            classroom.setName(name);
            classroom.setSubject(subject);
            classroom.setDescription(description);

            // Save to database
            Classroom savedClassroom = classroomDAO.createClassroom(classroom);

            if (savedClassroom != null) {
                // Success response
                ResponseData responseData = new ResponseData(true, savedClassroom, null);
                String jsonResponse = gson.toJson(responseData);
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
                out.flush();
            } else {
                sendErrorResponse(response, "Không thể tạo lớp học");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "Lỗi khi tạo lớp học: " + e.getMessage());
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        ResponseData responseData = new ResponseData(false, null, message);
        String jsonResponse = gson.toJson(responseData);
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
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
