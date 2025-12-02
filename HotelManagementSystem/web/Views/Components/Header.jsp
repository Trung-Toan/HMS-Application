<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Page</title>
        <link rel="stylesheet" href="CSS/Components/header.css">
    </head>
    <body>
        <header class="header">
            <div class="header-container">
                <a href="dashboard.html" class="header-logo">
                    <span>🏨</span>
                    <span>Hotel Manager</span>
                </a>

                <ul class="header-nav">
                    <li><a href="dashboard.html" class="active">Trang Chủ</a></li>
                    <li><a href="rooms.html">Phòng</a></li>
                    <li><a href="bookings.html">Đặt Phòng</a></li>
                    <li><a href="guests.html">Khách Hàng</a></li>
                    <li><a href="#">Báo Cáo</a></li>
                    <li><a href="#">Cài Đặt</a></li>
                </ul>

                <div class="header-right">
                    <div class="notification-icon">
                        🔔
                        <span class="notification-badge">3</span>
                    </div>
                    <div class="settings-icon">⚙️</div>
                    <div class="header-user">
                        <div class="user-avatar">AD</div>
                        <div class="user-menu">
                            <span class="user-name">Quản Trị Viên</span>
                            <span class="user-role">Admin</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>

    </body>
</html>
