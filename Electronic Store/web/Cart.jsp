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
        <title>Your Cart</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
                background-color: #f6f6f6;
            }
            h2 {
                color: #0078d7;
            }
            table {
                width: 80%;
                border-collapse: collapse;
                margin-bottom: 20px;
                background-color: #fff;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ccc;
                text-align: center;
            }
            th {
                background-color: #0078d7;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .btn {
                padding: 8px 15px;
                border-radius: 5px;
                color: white;
                text-decoration: none;
                font-weight: bold;
                background-color: #28a745;
                border: none;
                cursor: pointer;
            }
            .btn:hover {
                background-color: #218838;
            }
            .total {
                font-weight: bold;
            }
            input.qty-input {
                width: 60px;
                text-align: center;
            }
        </style>
    </head>
    <body>

        <h2>🛒 Your Shopping Cart</h2>

        <c:if test="${not empty sessionScope.message}">
            <p style="color: green; font-weight: bold; font-size: 16px;">
                ${sessionScope.message}
            </p>
            <c:remove var="message" scope="session"/>
        </c:if>

        <c:choose>
            <c:when test="${not empty sessionScope.cart}">
                <table>
                    <tr>
                        <th>Product Name</th>
                        <th>Price (VND)</th>
                        <th>Quantity</th>
                        <th>Total (VND)</th>
                        <th>Action</th>
                    </tr>
                    <c:set var="totalAmount" value="0" />
                    <c:forEach var="item" items="${sessionScope.cart}">
                        <c:set var="itemTotal" value="${item.product.price * item.quantity}" />
                        <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                        <tr>
                            <td>${item.product.productName}</td>
                            <td>${item.product.price}</td>
                            <td>
                                <form action="updatecartcontroller" method="post">
                                    <input type="hidden" name="productID" value="${item.product.productID}" />
                                    <input type="number" name="quantity" class="qty-input" value="${item.quantity}" min="1" />
                            </td>
                            <td>${itemTotal}</td>
                            <td>
                                <input type="submit" class="btn" value="Update" />
                            </td>
                            </form>
                        </tr>
                    </c:forEach>
                </table>

                <p class="total">Cart Total: ${totalAmount} VND</p>

                <form action="checkoutcontroller" method="post">
                    <input type="submit" class="btn" value="Checkout">
                    <a href="showProducts.jsp" class="btn" style="background-color:#0078d7; margin-top: 10px;">⬅ Continue Shopping</a>
                </form>

            </c:when>

            <c:otherwise>
                <p>Your cart is empty!</p>
                <a href="showProducts.jsp" class="btn">Go Back Shopping</a>
            </c:otherwise>
        </c:choose>

    </body>
</html>
