<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="refresh" content="3;url=${pageContext.request.contextPath}/${href}">
        <title>Notification</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .notification-card {
                background: white;
                border-radius: 20px;
                padding: 50px;
                max-width: 500px;
                width: 100%;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                text-align: center;
                animation: slideIn 0.5s ease;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .icon {
                font-size: 80px;
                margin-bottom: 20px;
            }

            .icon.success {
                color: #28a745;
            }

            .icon.error {
                color: #dc3545;
            }

            .icon.warning {
                color: #ffc107;
            }

            .icon.info {
                color: #17a2b8;
            }

            h1 {
                font-size: 32px;
                margin-bottom: 15px;
                color: #333;
            }

            .message {
                font-size: 18px;
                color: #666;
                margin-bottom: 30px;
                line-height: 1.6;
            }

            .redirect-info {
                font-size: 14px;
                color: #999;
                margin-bottom: 20px;
            }

            .btn {
                display: inline-block;
                padding: 12px 30px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
            }

            .spinner {
                border: 3px solid #f3f3f3;
                border-top: 3px solid #667eea;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                animation: spin 1s linear infinite;
                margin: 20px auto;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }
        </style>
    </head>

    <body>
        <div class="notification-card">
            <div class="icon ${type}">
                <c:choose>
                    <c:when test="${type == 'success'}">✓</c:when>
                    <c:when test="${type == 'error'}">✗</c:when>
                    <c:when test="${type == 'warning'}">⚠</c:when>
                    <c:otherwise>ℹ</c:otherwise>
                </c:choose>
            </div>

            <h1>
                <c:choose>
                    <c:when test="${type == 'success'}">Success!</c:when>
                    <c:when test="${type == 'error'}">Error!</c:when>
                    <c:when test="${type == 'warning'}">Warning!</c:when>
                    <c:otherwise>Notice</c:otherwise>
                </c:choose>
            </h1>

            <p class="message">${mess}</p>

            <div class="spinner"></div>

            <p class="redirect-info">Redirecting in 3 seconds...</p>

            <a href="${pageContext.request.contextPath}/${href}" class="btn">Go Now</a>
        </div>
    </body>

    </html>