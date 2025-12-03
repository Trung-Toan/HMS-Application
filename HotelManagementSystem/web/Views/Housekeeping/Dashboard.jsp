<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Housekeeping Dashboard</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">

        <div class="container py-4">
            <h2 class="mb-3">Housekeeping Dashboard</h2>

            <div class="mb-3">
                <a href="<c:url value='/housekeeping/tasks'/>" class="btn btn-primary btn-sm">
                    Danh sách task
                </a>
                <a href="<c:url value='/housekeeping/issue-report'/>" class="btn btn-warning btn-sm">
                    Báo sự cố / thiếu vật tư
                </a>
            </div>

            <!-- 1. Phòng cần dọn / đang dọn -->
            <div class="card mb-4">
                <div class="card-header">
                    Phòng cần dọn / đang dọn
                </div>
                <div class="card-body">
                    <c:if test="${empty roomsNeedCleaning}">
                        <p class="text-muted mb-0">Hiện không có phòng DIRTY hoặc CLEANING.</p>
                    </c:if>
                    <c:if test="${not empty roomsNeedCleaning}">
                        <table class="table table-sm table-striped align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Phòng</th>
                                    <th>Tầng</th>
                                    <th>Trạng thái</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${roomsNeedCleaning}" var="r" varStatus="st">
                                    <tr>
                                        <td>${st.index + 1}</td>
                                        <td>${r.roomNumber}</td>
                                        <td>${r.floor}</td>
                                        <td>${r.status}</td>
                                        <td>
                                            <a class="btn btn-outline-secondary btn-sm"
                                               href="<c:url value='/housekeeping/room-update'>
                                                        <c:param name='roomId' value='${r.roomId}'/>
                                                    </c:url>">
                                                Cập nhật trạng thái
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>

            <!-- 2. Task dọn phòng hôm nay -->
            <div class="card mb-4">
                <div class="card-header">
                    Task dọn phòng hôm nay 
                    <c:if test="${not empty today}">(${today})</c:if>
                </div>
                <div class="card-body">
                    <c:if test="${empty todayTasks}">
                        <p class="text-muted mb-0">Bạn chưa có task nào trong ngày.</p>
                    </c:if>
                    <c:if test="${not empty todayTasks}">
                        <table class="table table-sm table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Phòng</th>
                                    <th>Loại task</th>
                                    <th>Trạng thái</th>
                                    <th>Ghi chú</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${todayTasks}" var="t" varStatus="st">
                                    <tr>
                                        <td>${st.index + 1}</td>
                                        <td>${t.roomId}</td>
                                        <td>${t.taskType}</td>
                                        <td>${t.status}</td>
                                        <td>${t.note}</td>
                                        <td>
                                            <a class="btn btn-outline-primary btn-sm"
                                               href="<c:url value='/housekeeping/task-detail'>
                                                        <c:param name='id' value='${t.taskId}'/>
                                                    </c:url>">
                                                Chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>

            <!-- 3. Ca làm việc hôm nay -->
            <div class="card">
                <div class="card-header">
                    Ca làm việc hôm nay 
                    <c:if test="${not empty today}">(${today})</c:if>
                </div>
                <div class="card-body">
                    <c:if test="${empty todayAssignments}">
                        <p class="text-muted mb-0">Chưa có thông tin phân ca.</p>
                    </c:if>
                    <c:if test="${not empty todayAssignments}">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Ca</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${todayAssignments}" var="a" varStatus="st">
                                    <tr>
                                        <td>${st.index + 1}</td>
                                        <td>${a.shiftType}</td>
                                        <td>${a.status}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>

        </div>

        <!-- SweetAlert notify -->
        <jsp:include page="../public/notify.jsp" />
    </body>
</html>
