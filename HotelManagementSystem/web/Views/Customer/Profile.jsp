<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ Sơ Khách Hàng - Quản Lí Khách Sạn</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Customer/profile.css">
    </head>
    <body>
        <!-- Header -->
        <%@ include file="../Components/Header.jsp" %>

        <!-- Main Content -->
        <div class="container">
            <!-- Profile Header -->
            <div class="profile-header">
                <!-- Back Button -->
                <div class="back-home">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
                        ← Quay về trang chủ
                    </a>
                </div>
                <div class="profile-avatar">👤</div>
                <div class="profile-info">
                    <h1>Nguyễn Văn A</h1>
                    <span class="member-level">⭐ VIP Member</span>
                    <p><strong>Email:</strong> nguyenvana@email.com</p>
                    <p><strong>Số Điện Thoại:</strong> +84 98 765 4321</p>
                    <p><strong>Thành Viên Từ:</strong> Tháng 1, 2023</p>
                    <p><strong>Tổng Đặt Phòng:</strong> 12 lần</p>
                    <div class="profile-actions">
                        <button class="btn btn-primary" onclick="openEditModal()">Chỉnh Sửa Thông Tin</button>
                        <button class="btn btn-secondary">Đổi Mật Khẩu</button>
                    </div>
                </div>
            </div>

            <!-- Tabs -->
            <div class="tabs">
                <button class="tab active" onclick="switchTab(event, 'personal-info')">Thông Tin Cá Nhân</button>
                <button class="tab" onclick="switchTab(event, 'booking-history')">Lịch Sử Đặt Phòng</button>
                <button class="tab" onclick="switchTab(event, 'preferences')">Sở Thích & Cài Đặt</button>
            </div>

            <!-- Personal Information Tab -->
            <div id="personal-info" class="tab-content active">
                <div class="info-section">
                    <div class="section-title">
                        Thông Tin Cơ Bản
                        <button class="edit-btn" onclick="openEditModal()">Chỉnh Sửa</button>
                    </div>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Họ & Tên</div>
                            <div class="info-value">Nguyễn Văn A</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <div class="info-value">nguyenvana@email.com</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Số Điện Thoại</div>
                            <div class="info-value">+84 98 765 4321</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Ngày Sinh</div>
                            <div class="info-value">15/03/1990</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Giới Tính</div>
                            <div class="info-value">Nam</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Quốc Tịch</div>
                            <div class="info-value">Việt Nam</div>
                        </div>
                    </div>
                </div>

                <div class="info-section">
                    <div class="section-title">Địa Chỉ</div>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Địa Chỉ Nhà</div>
                            <div class="info-value">123 Đường ABC, Hà Nội</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Thành Phố</div>
                            <div class="info-value">Hà Nội</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Mã Bưu Chính</div>
                            <div class="info-value">100000</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Quốc Gia</div>
                            <div class="info-value">Việt Nam</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking History Tab -->
            <div id="booking-history" class="tab-content">
                <div class="info-section">
                    <div class="section-title">Lịch Sử Đặt Phòng</div>
                    <table class="bookings-table">
                        <thead>
                            <tr>
                                <th>Mã Đặt</th>
                                <th>Phòng</th>
                                <th>Ngày Nhập/Trả</th>
                                <th>Giá</th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#BK001</td>
                                <td>Phòng Đôi Cao Cấp</td>
                                <td>15/12 - 17/12/2024</td>
                                <td>2,000,000 ₫</td>
                                <td><span class="status-badge status-completed">Đã Hoàn Tất</span></td>
                                <td><button class="btn btn-primary">Chi Tiết</button></td>
                            </tr>
                            <tr>
                                <td>#BK002</td>
                                <td>Suite Premium</td>
                                <td>20/12 - 22/12/2024</td>
                                <td>3,500,000 ₫</td>
                                <td><span class="status-badge status-confirmed">Đã Duyệt</span></td>
                                <td><button class="btn btn-primary">Chi Tiết</button></td>
                            </tr>
                            <tr>
                                <td>#BK003</td>
                                <td>Phòng Gia Đình</td>
                                <td>25/12 - 27/12/2024</td>
                                <td>2,800,000 ₫</td>
                                <td><span class="status-badge status-pending">Chờ Duyệt</span></td>
                                <td><button class="btn btn-primary">Chi Tiết</button></td>
                            </tr>
                            <tr>
                                <td>#BK004</td>
                                <td>Phòng Đơn</td>
                                <td>10/01 - 11/01/2025</td>
                                <td>800,000 ₫</td>
                                <td><span class="status-badge status-cancelled">Đã Hủy</span></td>
                                <td><button class="btn btn-primary">Chi Tiết</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Preferences Tab -->
            <div id="preferences" class="tab-content">
                <div class="info-section">
                    <div class="section-title">Sở Thích & Thông Báo</div>

                    <div class="preference-item">
                        <span class="preference-label">📧 Nhận Email Về Khuyến Mãi</span>
                        <div class="toggle-switch active" onclick="toggleSwitch(this)"></div>
                    </div>

                    <div class="preference-item">
                        <span class="preference-label">📱 Nhận Thông Báo SMS</span>
                        <div class="toggle-switch active" onclick="toggleSwitch(this)"></div>
                    </div>

                    <div class="preference-item">
                        <span class="preference-label">🔔 Nhận Thông Báo Trên Điện Thoại</span>
                        <div class="toggle-switch" onclick="toggleSwitch(this)"></div>
                    </div>

                    <div class="preference-item">
                        <span class="preference-label">🎯 Chia Sẻ Dữ Liệu Cho Đối Tác</span>
                        <div class="toggle-switch" onclick="toggleSwitch(this)"></div>
                    </div>
                </div>

                <div class="info-section">
                    <div class="section-title">Sở Thích Phòng</div>

                    <div class="preference-item">
                        <span class="preference-label">🛏️ Loại Giường Yêu Thích: King Size</span>
                    </div>

                    <div class="preference-item">
                        <span class="preference-label">🌍 Vị Trí Yêu Thích: Tầng Cao</span>
                    </div>

                    <div class="preference-item">
                        <span class="preference-label">🚭 Phòng Không Hút Thuốc</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Chỉnh Sửa Thông Tin</h2>
                    <button class="close-btn" onclick="closeEditModal()">×</button>
                </div>
                <form>
                    <div class="form-group">
                        <label>Họ & Tên</label>
                        <input type="text" value="Nguyễn Văn A" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="nguyenvana@email.com" required>
                    </div>
                    <div class="form-group">
                        <label>Số Điện Thoại</label>
                        <input type="tel" value="+84 98 765 4321" required>
                    </div>
                    <div class="form-group">
                        <label>Địa Chỉ</label>
                        <textarea rows="3">123 Đường ABC, Hà Nội</textarea>
                    </div>
                    <div class="modal-actions">
                        <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <%@ include file="../Components/Footer.jsp" %>

        <script>
            // Tab functionality
            function switchTab(event, tabName) {
                const tabs = document.querySelectorAll('.tab');
                const contents = document.querySelectorAll('.tab-content');

                tabs.forEach(tab => tab.classList.remove('active'));
                contents.forEach(content => content.classList.remove('active'));

                event.target.classList.add('active');
                document.getElementById(tabName).classList.add('active');
            }

            // Modal functionality
            function openEditModal() {
                document.getElementById('editModal').classList.add('show');
            }

            function closeEditModal() {
                document.getElementById('editModal').classList.remove('show');
            }

            window.onclick = function (event) {
                const modal = document.getElementById('editModal');
                if (event.target == modal) {
                    modal.classList.remove('show');
                }
            }

            // Toggle switch functionality
            function toggleSwitch(element) {
                element.classList.toggle('active');
            }
        </script>
    </body>
</html>
