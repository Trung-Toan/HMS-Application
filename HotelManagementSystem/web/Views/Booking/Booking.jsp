<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xác Nhận Đặt Phòng - Khách Sạn Sao Mai</title>
        <link rel="stylesheet" href="CSS/Booking/booking.css">
    </head>
    <body>
        <!-- HEADER -->
        <%@ include file="../Components/Header.jsp" %>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <div class="breadcrumb">
                <a href="home">Trang Chủ</a>
                <span>/</span>
                <a href="rooms">Danh Sách Phòng</a>
                <span>/</span>
                <a href="room-detail">Chi Tiết Phòng</a>
                <span>/</span>
                <span class="current">Xác Nhận Đặt Phòng</span>
            </div>
            <h1 class="page-title">Xác Nhận Đặt Phòng</h1>

            <div class="container-flex">
                <!-- FORM SECTION -->
                <div class="form-section">
                    <form id="bookingForm">
                        <!-- THÔNG TIN KHÁCH -->
                        <h2>Thông Tin Khách Hàng</h2>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="firstName">Tên <span style="color: red;">*</span></label>
                                <input type="text" id="firstName" name="firstName" placeholder="Nhập tên của bạn" required>
                            </div>
                            <div class="form-group">
                                <label for="lastName">Họ <span style="color: red;">*</span></label>
                                <input type="text" id="lastName" name="lastName" placeholder="Nhập họ của bạn" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="email">Email <span style="color: red;">*</span></label>
                                <input type="email" id="email" name="email" placeholder="example@email.com" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Điện Thoại <span style="color: red;">*</span></label>
                                <input type="tel" id="phone" name="phone" placeholder="0123456789" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="country">Quốc Gia</label>
                            <input type="text" id="country" name="country" placeholder="Nhập quốc gia">
                        </div>

                        <!-- THÔNG TIN THANH TOÁN -->
                        <h2 style="margin-top: 30px;">Hình Thức Thanh Toán</h2>

                        <label class="payment-option">
                            <input type="radio" name="payment" value="pay_at_hotel" checked>
                            🏨 Thanh toán tại quầy khi check-out
                        </label>

                        <!-- GHI CHÚ -->
                        <h2 style="margin-top: 30px;">Ghi Chú Thêm</h2>
                        <div class="form-group">
                            <label for="notes">Yêu Cầu Đặc Biệt</label>
                            <textarea id="notes" name="notes" placeholder="Nhập các yêu cầu hoặc ghi chú thêm..." rows="4"></textarea>
                        </div>

                        <!-- CHECKBOX ĐỒNG Ý -->
                        <div class="form-group" style="margin-top: 20px;">
                            <label style="display: flex; align-items: center; cursor: pointer;">
                                <input type="checkbox" id="agree" name="agree" required style="width: auto; margin-right: 10px;">
                                <span>Tôi đồng ý với điều khoản và điều kiện của khách sạn</span>
                            </label>
                        </div>

                        <!-- BUTTONS -->
                        <div class="button-group">
                            <button type="button" class="btn-back" onclick="history.back()">← Quay Lại</button>
                            <button type="submit" class="btn-confirm">✓ Xác Nhận Đặt Phòng</button>
                        </div>
                    </form>
                </div>

                <!-- SUMMARY SECTION -->
                <div class="summary-section">
                    <div class="summary-title">📋 Tóm Tắt Đặt Phòng</div>

                    <div class="room-info">
                        <div class="room-name">Phòng Suite Premium</div>
                        <div class="room-info-item">
                            <span>Mã Phòng:</span>
                            <strong>#PR-305</strong>
                        </div>
                        <div class="room-info-item">
                            <span>Loại Phòng:</span>
                            <strong>Suite</strong>
                        </div>
                        <div class="room-info-item">
                            <span>Sức Chứa:</span>
                            <strong>2 Khách</strong>
                        </div>
                    </div>

                    <div class="room-info">
                        <div style="font-weight: bold; color: #1a5f7a; margin-bottom: 10px;">📅 Lịch Trình</div>
                        <div class="room-info-item">
                            <span>Nhập Phòng:</span>
                            <strong>15/03/2025</strong>
                        </div>
                        <div class="room-info-item">
                            <span>Trả Phòng:</span>
                            <strong>17/03/2025</strong>
                        </div>
                        <div class="room-info-item">
                            <span>Số Đêm:</span>
                            <strong>2 Đêm</strong>
                        </div>
                    </div>

                    <div class="price-summary">
                        <div class="price-item">
                            <span>Giá Phòng/Đêm:</span>
                            <span>2,500,000 VNĐ</span>
                        </div>
                        <div class="price-item">
                            <span>2 Đêm:</span>
                            <span>5,000,000 VNĐ</span>
                        </div>
                        <div class="price-item">
                            <span>Phí Dịch Vụ (10%):</span>
                            <span>500,000 VNĐ</span>
                        </div>
                        <div class="price-item">
                            <span>Thuế VAT (8%):</span>
                            <span>440,000 VNĐ</span>
                        </div>
                        <div class="price-item total">
                            <span>Tổng Cộng:</span>
                            <span>5,940,000 VNĐ</span>
                        </div>
                    </div>

                    <div style="background-color: #f0f8ff; padding: 12px; border-radius: 5px; font-size: 13px; color: #1a5f7a;">
                        <strong>⚠️ Lưu Ý:</strong> Giá này chưa bao gồm các dịch vụ bổ sung. Vui lòng kiểm tra lại thông tin trước khi xác nhận.
                    </div>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <%@ include file="../Components/Footer.jsp" %>

        <script>
            document.getElementById('bookingForm').addEventListener('submit', function (e) {
                e.preventDefault();
                alert('✓ Đặt phòng thành công! Chúng tôi sẽ gửi xác nhận qua email của bạn.');
            });
        </script>

    </body>
</html>


