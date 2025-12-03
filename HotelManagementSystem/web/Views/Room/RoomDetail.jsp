<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Phòng - Hotel Manager</title>
        <link rel="stylesheet" href="CSS/Authen/login.css" />
        <link rel="stylesheet" href="CSS/Pages/room-detail.css" />
    </head>
    <body>
        <%@ include file="./../Components/Header.jsp" %>
        
        <div class="room-detail-container">
            <div class="breadcrumb">
                <a href="home">Trang Chủ</a>
                <span>/</span>
                <a href="rooms">Danh Sách Phòng</a>
                <span>/</span>
                <span class="current">Chi Tiết Phòng</span>
            </div>

            <div class="detail-content">
                <!-- Image Gallery -->
                <div class="image-gallery">
                    <div class="main-image">
                        <img id="mainImage" src="/placeholder.svg?height=500&width=800" alt="Phòng">
                    </div>
                    <div class="thumbnail-gallery">
                        <img src="/placeholder.svg?height=100&width=100" alt="Hình 1" class="thumbnail active" onclick="changeImage(this)">
                        <img src="/placeholder.svg?height=100&width=100" alt="Hình 2" class="thumbnail" onclick="changeImage(this)">
                        <img src="/placeholder.svg?height=100&width=100" alt="Hình 3" class="thumbnail" onclick="changeImage(this)">
                        <img src="/placeholder.svg?height=100&width=100" alt="Hình 4" class="thumbnail" onclick="changeImage(this)">
                    </div>
                </div>

                <!-- Room Info Section -->
                <div class="info-section">
                    <div class="room-header">
                        <h1>Suite Hạng Sang</h1>
                        <div class="rating">
                            <span class="stars">⭐⭐⭐⭐⭐</span>
                            <span class="rating-text">(125 đánh giá)</span>
                        </div>
                    </div>

                    <!-- Price & Booking -->
                    <div class="price-booking">
                        <div class="price-info">
                            <span class="price-label">Giá mỗi đêm</span>
                            <span class="price">1.500.000₫</span>
                            <span class="per-night">/Đêm</span>
                        </div>
                        <a href="login" class="btn btn-primary btn-lg">Đặt Phòng</a>
                    </div>

                    <!-- Room Details -->
                    <div class="details-grid">
                        <div class="detail-item">
                            <span class="detail-label">Loại Phòng</span>
                            <span class="detail-value">Suite</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Sức Chứa</span>
                            <span class="detail-value">2-4 Khách</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Diện Tích</span>
                            <span class="detail-value">45m²</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Tầng</span>
                            <span class="detail-value">Tầng 5-10</span>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="description">
                        <h3>Mô Tả Phòng</h3>
                        <p>
                            Suite hạng sang của chúng tôi mang đến trải nghiệm lưu trú tuyệt vời với thiết kế sang trọng và đầy đủ tiện nghi hiện đại. 
                            Phòng được trang bị các vật dụng chất lượng cao, bao gồm giường King size thoải mái, phòng ngủ riêng, phòng khách rộng rãi 
                            và phòng tắm sang trọng với bồn tắm spa. Từ ban công, bạn có thể ngắm nhìn cảnh quan thành phố tuyệt đẹp.
                        </p>
                    </div>

                    <!-- Amenities -->
                    <div class="amenities-section">
                        <h3>Tiện Nghi Phòng</h3>
                        <div class="amenities-list">
                            <div class="amenity-item">
                                <span class="amenity-icon">🛏️</span>
                                <span class="amenity-name">Giường King Size</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">🌡️</span>
                                <span class="amenity-name">Điều Hòa Nhiệt Độ</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">📺</span>
                                <span class="amenity-name">TV 55 Inch</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">🛁</span>
                                <span class="amenity-name">Bồn Tắm Spa</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">📶</span>
                                <span class="amenity-name">WiFi Miễn Phí</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">☕</span>
                                <span class="amenity-name">Máy Pha Cà Phê</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">🛏️</span>
                                <span class="amenity-name">Sofa Phòng Khách</span>
                            </div>
                            <div class="amenity-item">
                                <span class="amenity-icon">❄️</span>
                                <span class="amenity-name">Mini Bar</span>
                            </div>
                        </div>
                    </div>

                    <!-- Rules & Info -->
                    <div class="rules-section">
                        <h3>Quy Định & Thông Tin</h3>
                        <ul class="rules-list">
                            <li>✓ Nhận phòng từ 14:00, Trả phòng trước 11:00</li>
                            <li>✓ Thú cưng được phép với phí bổ sung 200.000₫</li>
                            <li>✓ Hủy phòng miễn phí trước 24 giờ</li>
                            <li>✓ Không được hút thuốc trong phòng</li>
                            <li>✓ Bữa sáng đi kèm với đặt phòng</li>
                        </ul>
                    </div>

                    <!-- Call to Action -->
                    <div class="cta-buttons">
                        <a href="login" class="btn btn-primary btn-lg">Đặt Phòng Ngay</a>
                        <a href="rooms" class="btn btn-secondary">Quay Lại Danh Sách</a>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="./../Components/Footer.jsp" %>
        <%@ include file="./../public/notify.jsp" %>

        <script>
            function changeImage(thumbnail) {
                const mainImage = document.getElementById('mainImage');
                mainImage.src = thumbnail.src;
                
                // Update active thumbnail
                document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
                thumbnail.classList.add('active');
            }
        </script>
    </body>
</html>
