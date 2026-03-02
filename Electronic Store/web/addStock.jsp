<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Stock</title>
    <style>
        body { font-family: Arial; padding: 20px; background-color: #f6f6f6; }
        h2 { color: #0078d7; text-align: center; margin-bottom: 20px; }
        form { background: #fff; padding: 20px; border-radius: 8px; width: 400px; margin: auto; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        label { display: block; margin-bottom: 8px; font-weight: bold; }
        input[type=text], input[type=number] { width: 100%; padding: 8px; margin-bottom: 12px; border-radius: 4px; border: 1px solid #ccc; }
        input[type=submit] { background-color: #28a745; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; }
        input[type=submit]:hover { background-color: #218838; }
        .message { text-align: center; font-weight: bold; margin-bottom: 15px; color: green; }
        .error { text-align: center; font-weight: bold; margin-bottom: 15px; color: red; }
    </style>
</head>
<body>
    <h2>Add Stock for Product</h2>

    <!-- Thông báo từ session -->
    <c:if test="${not empty sessionScope.message}">
        <p class="${sessionScope.messageType == 'error' ? 'error' : 'message'}">
            ${sessionScope.message}
        </p>
        <c:remove var="message" scope="session"/>
        <c:remove var="messageType" scope="session"/>
    </c:if>

    <form action="addstockcontroller" method="post">
        <label for="productID">Product ID:</label>
        <input type="text" name="productID" required>

        <label for="quantity">Quantity to Add:</label>
        <input type="number" name="quantity" min="1" required>

        <input type="submit" value="Add Stock">
    </form>
</body>
</html>
