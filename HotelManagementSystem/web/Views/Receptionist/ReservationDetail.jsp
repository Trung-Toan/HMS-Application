<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Chi Tiết Đặt Phòng - Lễ Tân</title>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/receptionist.css">
                </head>

                <body>
                    <header>
                        <div class="logo">🏨 Khách Sạn Royal - Quản Lí</div>
                        <div class="header-right">
                            <div class="nav-links">
                                <a href="${pageContext.request.contextPath}/receptionist/dashboard">Dashboard</a>
                                <a href="${pageContext.request.contextPath}/reservation_approval">Duyệt Phòng</a>
                                <a href="${pageContext.request.contextPath}/receptionist/reservations">Danh Sách</a>
                            </div>
                            <div class="staff-profile">
                                <span>${sessionScope.currentUser.fullName}</span>
                                <div class="staff-avatar">${fn:substring(sessionScope.currentUser.fullName, 0, 2)}</div>
                            </div>
                        </div>
                    </header>

                    <div class="container">
                        <div class="page-title">
                            📄 Chi Tiết Đặt Phòng #BK-${booking.bookingId}
                            <a href="${pageContext.request.contextPath}/receptionist/reservations" class="back-link">←
                                Quay lại Danh Sách</a>
                        </div>

                        <!-- Booking Info -->
                        <div class="detail-card">
                            <div class="section-title">Thông Tin Đặt Phòng</div>
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">Mã Booking</div>
                                    <div class="info-value">BK-${booking.bookingId}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Trạng Thái</div>
                                    <div class="info-value">
                                        <span
                                            class="badge badge-${fn:toLowerCase(booking.status)}">${booking.status}</span>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Ngày Check-in</div>
                                    <div class="info-value">${booking.checkinDate}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Ngày Check-out</div>
                                    <div class="info-value">${booking.checkoutDate}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Số Khách</div>
                                    <div class="info-value">${booking.numGuests} người</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Tổng Tiền</div>
                                    <div class="info-value price-large">
                                        <fmt:formatNumber value="${booking.totalAmount}" pattern="#,###" /> đ
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Customer Info -->
                        <div class="detail-card">
                            <div class="section-title">Thông Tin Khách Hàng</div>
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">Họ Tên</div>
                                    <div class="info-value">${booking.customerName}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Email</div>
                                    <div class="info-value" style="font-size: 15px;">${booking.customerEmail}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Điện Thoại</div>
                                    <div class="info-value">${booking.customerPhone}</div>
                                </div>
                            </div>
                        </div>

                        <!-- Room Info -->
                        <div class="detail-card">
                            <div class="section-title">Thông Tin Phòng</div>
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">Số Phòng</div>
                                    <div class="info-value">${booking.roomNumber}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Loại Phòng</div>
                                    <div class="info-value">${booking.typeName}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Tầng</div>
                                    <div class="info-value">Tầng ${booking.floor}</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Giá Cơ Bản</div>
                                    <div class="info-value price">
                                        <fmt:formatNumber value="${booking.basePrice}" pattern="#,###" /> đ/đêm
                                    </div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Sức Chứa</div>
                                    <div class="info-value">Tối đa ${booking.maxOccupancy} người</div>
                                </div>
                            </div>
                        </div>

                        <!-- Timestamps -->
                        <div class="detail-card">
                            <div class="section-title">Lịch Sử</div>
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">Ngày Tạo</div>
                                    <div class="info-value" style="font-size: 15px;">
                                        ${fn:replace(fn:substring(booking.createdAt, 0, 16), 'T', ' ')}</div>
                                </div>
                                <c:if test="${not empty booking.updatedAt}">
                                    <div class="info-item">
                                        <div class="info-label">Cập Nhật Lần Cuối</div>
                                        <div class="info-value" style="font-size: 15px;">
                                            ${fn:replace(fn:substring(booking.updatedAt, 0, 16), 'T', ' ')}</div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <footer>
                        <p>&copy; 2025 Khách Sạn Royal. Hệ Thống Quản Lí Khách Sạn</p>
                    </footer>
                </body>

                </html>