<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Phòng - Hotel Manager</title>
        <link rel="stylesheet" href="CSS/Authen/login.css" />
        <link rel="stylesheet" href="CSS/Pages/room-list.css" />
    </head>
    <body>
        <%@ include file="./../Components/Header.jsp" %>
        
        <div class="room-container">
            <div class="room-header">
                <h1>Danh Sách Phòng</h1>
                <p>Tìm và xem phòng trống</p>
            </div>

            <!-- Search & Filter Section -->
            <div class="search-section">
                <form class="search-form" method="GET" action="rooms">
                    <div class="search-group">
                        <label for="check-in">Ngày Nhận Phòng</label>
                        <input type="date" id="check-in" name="checkIn" class="search-input">
                    </div>
                    <div class="search-group">
                        <label for="check-out">Ngày Trả Phòng</label>
                        <input type="date" id="check-out" name="checkOut" class="search-input">
                    </div>
                    <div class="search-group">
                        <label for="guests">Số Khách</label>
                        <select id="guests" name="guests" class="search-input">
                            <option value="">-- Chọn số khách --</option>
                            <option value="1">1 Khách</option>
                            <option value="2">2 Khách</option>
                            <option value="3">3 Khách</option>
                            <option value="4">4+ Khách</option>
                        </select>
                    </div>
                    <div class="search-group">
                        <label for="room-type">Loại Phòng</label>
                        <select id="room-type" name="roomType" class="search-input">
                            <option value="">-- Tất Cả Loại --</option>
                            <option value="single">Phòng Đơn</option>
                            <option value="double">Phòng Đôi</option>
                            <option value="suite">Suite</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary search-btn">Tìm Kiếm</button>
                </form>
            </div>

            <!-- Room List -->
            <div class="room-list">
                <!-- Sample Room Card 1 -->
                <div class="room-card">
                    <div class="room-image">
                        <img src="/placeholder.svg?height=250&width=350" alt="Phòng Đơn">
                        <span class="room-type-badge">Phòng Đơn</span>
                    </div>
                    <div class="room-info">
                        <h3>Phòng Đơn Tiêu Chuẩn</h3>
                        <p class="room-description">Phòng thoải mái với giường đơn, phòng tắm riêng và view thoáng.</p>
                        <div class="room-amenities">
                            <span class="amenity">🛏️ Giường Đơn</span>
                            <span class="amenity">🌡️ Điều Hòa</span>
                            <span class="amenity">📺 TV</span>
                            <span class="amenity">🚿 Phòng Tắm</span>
                        </div>
                        <div class="room-footer">
                            <div class="room-price">
                                <span class="price">500.000₫</span>
                                <span class="per-night">/Đêm</span>
                            </div>
                            <a href="room-detail?id=1" class="btn btn-secondary">Xem Chi Tiết</a>
                        </div>
                    </div>
                </div>

                <!-- Sample Room Card 2 -->
                <div class="room-card">
                    <div class="room-image">
                        <img src="/placeholder.svg?height=250&width=350" alt="Phòng Đôi">
                        <span class="room-type-badge">Phòng Đôi</span>
                    </div>
                    <div class="room-info">
                        <h3>Phòng Đôi Tiêu Chuẩn</h3>
                        <p class="room-description">Phòng sang với giường đôi, có bồn tắm và các tiện nghi hiện đại.</p>
                        <div class="room-amenities">
                            <span class="amenity">🛏️ Giường Đôi</span>
                            <span class="amenity">🌡️ Điều Hòa</span>
                            <span class="amenity">📺 TV</span>
                            <span class="amenity">🛁 Bồn Tắm</span>
                        </div>
                        <div class="room-footer">
                            <div class="room-price">
                                <span class="price">750.000₫</span>
                                <span class="per-night">/Đêm</span>
                            </div>
                            <a href="room-detail?id=2" class="btn btn-secondary">Xem Chi Tiết</a>
                        </div>
                    </div>
                </div>

                <!-- Sample Room Card 3 -->
                <div class="room-card">
                    <div class="room-image">
                        <img src="/placeholder.svg?height=250&width=350" alt="Suite">
                        <span class="room-type-badge">Suite</span>
                    </div>
                    <div class="room-info">
                        <h3>Suite Hạng Sang</h3>
                        <p class="room-description">Suite sang trọng với phòng khách riêng, phòng ngủ rộng rãi và tiện nghi cao cấp.</p>
                        <div class="room-amenities">
                            <span class="amenity">🛏️ Giường King</span>
                            <span class="amenity">🌡️ Điều Hòa</span>
                            <span class="amenity">📺 TV</span>
                            <span class="amenity">🏊 Bồn Tắm Spa</span>
                        </div>
                        <div class="room-footer">
                            <div class="room-price">
                                <span class="price">1.500.000₫</span>
                                <span class="per-night">/Đêm</span>
                            </div>
                            <a href="room-detail?id=3" class="btn btn-secondary">Xem Chi Tiết</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- No Results Message (Hidden by default) -->
            <div class="no-results" style="display: none;">
                <p>Không tìm thấy phòng phù hợp. Vui lòng thử lại với các điều kiện khác.</p>
            </div>
        </div>

        <%@ include file="./../Components/Footer.jsp" %>
        <%@ include file="./../public/notify.jsp" %>
    </body>
</html>
