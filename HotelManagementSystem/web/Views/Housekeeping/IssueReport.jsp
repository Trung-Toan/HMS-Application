<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Báo sự cố / thiếu vật tư</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">
        <div class="container py-4">
            <h2 class="mb-3">Báo sự cố / thiếu vật tư</h2>

            <div class="mb-3">
                <a href="<c:url value='/housekeeping/dashboard'/>"
                   class="btn btn-secondary btn-sm">← Dashboard</a>
            </div>

            <div class="card">
                <div class="card-body">
                    <form method="post" action="<c:url value='/housekeeping/issue-report'/>">
                        <input type="hidden" name="action" value="createIssue"/>

                        <div class="mb-3">
                            <label class="form-label">Phòng</label>
                            <c:choose>
                                <c:when test="${not empty room}">
                                    <input type="hidden" name="roomId" value="${room.roomId}"/>
                                    <input type="text" class="form-control" value="${room.roomNumber}" readonly/>
                                </c:when>
                                <c:otherwise>
                                    <!-- Nếu không truyền sẵn room, nhập Room ID -->
                                    <input type="number" class="form-control" name="roomId"
                                           placeholder="Nhập Room ID"/>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Loại sự cố</label>
                            <select name="issueType" class="form-select">
                                <option value="SUPPLY">Thiếu vật tư (SUPPLY)</option>
                                <option value="EQUIPMENT">Thiết bị hỏng (EQUIPMENT)</option>
                                <option value="OTHER">Khác (OTHER)</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả chi tiết</label>
                            <textarea name="description" rows="4" class="form-control"
                                      placeholder="Mô tả rõ vấn đề, vị trí, số lượng thiếu, tình trạng hỏng..."></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">Gửi báo cáo</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- SweetAlert notify -->
        <jsp:include page="../public/notify.jsp" />
    </body>
</html>
