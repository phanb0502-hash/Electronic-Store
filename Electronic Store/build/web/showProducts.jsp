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
        <title>Product Management</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background-color: #f6f8fa;
                color: #333;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #0078d7;
                margin-bottom: 30px;
            }

            /* ===== CATEGORY FILTER ===== */
            .category-filter {
                width: 90%;
                margin: 0 auto 35px auto;
                display: flex;
                align-items: center;
                justify-content: center;
                background: #ffffff;
                border-radius: 10px;
                padding: 15px 20px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                font-weight: 500;
            }

            .category-filter label {
                margin-right: 10px;
                font-weight: bold;
                color: #0078d7;
                font-size: 16px;
            }

            .category-filter select {
                padding: 8px 12px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 15px;
                outline: none;
                transition: 0.3s;
                min-width: 200px;
            }

            .category-filter select:hover,
            .category-filter select:focus {
                border-color: #0078d7;
                box-shadow: 0 0 6px rgba(0,120,215,0.3);
            }

            /* ===== ADMIN BUTTONS ===== */
            .admin-buttons {
                display: flex;
                justify-content: center;
                gap: 55px;
                margin-bottom: 35px;
                flex-wrap: wrap;
            }

            .btn {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 6px;
                font-weight: bold;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                font-size: 14px;
                margin: 2px;
            }

            .btn-product {
                background-color: #218838;
            }
            .btn-product:hover {
                background-color: #1e7e34;
            }

            .btn-category {
                background-color: #d39e00;
            }
            .btn-category:hover {
                background-color: #c69500;
            }

            /* ===== NEW BUTTON FOR ORDER MANAGEMENT ===== */
            .btn-order {
                background-color: #0078d7;
            }
            .btn-order:hover {
                background-color: #005fa3;
            }

            /* ===== TABLE ===== */
            table {
                width: 90%;
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

            .btn-edit {
                background-color: #2d89ef;
            }
            .btn-edit:hover {
                background-color: #1e70bf;
            }
            .btn-delete {
                background-color: #e81123;
            }
            .btn-delete:hover {
                background-color: #c50f1f;
            }
            .btn-view {
                background-color: #f0ad4e;
            }
            .btn-view:hover {
                background-color: #ec971f;
            }
            .btn-cart {
                background-color: #28a745;
            }
            .btn-cart:hover {
                background-color: #218838;
            }

            @media screen and (max-width: 768px) {
                table, th, td {
                    font-size: 12px;
                    padding: 8px;
                }
                .btn {
                    padding: 4px 8px;
                    font-size: 12px;
                }
            }
        </style>
    </head>
    <body>

        <h1>Product Management</h1>

        <% if (isAdmin) { %>
        <div class="admin-buttons">
            <a href="addProduct.jsp" class="btn btn-product">➕ Add New Product</a>
            <a href="addCategory.jsp" class="btn btn-category">📂 Add New Category</a>
            <!-- ✅ New button added below -->
            <a href="ordercontroller" class="btn btn-order">🧾 Manage Orders</a>
            <a href="addStock.jsp" class="btn btn-product">📦 Add Stock</a>
            <a href="dashboard" class="btn btn-order">📊 Dashboard</a>

        </div>
        <% } %>

        <!-- CATEGORY FILTER -->
        <form action="loadProduct" method="post" class="category-filter">
            <label for="selectCategory">📑 List of Categories:</label>
            <select name="selectCategory" id="selectCategory" onchange="this.form.submit()">
                <option value="all" 
                        ${sessionScope.catId.toString() eq 'all' ? 'selected' : ''}>
                    All Products
                </option>

                <c:forEach var="c" items="${sessionScope.listOfCategories}">
                    <option value="${c.categoryID}" 
                            ${sessionScope.catId.toString() eq c.categoryID.toString() ? 'selected' : ''}>
                        ${c.categoryName}
                    </option>
                </c:forEach>
            </select>
        </form>

        <!-- PRODUCT TABLE -->
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Price (VND)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${sessionScope.listOfProducts}">
                    <tr>
                        <td>${p.productName}</td>
                        <td>${p.price}</td>
                        <td>
                            <% if (isAdmin) { %>
                            <a href="updateProduct?productID=${p.productID}" class="btn btn-edit">Edit</a>
                            <a href="deleteProduct?productID=${p.productID}" onclick="return confirm('Delete?')" class="btn btn-delete">Delete</a>
                            <% } else { %>
                            <a href="updateProduct?productID=${p.productID}" class="btn btn-view">View</a>
                            <form action="addtocartcontroller" method="post" style="display:inline;">
                                <input type="hidden" name="productID" value="${p.productID}">
                                <input type="hidden" name="quantity" value="1">
                                <input type="submit" value="Add to Cart" class="btn btn-cart">
                            </form>
                            <% }%>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
