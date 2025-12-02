<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Forgot Password</title>
        <link rel="stylesheet" href="CSS/Authen/forgot_password.css" />
    </head>
    <body>

        <div class="forgot-wrapper">
            <div class="forgot-box">

                <h2 class="forgot-title">Quên mật khẩu</h2>
                <p class="forgot-desc">Nhập email của bạn để nhận liên kết đặt lại mật khẩu.</p>

                <form>
                    <label for="email">Email</label>
                    <input 
                        type="email" 
                        id="email" 
                        name="email" 
                        placeholder="Nhập email của bạn"
                        required
                        />

                    <button type="submit" class="forgot-btn">Gửi yêu cầu</button>
                </form>

                <div class="forgot-links">
                    <a href="login">← Quay lại đăng nhập</a>
                </div>

            </div>
        </div>

    </body>
</html>
