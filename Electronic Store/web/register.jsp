<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng ký tài khoản</title>

    <style>
        /* Toàn trang */
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://img.freepik.com/premium-photo/modern-electronics-store-displaying-background_1144944-2060.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Khung đăng ký */
        .register-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
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
            padding: 8px 5px;
            vertical-align: middle;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
        }

        /* Nút */
        input[type="submit"], .back-btn {
            display: inline-block;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 6px;
            border: none;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover, .back-btn:hover {
            background-color: #0056b3;
        }

        .btn-container {
            text-align: center;
            padding-top: 10px;
        }

        /* Thông báo lỗi / thành công */
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .success {
            color: green;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <div class="register-box">
        <h2>Đăng ký tài khoản</h2>

        <form action="register" method="POST">
            <table>
                <tr>
                    <td>Username:</td>
                    <td><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td>Fullname:</td>
                    <td><input type="text" name="fullname"></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="text" name="email"></td>
                </tr>
                <tr>
                   
                </tr>
            </table>

            <div class="btn-container">
                <input type="submit" value="Register">
                <a href="login.jsp" class="back-btn">Back to login</a>
            </div>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="success">${success}</div>
            </c:if>
        </form>
    </div>
</body>
</html>
