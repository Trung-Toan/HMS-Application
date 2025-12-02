<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Login - Hotel System</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="CSS/Authen/login.css">
    </head>

    <body class="login-page">
        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <h1>🏨 Hotel System</h1>
                    <p>Platform for booking and hotel operations</p>
                </div>

                <form class="login-form">
                    <div class="form-group">
                        <label for="identifier">Email or Phone Number:</label>
                        <input 
                            type="text" 
                            id="identifier" 
                            name="identifier" 
                            placeholder="you@example.com or 0912345678"
                            required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input 
                            type="password" 
                            id="password" 
                            name="password"
                            placeholder="Enter your password"
                            required>
                    </div>

                    <div class="form-options">
                        <label class="checkbox">
                            <input type="checkbox" name="remember">
                            Remember me
                        </label>
                        <a href="#" class="forgot-password">Forgot password?</a>
                    </div>

                    <button type="submit" class="btn-login">Sign In</button>
                </form>
            </div>
        </div>
    </body>
</html>
