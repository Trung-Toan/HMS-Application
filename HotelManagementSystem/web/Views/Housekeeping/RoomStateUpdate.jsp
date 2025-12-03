<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật trạng thái phòng</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    </head>
    <body class="bg-light">
        <div class="container py-4">
            <h2 class="mb-3">Cập nhật trạng thái phòng</h2>

            <div class="mb-3">
                <a href="<c:url value='/housekeeping/dashboard'/>"
                   class="btn btn-secondary btn-sm">← Dashboard</a>
            </div>

            <c:if test="${empty room}">
                <p class="text-danger">Không tìm thấy phòng.</p>
            </c:if>

            <c:if test="${not empty room}">
                <div class="card">
                    <div class="card-body">
                        <p><strong>Phòng:</strong> ${room.roomNumber}</p>
                        <p><strong>Tầng:</strong> ${room.floor}</p>
                        <p><strong>Trạng thái hiện tại:</strong> ${room.status}</p>

                        <form method="post" action="<c:url value='/housekeeping/room-update'/>">
                            <input type="hidden" name="action" value="updateRoomStatus"/>
                            <input type="hidden" name="roomId" value="${room.roomId}"/>

                            <div class="mb-3">
                                <label class="form-label">Trạng thái mới</label>
                                <select name="status" class="form-select">
                                    <option value="AVAILABLE" ${room.status == 'AVAILABLE' ? 'selected' : ''}>AVAILABLE</option>
                                    <option value="BOOKED" ${room.status == 'BOOKED' ? 'selected' : ''}>BOOKED</option>
                                    <option value="OCCUPIED" ${room.status == 'OCCUPIED' ? 'selected' : ''}>OCCUPIED</option>
                                    <option value="DIRTY" ${room.status == 'DIRTY' ? 'selected' : ''}>DIRTY</option>
                                    <option value="CLEANING" ${room.status == 'CLEANING' ? 'selected' : ''}>CLEANING</option>
                                    <option value="MAINTENANCE" ${room.status == 'MAINTENANCE' ? 'selected' : ''}>MAINTENANCE</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </form>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- SweetAlert notify -->
        <jsp:include page="../public/notify.jsp" />
    </body>
</html>
