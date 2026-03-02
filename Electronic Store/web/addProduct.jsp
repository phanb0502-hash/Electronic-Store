<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ include file="Header.jsp" %>  <%-- Chèn header giống showProducts.jsp --%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Product</title>

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

        .product-form {
            width: 50%;
            margin: 0 auto 50px auto;
            background: #ffffff;
            padding: 25px 30px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .product-form label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .product-form input[type="text"],
        .product-form input[type="number"],
        .product-form select {
            width: 95%;
            padding: 8px;
            border: 1px solid #0078d7;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .product-form input[type="submit"] {
            background-color: #0078d7;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .product-form input[type="submit"]:hover {
            background-color: #005ea6;
        }
    </style>
</head>
<body>

    <h1>Add New Product</h1>

    <div class="product-form">
        <form action="addProduct" method="post">
            <label for="productName">Name:</label>
            <input type="text" id="productName" name="productName" required />

            <label for="price">Price:</label>
            <input type="text" id="price" name="price" required />

            <label for="quantity">Quantity:</label>
            <input type="text" id="quantity" name="quantity" required />

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" />

            <label for="categoryID">Category:</label>
            <select id="categoryID" name="categoryID">
                <c:forEach var="c" items="${sessionScope.listOfCategories}">
                    <option value="${c.categoryID}">${c.categoryName}</option>
                </c:forEach>
            </select>

            <input type="submit" value="Add Product" />
        </form>
    </div>

</body>
</html>
