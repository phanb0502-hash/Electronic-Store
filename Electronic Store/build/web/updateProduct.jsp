<%@page import="DAO.RoleDAO"%>
<%@page import="model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Product Details</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background-color: #f0f7ff;
                color: #333;
                margin: 0;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #0078d7;
                margin-bottom: 30px;
            }
            .product-box {
                width: 60%;
                margin: 0 auto;
                background: #ffffff;
                padding: 25px 35px;
                border-radius: 14px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }
            .section-title {
                color: #0078d7;
                border-bottom: 2px solid #0078d7;
                padding-bottom: 5px;
                margin-bottom: 15px;
            }
            .product-form input[type="text"],
            .product-form input[type="number"] {
                width: 95%;
                padding: 8px;
                border: 1px solid #0078d7;
                border-radius: 8px;
                margin-bottom: 15px;
                font-size: 14px;
            }
            .product-form input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }
            .btn {
                background-color: #0078d7;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 8px;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s ease;
                margin-right: 10px;
            }
            .btn:hover {
                background-color: #005ea6;
            }
            .add-to-cart-btn {
                background-color: #2d89ef;
            }
            .add-to-cart-btn:hover {
                background-color: #1e70bf;
            }
            .cancel-btn {
                background-color: #6c757d;
            }
            .cancel-btn:hover {
                background-color: #555;
            }
            .btn-container {
                text-align: right;
                margin-top: 25px;
            }

           
        </style>
    </head>
    <body>

        <h1>Product Details</h1>

        <div class="product-box">
            <h3 class="section-title">Product Information</h3>

            <form class="product-form" action="updateProduct" method="post">
                <input type="hidden" name="productID" value="${product.productID}" />
                <input type="hidden" name="categoryID" value="${product.categoryID}" />

                <label>Product Name:</label>
                <input type="text" name="productName" value="${product.productName}" <%= isAdmin ? "" : "readonly"%> />

                <label>Price:</label>
                <input type="text" name="price" value="${product.price}" <%= isAdmin ? "" : "readonly"%> />

                <label>Quantity:</label>
                <input type="text" name="quantity" value="${product.quantity}" <%= isAdmin ? "" : "readonly"%> />

                <label>Description:</label>
                <input type="text" name="description" value="${product.description}" <%= isAdmin ? "" : "readonly"%> />

                <% if (isAdmin) { %>
                <input type="submit" class="btn" value="Update" />
                <% } %>
            </form>

            <% if (!isAdmin) { %>
            <!-- Form riêng cho Add to Cart -->
            <form action="addtocartcontroller" method="post" style="text-align:center; margin-top:15px;">
                <input type="hidden" name="productID" value="${product.productID}">
                <input type="hidden" name="quantity" value="1">
                <input type="submit" value="Add to Cart" class="btn add-to-cart-btn">
            </form>
            <% }%>

            <!-- Form riêng cho Cancel -->
            <form action="loadProduct" method="post" style="text-align:center; margin-top:10px;">
                <input type="submit" value="Cancel" class="btn cancel-btn">
            </form>

            <div class="rating-section">
                <h3 class="section-title">Product Ratings</h3>
                <c:if test="${not empty ratings}">
                    <c:forEach var="r" items="${ratings}">
                        <div class="rating-item">
                            <strong>⭐ ${r.rating} / 5</strong>
                            <i>${r.comment}</i>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty ratings}">
                    <p class="no-rating">No ratings for this product yet.</p>
                </c:if>
            </div>
            
        </div>
       

    </body>
</html>
