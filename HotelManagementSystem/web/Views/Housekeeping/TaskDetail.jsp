<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết Task dọn phòng</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">
        <div class="container py-4">
            <h2 class="mb-3">Chi tiết Task dọn phòng</h2>

            <div class="mb-3">
                <a href="<c:url value='/housekeeping/tasks'/>"
                   class="btn btn-secondary btn-sm">← Quay lại danh sách</a>
            </div>

            <c:if test="${empty task}">
                <p class="text-danger">Không tìm thấy task.</p>
            </c:if>

            <c:if test="${not empty task}">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-3">
                            <div class="card-header">Thông tin Task</div>
                            <div class="card-body">
                                <p><strong>Mã task:</strong> ${task.taskId}</p>
                                <p><strong>Ngày:</strong> ${task.taskDate}</p>
                                <p><strong>Phòng ID:</strong> ${task.roomId}</p>
                                <p><strong>Loại task:</strong> ${task.taskType}</p>
                                <p><strong>Trạng thái hiện tại:</strong> ${task.status}</p>
                                <p><strong>Ghi chú:</strong> ${task.note}</p>

                                <c:if test="${not empty room}">
                                    <hr/>
                                    <p><strong>Phòng:</strong> ${room.roomNumber}</p>
                                    <p><strong>Tầng:</strong> ${room.floor}</p>
                                    <p><strong>Trạng thái phòng:</strong> ${room.status}</p>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">Cập nhật Task</div>
                            <div class="card-body">
                                <form method="post" action="<c:url value='/housekeeping/task-update'/>">
                                    <input type="hidden" name="action" value="updateTask"/>
                                    <input type="hidden" name="taskId" value="${task.taskId}"/>

                                    <div class="mb-3">
                                        <label class="form-label">Trạng thái mới</label>
                                        <select name="status" class="form-select">
                                            <option value="NEW" ${task.status == 'NEW' ? 'selected' : ''}>NEW</option>
                                            <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? 'selected' : ''}>IN_PROGRESS</option>
                                            <option value="DONE" ${task.status == 'DONE' ? 'selected' : ''}>DONE</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Ghi chú</label>
                                        <textarea name="note" class="form-control" rows="4">${task.note}</textarea>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Lưu cập nhật</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- SweetAlert notify -->
        <jsp:include page="../public/notify.jsp" />
    </body>
</html>
