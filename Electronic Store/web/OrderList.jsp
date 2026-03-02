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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order List</title>
        <style>
            .header-container {
                background: linear-gradient(90deg, #0056b3, #0056b3 100%);
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 24px;
                border-radius: 6px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.15);
            

            /* Thêm margin top và 2 bên */
            margin: 20px 20px 20px 20px;
            }
            body {
                font-family: "Segoe UI", sans-serif;
                background-color: #f4f6f8;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                color: #0078d7;
                margin-top: 20px;      /* sửa margin-top cho vừa */
                margin-bottom: 25px;   /* sửa margin-bottom cho vừa */

            }

            .container {
                width: 90%;
                max-width: 1100px;
                margin: 30px auto;
                background: white;
                padding: 25px 30px;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #2d89ef;
                color: white;
                font-weight: 600;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #eef4ff;
            }

            a.button-link, input[type=submit] {
                background-color: #2d89ef;
                color: white;
                padding: 8px 14px;
                text-decoration: none;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.2s ease;
            }

            a.button-link:hover, input[type=submit]:hover {
                background-color: #1b5fc6;
            }

            select {
                padding: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .btn-container {
                text-align: right;
                margin-top: 25px;
            }

            .btn-container a {
                font-size: 15px;
            }
            .back-btn {
                display: content;
                background-color: #0078d7;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: 0.3s;
                margin-top: 20px;
                text-align: center;
            }
            .back-btn:hover {
                background-color: #005fa3;
                transform: scale(1.05);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Order List</h1>

            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Full Name</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Order Detail</th>
                        <th>Change Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ord" items="${sessionScope.listoforder}">
                        <tr>
                            <td>${ord.getOrderID()}</td>
                            <td>${ord.getFullName()}</td>
                            <td>${ord.getOrderDate()}</td>
                            <td>${ord.getTotalAmount()}</td>
                            <td>${ord.getStatus()}</td>
                            <td>
                                <a class="button-link" href="orderdetailcontroller?orderid=${ord.getOrderID()}">
                                    Show
                                </a>
                            </td>
                            <td>
                                <form action="changestatuscontroller" method="post">
                                    <input type="hidden" name="OrderID" value="${ord.getOrderID()}"/>
                                    <select name="status">
                                        <option value="Pending" ${ord.getStatus() == 'Pending' ? 'selected' : ''}>Pending</option>
                                        <option value="Processing" ${ord.getStatus() == 'Processing' ? 'selected' : ''}>Processing</option>
                                        <option value="Completed" ${ord.getStatus() == 'Completed' ? 'selected' : ''}>Completed</option>
                                        <option value="Cancelled" ${ord.getStatus() == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                    <input type="submit" value="Save"/>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>   
                </tbody>
            </table>

            <div class="btn-container">
                <a class="button-link" href="checkoutcontroller">Product Manager</a>
                <a href="showProducts.jsp" class="back-btn">← Back to Main</a>
            </div>



        </div>
    </body>
</html>
