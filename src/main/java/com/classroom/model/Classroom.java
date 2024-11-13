package com.classroom.model;

import java.util.List;
import java.util.ArrayList;

public class Classroom {

    private String id;
    private String name;
    private String subject;
    private String description;
    private int creatorId;
    private List<ClassEnrollment> enrollments;

    public Classroom() {
        this.enrollments = new ArrayList<>();
    }

    public Classroom(String id, String name, String subject, String description, int creatorId) {
        this.id = id;
        this.name = name;
        this.subject = subject;
        this.description = description;
        this.creatorId = creatorId;
        this.enrollments = new ArrayList<>();
    }

    public Classroom(String name, String subject, String description, int creatorId) {
        this.name = name;
        this.subject = subject;
        this.description = description;
        this.creatorId = creatorId;
        this.enrollments = new ArrayList<>();
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getSubject() {
        return subject;
    }

    public String getDescription() {
        return description;
    }

    public int getCreatorId() {
        return creatorId;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCreatorId(int creatorId) {
        this.creatorId = creatorId;
    }

    public List<ClassEnrollment> getEnrollments() {
        return enrollments;
    }

    public void setEnrollments(List<ClassEnrollment> enrollments) {
        this.enrollments = enrollments;
    }

    public void addEnrollment(ClassEnrollment enrollment) {
        this.enrollments.add(enrollment);
    }

    public void removeEnrollment(ClassEnrollment enrollment) {
        this.enrollments.remove(enrollment);
    }
}
