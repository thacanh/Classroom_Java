package com.classroom.controller;

import com.classroom.dao.ClassroomDAO;
import com.classroom.model.Classroom;
import com.classroom.model.User;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.annotation.MultipartConfig;

@MultipartConfig
public class JoinClassServlet extends HttpServlet {
    private ClassroomDAO classroomDAO;

    @Override
    public void init() throws ServletException {
        classroomDAO = new ClassroomDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();

        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");
            String classroomId = request.getParameter("classId");
            String nickname = request.getParameter("nickName");
            if (classroomId == null || classroomId.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Mã lớp học không hợp lệ!");
                out.print(jsonResponse.toString());
                return;
            }

            if (nickname == null || nickname.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Biệt danh không được để trống!");
                out.print(jsonResponse.toString());
                return;
            }

            Classroom classroom = classroomDAO.getClassroomById(classroomId);

            if (classroom.getCreatorId() == currentUser.getId()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Bạn là người tạo lớp học này!");
                out.print(jsonResponse.toString());
                return;
            }
            
            if (classroom == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Không tìm thấy lớp học với mã này!");
                out.print(jsonResponse.toString());
                return;
            }

            if (classroomDAO.isUserInClassroom(currentUser.getId(), classroomId)) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Bạn đã tham gia lớp học này rồi!");
                out.print(jsonResponse.toString());
                return;
            }

            boolean success = classroomDAO.addUserToClassroom(currentUser.getId(), classroomId, nickname);

            if (success) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Tham gia lớp học thành công!");
                jsonResponse.addProperty("classId", classroomId);
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Có lỗi xảy ra khi tham gia lớp học!");
            }
        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        out.print(jsonResponse.toString());
    }
}
