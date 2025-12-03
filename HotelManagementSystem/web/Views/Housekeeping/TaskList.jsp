<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách Task dọn phòng</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">
        <div class="container py-4">
            <h2 class="mb-3">Danh sách Task dọn phòng</h2>

            <div class="mb-3">
                <a href="<c:url value='/housekeeping/dashboard'/>"
                   class="btn btn-secondary btn-sm">← Dashboard</a>
            </div>

            <!-- Bộ lọc -->
            <form class="row g-2 mb-3" method="get" action="<c:url value='/housekeeping/tasks'/>">
                <div class="col-md-3">
                    <label class="form-label">Ngày</label>
                    <input type="date" name="date" value="${filterDate}" class="form-control"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="">Tất cả</option>
                        <option value="NEW" ${filterStatus == 'NEW' ? 'selected' : ''}>NEW</option>
                        <option value="IN_PROGRESS" ${filterStatus == 'IN_PROGRESS' ? 'selected' : ''}>IN_PROGRESS</option>
                        <option value="DONE" ${filterStatus == 'DONE' ? 'selected' : ''}>DONE</option>
                    </select>
                </div>
                <div class="col-md-3 align-self-end">
                    <button type="submit" class="btn btn-primary">Lọc</button>
                </div>
            </form>

            <c:if test="${empty tasks}">
                <p class="text-muted">Không có task nào.</p>
            </c:if>

            <c:if test="${not empty tasks}">
                <table class="table table-striped table-hover align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Ngày</th>
                            <th>Phòng</th>
                            <th>Loại</th>
                            <th>Trạng thái</th>
                            <th>Ghi chú</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${tasks}" var="t" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td>${t.taskDate}</td>
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

        <!-- SweetAlert notify -->
        <jsp:include page="../public/notify.jsp" />
    </body>
</html>
