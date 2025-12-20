<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>My Rooms - Hotel Management System</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <style>
                    .rooms-container {
                        max-width: 1000px;
                        margin: 40px auto;
                        padding: 0 20px;
                    }

                    .rooms-header {
                        background: white;
                        padding: 30px;
                        border-radius: 15px;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                        margin-bottom: 30px;
                    }

                    .rooms-header h2 {
                        color: #2c3e50;
                        margin: 0 0 10px 0;
                        font-size: 24px;
                    }

                    .rooms-header p {
                        color: #7f8c8d;
                        margin: 0;
                    }

                    .rooms-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                        gap: 25px;
                    }

                    .room-card {
                        background: white;
                        border-radius: 15px;
                        overflow: hidden;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                        transition: transform 0.2s, box-shadow 0.2s;
                    }

                    .room-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                    }

                    .room-card-header {
                        background: linear-gradient(135deg, #3498db, #2980b9);
                        color: white;
                        padding: 20px;
                    }

                    .room-number {
                        font-size: 28px;
                        font-weight: bold;
                        margin-bottom: 5px;
                    }

                    .room-type {
                        opacity: 0.9;
                        font-size: 14px;
                    }

                    .room-card-body {
                        padding: 20px;
                    }

                    .room-info-row {
                        display: flex;
                        justify-content: space-between;
                        padding: 10px 0;
                        border-bottom: 1px solid #eee;
                    }

                    .room-info-row:last-child {
                        border-bottom: none;
                    }

                    .room-info-label {
                        color: #7f8c8d;
                        font-size: 14px;
                    }

                    .room-info-value {
                        color: #2c3e50;
                        font-weight: 600;
                    }

                    .room-card-footer {
                        padding: 15px 20px;
                        background: #f8f9fa;
                        text-align: center;
                    }

                    .btn-view-amenities {
                        padding: 10px 25px;
                        background: #3498db;
                        color: white;
                        border: none;
                        border-radius: 8px;
                        text-decoration: none;
                        font-weight: 600;
                        transition: background 0.2s;
                        display: inline-block;
                    }

                    .btn-view-amenities:hover {
                        background: #2980b9;
                        color: white;
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                    }

                    .empty-state i {
                        font-size: 60px;
                        color: #bdc3c7;
                        margin-bottom: 20px;
                    }

                    .empty-state h3 {
                        color: #2c3e50;
                        margin-bottom: 10px;
                    }

                    .empty-state p {
                        color: #7f8c8d;
                        margin-bottom: 20px;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../Components/Header.jsp" />

                <div class="rooms-container">
                    <div class="rooms-header">
                        <h2><i class="fas fa-door-open"></i> My Active Rooms</h2>
                        <p>View amenities for your checked-in rooms</p>
                    </div>

                    <c:choose>
                        <c:when test="${not empty activeBookings}">
                            <div class="rooms-grid">
                                <c:forEach items="${activeBookings}" var="b">
                                    <div class="room-card">
                                        <div class="room-card-header">
                                            <div class="room-number">Room ${b.room.roomNumber}</div>
                                            <div class="room-type">${b.room.roomType.typeName}</div>
                                        </div>
                                        <div class="room-card-body">
                                            <div class="room-info-row">
                                                <span class="room-info-label">Check-in</span>
                                                <span class="room-info-value">${b.checkinDate}</span>
                                            </div>
                                            <div class="room-info-row">
                                                <span class="room-info-label">Check-out</span>
                                                <span class="room-info-value">${b.checkoutDate}</span>
                                            </div>
                                            <div class="room-info-row">
                                                <span class="room-info-label">Guests</span>
                                                <span class="room-info-value">${b.numGuests}</span>
                                            </div>
                                        </div>
                                        <div class="room-card-footer"
                                            style="display: flex; justify-content: space-between; align-items: center;">
                                            <c:choose>
                                                <c:when test="${confirmationStatus[b.bookingId]}">
                                                    <span
                                                        style="background: #d4edda; color: #155724; padding: 5px 12px; border-radius: 15px; font-size: 13px; font-weight: 500;">
                                                        <i class="fas fa-check-circle"></i> Confirmed
                                                    </span>
                                                    <a href="${pageContext.request.contextPath}/customer/amenities?bookingId=${b.bookingId}"
                                                        style="background: #6c757d; color: white; padding: 8px 20px; border-radius: 6px; text-decoration: none; font-weight: 600;">
                                                        <i class="fas fa-eye"></i> View
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        style="background: #fff3cd; color: #856404; padding: 5px 12px; border-radius: 15px; font-size: 13px; font-weight: 500;">
                                                        <i class="fas fa-clock"></i> Pending
                                                    </span>
                                                    <a href="${pageContext.request.contextPath}/customer/amenities?bookingId=${b.bookingId}"
                                                        style="background: #3498db; color: white; padding: 8px 20px; border-radius: 6px; text-decoration: none; font-weight: 600;">
                                                        <i class="fas fa-check"></i> Confirm
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-door-closed"></i>
                                <h3>No Active Rooms</h3>
                                <p>You don't have any checked-in rooms at the moment.</p>
                                <a href="${pageContext.request.contextPath}/" class="btn-view-amenities">
                                    <i class="fas fa-home"></i> Back to Home
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <jsp:include page="../Components/Footer.jsp" />
                <jsp:include page="../public/notify.jsp" />
            </body>

            </html>