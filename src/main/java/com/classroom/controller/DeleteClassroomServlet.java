package com.classroom.controller;

import com.classroom.dao.ClassroomDAO;
import com.classroom.model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

public class DeleteClassroomServlet extends HttpServlet {
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            String classroomId = request.getParameter("id");
            if (!classroomDAO.isClassroomCreator(currentUser.getId(), classroomId)) {
                sendErrorResponse(response, "Bạn không có quyền xóa lớp học này");
                return;
            }
            boolean success = classroomDAO.deleteClassroom(classroomId);
            ResponseData responseData = new ResponseData(success, 
                success ? "Xóa lớp học thành công" : "Không thể xóa lớp học");
            out.print(gson.toJson(responseData));
        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorResponse(response, e.getMessage());
        } finally {
            out.flush();
            out.close();
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        ResponseData responseData = new ResponseData(false, message);
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(responseData));
        out.flush();
    }

    private static class ResponseData {
        private final boolean success;
        private final String message;

        ResponseData(boolean success, String message) {
            this.success = success;
            this.message = message;
        }

        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
    }
}
