package com.classroom.model;

public class Classroom {
    private int id;
    private String name;
    private String description;
    private int teacherId;

    public Classroom(int id, int teacherId, String description, String name) {
        this.id = id;
        this.teacherId = teacherId;
        this.description = description;
        this.name = name;
    }

    public Classroom() {
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }
}
