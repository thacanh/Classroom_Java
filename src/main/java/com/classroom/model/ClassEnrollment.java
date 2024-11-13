package com.classroom.model;

public class ClassEnrollment {
    private int studentId;
    private String nickname;

    public ClassEnrollment(int studentId, String nickname) {
        this.studentId = studentId;
        this.nickname = nickname;
    }

    // Getters and setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
