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
<h2>Completed Orders</h2>
<table border="1" cellpadding="10" cellspacing="0" style="width:90%; margin:auto; text-align:center;">
    <thead>
        <tr>
            <th>Order ID</th>
            <th>Full Name</th>
            <th>Total Amount</th>
            <th>Order Date</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="o" items="${completedOrders}">
            <tr>
                <td>${o.orderID}</td>
                <td>${o.fullName}</td>
                <td>${o.totalAmount}</td>
                <td>${o.orderDate}</td>
                <td>${o.status}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
