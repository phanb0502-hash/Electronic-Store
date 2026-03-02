<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
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
                margin-top: 25px;
                padding: 10px 18px;
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

            .total {
                text-align: right;
                font-weight: bold;
                font-size: 18px;
                margin-right: 8%;
                margin-top: 20px;
            }

            @media screen and (max-width: 768px) {
                table, th, td {
                    font-size: 13px;
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <h1>Order Details</h1>

        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price (VND)</th>
                    <th>Subtotal (VND)</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="total" value="0" />
                <c:forEach var="d" items="${detailList}">
                    <tr>
                        <td>${d.productName}</td>
                        <td>${d.quantity}</td>
                        <td>${d.price}</td>
                        <td>${d.subTotal}</td>
                    </tr>
                    <c:set var="total" value="${total + d.subTotal}" />
                </c:forEach>
            </tbody>
        </table>

        <p class="total">Total: ${total} VND</p>

        <div style="text-align:center;">
            <a href="ordercontroller" class="btn">⬅ Back to Orders</a>
        </div>
    </body>
</html>
