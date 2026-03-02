<%@page import="DAO.RoleDAO"%>
<%@page import="model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<%
    User user = (User) session.getAttribute("user");
    RoleDAO roleDAO = new RoleDAO();
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean isAdmin = roleDAO.isAdmin(user.getRoleID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Checkout - Product List</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background-color: #f6f8fa;
                color: #333;
                margin: 0;
                padding: 20px;
            }

            h2 {
                text-align: center;
                color: #0078d7;
                margin-bottom: 30px;
            }

            table {
                width: 85%;
                margin: 0 auto;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 12px 15px;
                text-align: center;
            }

            th {
                background-color: #0078d7;
                color: white;
                font-size: 16px;
            }

            tr:nth-child(even) {
                background-color: #f2f6fb;
            }

            tr:hover {
                background-color: #e1f0ff;
            }

            .btn {
                display: inline-block;
                padding: 8px 14px;
                border-radius: 6px;
                font-weight: bold;
                color: white;
                text-decoration: none;
                background-color: #28a745;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #218838;
            }


            @media screen and (max-width: 768px) {
                table, th, td {
                    font-size: 13px;
                    padding: 8px;
                }
            }
            .btn-container {
                text-align: center; /* Căn giữa hai nút */
                margin-top: 20px;
            }

            .btn-container a {
                display: inline-block;
                font-size: 15px;
                margin: 0 10px; /* Tạo khoảng cách giữa 2 nút */
            }

            .back-btn {
                background-color: #0078d7;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: 0.3s;
            }

            .back-btn:hover {
                background-color: #005fa3;
                transform: scale(1.05);
            }
        </style>
    </head>
    <body>
        <h2>Product List</h2>

        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Price (VND)</th>
                    <th>Stock Quantity</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${list}">
                    <tr>
                        <td>${p.productID}</td>
                        <td>${p.productName}</td>
                        <td>${p.price}</td>
                        <td>${p.quantity}</td>
                    </tr>
                </c:forEach>
            </tbody>

        </table>
        
        <div class="btn-container">
            <a href="OrderList.jsp" class="back-btn">← Back to Manager</a>
            <a href="showProducts.jsp" class="back-btn">← Back to Main</a>
        </div>

    </body>
</html>
