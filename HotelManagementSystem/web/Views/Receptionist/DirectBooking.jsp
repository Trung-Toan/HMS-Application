<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Walk-in Booking - Receptionist</title>
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
                                <a href="${pageContext.request.contextPath}/receptionist/checkinout">Check-in/out</a>
                                <a href="${pageContext.request.contextPath}/receptionist/direct-booking"
                                    class="active">Walk-in</a>
                                <a href="${pageContext.request.contextPath}/receptionist/room-status">Phòng</a>
                                <a href="${pageContext.request.contextPath}/receptionist/profile">Profile</a>
                                <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                            </div>
                            <div class="staff-profile">
                                <span>${sessionScope.currentUser.fullName}</span>
                                <div class="staff-avatar">${fn:substring(sessionScope.currentUser.fullName, 0, 2)}</div>
                            </div>
                        </div>
                    </header>

                    <div class="container">
                        <h1 class="page-title">➕ Walk-in Booking</h1>

                        <!-- Messages -->
                        <c:if test="${not empty sessionScope.success}">
                            <div class="alert alert-success">
                                ✓ ${sessionScope.success}
                            </div>
                            <c:remove var="success" scope="session" />
                        </c:if>

                        <c:if test="${not empty sessionScope.error}">
                            <div class="alert alert-error">
                                ✗ ${sessionScope.error}
                            </div>
                            <c:remove var="error" scope="session" />
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">
                                ✗ ${error}
                            </div>
                        </c:if>

                        <!-- Search Available Rooms -->
                        <div class="filter-section">
                            <h2>🔍 Search Available Rooms</h2>
                            <form method="post" action="${pageContext.request.contextPath}/receptionist/direct-booking">
                                <input type="hidden" name="action" value="search">
                                <div class="filter-grid">
                                    <input type="date" id="checkIn" name="checkIn"
                                        value="${checkIn != null ? checkIn : ''}" min="${pageScope.today}" required>
                                    <input type="date" id="checkOut" name="checkOut"
                                        value="${checkOut != null ? checkOut : ''}" min="${pageScope.today}" required>
                                    <button type="submit" class="btn btn-primary">Search Rooms</button>
                                </div>
                            </form>
                        </div>

                        <!-- Available Rooms Results -->
                        <c:if test="${not empty availableRooms}">
                            <div class="section">
                                <h2>🏨 Available Rooms (${fn:length(availableRooms)})</h2>
                                <p style="margin-bottom: 20px; color: #777;">
                                    ${checkIn} to ${checkOut} - <strong>${nights} night${nights gt 1 ? 's' :
                                        ''}</strong>
                                </p>
                                <div class="reservations-grid">
                                    <c:forEach var="room" items="${availableRooms}">
                                        <div class="reservation-card">
                                            <div class="reservation-header">
                                                <div class="reservation-id">Room ${room.roomNumber}</div>
                                                <span class="badge badge-confirmed">Available</span>
                                            </div>
                                            <div class="reservation-body">
                                                <div class="info-table">
                                                    <table style="width: 100%; border: none;">
                                                        <tr>
                                                            <td style="border: none; padding: 10px 0;">
                                                                <strong>Type:</strong>
                                                            </td>
                                                            <td
                                                                style="border: none; padding: 10px 0; text-align: right;">
                                                                ${room.typeName}
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="border: none; padding: 10px 0;">
                                                                <strong>Floor:</strong>
                                                            </td>
                                                            <td
                                                                style="border: none; padding: 10px 0; text-align: right;">
                                                                Floor ${room.floor}
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="border: none; padding: 10px 0;">
                                                                <strong>Max Guests:</strong>
                                                            </td>
                                                            <td
                                                                style="border: none; padding: 10px 0; text-align: right;">
                                                                ${room.maxOccupancy} guests
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="border: none; padding: 10px 0;">
                                                                <strong>Price/Night:</strong>
                                                            </td>
                                                            <td
                                                                style="border: none; padding: 10px 0; text-align: right;">
                                                                <span class="price">
                                                                    <fmt:formatNumber value="${room.basePrice}"
                                                                        pattern="#,###" /> đ
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr style="border-top: 2px solid #e0e0e0;">
                                                            <td style="border: none; padding: 15px 0 5px 0;">
                                                                <strong>Total (${nights} nights):</strong>
                                                            </td>
                                                            <td
                                                                style="border: none; padding: 15px 0 5px 0; text-align: right;">
                                                                <span class="price price-large">
                                                                    <fmt:formatNumber value="${room.totalPrice}"
                                                                        pattern="#,###" /> đ
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <button class="btn btn-primary" style="width: 100%; margin-top: 15px;"
                                                    onclick="selectRoom(${room.roomId}, '${room.roomNumber}', '${room.typeName}', ${room.totalPrice}, ${room.maxOccupancy})">
                                                    Select Room
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div id="rooms-pagination" class="pagination"></div>
                            </div>
                        </c:if>

                        <c:if test="${not empty checkIn && not empty checkOut && empty availableRooms && empty error}">
                            <div class="section">
                                <div class="empty-state">
                                    <h3>😔 No rooms available</h3>
                                    <p>Please try different dates</p>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Booking Form Modal -->
                    <div id="bookingModal" class="modal">
                        <div class="modal-content">
                            <div class="modal-header">Create Walk-in Booking</div>
                            <form id="bookingForm" method="post"
                                action="${pageContext.request.contextPath}/receptionist/direct-booking">
                                <input type="hidden" name="action" value="create">
                                <input type="hidden" name="roomId" id="selectedRoomId">
                                <input type="hidden" name="checkIn" id="selectedCheckIn">
                                <input type="hidden" name="checkOut" id="selectedCheckOut">
                                <input type="hidden" name="totalAmount" id="selectedTotalAmount">

                                <div class="modal-body">
                                    <!-- Room Summary -->
                                    <div
                                        style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                                        <h4 style="margin: 0 0 10px; color: #1e3c72;">Selected Room</h4>
                                        <p style="margin: 5px 0;"><strong>Room:</strong> <span id="summaryRoom"></span>
                                        </p>
                                        <p style="margin: 5px 0;"><strong>Dates:</strong> <span
                                                id="summaryDates"></span></p>
                                        <p style="margin: 10px 0 0; font-size: 18px;"><strong>Total:</strong>
                                            <span id="summaryTotal" class="price"></span>
                                        </p>
                                    </div>

                                    <!-- Customer Information -->
                                    <h4 style="margin: 20px 0 15px; color: #1e3c72;">Customer Information</h4>
                                    <div style="margin-bottom: 15px;">
                                        <label
                                            style="display: block; margin-bottom: 5px; font-weight: 600; color: #555;">
                                            Full Name *
                                        </label>
                                        <input type="text" id="customerName" name="customerName"
                                            placeholder="Enter customer full name" required
                                            style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label
                                            style="display: block; margin-bottom: 5px; font-weight: 600; color: #555;">
                                            Email *
                                        </label>
                                        <input type="email" id="customerEmail" name="customerEmail"
                                            placeholder="customer@example.com" required
                                            style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label
                                            style="display: block; margin-bottom: 5px; font-weight: 600; color: #555;">
                                            Phone Number *
                                        </label>
                                        <input type="tel" id="customerPhone" name="customerPhone"
                                            placeholder="0123456789" required
                                            style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                    </div>
                                    <div style="margin-bottom: 15px;">
                                        <label
                                            style="display: block; margin-bottom: 5px; font-weight: 600; color: #555;">
                                            Number of Guests *
                                        </label>
                                        <input type="number" id="numGuests" name="numGuests" min="1" max="10" value="1"
                                            required
                                            style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px;">
                                        <small style="color: #999;">Maximum: <span id="maxGuests"></span> guests</small>
                                    </div>

                                    <div style="margin-bottom: 15px;">
                                        <label
                                            style="display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 10px; background: #f8f9fa; border-radius: 8px;">
                                            <input type="checkbox" name="immediateCheckIn" id="immediateCheckIn">
                                            <span>Check in immediately (only for same-day arrivals)</span>
                                        </label>
                                    </div>
                                </div>

                                <div class="modal-buttons">
                                    <button type="button" class="btn btn-cancel"
                                        onclick="closeBookingModal()">Cancel</button>
                                    <button type="submit" class="btn btn-approve">Create Booking</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <footer>
                        <p>&copy; 2025 Khách Sạn Royal. Hệ Thống Quản Lí Khách Sạn</p>
                    </footer>

                    <script>
                        // Set minimum dates to today
                        const today = new Date().toISOString().split('T')[0];
                        document.getElementById('checkIn').min = today;
                        document.getElementById('checkOut').min = today;

                        // Update checkout min date when checkin changes
                        document.getElementById('checkIn').addEventListener('change', function () {
                            const checkInDate = new Date(this.value);
                            const nextDay = new Date(checkInDate);
                            nextDay.setDate(nextDay.getDate() + 1);
                            document.getElementById('checkOut').min = nextDay.toISOString().split('T')[0];
                        });

                        function selectRoom(roomId, roomNumber, typeName, totalPrice, maxOccupancy) {
                            const checkIn = document.getElementById('checkIn').value;
                            const checkOut = document.getElementById('checkOut').value;

                            document.getElementById('selectedRoomId').value = roomId;
                            document.getElementById('selectedCheckIn').value = checkIn;
                            document.getElementById('selectedCheckOut').value = checkOut;
                            document.getElementById('selectedTotalAmount').value = totalPrice;

                            document.getElementById('summaryRoom').textContent = 'Room ' + roomNumber + ' (' + typeName + ')';
                            document.getElementById('summaryDates').textContent = checkIn + ' to ' + checkOut;
                            document.getElementById('summaryTotal').textContent = formatCurrency(totalPrice) + ' đ';
                            document.getElementById('maxGuests').textContent = maxOccupancy;
                            document.getElementById('numGuests').max = maxOccupancy;

                            const isToday = checkIn === today;
                            document.getElementById('immediateCheckIn').disabled = !isToday;
                            if (!isToday) {
                                document.getElementById('immediateCheckIn').checked = false;
                            }

                            document.getElementById('bookingModal').style.display = 'block';
                        }

                        function closeBookingModal() {
                            document.getElementById('bookingModal').style.display = 'none';
                            document.getElementById('bookingForm').reset();
                        }

                        function formatCurrency(value) {
                            return new Intl.NumberFormat('vi-VN').format(value);
                        }

                        window.onclick = function (event) {
                            if (event.target.id === 'bookingModal') {
                                closeBookingModal();
                            }
                        }
                    </script>
                    <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
                    <script>
                        // Initialize pagination for available rooms
                        document.addEventListener('DOMContentLoaded', function () {
                            const roomsGrid = document.querySelector('.reservations-grid');
                            if (roomsGrid && roomsGrid.children.length > 12) {
                                paginateGrid('.reservations-grid', 12, 'rooms-pagination');
                            }
                        });
                    </script>
                </body>

                </html>