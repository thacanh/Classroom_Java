<div id="studentsSection" class="content-section">
    <h2>Danh sách sinh viên</h2>
    <ul class="students-list">
        <c:forEach items="${students}" var="enrollment">
            <li class="student-item">
                <div class="student-avatar">
                    ${enrollment.nickname.charAt(0)}
                </div>
                <div class="student-info">
                    <strong>${enrollment.nickname}</strong>
                    <div>ID: ${enrollment.studentId}</div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
