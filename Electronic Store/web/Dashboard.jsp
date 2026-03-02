<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
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

    .container {
        width: 90%;
        margin: 0 auto;
    }

    .row {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }

    .card {
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        width: 300px;
        text-align: center;
        padding: 20px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    }

    .card-header {
        font-weight: bold;
        font-size: 16px;
        padding: 10px 0;
        border-bottom: 1px solid rgba(255,255,255,0.3);
    }

    .card-body {
        padding: 15px 0;
    }

    .bg-success {
        background-color: #218838; /* đồng bộ với màu nút product */
        color: white;
    }

    .bg-primary {
        background-color: #0078d7; /* đồng bộ với header / nút order */
        color: white;
    }

    .card-title {
        font-size: 22px;
        font-weight: bold;
        margin: 10px 0 0 0;
    }

    @media screen and (max-width: 768px) {
        .row {
            flex-direction: column;
            align-items: center;
        }
        .card {
            width: 90%;
        }
    }
</style>

<div class="container mt-4">
    <h2>Dashboard Admin</h2>
    <div class="row">

        <!-- Tổng doanh thu -->
        <div class="col-md-4">
            <a href="completedorder" style="text-decoration:none; color:white;">
            <div class="card text-white bg-success mb-3">
                <div class="card-header">Tổng doanh thu</div>
                <div class="card-body">
                    <h5 class="card-title">${totalRevenue} VNĐ</h5>
                </div>
            </div>
        </div>

        <!-- Tổng số đơn hàng -->
        <div class="col-md-4">
             <a href="ordercontroller" style="text-decoration:none; color:white;">
            <div class="card text-white bg-primary mb-3">
                <div class="card-header">Tổng số đơn hàng</div>
                <div class="card-body">
                    <h5 class="card-title">${totalOrders}</h5>
                </div>
            </div>
        </div>
                

        <!-- Có thể thêm các thẻ khác: top sản phẩm, khách hàng ... -->
    </div>
</div>
