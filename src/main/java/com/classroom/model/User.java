package com.classroom.model;

public class User {
    private int id;
    private String username;
    private String password; // Mật khẩu không có getter
    private String email;
    private String role;

    // Constructor đầy đủ
    public User(int id, String username, String password, String email, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
    }

    // Constructor không bao gồm id (dùng khi tạo mới đối tượng User trước khi lưu vào DB)
    public User(String username, String password, String email, String role) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
    }

    // Constructor mặc định
    public User() {
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }

    // Không tạo getter cho password để tăng bảo mật
    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
