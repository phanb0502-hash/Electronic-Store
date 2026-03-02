<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Electronic Store</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-image: url('https://img.freepik.com/premium-photo/modern-electronics-store-displaying-background_1144944-2060.jpg'); /* đường dẫn ảnh */
                background-size: cover;       /* Ảnh tự co giãn để phủ kín */
                background-position: center;  /* Ảnh căn giữa màn hình */
                background-repeat: no-repeat; /* Không lặp lại ảnh */
                background-attachment: fixed; /* Ảnh cố định khi cuộn trang */
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;

            }

            .login-box {
                background: white;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 350px;
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                color: #333;
            }

            table {
                width: 100%;
            }

            td {
                padding: 10px 5px;
                vertical-align: middle;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                box-sizing: border-box;
            }

            .button-row {
                text-align: center; /* căn giữa hai nút */
                padding-top: 10px;
            }

            input[type="submit"],
            input[type="button"] {
                width: 45%;
                background-color: #007bff;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                margin: 5px;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover,
            input[type="button"]:hover {
                background-color: #0056b3;
            }

            .error {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>

    <body>
        <div class="login-box">
            <h2>Login</h2>

            <form action="login" method="post">
                <table>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" value="${param.username}" placeholder="Nhập username"></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" placeholder="Nhập password"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="Login" >
                            <input type="button" value="Register" onclick="window.location.href = 'register.jsp'">
                        </td>
                    </tr>



                </table>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>
            </form>
        </div>
    </body>
</html>
