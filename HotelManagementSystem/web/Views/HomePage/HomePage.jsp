<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hotel Manager - Đặt Phòng Khách Sạn</title>
        <link rel="stylesheet" href="CSS/Authen/login.css" />
        <link rel="stylesheet" href="CSS/Pages/home.css" />
    </head>
    <body>
        <%@ include file="./../Components/Header.jsp" %>
        
        <!-- Hero Banner Section -->
        <section class="hero-banner">
            <div class="hero-content">
                <h1>Chào Mừng Đến Khách Sạn Của Chúng Tôi</h1>
                <p>Trải nghiệm dịch vụ lưu trú hạng sang với giá cả phải chăng</p>
                <div class="hero-buttons">
                    <a href="rooms" class="btn btn-primary">Xem Phòng</a>
                    <a href="register" class="btn btn-secondary">Đăng Ký</a>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section class="about-section">
            <div class="container">
                <h2>Về Khách Sạn Của Chúng Tôi</h2>
                <p>Khách sạn của chúng tôi cung cấp các phòng thoải mái với đầy đủ tiện nghi hiện đại. Đội ngũ nhân viên thân thiện sẵn sàng phục vụ bạn 24/7.</p>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <div class="container">
                <div class="features-grid">
                    <div class="feature-card">
                        <h3>🏨 Phòng Sang Trọng</h3>
                        <p>Các phòng được thiết kế với phong cách hiện đại và đầy đủ tiện nghi</p>
                    </div>
                    <div class="feature-card">
                        <h3>🌟 Dịch Vụ Chuyên Nghiệp</h3>
                        <p>Đội ngũ nhân viên luyện tập chuyên nghiệp luôn sẵn sàng giúp đỡ</p>
                    </div>
                    <div class="feature-card">
                        <h3>💎 Giá Cả Hợp Lý</h3>
                        <p>Cung cấp dịch vụ chất lượng cao với giá cả cạnh tranh nhất</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <div class="container">
                <h2>Sẵn Sàng Đặt Phòng?</h2>
                <p>Tìm phòng phù hợp với nhu cầu của bạn</p>
                <a href="rooms" class="btn btn-primary">Tìm Phòng Ngay</a>
            </div>
        </section>

        <%@ include file="./../Components/Footer.jsp" %>
        <%@ include file="./../public/notify.jsp" %>
    </body>
</html>
