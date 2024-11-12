<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .class-grid {
        margin-top: 100px;
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }

    .class-card {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 2px 0 rgba(60,64,67,0.3), 0 1px 3px 1px rgba(60,64,67,0.15);
        overflow: hidden;
        transition: box-shadow 0.3s ease, transform 0.3s ease;
        display: flex;
        flex-direction: column;
        min-height: 200px;
    }

    .class-card:hover {
        box-shadow: 0 1px 3px 0 rgba(60,64,67,0.3), 0 4px 8px 3px rgba(60,64,67,0.15);
        transform: translateY(-2px);
    }

    .class-header {
        background-color: #1aa260;
        color: white;
        padding: 16px;
        position: relative;
        overflow: hidden;
    }

    .class-title {
        font-size: 20px;
        margin: 0;
        font-weight: 500;
        word-wrap: break-word;
    }

    .class-section {
        font-size: 14px;
        margin-top: 4px;
        opacity: 0.9;
        word-wrap: break-word;
    }

    .class-menu {
        position: absolute;
        top: 12px;
        right: 12px;
        color: white;
        cursor: pointer;
        padding: 8px;
        border-radius: 50%;
    }

    .class-menu:hover {
        background-color: rgba(255,255,255,0.1);
    }

    .class-body {
        padding: 16px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .class-body p {
        margin-bottom: 12px;
        word-wrap: break-word;
    }

    .class-body a {
        color: #1a73e8;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s ease;
        align-self: flex-start;
    }

    .class-body a:hover {
        color: #174ea6;
        text-decoration: underline;
    }
</style>

<div class="class-grid">
    <c:forEach items="${classrooms}" var="classroom">
        <div class="class-card">
            <div class="class-header">
                <h2 class="class-title">${classroom.name}</h2>
                <p class="class-section">${classroom.subject}</p>
                <i class="material-icons class-menu">more_vert</i>
            </div>
            <div class="class-body">
                <p>${classroom.description}</p>
                <a href="classroom?id=${classroom.id}">Xem lớp học</a>
            </div>
        </div>
    </c:forEach>
</div>
