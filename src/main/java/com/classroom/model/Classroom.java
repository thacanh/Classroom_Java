package com.classroom.model;

public class Classroom {
    private String id;           
    private String name;
    private String subject;
    private String description;
    private int creatorId;       

    public Classroom() {}

    public Classroom(String id, String name, String subject, String description, int creatorId) {
        this.id = id;
        this.name = name;
        this.subject = subject;
        this.description = description;
        this.creatorId = creatorId;
    }

    public Classroom(String name, String subject, String description, int creatorId) {
        this.name = name;
        this.subject = subject;
        this.description = description;
        this.creatorId = creatorId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(int creatorId) {
        this.creatorId = creatorId;
    }
}
